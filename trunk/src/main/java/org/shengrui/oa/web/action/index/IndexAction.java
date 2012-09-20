package org.shengrui.oa.web.action.index;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.shengrui.oa.model.admin.ModelTaskPlan;
import org.shengrui.oa.model.finan.ModelFinanContract;
import org.shengrui.oa.model.finan.ModelFinanExpense;
import org.shengrui.oa.model.finan.ModelFinanProject;
import org.shengrui.oa.model.hrm.ModelHrmEmployee;
import org.shengrui.oa.model.hrm.ModelHrmEmployeeDevelop;
import org.shengrui.oa.model.hrm.ModelHrmJobHireEntry;
import org.shengrui.oa.model.hrm.ModelHrmJobHireInterview;
import org.shengrui.oa.model.system.ModelAppUser;
import org.shengrui.oa.service.base.ServiceBase;
import org.shengrui.oa.util.ContextUtil;
import org.shengrui.oa.util.WebActionUtil;
import org.shengrui.oa.web.action.BaseAppAction;

import cn.trymore.core.util.UtilString;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

/**
 * The index web action, it shows the index page for system.
 * 
 * @author  Jeccy.Zhao
 *
 */
public class IndexAction 
extends BaseAppAction
{
	/**
	 * The LOGGER
	 */
	private static final Logger LOGGER = Logger.getLogger(IndexAction.class);
	
	/**
	 * The service of HRM employee develop.
	 */
	@Resource
	private ServiceBase serviceBase;
	
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * The index presentation page action.
	 */
	public ActionForward index (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		// initialization.
		init(request);
		
		return mapping.findForward("index");
	}
	
	/**
	 * 通讯录
	 */
	public ActionForward addressBookInfo (ActionMapping mapping,ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
	{
		try 
		{
			loadAddressData(request);
			
			// 加载校结构图
			this.loadOrganizationTree(request);
			
			return mapping.findForward("personal.page.addressBook");
		} 
		catch (Exception e) 
		{
			LOGGER.error("Exception raised when loading address book page.", e);
			return ajaxPrint(response, getErrorCallback("数据加载失败:" + e));
		}
	}
	
	/**
	 * 加载用户员工数据列表
	 */
	public ActionForward loadEmployeeData (ActionMapping mapping,ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
	{
		try
		{
			loadAddressData(request);
			return mapping.findForward("data.addressbook.employee");
		}
		catch (Exception e)
		{
			LOGGER.error("Exception raised when load employee data..", e);
			return ajaxPrint(response, getErrorCallback("数据加载失败:" + e));
		}
	}
	
	/**
	 * 加载通讯录数据列表
	 */
	private void loadAddressData (HttpServletRequest request) throws Exception
	{
		String depId = request.getParameter("depId");
		String districtId = request.getParameter("districtId");
		String empName = request.getParameter("empName");
		
		PagingBean pagingBean = this.getPagingBean(request);
		
		try
		{
			// 姓名为空的时候, 查找所有用户数据.
			if (!UtilString.isNotEmpty(empName) && 
					request.getParameter(PAGING_PARAM_PAGENUM) == null && request.getParameter("byorder") == null)
			{
				depId = null;
				districtId = null;
			}
			
			PaginationSupport<ModelHrmEmployee> empInfo = 
					this.serviceHrmEmployee.getEmployeeDataPage(depId, districtId, empName, pagingBean);
			
			request.setAttribute("empInfo", empInfo);
			request.setAttribute("depId", depId);
			request.setAttribute("districtId", districtId);
			
			// 输出分页信息至客户端
			outWritePagination(request, pagingBean, empInfo);
		}
		catch (Exception e)
		{
			throw new Exception(e);
		}
	}
	
	/**
	 * 根据校区及部门, 加载用户列表数据
	 * @return
	 */
	public ActionForward loadUserDataByDepartmentAndDistrict (ActionMapping mapping,
			ActionForm form, HttpServletRequest request, HttpServletResponse response)
	{
		try
		{
			ModelAppUser modelAppUser = (ModelAppUser) form;
			PagingBean pagingBean = this.getPagingBean(request);
			
			String depId = request.getParameter("depId");
			String disId = request.getParameter("districtId");
			
			if (UtilString.isNotEmpty(depId, disId))
			{
				modelAppUser.setDepartment(this.serviceSchoolDepartment.get(depId));
				modelAppUser.setDistrict(this.serviceSchoolDistrict.get(disId));
			}
			else
			{
				// 加载所有用户数据.
			}
			
			PaginationSupport<ModelAppUser> userInfo = 
				this.serviceAppUser.getUserPagination(modelAppUser, pagingBean);
			
			request.setAttribute("userInfo", userInfo);
			
			// 输出分页信息至客户端
			outWritePagination(request, pagingBean, userInfo);
			
			return null;
		}
		catch (Exception e)
		{
			LOGGER.error("Exception raised when loading user data...", e);
			return ajaxPrint(response, getErrorCallback("加载数据异常, 请再一次尝试!"));
		}
	}
	
	/**
	 * Initialization for current logon user
	 * 
	 * @param request
	 */
	private void init(HttpServletRequest request)
	{
		String empId = ContextUtil.getCurrentUser().getEmployee().getId();
		
		request.setAttribute("numMsgUnread", 
				this.getUnreadMessageByUserId(empId));
		
		Map<String, Integer> affectedItems = new HashMap<String, Integer>();
		
		// 获取待审批委托任务数量...
		affectedItems.put(WebActionUtil.MENU_ITEM_ADMIN_TASK.getKey(), 
			this.serviceBase.getAffectedNumByQuery(ModelTaskPlan.class, 
				this.getModelDataPolicyQuery(
					WebActionUtil.MENU_ITEM_ADMIN_TASK.getObject().getKey(),
					WebActionUtil.MENU_ITEM_ADMIN_TASK.getObject().getObject(),
					ModelTaskPlan.class, 
					new String[] {
						"(approval_status = " + ModelTaskPlan.ETaskApprovalStatus.TOAPPROVE.getValue() + " OR approval_status IS NULL)"
					}
				)
			)
		);
		
		// 获取人力资源发展`审批中`数量...
		affectedItems.put(WebActionUtil.MENU_ITEM_HRM_DEVELOP.getKey(), 
			this.serviceBase.getAffectedNumByQuery(ModelHrmEmployeeDevelop.class, 
				this.getModelDataPolicyQuery(
					WebActionUtil.MENU_ITEM_HRM_DEVELOP.getObject().getKey(),
					WebActionUtil.MENU_ITEM_HRM_DEVELOP.getObject().getObject(),
					ModelHrmEmployeeDevelop.class, 
					new String[] {
						"(audit_state IS NULL and cproc_depid = " + 
							ContextUtil.getCurrentUser().getEmployee().getEmployeeDepartment().getId() + " and cproc_posid= " + 
							ContextUtil.getCurrentUser().getEmployee().getEmployeePosition().getId() + " and " +
							"(to_district IS NULL OR to_district = " + 
								ContextUtil.getCurrentUser().getEmployee().getEmployeeDistrict().getId() + "))"
					}
				)
			)
		);
		
		// 获取费用支出申请`审批中`数量...
		affectedItems.put(WebActionUtil.MENU_ITEM_FINA_EXPENSE.getKey(), 
			this.serviceBase.getAffectedNumByQuery(ModelFinanExpense.class, 
				this.getModelDataPolicyQuery(
					WebActionUtil.MENU_ITEM_FINA_EXPENSE.getObject().getKey(),
					WebActionUtil.MENU_ITEM_FINA_EXPENSE.getObject().getObject(),
					ModelFinanExpense.class, 
					new String[] {
						"(audit_state IS NULL and cproc_depid = " + 
								ContextUtil.getCurrentUser().getEmployee().getEmployeeDepartment().getId() + " and cproc_posid= " + 
								ContextUtil.getCurrentUser().getEmployee().getEmployeePosition().getId()  + ")"
					}
				)
			)
		);
		
		// 获取合同审批申请`审批中`数量...
		affectedItems.put(WebActionUtil.MENU_ITEM_FINA_CONTRACT.getKey(), 
			this.serviceBase.getAffectedNumByQuery(ModelFinanContract.class, 
				this.getModelDataPolicyQuery(
					WebActionUtil.MENU_ITEM_FINA_CONTRACT.getObject().getKey(),
					WebActionUtil.MENU_ITEM_FINA_CONTRACT.getObject().getObject(),
					ModelFinanContract.class, 
					new String[] {
						"(audit_state IS NULL and cproc_depid = " + 
								ContextUtil.getCurrentUser().getEmployee().getEmployeeDepartment().getId() + " and cproc_posid= " + 
								ContextUtil.getCurrentUser().getEmployee().getEmployeePosition().getId()  + ")"
					}
				)
			)
		);
		
		// 获取新项目审批申请`审批中`数量...
		affectedItems.put(WebActionUtil.MENU_ITEM_FINA_PROJECT.getKey(), 
			this.serviceBase.getAffectedNumByQuery(ModelFinanProject.class, 
				this.getModelDataPolicyQuery(
					WebActionUtil.MENU_ITEM_FINA_PROJECT.getObject().getKey(),
					WebActionUtil.MENU_ITEM_FINA_PROJECT.getObject().getObject(),
					ModelFinanProject.class, 
					new String[] {
						"(audit_state IS NULL and cproc_depid = " + 
								ContextUtil.getCurrentUser().getEmployee().getEmployeeDepartment().getId() + " and cproc_posid= " + 
								ContextUtil.getCurrentUser().getEmployee().getEmployeePosition().getId()  + ")"
					}
				)
			)
		);
		
		// 获取招聘入职`待入职 & 考察中`数量...
		affectedItems.put(WebActionUtil.MENU_ITEM_HRM_ENTRY.getKey(), 
			this.serviceBase.getAffectedNumByQuery(ModelHrmJobHireEntry.class, 
				this.getModelDataPolicyQuery(
					WebActionUtil.MENU_ITEM_HRM_ENTRY.getObject().getKey(),
					WebActionUtil.MENU_ITEM_HRM_ENTRY.getObject().getObject(),
					ModelHrmJobHireEntry.class, 
					new String[] {
						"(fstatus = " + ModelHrmJobHireEntry.EHireEntryFStatus.TODO.getValue() + " OR " + 
							"inspect_status = " + ModelHrmJobHireEntry.EHireEntryInspectStatus.INSPECTING.getValue() + ")"
					}
				)
			)
		);
		
		// 获取`我做伯乐`(需输入面试意见)的数量.
		affectedItems.put(WebActionUtil.MENU_ITEM_INTERVIEW_COMMIT.getKey(), 
			this.serviceBase.getAffectedNumByQuery(ModelHrmJobHireInterview.class, 
				this.getModelDataPolicyQuery(
					WebActionUtil.MENU_ITEM_INTERVIEW_COMMIT.getObject().getKey(),
					WebActionUtil.MENU_ITEM_INTERVIEW_COMMIT.getObject().getObject(),
					ModelHrmJobHireInterview.class, 
					new String[] {
						"(state IN (" + 
								ModelHrmJobHireInterview.EInterviewState.TODO.getValue() + "," + 
								ModelHrmJobHireInterview.EInterviewState.ONGING.getValue() + 
							") AND " + 
								"interviewer_id = " + ContextUtil.getCurrentUser().getId() + 
						")"
					}
				)
			)
		);
		
		// 获取待我审批数量
		// TODO: 新闻审批和岗位审批目前并未实现.
		affectedItems.put(WebActionUtil.MENU_KEY_APPROVAL_TODO, 
			affectedItems.get(WebActionUtil.MENU_ITEM_ADMIN_TASK.getKey()) + 
			affectedItems.get(WebActionUtil.MENU_ITEM_FINA_CONTRACT.getKey()) + 
			affectedItems.get(WebActionUtil.MENU_ITEM_FINA_EXPENSE.getKey()) +
			affectedItems.get(WebActionUtil.MENU_ITEM_HRM_DEVELOP.getKey()) + 
			affectedItems.get(WebActionUtil.MENU_ITEM_FINA_PROJECT.getKey())
		);
		
		// loads all configured menus, aims to present the left menu items.
		this.getRootMenus(request, affectedItems);
	}

	public ServiceBase getServiceBase()
	{
		return serviceBase;
	}

	public void setServiceBase(ServiceBase serviceBase)
	{
		this.serviceBase = serviceBase;
	}
	
}

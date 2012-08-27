package org.shengrui.oa.web.action.index;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.shengrui.oa.model.admin.ModelTaskPlan;
import org.shengrui.oa.model.finan.ModelFinanContract;
import org.shengrui.oa.model.finan.ModelFinanExpense;
import org.shengrui.oa.model.hrm.ModelHrmEmployeeDevelop;
import org.shengrui.oa.model.hrm.ModelHrmJobHireEntry;
import org.shengrui.oa.model.hrm.ModelHrmJobHireInterview;
import org.shengrui.oa.model.system.ModelAppUser;
import org.shengrui.oa.model.system.ModelSchoolDepartment;
import org.shengrui.oa.service.base.ServiceBase;
import org.shengrui.oa.util.AppUtil;
import org.shengrui.oa.util.ContextUtil;
import org.shengrui.oa.util.WebActionUtil;
import org.shengrui.oa.web.action.BaseAppAction;

import cn.trymore.core.exception.ServiceException;
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
	
	@SuppressWarnings("unused")
	public ActionForward addressBookInfo (ActionMapping mapping,ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
	{
		ModelAppUser modelAppUser = (ModelAppUser) form;
		PagingBean pagingBean = this.getPagingBean(request);
		String id = request.getParameter("id");
		String depId = request.getParameter("depId");
		try {
			modelAppUser.setDistrict(this.serviceSchoolDistrict.get(id));
//			modelAppUser.setDepartment(this.serviceSchoolDepartment.get(depId));
			PaginationSupport<ModelAppUser> userInfo = 
				this.serviceAppUser.getUserPagination(modelAppUser, pagingBean);
			request.setAttribute("userInfo", userInfo);
			request.setAttribute("modelAppUser", modelAppUser);
			request.setAttribute("districts" , this.getServiceSchoolDistrict().getAll());
			// 获取按校区所有部门列表
			Map<Integer, List<ModelSchoolDepartment>> departments = this.getAllDepartments(request, false);
			if (departments != null)
			{
				List<Object> depNames = this.serviceSchoolDepartment.getDistinctDepartmentNames();
				if (depNames != null)
				{
					request.setAttribute("depNames", depNames);
					
					Map<String, String> depSetIds = new HashMap<String, String>();
					
					// 总部部门
					List<ModelSchoolDepartment> depMasters = departments.get(AppUtil.EAppSchoolType.HEADQUARTERS.getValue());
					if (depMasters != null)
					{
						for (ModelSchoolDepartment dep : depMasters)
						{
							if (depNames.contains(dep.getDepName()))
							{
								// depSetIds.put(dep.getDepName(), value)
							}
						}
					}
					
					// 校区部门
					List<ModelSchoolDepartment> depCampus = departments.get(AppUtil.EAppSchoolType.AREA_CAMPUS.getValue());
				}
			}
		} catch (ServiceException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return mapping.findForward("personal.page.addressBook");
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
								ContextUtil.getCurrentUser().getEmployee().getEmployeePosition().getId()  + ")"
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
			affectedItems.get(WebActionUtil.MENU_ITEM_HRM_DEVELOP.getKey())
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

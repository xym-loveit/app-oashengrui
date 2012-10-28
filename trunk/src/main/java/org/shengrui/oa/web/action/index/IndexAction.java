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
import org.shengrui.oa.model.admin.ModelConference;
import org.shengrui.oa.model.admin.ModelTaskPlan;
import org.shengrui.oa.model.finan.ModelFinanContract;
import org.shengrui.oa.model.finan.ModelFinanExpense;
import org.shengrui.oa.model.finan.ModelFinanProject;
import org.shengrui.oa.model.hrm.ModelHrmEmployee;
import org.shengrui.oa.model.hrm.ModelHrmEmployeeDevelop;
import org.shengrui.oa.model.hrm.ModelHrmJobHireEntry;
import org.shengrui.oa.model.hrm.ModelHrmJobHireInfo;
import org.shengrui.oa.model.hrm.ModelHrmJobHireInterview;
import org.shengrui.oa.model.news.ModelNewsMag;
import org.shengrui.oa.model.system.ModelAppUser;
import org.shengrui.oa.service.base.ServiceBase;
import org.shengrui.oa.service.hrm.ServiceHrmJobHireIssue;
import org.shengrui.oa.util.ContextUtil;
import org.shengrui.oa.util.UtilDateTime;
import org.shengrui.oa.util.WebActionUtil;
import org.shengrui.oa.web.action.BaseAppAction;

import cn.trymore.core.exception.ResourceNotGrantedException;
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
	 * The service of HRM job hire issue
	 */
	@Resource
	private ServiceHrmJobHireIssue serviceHrmJobHireIssue;
	
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
					this.serviceHrmEmployee.getEmployeeDataPage(depId, districtId, empName, pagingBean, true);
			
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
		
		// 获取新闻待审批数量...
		try
		{
			affectedItems.put(WebActionUtil.MENU_ITEM_ADMIN_NEWS.getKey(), 
				this.serviceBase.getAffectedNumByQuery(ModelNewsMag.class, 
					this.getModelDataPolicyQuery(
						WebActionUtil.MENU_ITEM_ADMIN_NEWS.getObject().getKey(),
						WebActionUtil.MENU_ITEM_ADMIN_NEWS.getObject().getObject(),
						ModelNewsMag.class, 
						new String[] {
							"(status = " + ModelNewsMag.newsStatus.TODO_APPROVE.getValue() + ")"
						}
					)
				)
			);
		} 
		catch (ResourceNotGrantedException e)
		{
			affectedItems.put(WebActionUtil.MENU_ITEM_ADMIN_NEWS.getKey(), 0);
		}
		
		// 获取待审批委托任务数量...
		try
		{
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
		} 
		catch (ResourceNotGrantedException e)
		{
			affectedItems.put(WebActionUtil.MENU_ITEM_ADMIN_TASK.getKey(), 0);
		}
		
		// 获取人力资源发展`审批中`数量...
		try
		{
			affectedItems.put(WebActionUtil.MENU_ITEM_HRM_DEVELOP.getKey(), 
				this.serviceBase.getAffectedNumByQuery(ModelHrmEmployeeDevelop.class, 
					this.getModelDataPolicyQuery(
						WebActionUtil.MENU_ITEM_HRM_DEVELOP.getObject().getKey(),
						WebActionUtil.MENU_ITEM_HRM_DEVELOP.getObject().getObject(),
						ModelHrmEmployeeDevelop.class, 
						new String[] {
							"(audit_state IS NULL and cproc_depid = " + 
								ContextUtil.getCurrentUser().getDepartmentId() + " and cproc_posid= " + 
								ContextUtil.getCurrentUser().getPositionId() + " and " +
								"(cproc_disid = " + 
									ContextUtil.getCurrentUser().getDistrictId() + "))"
						},
						false
					)
				)
			);
		} 
		catch (ResourceNotGrantedException e)
		{
			affectedItems.put(WebActionUtil.MENU_ITEM_HRM_DEVELOP.getKey(), 0);
		}
		
		// 获取费用支出申请`审批中`数量...
		try
		{
			affectedItems.put(WebActionUtil.MENU_ITEM_FINA_EXPENSE.getKey(), 
				this.serviceBase.getAffectedNumByQuery(ModelFinanExpense.class, 
					this.getModelDataPolicyQuery(
						WebActionUtil.MENU_ITEM_FINA_EXPENSE.getObject().getKey(),
						WebActionUtil.MENU_ITEM_FINA_EXPENSE.getObject().getObject(),
						ModelFinanExpense.class, 
						new String[] {
							"(audit_state IS NULL and cproc_depid = " + 
								ContextUtil.getCurrentUser().getDepartmentId() + " and cproc_posid= " + 
								ContextUtil.getCurrentUser().getPositionId() + " and " +
								"(cproc_disid = " + 
									ContextUtil.getCurrentUser().getDistrictId() + "))"
						},
						false
					)
				)
			);
		} 
		catch (ResourceNotGrantedException e1)
		{
			affectedItems.put(WebActionUtil.MENU_ITEM_FINA_EXPENSE.getKey(), 0);
		}
		
		// 获取合同审批申请`审批中`数量...
		try
		{
			affectedItems.put(WebActionUtil.MENU_ITEM_FINA_CONTRACT.getKey(), 
				this.serviceBase.getAffectedNumByQuery(ModelFinanContract.class, 
					this.getModelDataPolicyQuery(
						WebActionUtil.MENU_ITEM_FINA_CONTRACT.getObject().getKey(),
						WebActionUtil.MENU_ITEM_FINA_CONTRACT.getObject().getObject(),
						ModelFinanContract.class, 
						new String[] {
							"(audit_state IS NULL and cproc_depid = " + 
								ContextUtil.getCurrentUser().getDepartmentId() + " and cproc_posid= " + 
								ContextUtil.getCurrentUser().getPositionId() + " and " +
								"(cproc_disid = " + 
									ContextUtil.getCurrentUser().getDistrictId() + "))"
						},
						false
					)
				)
			);
		} 
		catch (ResourceNotGrantedException e)
		{
			affectedItems.put(WebActionUtil.MENU_ITEM_FINA_CONTRACT.getKey(), 0);
		}
		
		// 获取新项目审批申请`审批中`数量...
		try
		{
			affectedItems.put(WebActionUtil.MENU_ITEM_FINA_PROJECT.getKey(), 
				this.serviceBase.getAffectedNumByQuery(ModelFinanProject.class, 
					this.getModelDataPolicyQuery(
						WebActionUtil.MENU_ITEM_FINA_PROJECT.getObject().getKey(),
						WebActionUtil.MENU_ITEM_FINA_PROJECT.getObject().getObject(),
						ModelFinanProject.class, 
						new String[] {
							"(audit_state IS NULL and cproc_depid = " + 
								ContextUtil.getCurrentUser().getDepartmentId() + " and cproc_posid= " + 
								ContextUtil.getCurrentUser().getPositionId() + " and " +
								"(cproc_disid = " + 
									ContextUtil.getCurrentUser().getDistrictId() + "))"
						},
						false
					)
				)
			);
		} 
		catch (ResourceNotGrantedException e)
		{
			affectedItems.put(WebActionUtil.MENU_ITEM_FINA_PROJECT.getKey(), 0);
		}
		
		// 获取招聘入职`待入职 & 考察中`数量...
		try
		{
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
		} 
		catch (ResourceNotGrantedException e)
		{
			affectedItems.put(WebActionUtil.MENU_ITEM_HRM_ENTRY.getKey(), 0);
		}
		
		// 获取`我的会议`(会议状态为-已发起)的数量.
		try
		{
			StringBuilder builder = new StringBuilder();
			builder.append(" status = " + ModelConference.ConferenceStatus.START.getText());
			builder.append(" AND ");
			builder.append(" (sponsor = " + ContextUtil.getCurrentUserId());
			builder.append(" OR ");
			builder.append(" FIND_IN_SET(" + ContextUtil.getCurrentUser().getEmployeeId() + ", `attendances_ids`) > 0)");
			
			affectedItems.put(WebActionUtil.MENU_KEY_MY_CONFERENCE, 
				this.serviceBase.getAffectedNumByQuery(ModelConference.class, 
					builder.toString()
				)
			);
		} 
		catch (Exception e)
		{
			affectedItems.put(WebActionUtil.MENU_KEY_MY_CONFERENCE, 0);
		}
		
		// 获取`我的任务`(任务状态为-进行中)的数量.
		try
		{
			StringBuilder builder = new StringBuilder();
			builder.append(" approval_status = " + ModelTaskPlan.ETaskApprovalStatus.APPROVED.getValue());
			builder.append(" AND ");
			builder.append(" (task_status IS NULL OR ");
			builder.append(" task_status != " + ModelTaskPlan.ETaskStatus.DONE.getValue() + ")");
			builder.append(" AND ");
			builder.append(" task_planStartDate <= '" + UtilDateTime.nowDateString() + "'");
			builder.append(" AND ");
			builder.append(" task_planEndDate >= '" + UtilDateTime.nowDateString() + "'");
			builder.append(" AND ");
			builder.append(" (task_charger = " + ContextUtil.getCurrentUser().getEmployeeId());
			builder.append(" OR ");
			builder.append(" FIND_IN_SET(" + ContextUtil.getCurrentUser().getEmployeeId() + ", `task_participant_ids`) > 0)");
			
			affectedItems.put(WebActionUtil.MENU_KEY_MY_TASK, 
				this.serviceBase.getAffectedNumByQuery(ModelTaskPlan.class, 
					builder.toString()
				)
			);
		} 
		catch (Exception e)
		{
			affectedItems.put(WebActionUtil.MENU_KEY_MY_TASK, 0);
		}
		
		// 获取`我做伯乐`(需输入面试意见)的数量.
		try
		{
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
		} 
		catch (ResourceNotGrantedException e)
		{
			affectedItems.put(WebActionUtil.MENU_ITEM_INTERVIEW_COMMIT.getKey(), 0);
		}
		
		// 获取岗位审批(待总部审批)数量...
		int numJobOnMaster = 0;
		try
		{
			numJobOnMaster = this.serviceBase.getAffectedNumByQuery(ModelHrmJobHireInfo.class, 
				this.getModelDataPolicyQuery(
					WebActionUtil.APPROVAL_HRM_JOB_MASTER.getKey(),
					WebActionUtil.APPROVAL_HRM_JOB_MASTER.getObject(),
					ModelHrmJobHireInfo.class, 
					new String[] {
						"(status = " + ModelHrmJobHireInfo.EJobHireStatus.TODO_HEAD.getValue() + ")"
					}
				)
			);
		} 
		catch (ResourceNotGrantedException e)
		{
			// do nothing.
		}
		
		// 获取岗位审批(待校区审批)数量...
		int numJobOnZone = 0;
		try
		{
			numJobOnZone = this.serviceBase.getAffectedNumByQuery(ModelHrmJobHireInfo.class, 
				this.getModelDataPolicyQuery(
					WebActionUtil.APPROVAL_HRM_JOB_ZOON.getKey(),
					WebActionUtil.APPROVAL_HRM_JOB_ZOON.getObject(),
					ModelHrmJobHireInfo.class, 
					new String[] {
						"(status = " + ModelHrmJobHireInfo.EJobHireStatus.TODO_ZONE.getValue() + ")"
					}
				)
			);
		} 
		catch (ResourceNotGrantedException e)
		{
			// do nothing.
		}
		
		/*
		// 获取`入职安排`数量
		int numJobEntryIssue = this.serviceHrmJobHireIssue.getNumHireEntry( 
			this.getModelDataPolicyQuery(
				WebActionUtil.ENTRY_GATE_HRM_JOB_ENTRY.getKey(),
				WebActionUtil.ENTRY_GATE_HRM_JOB_ENTRY.getObject(),
				ModelHrmJobHireIssue.class, 
				null
			), false
		);
		
		// 获取`入职安排`数量
		int numJobHireIssue = this.serviceHrmJobHireIssue.getNumHireIssue(
			this.getModelDataPolicyQuery(
				WebActionUtil.ENTRY_GATE_HRM_JOB_OFFER.getKey(),
				WebActionUtil.ENTRY_GATE_HRM_JOB_OFFER.getObject(),
				ModelHrmJobHireIssue.class, 
				null
			), false
		);
		*/
		
		// 获取当前招聘管理待办提醒数字...
		affectedItems.put(WebActionUtil.MENU_KEY_JOB_MGR, 
				numJobOnMaster + numJobOnZone); // + numJobHireIssue + numJobEntryIssue);
		
		// 获取待我审批数量
		affectedItems.put(WebActionUtil.MENU_KEY_APPROVAL_TODO, 
			affectedItems.get(WebActionUtil.MENU_ITEM_ADMIN_TASK.getKey()) 		+ 
			affectedItems.get(WebActionUtil.MENU_ITEM_FINA_CONTRACT.getKey()) 	+ 
			affectedItems.get(WebActionUtil.MENU_ITEM_FINA_EXPENSE.getKey()) 	+
			affectedItems.get(WebActionUtil.MENU_ITEM_HRM_DEVELOP.getKey()) 	+ 
			affectedItems.get(WebActionUtil.MENU_ITEM_FINA_PROJECT.getKey()) 	+
			affectedItems.get(WebActionUtil.MENU_ITEM_ADMIN_NEWS.getKey())		+ 
			(numJobOnMaster + numJobOnZone)
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

	public void setServiceHrmJobHireIssue(ServiceHrmJobHireIssue serviceHrmJobHireIssue)
	{
		this.serviceHrmJobHireIssue = serviceHrmJobHireIssue;
	}

	public ServiceHrmJobHireIssue getServiceHrmJobHireIssue()
	{
		return serviceHrmJobHireIssue;
	}
	
}

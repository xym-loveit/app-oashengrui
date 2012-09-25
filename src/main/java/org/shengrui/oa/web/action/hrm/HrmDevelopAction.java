package org.shengrui.oa.web.action.hrm;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.shengrui.oa.model.flow.ModelProcessForm;
import org.shengrui.oa.model.flow.ModelProcessType;
import org.shengrui.oa.model.hrm.ModelHrmArchive;
import org.shengrui.oa.model.hrm.ModelHrmEmployee;
import org.shengrui.oa.model.hrm.ModelHrmEmployeeDevelop;
import org.shengrui.oa.model.hrm.ModelHrmEmployeeRoadMap;
import org.shengrui.oa.service.flow.ServiceProcessType;
import org.shengrui.oa.util.UtilDateTime;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.util.UtilString;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

/**
 * 人力资源发展
 * 
 * @author Jeccy.Zhao
 *
 */
public class HrmDevelopAction
extends BaseHrmAction
{
	/**
	 * The LOGGER
	 */
	private static final Logger LOGGER = Logger.getLogger(HrmDevelopAction.class);
	
	/**
	 * The process type service.
	 */
	private ServiceProcessType serviceProcessType;
	
	/**
	 * <b>[WebAction]</b> <br/>
	 * 人力资源发展管理
	 */
	public ActionForward hrmEmployeeDevelopIndex(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		
		try
		{
			ModelHrmEmployeeDevelop employeeDevelopForm = (ModelHrmEmployeeDevelop) form;
			
			List<ModelProcessType> procTypes = this.serviceProcessType.getTypesBySlug("hrm", true);
			if (procTypes == null)
			{
				return ajaxPrint(response, getErrorCallback("人资申请流程类型不存在..."));
			}
			
			request.setAttribute("types", procTypes);
			request.setAttribute("formEntity", employeeDevelopForm);
			
			// 获取所有校区, 用于搜索查询使用
			request.setAttribute("districts", this.serviceSchoolDistrict.getAll());
		} 
		catch (ServiceException e)
		{
			LOGGER.error("Exception raised when fetch all employee documents.", e);
		}
		
		return mapping.findForward("hrm.page.employee.develop.index");
	}
	
	/**
	 * <b>[WebAction]</b> <br/>
	 * 人力资源发展详细信息查看
	 */
	public ActionForward hrmEmployeeDevelopDetail(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		try
		{
			String developId = request.getParameter("id");
			if (this.isObjectIdValid(developId))
			{
				ModelHrmEmployeeDevelop developInfo = this.serviceHrmEmployeeDevelop.get(developId);
				if (developInfo != null)
				{
					request.setAttribute("employeeDevelopEntry", developInfo);
				}
				request.setAttribute("districts", this.serviceSchoolDistrict.getAll());
				request.setAttribute("departments", this.serviceSchoolDepartment.getAll());
				request.setAttribute("positions", this.serviceSchoolDepartmentPosition.getAll());
			}
			else
			{
				LOGGER.error("需要传入人资发展ID参数.");
			}
		}
		catch (ServiceException e)
		{
			LOGGER.error("Exception raised when fetch employee development detail.", e);
		}
		return mapping.findForward("hrm.page.employee.develop.detail");
	}

	
	/**
	 * <b>[WebAction]</b> <br/>
	 * 人力资源发展调动，离职，晋升，转正
	 */
	public ActionForward actionDevelopFinalize(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		try
		{
			String developId = request.getParameter("id");
			if (this.isObjectIdValid(developId))
			{
				String state = request.getParameter("state");
				if (this.isObjectIdValid(state) && this.isOperationStateAccepted(Integer.valueOf(state)))
				{
					ModelHrmEmployeeDevelop developInfo = this.serviceHrmEmployeeDevelop.get(developId);
					if (developInfo != null)
					{
						// 状态确认弹框
						String operation = request.getParameter("op");
						if (UtilString.isNotEmpty(operation) && "dialog".equals(operation))
						{
							request.setAttribute("state", state);
							request.setAttribute("employeeDevelopEntry", developInfo);
							
							return mapping.findForward("dialog.hrm.form.state." + state);
						}
						
						// 状态确认日期
						Date finalizedDate = null;
						String paramDate = request.getParameter("finalizedDate");
						if (UtilString.isNotEmpty(paramDate))
						{
							finalizedDate = UtilDateTime.toDateByPattern(paramDate);
						}
						else
						{
							finalizedDate = new Date();
						}
						
						// 保存操作
						developInfo.setOperationState(1);
						this.serviceHrmEmployeeDevelop.save(developInfo);

						// 记录至员工晟睿旅程
						ModelHrmEmployeeRoadMap roadMap = new ModelHrmEmployeeRoadMap();
						roadMap.setDate(finalizedDate);
						roadMap.setEmployee(developInfo.getEmployee());
						roadMap.setOrginalDistrict(developInfo.getFromDistrict());
						roadMap.setOrginalDepartmentPosition(developInfo.getFromPosition());
						roadMap.setOrginalDepartment(developInfo.getFromDepartment());
						roadMap.setDstDepartment(developInfo.getToDepartment());
						roadMap.setDstDepartmentPosition(developInfo.getToPosition());
						roadMap.setDstDistrict(developInfo.getToDistrict());
						roadMap.setType(Integer.valueOf(state));
						
						this.serviceHrmEmployeeRoadMap.save(roadMap);
						
						// 淘汰或未面试
						String archived = request.getParameter("archived");
						if (UtilString.isNotEmpty(archived))
						{
							// 移入人才库
							String archiveStar = request.getParameter("archiveStar");
							
							ModelHrmArchive hrmArchive = new ModelHrmArchive();
							hrmArchive.setJobHireInfo(null);
							hrmArchive.setResume(developInfo.getEmployee().getResume());
							hrmArchive.setSource(ModelHrmArchive.EArchiveSource.FAIRWELL.getValue());
							hrmArchive.setStarLevel(Integer.parseInt(archiveStar));
							this.serviceHrmArchive.save(hrmArchive);
						}
						
						ModelHrmEmployee employee = developInfo.getEmployee();
						
						// 更新员工所在校区/部门/岗位 (调动/晋升)
						if (ModelHrmEmployeeRoadMap.ERoadMapType.PROMOTION.getValue().equals(Integer.valueOf(state)) 
								|| ModelHrmEmployeeRoadMap.ERoadMapType.TRANSFER.getValue().equals(Integer.valueOf(state)))
						{
							employee.setEmployeeDistrict(developInfo.getToDistrict());
							employee.setEmployeePosition(developInfo.getToPosition());
							employee.setEmployeeDepartment(developInfo.getToDepartment());
							this.serviceHrmEmployee.save(employee);
						}
						
						// 转正 -> 更新员工状态
						if (ModelHrmEmployeeRoadMap.ERoadMapType.BEREGULAR.getValue().equals(Integer.valueOf(state)))
						{
							employee.setOnboardStatus(ModelHrmEmployee.EOnBoardStatus.ONREGULAR.getValue());
							this.serviceHrmEmployee.save(employee);
						}
						
						// 离职 -> 更新员工状态
						if (ModelHrmEmployeeRoadMap.ERoadMapType.FAIRWELL.getValue().equals(Integer.valueOf(state)))
						{
							employee.setOnboardStatus(ModelHrmEmployee.EOnBoardStatus.FAIRWELL.getValue());
							this.serviceHrmEmployee.save(employee);
						}
						
						// 保存成功后, Dialog进行关闭
						return ajaxPrint(response, 
								getSuccessCallback("操作成功...", CALLBACK_TYPE_CLOSE, CURRENT_NAVTABID, null, false));
					}
					else
					{
						return ajaxPrint(response, getErrorCallback("人力申请(id:" + developId + ")数据不存在."));
					}
				}
				else
				{
					return ajaxPrint(response, getErrorCallback("需要传入合法的操作状态, 非法状态参数被传递: " + state));
				}
			}
			else
			{
				return ajaxPrint(response, getErrorCallback("需要传入人资发展ID参数."));
			}
		}
		catch (ServiceException e)
		{
			LOGGER.error("Exception raised when fetch employee development detail.", e);
		}
		return mapping.findForward("hrm.page.employee.develop.finalize");
	}
	
	/**
	 * <b>[WebAction]</b> <br/>
	 * 费用支出记录
	 */
	public ActionForward actionDevelopLoadRecords (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		try
		{
			ModelHrmEmployeeDevelop formEntity = (ModelHrmEmployeeDevelop) form;
			
			// 加载审批数据
			boolean isOnApproval = request.getParameter("finished") == null;
			obtainDevelopRecords(formEntity, isOnApproval, request);
			
			request.setAttribute("formEntity", formEntity);
			request.setAttribute("isOnApproval", isOnApproval);
		} 
		catch (Exception e)
		{
			LOGGER.error("Exception raised when fetch all expense documents.", e);
			return ajaxPrint(response, getErrorCallback("页面加载失败:" + e.getMessage()));
		}
		
		return mapping.findForward("hrm.data.employee.develop.records");
	}
	
	/**
	 * 
	 * @param request
	 * @param onApprovalStatus
	 * @return
	 * @throws ServiceException 
	 */
	private PaginationSupport<ModelHrmEmployeeDevelop> obtainDevelopRecords (ModelHrmEmployeeDevelop formEntity, 
			Boolean isOnApproval, HttpServletRequest request) throws ServiceException
	{
		if (isOnApproval != null && isOnApproval)
		{
			// 审批中
			// formEntity.setAuditState(null);
			formEntity.setCondAuditStates(new Integer[] {
					null
					// ModelProcessForm.EProcessFormStatus.RETURNED.getValue()
			});
		}
		else
		{
			if (formEntity.getAuditState() != null && formEntity.getAuditState() > -1) 
			{
				formEntity.setAuditState(formEntity.getAuditState());
			}
			else
			{
				formEntity.setCondAuditStates(new Integer[] {
					ModelProcessForm.EProcessFormStatus.APPROVED.getValue(), 
					ModelProcessForm.EProcessFormStatus.NOTPASSED.getValue()
					// ModelProcessForm.EProcessFormStatus.RETURNED.getValue()
				});
			}
		}
		
		PagingBean pagingBean = this.getPagingBean(request);
		PaginationSupport<ModelHrmEmployeeDevelop> items =
				this.serviceHrmEmployeeDevelop.getEmployeeDevelopInfoPagination(formEntity, pagingBean);
		
		request.setAttribute("dataList", items);
		
		// 输出分页信息至客户端
		outWritePagination(request, pagingBean, items);
		
		return items;
	}
	
	/**
	 * Returns true if the specified operation state accepted.  
	 * 
	 * @param operationState
	 *                  the operation state.
	 * @return
	 */
	private boolean isOperationStateAccepted (Integer operationState)
	{
		if (operationState != null)
		{
			return ModelHrmEmployeeRoadMap.ERoadMapType.BEREGULAR.getValue().equals(operationState) || 
						ModelHrmEmployeeRoadMap.ERoadMapType.PROMOTION.getValue().equals(operationState) || 
						ModelHrmEmployeeRoadMap.ERoadMapType.FAIRWELL.getValue().equals(operationState) || 
						ModelHrmEmployeeRoadMap.ERoadMapType.TRANSFER.getValue().equals(operationState);
		}
		
		return false;
	}
	
	public ServiceProcessType getServiceProcessType()
	{
		return serviceProcessType;
	}

	public void setServiceProcessType(ServiceProcessType serviceProcessType)
	{
		this.serviceProcessType = serviceProcessType;
	}
}

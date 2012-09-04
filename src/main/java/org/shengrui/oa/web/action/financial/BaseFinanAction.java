package org.shengrui.oa.web.action.financial;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.shengrui.oa.model.finan.ModelFinanBase;
import org.shengrui.oa.model.finan.ModelFinanContract;
import org.shengrui.oa.model.finan.ModelFinanExpense;
import org.shengrui.oa.model.flow.ModelProcessForm;
import org.shengrui.oa.model.hrm.ModelHrmEmployee;
import org.shengrui.oa.model.info.ModelShortMessage;
import org.shengrui.oa.service.finan.ServiceFinanContract;
import org.shengrui.oa.service.finan.ServiceFinanExpense;
import org.shengrui.oa.service.finan.ServiceFinanProject;
import org.shengrui.oa.util.WebActionUtil;
import org.shengrui.oa.web.action.flow.FlowBaseAction;

import cn.trymore.core.bean.PairObject;
import cn.trymore.core.util.UtilString;

/**
 * The base action for Finance Management.
 * 
 * @author Jeccy.Zhao
 *
 */
public class BaseFinanAction
extends FlowBaseAction
{
	/**
	 * The LOGGER
	 */
	private static final Logger LOGGER = Logger.getLogger(BaseFinanAction.class);
	
	/**
	 * The form key for financial expense
	 */
	protected final static String FINAN_FORM_KEY_EXPENSE = "FE";
	
	/**
	 * The form key for financial contract
	 */
	protected final static String FINAN_FORM_KEY_CONTRACT = "FC";
	
	/**
	 * The form key for financial project
	 */
	protected final static String FINAN_FORM_KEY_PROJECT = "FP";
	
	/**
	 * The category key for financial expense
	 */
	protected final static String FIANA_CATKEY_EXPENSE = "expense";
	
	/**
	 * The category key for financial contract
	 */
	protected final static String FIANA_CATKEY_CONTRACT = "contract";
	
	/**
	 * The process type key for financial expense payment
	 */
	protected final static String PROC_TYPE_FINAN_PAYMENT = "PROCESS_PAYMENT";
	
	/**
	 * The process type key for financial contract
	 */
	protected final static String PROC_TYPE_FINAN_CONTRACT = "PROCESS_CONTRACT";
	
	/**
	 * The process type key for financial project
	 */
	protected final static String PROC_TYPE_FINAN_PROJECT = "PROCESS_PROJECT";
	
	/**
	 * The Expense service.
	 */
	@Resource
	protected ServiceFinanExpense serviceFinanExpense;
	
	/**
	 * The contract service
	 */
	@Resource
	protected ServiceFinanContract serviceFinanContract;
	
	/**
	 * The contract service
	 */
	@Resource
	protected ServiceFinanProject serviceFinanProject;
	
	/**
	 * <b>[WebAction]</b> <br/>
	 * 财务费用申请审批
	 */
	public  ActionForward actionFinanApplicationApprove(ActionMapping mapping,
			ActionForm form, HttpServletRequest request, HttpServletResponse response) 
	{
		String formId = request.getParameter("formId");
		String procFormId = request.getParameter("id");
		String procFormState = request.getParameter("state");
		String procFormComments = request.getParameter("comments");
		
		if (UtilString.isNotEmpty(procFormId, procFormState))
		{
			if (this.isObjectIdValid(procFormId))
			{
				try
				{
					ModelFinanBase baseEntity = null;
					ModelProcessForm formEntity = null;
					
					PairObject<Boolean, ModelProcessForm> result = this.serviceWorkFlow.proceed(
							procFormId, Integer.parseInt(procFormState), procFormComments);
					
					String catKey = request.getParameter("catkey");
					if (UtilString.isNotEmpty(catKey))
					{
						// 更新业务表中的状态...
						String formNo = request.getParameter("formNo");
						formEntity = this.serviceProcessForm.get(procFormId);
						
						if (!UtilString.isNotEmpty(formNo))
						{
							if (formEntity != null)
							{
								formNo = formEntity.getApplyFormNo();
							}
						}
						
						if (formNo == null)
						{
							return ajaxPrint(response, getErrorCallback("审批失败: 申请单号不存在或者非法..."));
						}
						
						if (FIANA_CATKEY_EXPENSE.equalsIgnoreCase(catKey))
						{
							// 费用支出
							ModelFinanExpense entity = this.serviceFinanExpense.getByFormNo(formNo);
							if (entity.getApplyForm() == null || entity.getApplyForm().size() == 0)
							{
								entity.setAuditState(Integer.parseInt(procFormState));
							}
							
							if (result.getRight() == null)
							{
								// 审批结束, 审批退回/不通过/通过
								entity.setCurrentProcDepId(null);
								entity.setCurrentProcPosId(null);
							}
							else
							{
								ModelProcessForm procForm = result.getRight();
								entity.setCurrentProcDepId(procForm.getToDepartmentIds());
								entity.setCurrentProcPosId(procForm.getToPositionIds());
							}
							
							this.serviceFinanExpense.save(entity);
							
							baseEntity = entity;
						}
						else if (FIANA_CATKEY_CONTRACT.equalsIgnoreCase(catKey))
						{
							// 合同申请
							ModelFinanContract entity = this.serviceFinanContract.getByFormNo(formNo);
							if (entity.getApplyForm() == null || entity.getApplyForm().size() == 0)
							{
								entity.setAuditState(Integer.parseInt(procFormState));
							}
							
							if (result.getRight() == null)
							{
								// 审批结束, 审批退回/不通过/通过
								entity.setCurrentProcDepId(null);
								entity.setCurrentProcPosId(null);
							}
							else
							{
								ModelProcessForm procForm = result.getRight();
								entity.setCurrentProcDepId(procForm.getToDepartmentIds());
								entity.setCurrentProcPosId(procForm.getToPositionIds());
							}
							
							this.serviceFinanContract.save(entity);
							
							baseEntity = entity;
						}
						else
						{
							return ajaxPrint(response, getErrorCallback("审批失败: 非法的审核分类Key被传入..."));
						}
					}
					else
					{
						return ajaxPrint(response, getErrorCallback("审批失败: 需要传入审核分类Key..."));
					}
					
					if (result.getLeft())
					{
						// 短消息通知
						Map<String, Object> params = new HashMap<String, Object>();
						params.put("entity", baseEntity);
						params.put("state", Integer.valueOf(procFormState));
						params.put("procForm", formEntity);
						params.put("formId", formId);
						params.put("type", catKey.toLowerCase());
						
						if (result.getRight() == null)
						{
							// 审批结束, 审批退回/不通过/通过
							this.sendMessage("fina.audit.result", 
								params, new Object[] {
									baseEntity.getEmployee().getId()
								}, 
								ModelShortMessage.EMessageType.TYPE_SYSTEM.getValue()
							);
						}
						else
						{
							List<ModelHrmEmployee> employees = this.serviceHrmEmployee.getByDepartmentAndPosition(
									result.getRight().getToDepartmentIds(), result.getRight().getToPositionIds());
							
							StringBuilder builder = new StringBuilder();
							for (int i = 0, size = employees.size(); i <  size; i++)
							{
								ModelHrmEmployee employee = employees.get(i);
								builder.append(employee.getId());
								builder.append(",");
							}
							
							// 通知下一个审批环节的审批人
							this.sendMessage("my.approval.audit.fina", 
								params, new Object[] {
									builder.toString()
								}, 
								ModelShortMessage.EMessageType.TYPE_SYSTEM.getValue()
							);
							
							// 服务器推送至下一个审批环节的审批人客户端.
							this.messagePush.pushMessage(builder.toString(), 
								WebActionUtil.scriptMessageNotify, 
								(FIANA_CATKEY_EXPENSE.equalsIgnoreCase(catKey) ? 
									WebActionUtil.MENU_ITEM_FINA_EXPENSE.getKey() : 
										WebActionUtil.MENU_ITEM_FINA_CONTRACT.getKey()) + "," + WebActionUtil.MENU_KEY_APPROVAL_TODO, 
								1
							);
							
							builder = null;
						}
						
						if (formEntity != null)
						{
							List<ModelHrmEmployee> preAuditors = this.serviceHrmEmployee.getByDepartmentAndPosition(
									formEntity.getToDepartmentIds(), formEntity.getToPositionIds());
							
							StringBuilder sb = new StringBuilder();
							for (int i = 0, size = preAuditors.size(); i <  size; i++)
							{
								ModelHrmEmployee employee = preAuditors.get(i);
								sb.append(employee.getId());
								sb.append(",");
							}
							
							// 服务器推送至前一个环节审批人的客户端, 待办提醒数字减1
							this.messagePush.pushMessage(sb.toString(), 
								WebActionUtil.scriptMessageNotify, 
								(FIANA_CATKEY_EXPENSE.equalsIgnoreCase(catKey) ? 
									WebActionUtil.MENU_ITEM_FINA_EXPENSE.getKey() : 
										WebActionUtil.MENU_ITEM_FINA_CONTRACT.getKey()) + "," + WebActionUtil.MENU_KEY_APPROVAL_TODO, 
								-1
							);
							
							sb = null;
						}
						
						return ajaxPrint(response, 
								getSuccessCallback("审批成功.", CALLBACK_TYPE_CLOSE, CURRENT_NAVTABID, null, false));
					}
					else
					{
						return ajaxPrint(response, getErrorCallback("审批失败."));
					}
				}
				catch (Exception e)
				{
					LOGGER.error("Exception raised when approving the financial application.");
					return ajaxPrint(response, getErrorCallback("审批财务申请失败:" + e.getMessage()));
				}
			}
			else
			{
				return ajaxPrint(response, getErrorCallback("需要传入合法的申请流程ID..."));
			}
		}
		else
		{
			return ajaxPrint(response, getErrorCallback("需要传入申请流程ID..."));
		}
	}
	
	public ServiceFinanExpense getServiceFinanExpense() {
		return serviceFinanExpense;
	}

	public void setServiceFinanExpense(ServiceFinanExpense serviceFinanExpense) {
		this.serviceFinanExpense = serviceFinanExpense;
	}

	public ServiceFinanContract getServiceFinanContract()
	{
		return serviceFinanContract;
	}

	public void setServiceFinanContract(ServiceFinanContract serviceFinanContract)
	{
		this.serviceFinanContract = serviceFinanContract;
	}
	
	public ServiceFinanProject getServiceFinanProject()
	{
		return serviceFinanProject;
	}

	public void setServiceFinanProject(ServiceFinanProject serviceFinanProject)
	{
		this.serviceFinanProject = serviceFinanProject;
	}
}

package org.shengrui.oa.web.action.financial;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.shengrui.oa.model.finan.ModelFinanContract;
import org.shengrui.oa.model.finan.ModelFinanExpense;
import org.shengrui.oa.model.flow.ModelProcessForm;
import org.shengrui.oa.service.finan.ServiceFinanContract;
import org.shengrui.oa.service.finan.ServiceFinanExpense;
import org.shengrui.oa.web.action.flow.FlowBaseAction;

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
	 * <b>[WebAction]</b> <br/>
	 * 财务费用申请审批
	 */
	public  ActionForward actionFinanApplicationApprove(ActionMapping mapping,
			ActionForm form, HttpServletRequest request, HttpServletResponse response) 
	{
		String procFormId = request.getParameter("id");
		String procFormState = request.getParameter("state");
		String procFormComments = request.getParameter("comments");
		
		if (UtilString.isNotEmpty(procFormId, procFormState))
		{
			if (this.isObjectIdValid(procFormId))
			{
				try
				{
					boolean result = this.serviceWorkFlow.proceed(
							procFormId, Integer.parseInt(procFormState), procFormComments);
					
					String catKey = request.getParameter("catkey");
					if (UtilString.isNotEmpty(catKey))
					{
						// 更新业务表中的状态...
						String formNo = request.getParameter("formNo");
						if (!UtilString.isNotEmpty(formNo))
						{
							ModelProcessForm formEntity = this.serviceProcessForm.get(procFormId);
							if (formEntity != null)
							{
								formNo = formEntity.getApplyFormNo();
							}
						}
						
						if (formNo == null)
						{
							return ajaxPrint(response, getErrorCallback("审批失败: 申请单号不存在或者非法..."));
						}
						
						if (FIANA_CATKEY_EXPENSE.equals(catKey.toLowerCase()))
						{
							// 费用支出
							ModelFinanExpense entity = this.serviceFinanExpense.getByFormNo(formNo);
							if (entity.getApplyForm() == null || entity.getApplyForm().size() == 0)
							{
								entity.setAuditState(Integer.parseInt(procFormState));
								this.serviceFinanExpense.save(entity);
							}
						}
						else if (FIANA_CATKEY_CONTRACT.equals(catKey.toLowerCase()))
						{
							// 合同申请
							ModelFinanContract entity = this.serviceFinanContract.getByFormNo(formNo);
							if (entity.getApplyForm() == null || entity.getApplyForm().size() == 0)
							{
								entity.setAuditState(Integer.parseInt(procFormState));
								this.serviceFinanContract.save(entity);
							}
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
					
					if (result)
					{
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
}

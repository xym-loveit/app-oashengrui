package org.shengrui.oa.web.action.financial;

import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.shengrui.oa.model.finan.ModelFinanExpense;
import org.shengrui.oa.service.finan.ServiceFinanExpense;
import org.shengrui.oa.util.AppUtil;
import org.shengrui.oa.util.ContextUtil;
import org.shengrui.oa.web.action.flow.FlowBaseAction;

import cn.trymore.core.util.UtilBean;
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
	protected final String FINAN_FORM_KEY_EXPENSE = "FE";
	
	/**
	 * The form key for financial contract
	 */
	protected final String FINAN_FORM_KEY_CONTRACT = "FC";
	
	/**
	 * The Expense service.
	 */
	@Resource
	protected ServiceFinanExpense serviceFinanExpense;
	
	/**
	 * <b>[WebAction]</b> <br/>
	 * 财务费用申请表单保存
	 */
	public ActionForward actionFinanApplicationFormSave(ActionMapping mapping,
			ActionForm form, HttpServletRequest request, HttpServletResponse response) 
	{
		try
		{
			boolean isCreation = false;
			
			ModelFinanExpense expenseInfo = null;
			ModelFinanExpense formEntity = (ModelFinanExpense) form;
			
			String expenseId = request.getParameter("id");
			if (formEntity.getId() != null)
			{
				// 修改
				if (this.isObjectIdValid(expenseId))
				{
					expenseInfo = this.serviceFinanExpense.get(expenseId);
					if (expenseInfo == null)
					{
						return ajaxPrint(response, getErrorCallback("费用申请记录不存在:id-" + expenseId));
					}
					else
					{
						UtilBean.copyNotNullProperties(expenseInfo, formEntity);
					}
				}
				else
				{
					return ajaxPrint(response, getErrorCallback("需要传入合法费用申请ID参数."));
				}
			}
			else
			{
				// 创建
				isCreation = true;
				
				expenseInfo = formEntity;
				expenseInfo.setFormNo(AppUtil.genFormNo(FINAN_FORM_KEY_EXPENSE));
				expenseInfo.setEntryDateTime(new Date());
				expenseInfo.setEntryId(ContextUtil.getCurrentUserId());
				
				// expenseInfo.setAuditState(ModelProcessForm.EProcessFormStatus.ONAPPROVING.getValue());
				
				String typeId = request.getParameter("applyFormTypeId");
				expenseInfo.setApplyFormType(this.serviceProcessType.get(typeId));
			}
			
			expenseInfo.setEmployee(
					this.serviceHrmEmployee.get(request.getParameter("emp.id")));
			
			expenseInfo.setEmpDepartment(
					this.serviceSchoolDepartment.get(request.getParameter("emp.depId")));
			
			expenseInfo.setEmpDistrict(
					this.serviceSchoolDistrict.get(request.getParameter("emp.districtId")));
			
			expenseInfo.setEmpPhoneNo(request.getParameter("emp.phoneNo"));
			
			this.serviceFinanExpense.save(expenseInfo);
			
			if (isCreation)
			{
				// 进入流程...
				this.serviceWorkFlow.doStartProcess(
						expenseInfo.getApplyFormType().getId(), 
						null, 
						expenseInfo.getApplyAmt(), 
						expenseInfo.getFormNo(), 
						expenseInfo.getEmployee());
			}
			
			return ajaxPrint(response, 
					getSuccessCallback("费用申请保存成功.", CALLBACK_TYPE_CLOSE, CURRENT_NAVTABID, null, false));
		}
		catch (Exception e)
		{
			LOGGER.error("Exception raised when delete expense document.", e);
			return ajaxPrint(response, getErrorCallback("费用申请保存失败:" + e.getMessage()));
		}
	}
	
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
					
					if (result)
					{
						return ajaxPrint(response, 
								getSuccessCallback("审批成功.", null, null, null, false));
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
}

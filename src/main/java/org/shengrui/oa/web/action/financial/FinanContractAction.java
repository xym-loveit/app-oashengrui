package org.shengrui.oa.web.action.financial;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.shengrui.oa.model.finan.ModelFinanContract;
import org.shengrui.oa.model.flow.ModelProcessForm;
import org.shengrui.oa.model.flow.ModelProcessType;
import org.shengrui.oa.util.AppUtil;
import org.shengrui.oa.util.ContextUtil;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.util.UtilBean;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

/**
 * 财务管理 - 合同
 * 
 * @author Jeccy.Zhao
 *
 */
public class FinanContractAction
extends BaseFinanAction
{
	/**
	 * The LOGGER
	 */
	private static final Logger LOGGER = Logger.getLogger(FinanContractAction.class);
	
	/**
	 * <b>[WebAction]</b> <br/>
	 *合同申请单展现列表
	 */
	public ActionForward pageFinaContractIndex (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		try
		{
			ModelFinanContract contractForm = (ModelFinanContract) form;
			
			ModelProcessType procType = this.serviceProcessType.getTypesByKey(PROC_TYPE_FINAN_CONTRACT);
			if (procType == null)
			{
				return ajaxPrint(response, getErrorCallback("合同申请流程类型不存在..."));
			}
			
			request.setAttribute("types", this.getProcessSubTypes(procType.getId()));
			
			PagingBean pagingBean = this.getPagingBean(request);
			PaginationSupport<ModelFinanContract> contractInfo =
					this.serviceFinanContract.getFinanContractInfoPagination(contractForm, pagingBean);
			
			request.setAttribute("dataList", contractInfo);
			request.setAttribute("formEntity", contractForm);
			request.setAttribute("districts", this.serviceSchoolDistrict.getAll());
			
			// 输出分页信息至客户端
			outWritePagination(request, pagingBean, contractInfo);
			
		} 
		catch (Exception e)
		{
			LOGGER.error("Exception raised when fetch all expense documents.", e);
			return ajaxPrint(response, getErrorCallback("页面加载失败:" + e.getMessage()));
		}
		
		request.setAttribute("PAGE_TYPE", FINAN_FORM_KEY_CONTRACT);
		
		return mapping.findForward("fina.application.list.index");
	}
	
	/**
	 * <b>[WebAction]</b> <br/>
	 * 费用支出记录
	 */
	public ActionForward pageFinaContractRecords(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		try
		{
			ModelFinanContract formEntity = (ModelFinanContract) form;
			
			ModelProcessType procType = this.serviceProcessType.getTypesByKey(PROC_TYPE_FINAN_CONTRACT);
			if (procType == null)
			{
				return ajaxPrint(response, getErrorCallback("费用支出申请流程类型不存在..."));
			}
			
			request.setAttribute("types", this.getProcessSubTypes(procType.getId()));
			request.setAttribute("formEntity", formEntity);
			request.setAttribute("districts", this.serviceSchoolDistrict.getAll());
			
		} 
		catch (Exception e)
		{
			LOGGER.error("Exception raised when fetch all expense documents.", e);
			return ajaxPrint(response, getErrorCallback("页面加载失败:" + e.getMessage()));
		}
		
		request.setAttribute("currentindex", request.getParameter("currentindex"));
		request.setAttribute("PAGE_TYPE", FINAN_FORM_KEY_CONTRACT);
		
		return mapping.findForward("fina.application.records.index");
	}
	
	/**
	 * <b>[WebAction]</b> <br/>
	 * 合同申请记录
	 */
	public ActionForward loadFinaContractRecords (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		try
		{
			ModelFinanContract formEntity = (ModelFinanContract) form;
			
			// 加载审批数据
			boolean isOnApproval = request.getParameter("finished") == null;
			obtainFinaContractRecords(formEntity, isOnApproval, request);
			
			request.setAttribute("currentindex", request.getParameter("currentindex"));
			request.setAttribute("isOnApproval", isOnApproval);
			request.setAttribute("formEntity", formEntity);
		} 
		catch (Exception e)
		{
			LOGGER.error("Exception raised when fetch all expense documents.", e);
			return ajaxPrint(response, getErrorCallback("页面加载失败:" + e.getMessage()));
		}
		
		request.setAttribute("PAGE_TYPE", FINAN_FORM_KEY_CONTRACT);
		request.setAttribute("recordPage", true);
		
		return mapping.findForward("data.fina.application.records");
	}
	
	/**
	 * 
	 * @param request
	 * @param onApprovalStatus
	 * @return
	 * @throws ServiceException 
	 */
	private PaginationSupport<ModelFinanContract> obtainFinaContractRecords (ModelFinanContract formEntity, 
			Boolean isOnApproval, HttpServletRequest request) throws ServiceException
	{
		if (isOnApproval != null && isOnApproval)
		{
			// 审批中
			formEntity.setAuditState(null);
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
					ModelProcessForm.EProcessFormStatus.NOTPASSED.getValue(),
					ModelProcessForm.EProcessFormStatus.RETURNED.getValue()});
			}
		}
		
		PagingBean pagingBean = this.getPagingBean(request);
		PaginationSupport<ModelFinanContract> items =
				this.serviceFinanContract.getFinanContractInfoPagination(formEntity, pagingBean);
		
		request.setAttribute("dataList", items);
		
		// 输出分页信息至客户端
		outWritePagination(request, pagingBean, items);
		
		return items;
	}
	
	/**
	 * <b>[WebAction]</b> <br/>
	 * 合同申请单查看
	 */
	public ActionForward diaglogFinaContractPage (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		try
		{
			ModelProcessType procType = this.serviceProcessType.getTypesByKey(PROC_TYPE_FINAN_CONTRACT);
			if (procType == null)
			{
				return ajaxPrint(response, getErrorCallback("合同申请流程类型不存在..."));
			}
			
			request.setAttribute("types", this.getProcessSubTypes(procType.getId()));
			
			String contractId = request.getParameter("id");
			if (contractId != null && this.isObjectIdValid(contractId))
			{
				ModelFinanContract contractInfo = this.serviceFinanContract.get(contractId);
				if (contractInfo != null)
				{
					request.setAttribute("entity", contractInfo);
				}
			}
			
			request.setAttribute("op", request.getParameter("op"));
		}
		catch (Exception e)
		{
			LOGGER.error("Exception raised when fetch contract application detail.", e);
		}
		
		request.setAttribute("CATKEY", "contract");
		
		return mapping.findForward("dialog.fina.contract.application.page");
	}
	
	/**
	 * <b>[WebAction]</b> <br/>
	 * 合同申请保存
	 */
	public ActionForward actionFinanContractFormSave(ActionMapping mapping,
			ActionForm form, HttpServletRequest request, HttpServletResponse response) 
	{
		try
		{
			boolean isCreation = false;
			
			ModelFinanContract contractInfo = null;
			ModelFinanContract formEntity = (ModelFinanContract) form;
			
			String contractId = request.getParameter("id");
			if (formEntity.getId() != null)
			{
				// 修改
				if (this.isObjectIdValid(contractId))
				{
					contractInfo = this.serviceFinanContract.get(contractId);
					if (contractInfo == null)
					{
						return ajaxPrint(response, getErrorCallback("合同申请记录不存在:id-" + contractId));
					}
					else
					{
						UtilBean.copyNotNullProperties(contractInfo, formEntity);
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
				
				contractInfo = formEntity;
				contractInfo.setFormNo(AppUtil.genFormNo(FINAN_FORM_KEY_CONTRACT));
				contractInfo.setEntryDateTime(new Date());
				contractInfo.setEntryId(ContextUtil.getCurrentUserId());
				
				// expenseInfo.setAuditState(ModelProcessForm.EProcessFormStatus.ONAPPROVING.getValue());
				
				String typeId = request.getParameter("applyFormTypeId");
				contractInfo.setApplyFormType(this.serviceProcessType.get(typeId));
			}
			
			contractInfo.setEmployee(
					this.serviceHrmEmployee.get(request.getParameter("emp.id")));
			
			contractInfo.setEmpDepartment(
					this.serviceSchoolDepartment.get(request.getParameter("emp.depId")));
			
			contractInfo.setEmpDistrict(
					this.serviceSchoolDistrict.get(request.getParameter("emp.districtId")));
			
			contractInfo.setEmpPhoneNo(request.getParameter("emp.phoneNo"));
			
			this.serviceFinanContract.save(contractInfo);
			
			if (isCreation)
			{
				// 进入流程...
				this.serviceWorkFlow.doStartProcess(
						contractInfo.getApplyFormType().getId(), 
						null, 
						contractInfo.getApplyAmt(), 
						contractInfo.getFormNo(), 
						contractInfo.getEmployee());
			}
			
			return ajaxPrint(response, 
					getSuccessCallback("合同申请保存成功.", CALLBACK_TYPE_CLOSE, CURRENT_NAVTABID, null, false));
		}
		catch (Exception e)
		{
			LOGGER.error("Exception raised when saving the financial contrct.", e);
			return ajaxPrint(response, getErrorCallback("合同申请保存失败:" + e.getMessage()));
		}
	}
	
}

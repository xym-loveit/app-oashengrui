package org.shengrui.oa.web.action.flow;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.shengrui.oa.model.flow.ModelProcessDefinition;
import org.shengrui.oa.model.flow.ModelProcessType;
import org.shengrui.oa.model.system.ModelSchoolPositionSet;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.util.UtilString;

/**
 * 工作流设置 - 人资审批流程设置
 * 
 * @author Jeccy.Zhao
 *
 */
public class FlowHrmAction
extends FlowBaseAction
{
	/**
	 * The LOGGER
	 */
	private static final Logger LOGGER = Logger.getLogger(FlowHrmAction.class);
			
	/**
	 * The slug name for human resource flow
	 */
	public static final String PROCESS_TYPE_SLUG = "hrm";
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 *财务审批流程页面
	 */
	public ActionForward pageFlowIndex (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		
		request.setAttribute("typeSlug", PROCESS_TYPE_SLUG);
		
		try
		{
			request.setAttribute("rootTypes", 
					this.getProcessRootTypesBySlug(PROCESS_TYPE_SLUG));
		} 
		catch (ServiceException e)
		{
			LOGGER.error("Exception raised when obtain the root types with type:" + PROCESS_TYPE_SLUG, e);
		}
		
		return mapping.findForward("page.sys.setting.flow.hrm.index");
	}
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 加载职位流程配置
	 */
	public  ActionForward actionLoadProcessPosets (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		String rootTypeId = request.getParameter("rootTypeId");
		
		if (UtilString.isNotEmpty(rootTypeId))
		{
			try
			{
				
				ModelProcessType rootType = this.serviceProcessType.get(rootTypeId);
				if (rootType != null)
				{
					request.setAttribute("typeSlug", rootType.getProcessTypeSlug());
					request.setAttribute("posetList", 
							this.serviceSchoolPositionSet.getAll());
					
					// 获取已进行的职位流程审批列表...
					List<ModelProcessDefinition> procDefs = 
						this.serviceProcessDefinition.getProcessDefinitionByType(rootTypeId);
					
					if (procDefs != null)
					{
						Map<String, Boolean> filteredDefs = new HashMap<String, Boolean>();
						for (ModelProcessDefinition procDef : procDefs)
						{
							if (procDef.getFilterPoset() != null && 
									!filteredDefs.containsKey(procDef.getFilterPoset().getId()))
							{
								filteredDefs.put(procDef.getFilterPoset().getId(), true);
							}
						}
						request.setAttribute("filteredDefs", filteredDefs);
					}
				}
				else
				{
					return ajaxPrint(response, 
							getErrorCallback("流程类型(id:" + rootTypeId + ")不存在..."));
				}
			} 
			catch (Exception e)
			{
				LOGGER.error("Exception raised when obtain the sub types with root type:" + rootTypeId, e);
				return ajaxPrint(response, 
						getErrorCallback("页面加载失败:" + e.getMessage()));
			}
		}
		
		request.setAttribute("rootTypeId", rootTypeId);
		
		return mapping.findForward("data.sys.setting.flow.hrm.poset.list");
	}
	
	/**
	 * 人资职位流程配置页面
	 */
	public ActionForward pageFlowPosetConfigure (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		String procTypeId = request.getParameter("procTypeId");
		if (this.isObjectIdValid(procTypeId))
		{
			try
			{
				ModelProcessType procTypeEntity = this.serviceProcessType.get(procTypeId);
				if (procTypeEntity != null)
				{
					
					String posetId = request.getParameter("posetId");
					if (this.isObjectIdValid(posetId))
					{
						ModelSchoolPositionSet posetEntity = this.serviceSchoolPositionSet.get(posetId);
						if (posetEntity != null)
						{
							// ensures data existed before page render.
							this.doCheckProcDefsAgainstPoset(posetEntity, procTypeEntity);
							
							request.setAttribute("prcessDefs", 
									this.serviceProcessDefinition.getProcessDefinitionFilterByPoset(procTypeId, posetId));
							
							request.setAttribute("typeSlug", procTypeEntity.getProcessTypeSlug());
							request.setAttribute("processType", procTypeEntity);
							request.setAttribute("posetEntity", posetEntity);
							
							return mapping.findForward("page.sys.flow.hrm.configuration");
						}
						else
						{
							return ajaxPrint(response, getErrorCallback("指定的职位不存在..."));
						}
					}
					else
					{
						return ajaxPrint(response, getErrorCallback("需要传递合法的职位ID..."));
					}
				}
				else
				{
					return ajaxPrint(response, getErrorCallback("指定的流程类型不存在..."));
				}
			}
			catch (Exception e)
			{
				return ajaxPrint(response, getErrorCallback("数据加载失败..." + e.getMessage()));
			}
		}
		else
		{
			return ajaxPrint(response, getErrorCallback("需要传递合法的配置流程类型ID..."));
		}
	}
	
	/**
	 * Checks the process definition against specified position set. 
	 * Data for process definitions will be inserted if not found. 
	 * 
	 * @param poset
	 *          the position set entity
	 * @param procType
	 *          the process type entity
	 * @throws Exception
	 */
	private void doCheckProcDefsAgainstPoset (ModelSchoolPositionSet poset, 
			ModelProcessType procType) throws Exception
	{
		if (poset != null && procType != null)
		{
			List<ModelProcessDefinition> procDefs = 
				this.serviceProcessDefinition.getProcessDefinitionFilterByPoset(procType.getId(), poset.getId());
			if (procDefs == null || procDefs.size() == 0)
			{
				String defDesc = procType.getProcessTypeName() + "-" + poset.getPosetName();
				// inserts process definition data.
				if (this.existsInstanceInAndOut(procType.getProcessTypeKey()))
				{
					ModelProcessDefinition procDef = new ModelProcessDefinition();
					
					procDef.setCreateTime(new Date());
					procDef.setFilterPoset(poset);
					procDef.setCondition(EXPR_TRANSFER_INSIDE);
					procDef.setProcessDefName(defDesc + "(in)");
					procDef.setProcessDefDesc(defDesc + "(in)");
					procDef.setProcessType(procType);
					this.serviceProcessDefinition.save(procDef);
					
					ModelProcessDefinition procDefOut = new ModelProcessDefinition();
					procDefOut.setCreateTime(new Date());
					procDefOut.setProcessDefName(defDesc + "(out)");
					procDefOut.setProcessDefDesc(defDesc + "(out)");
					procDefOut.setCondition(EXPR_TRANSFER_OUTSIDE);
					procDefOut.setProcessType(procType);
					procDefOut.setFilterPoset(poset);
					this.serviceProcessDefinition.save(procDefOut);
				}
				else
				{
					ModelProcessDefinition procDef = new ModelProcessDefinition();
					
					procDef.setCreateTime(new Date());
					procDef.setFilterPoset(poset);
					procDef.setCondition(null);
					procDef.setProcessDefName(defDesc);
					procDef.setProcessDefDesc(defDesc);
					procDef.setProcessType(procType);
					
					this.serviceProcessDefinition.save(procDef);
				}
			}
		}
	}
	
	/**
	 * Returns true if it exists in/out for the specified process key 
	 * 
	 * @param procKey
	 *         the process key
	 * @return
	 */
	private boolean existsInstanceInAndOut (String procKey)
	{
		if (UtilString.isNotEmpty(procKey))
		{
			return PROCESS_MEMBER_PROMOTION.equals(procKey.toUpperCase()) 
					|| PROCESS_MEMBER_TRANSFER.equals(procKey.toUpperCase());
		}
		
		return false;
	}
	
	public static Logger getLogger()
	{
		return LOGGER;
	}
}

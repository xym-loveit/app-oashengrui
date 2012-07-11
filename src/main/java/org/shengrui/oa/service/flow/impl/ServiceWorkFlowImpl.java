package org.shengrui.oa.service.flow.impl;

import java.util.List;
import java.util.Set;

import org.apache.log4j.Logger;
import org.shengrui.oa.model.flow.ModelProcessDefinition;
import org.shengrui.oa.model.flow.ModelProcessForm;
import org.shengrui.oa.model.flow.ModelProcessHistory;
import org.shengrui.oa.model.flow.ModelProcessTask;
import org.shengrui.oa.model.hrm.ModelHrmEmployee;
import org.shengrui.oa.model.system.ModelSchoolDepartment;
import org.shengrui.oa.model.system.ModelSchoolDepartmentPosition;
import org.shengrui.oa.service.flow.ServiceProcessDefinition;
import org.shengrui.oa.service.flow.ServiceProcessForm;
import org.shengrui.oa.service.flow.ServiceProcessHistory;
import org.shengrui.oa.service.flow.ServiceProcessTask;
import org.shengrui.oa.service.flow.ServiceProcessType;
import org.shengrui.oa.service.flow.ServiceWorkFlow;
import org.shengrui.oa.service.system.ServiceSchoolDepartment;
import org.shengrui.oa.service.system.ServiceSchoolDepartmentPosition;
import org.shengrui.oa.util.AppUtil;

import cn.trymore.core.bean.PairObject;
import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.jstl.JstlTagString;
import cn.trymore.core.util.UtilString;

public class ServiceWorkFlowImpl
implements ServiceWorkFlow
{
	/**
	 * The LOGGER
	 */
	private static final Logger LOGGER = Logger.getLogger(ServiceWorkFlowImpl.class);
	
	/**
	 * The process definition service.
	 */
	private ServiceProcessDefinition serviceProcessDefinition;
	
	/**
	 * The process form service.
	 */
	private ServiceProcessForm serviceProcessForm;
	
	/**
	 * The process type service
	 */
	private ServiceProcessType serviceProcessType;
	
	/**
	 * The process task service.
	 */
	private ServiceProcessTask serviceProcessTask;
	
	/**
	 * The process history service.
	 */
	private ServiceProcessHistory serviceProcessHistory;
	
	/**
	 * The school department service
	 */
	private ServiceSchoolDepartment serviceSchoolDepartment;
	
	/**
	 * The school department position service
	 */
	private ServiceSchoolDepartmentPosition serviceSchoolDepartmentPosition;
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.flow.ServiceWorkFlow#doStartProcess(java.lang.String, java.lang.String, java.lang.String, java.lang.String, org.shengrui.oa.model.system.ModelAppUser)
	 */
	@Override
	public void doStartProcess (String processTypeId, 
			String filterPositions, Object condParamVal, String formNo, ModelHrmEmployee employee) throws ServiceException
	{
		List<ModelProcessDefinition> processDefs = this.serviceProcessDefinition.getProcessDefinition(
				processTypeId, filterPositions, condParamVal);
		
		if (processDefs != null && processDefs.size() > 0)
		{
			ModelProcessDefinition def = null;
			
			if (condParamVal != null && UtilString.isNotEmpty(condParamVal.toString()))
			{
				// Evaluates the condition from the obtained process definitions.
				for (ModelProcessDefinition processDef : processDefs)
				{
					if (AppUtil.isCondExprSatisfied(processDef.getCondition(), condParamVal))
					{
						def = processDef;
					}
				}
				
				if (def == null)
				{
					throw new ServiceException("No process entities found for the specified type:" + processTypeId);
				}
			}
			else
			{
				// it's only accepted one process definition.
				if (processDefs.size() == 1)
				{
					def = processDefs.get(0);
				}
				else
				{
					throw new ServiceException("More than one process definition is found.");
				}
			}
			
			// obtains set of process tasks.
			Set<ModelProcessTask> tasks = def.getProcessTasks();
			if (tasks != null && tasks.size() > 0)
			{
				for (ModelProcessTask task : tasks)
				{
					ModelProcessForm form = this.convertTaskToForm(task, processTypeId, formNo, employee);
					
					if (form != null)
					{
						this.serviceProcessForm.save(form);
					}
				}
			}
			else
			{
				throw new ServiceException("No tasks definition found for the process definition.");
			}
		}
		else
		{
			throw new ServiceException("No process entities found for the specified type:" + processTypeId);
		}
		
	}

	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.flow.ServiceWorkFlow#getProcessDefinitionByDefId(java.lang.String)
	 */
	@Override
	public ModelProcessDefinition getProcessDefinitionByDefId(String defId)
			throws ServiceException
	{
		return this.serviceProcessDefinition.get(defId);
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.flow.ServiceWorkFlow#getProcessTaskNodesByDefId(java.lang.String)
	 */
	@Override
	public List<ModelProcessTask> getProcessTaskNodesByDefId(String defId)
			throws ServiceException
	{
		return this.serviceProcessTask.getProcessTaskNodesByDefId(defId);
	}

	@Override
	public ModelProcessTask getPreTask(String taskId) throws ServiceException
	{
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ModelProcessTask getNextTask(String taskId) throws ServiceException
	{
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean isProcessInstanceEnded(String taskId)
			throws ServiceException
	{
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public void jumpToPreTask(String taskId, String comments)
			throws ServiceException
	{
		// TODO Auto-generated method stub
		
	}

	@Override
	public void completeTask(String taskId) throws ServiceException
	{
		// TODO Auto-generated method stub
		
	}

	@Override
	public void doEndProcess(String taskId) throws ServiceException
	{
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<ModelProcessHistory> getProcessHistoriesByFormNo(String formNo)
			throws ServiceException
	{
		// TODO Auto-generated method stub
		return null;
	}
	
	/**
	 * Converts the specified process task to process form entity.
	 * 
	 * @param task
	 *          the process task entity
	 * @param processTypeId
	 *          the process type id
	 * @param formNo
	 *          the application form no
	 * @param employee
	 *          the employee entity.
	 * @return entity of process form
	 */
	private ModelProcessForm convertTaskToForm (ModelProcessTask task, 
			String processTypeId, String formNo, ModelHrmEmployee employee) throws ServiceException
	{
		if (task != null)
		{
			ModelProcessForm form = new ModelProcessForm();
			
			if (ModelProcessTask.EProcessTaskType.OWNER_DEPS_AGAINST.getValue().equals(
					task.getProcessTaskType()))
			{
				// Handles against on district
				if (employee.getEmployeeDepartment() != null)
				{
					form.setToDepartmentIds(employee.getEmployeeDepartment().getId());
					form.setToDepartmentNames(employee.getEmployeeDepartment().getDepName());
					
					PairObject<String, String> matchedPosition = this.getMatchedPositionEntity(
							employee.getEmployeeDepartment().getId(), task.getToPositionIds());
					if (matchedPosition != null)
					{
						form.setToPositionIds(matchedPosition.getLeft());
						form.setToPositionNames(matchedPosition.getRight());
					}
				}
			}
			else if (ModelProcessTask.EProcessTaskType.MASTER_DEPS_AGAINST.getValue().equals(
					task.getProcessTaskType()))
			{
				// Handles against on master
				if (employee.getEmployeeDepartment() != null && 
						employee.getEmployeeDepartment().getDepEquivalentBranch() != null)
				{
					form.setToDepartmentIds(
							employee.getEmployeeDepartment().getDepEquivalentBranch().getId());
					form.setToDepartmentNames(
							employee.getEmployeeDepartment().getDepEquivalentBranch().getDepName());
				}
				
				PairObject<String, String> matchedPosition = this.getMatchedPositionEntity(
						employee.getEmployeeDepartment().getDepEquivalentBranch().getId(), task.getToPositionIds());
				if (matchedPosition != null)
				{
					form.setToPositionIds(matchedPosition.getLeft());
					form.setToPositionNames(matchedPosition.getRight());
				}
			}
			else
			{
				form.setToDepartmentNames(task.getToDepartmentNames());
				form.setToDepartmentIds(task.getToDepartmentIds());
				form.setToPositionIds(task.getToPositionIds());
				form.setToPositionNames(task.getToPositionNames());
			}
			
			form.setTaskType(task.getProcessTaskType());
			form.setProcessType(this.serviceProcessType.get(processTypeId));
			
			// The following properties can be ignored during the current cases.
			form.setToUserIds(task.getToUserIds());
			form.setToUserNames(task.getToUserNames());
			form.setToRoleIds(task.getToRoleIds());
			form.setToRoleNames(task.getToRoleNames());
			
			form.setApplyFormNo(formNo);
			form.setSortCode(task.getSortCode());
			
			return form;
		}
		
		return null;
	}
	
	/**
	 * Obtain the matched position id from the position list laid in the department id.
	 * 
	 * @param depId
	 *          the department id
	 * @param posIds
	 *          the position id
	 * @return matched position pair object
	 */
	private PairObject<String, String> getMatchedPositionEntity (String depId, String posIds)
	{
		if (UtilString.isNotEmpty(depId, posIds))
		{
			try
			{
				ModelSchoolDepartment dep = this.serviceSchoolDepartment.get(depId);
				if (dep != null && dep.getPositions() != null)
				{
					for (ModelSchoolDepartmentPosition pos : dep.getPositions())
					{
						if (JstlTagString.inRange(posIds, pos.getId(), ","))
						{
							return new PairObject<String, String>(pos.getId(), pos.getPositionName());
						}
					}
				}
			} 
			catch (ServiceException e)
			{
				LOGGER.error("It failed to fetch the matched position entity from (depId: posIds) : (" + depId + ": " + posIds + ")", e);
			}
			
		}
		return null;
	}

	public void setServiceProcessDefinition(ServiceProcessDefinition serviceProcessDefinition)
	{
		this.serviceProcessDefinition = serviceProcessDefinition;
	}

	public ServiceProcessDefinition getServiceProcessDefinition()
	{
		return serviceProcessDefinition;
	}

	public void setServiceProcessForm(ServiceProcessForm serviceProcessForm)
	{
		this.serviceProcessForm = serviceProcessForm;
	}

	public ServiceProcessForm getServiceProcessForm()
	{
		return serviceProcessForm;
	}

	public void setServiceProcessTask(ServiceProcessTask serviceProcessTask)
	{
		this.serviceProcessTask = serviceProcessTask;
	}

	public ServiceProcessTask getServiceProcessTask()
	{
		return serviceProcessTask;
	}

	public void setServiceProcessHistory(ServiceProcessHistory serviceProcessHistory)
	{
		this.serviceProcessHistory = serviceProcessHistory;
	}

	public ServiceProcessHistory getServiceProcessHistory()
	{
		return serviceProcessHistory;
	}

	public void setServiceSchoolDepartment(ServiceSchoolDepartment serviceSchoolDepartment)
	{
		this.serviceSchoolDepartment = serviceSchoolDepartment;
	}

	public ServiceSchoolDepartment getServiceSchoolDepartment()
	{
		return serviceSchoolDepartment;
	}

	public void setServiceSchoolDepartmentPosition(
			ServiceSchoolDepartmentPosition serviceSchoolDepartmentPosition)
	{
		this.serviceSchoolDepartmentPosition = serviceSchoolDepartmentPosition;
	}

	public ServiceSchoolDepartmentPosition getServiceSchoolDepartmentPosition()
	{
		return serviceSchoolDepartmentPosition;
	}

	public static Logger getLogger()
	{
		return LOGGER;
	}

	public void setServiceProcessType(ServiceProcessType serviceProcessType)
	{
		this.serviceProcessType = serviceProcessType;
	}

	public ServiceProcessType getServiceProcessType()
	{
		return serviceProcessType;
	}

}

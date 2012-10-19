package org.shengrui.oa.service.flow.impl;

import java.util.Date;
import java.util.List;
import java.util.Set;

import org.apache.log4j.Logger;
import org.shengrui.oa.model.flow.ModelProcessDefinition;
import org.shengrui.oa.model.flow.ModelProcessForm;
import org.shengrui.oa.model.flow.ModelProcessHistory;
import org.shengrui.oa.model.flow.ModelProcessTask;
import org.shengrui.oa.model.hrm.ModelHrmEmployee;
import org.shengrui.oa.model.system.ModelAppUser;
import org.shengrui.oa.model.system.ModelSchoolDepartment;
import org.shengrui.oa.model.system.ModelSchoolDepartmentPosition;
import org.shengrui.oa.model.system.ModelSchoolDistrict;
import org.shengrui.oa.service.flow.ServiceProcessDefinition;
import org.shengrui.oa.service.flow.ServiceProcessForm;
import org.shengrui.oa.service.flow.ServiceProcessHistory;
import org.shengrui.oa.service.flow.ServiceProcessTask;
import org.shengrui.oa.service.flow.ServiceProcessType;
import org.shengrui.oa.service.flow.ServiceWorkFlow;
import org.shengrui.oa.service.hrm.ServiceHrmEmployee;
import org.shengrui.oa.service.system.ServiceSchoolDepartment;
import org.shengrui.oa.service.system.ServiceSchoolDepartmentPosition;
import org.shengrui.oa.util.AppUtil;
import org.shengrui.oa.util.ContextUtil;

import cn.trymore.core.bean.PairObject;
import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.jstl.JstlTagString;
import cn.trymore.core.util.UtilBean;
import cn.trymore.core.util.UtilCollection;
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
	
	/**
	 * The employee service
	 */
	private ServiceHrmEmployee serviceHrmEmployee;
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.flow.ServiceWorkFlow#doStartProcess(java.lang.String, java.lang.String, java.lang.String, java.lang.String, org.shengrui.oa.model.system.ModelAppUser)
	 */
	@Override
	public ModelProcessForm doStartProcess (String processTypeId, 
			ModelSchoolDepartmentPosition filterPosition, Object condParamVal, String formNo, ModelHrmEmployee employee) throws ServiceException
	{
		return doStartProcess(processTypeId, filterPosition, null, condParamVal, formNo, employee);
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.flow.ServiceWorkFlow#doStartProcess(java.lang.String, java.lang.String, java.lang.String, java.lang.String, org.shengrui.oa.model.system.ModelAppUser)
	 */
	public ModelProcessForm doStartProcess (String processTypeId, 
			ModelSchoolDepartmentPosition filterPosition, ModelSchoolDistrict filterDistrict, Object condParamVal, String formNo, ModelHrmEmployee employee) throws ServiceException
	{
		ModelProcessForm firstItem = null;
		
		List<ModelProcessDefinition> processDefs = this.serviceProcessDefinition.getProcessDefinition(
				processTypeId, filterPosition, condParamVal);
		
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
				if (processDefs.size() > 0)
				{
					def = processDefs.get(0);
				}
			}
			
			// obtains set of process tasks.
			Set<ModelProcessTask> tasks = def.getProcessTasks();
			if (tasks != null && tasks.size() > 0)
			{
				boolean isFirstStep = true;
				
				for (ModelProcessTask task : tasks)
				{
					ModelProcessForm form = this.convertTaskToForm(task, 
							processTypeId, formNo, employee, filterDistrict, isFirstStep);
					
					// 判断当前Form是否被设置为第一个审批节点..
					if (ModelProcessForm.EProcessFormStatus.ONAPPROVING.getValue().equals(form.getAuditState())
							&& isFirstStep)
					{
						firstItem = form;
					}
					
					if (isFirstStep && ModelProcessForm.EProcessFormStatus.IGNORED.getValue().equals(form.getAuditState()))
					{
						isFirstStep = true;
					}
					else
					{
						isFirstStep = false;
					}
					
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
		
		return firstItem;
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.flow.ServiceWorkFlow#proceed(java.lang.String, java.lang.Integer, java.lang.String)
	 */
	@Override
	public PairObject<Boolean, ModelProcessForm> proceed (String procFormId, 
			Integer procFormState, String comments) throws ServiceException
	{
		ModelProcessForm entityDist = null;
		
		if (ModelProcessForm.EProcessFormStatus.APPROVED.getValue().equals(procFormState))
		{
			// 审批通过, 跳转到下一个审批节点..
			entityDist = this.jumpToNextTask(procFormId, comments);
		}
		else if (ModelProcessForm.EProcessFormStatus.RETURNED.getValue().equals(procFormState))
		{
			// 审批退回
			entityDist = this.jumpToPreTask(procFormId, comments);
		}
		else if (ModelProcessForm.EProcessFormStatus.NOTPASSED.getValue().equals(procFormState))
		{
			// 审批不通过
			completeTask(procFormId, ModelProcessForm.EProcessFormStatus.NOTPASSED.getValue(), comments);
		}
		
		return new PairObject<Boolean, ModelProcessForm> (true, entityDist);
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
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.flow.ServiceWorkFlow#jumpToPreTask(java.lang.String, java.lang.String)
	 */
	@Override
	public ModelProcessForm jumpToPreTask(String procFormId, String comments)
			throws ServiceException
	{
		ModelProcessForm preFormEntity = null;
		
		ModelProcessForm procForm = this.serviceProcessForm.get(procFormId);
		
		if (procForm != null)
		{
			ModelProcessForm previousForm = this.serviceProcessForm.getPreviousProcessForm(procFormId);
			
			while (true)
			{
				if (previousForm == null)
				{
					// 当前为第一个流程节点, 回退代表结束.
					this.completeTask(procForm, ModelProcessForm.EProcessFormStatus.RETURNED.getValue(), comments);
					break;
				}
				else
				{
					if (this.isProcessIgnored(previousForm))
					{
						previousForm = this.serviceProcessForm.getPreviousProcessForm(previousForm.getId());
						continue;
					}
					else
					{
						// 回退到上一个节点, 并重置当前节点状态.
						this.completeTask(procForm, null, ModelProcessForm.EProcessFormStatus.RETURNED.getValue(), comments);
						
						// 重置前一个审批流程节点为待审批状态
						previousForm.setAuditState(ModelProcessForm.EProcessFormStatus.ONAPPROVING.getValue());
						this.serviceProcessForm.save(previousForm);
						
						preFormEntity = previousForm;
						break;
					}
				}
			}
		}
		
		return preFormEntity;
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.flow.ServiceWorkFlow#jumpToNextTask(java.lang.String, java.lang.String, java.lang.String)
	 */
	@Override
	public ModelProcessForm jumpToNextTask(String procFormId,
			String comments) throws ServiceException
	{
		ModelProcessForm nextFormEntity = null;
		
		ModelProcessForm procForm = this.serviceProcessForm.get(procFormId);
		
		if (procForm != null)
		{
			// 完成当前流程节点并生成审批历史记录
			this.completeTask(procForm, ModelProcessForm.EProcessFormStatus.APPROVED.getValue(), comments);
			
			// 查找下一个流程节点
			ModelProcessForm nextForm = this.serviceProcessForm.getNextProcessForm(procFormId);
			while (true)
			{
				if (nextForm != null)
				{
					if (this.isProcessIgnored(nextForm))
					{
						// 无法触及, 流程忽略
						this.completeTask(nextForm, ModelProcessForm.EProcessFormStatus.IGNORED.getValue(), null);
						
						// 查找下一个几点
						nextForm = this.serviceProcessForm.getNextProcessForm(nextForm.getId());
						this.completeTask(procForm, ModelProcessForm.EProcessFormStatus.APPROVED.getValue(), comments);
					}
					else
					{
						nextForm.setAuditState(ModelProcessForm.EProcessFormStatus.ONAPPROVING.getValue());
						this.serviceProcessForm.save(nextForm);
						
						nextFormEntity = nextForm;
						break;
					}
				}
				else
				{
					// 当前已经是最后一个节点了, 移除ProcessForm表中的记录
					this.doEndProcess(procForm.getApplyFormNo());
					break;
				}
			}
		}
		
		return nextFormEntity;
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.flow.ServiceWorkFlow#doEndProcess(java.lang.String)
	 */
	@Override
	public void doEndProcess(String procFormNo) throws ServiceException
	{
		this.serviceProcessForm.removeFormByNo(procFormNo);
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.flow.ServiceWorkFlow#getProcessHistoriesByFormNo(java.lang.String)
	 */
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
	 * @param isFistStep
	 *          the flag for first step
	 * @return entity of process form
	 */
	private ModelProcessForm convertTaskToForm (ModelProcessTask task, 
			String processTypeId, String formNo, ModelHrmEmployee employee, ModelSchoolDistrict toDistrict, boolean isFistStep) throws ServiceException
	{
		if (task != null)
		{
			ModelProcessForm form = new ModelProcessForm();
			
			if (ModelProcessTask.EProcessTaskType.OWNER_DEPS_AGAINST.getValue().equals(task.getProcessTaskType()))
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
					else
					{
						// 节点无法触及, 直接忽略.
						form.setAuditState(ModelProcessForm.EProcessFormStatus.IGNORED.getValue());
					}
				}
			}
			else if (ModelProcessTask.EProcessTaskType.TRANSFER_DEPS.getValue().equals(task.getProcessTaskType()))
			{
				// 晋升/调动
				form.setToPositionIds(task.getToPositionIds());
				form.setToPositionNames(task.getToPositionNames());
				form.setToDepartmentIds(task.getToDepartmentIds());
				form.setToDepartmentNames(task.getToDepartmentNames());
				form.setToDistrictIds(toDistrict.getId());
				form.setToDistrictNames(toDistrict.getDistrictName());
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
			
			// double confirm whether employee existed in the destination department & position.
			List<ModelHrmEmployee> employees = this.serviceHrmEmployee.getByDepartmentAndPosition(
					form.getToDepartmentIds(), form.getToPositionIds());
			if (!UtilCollection.isNotEmpty(employees))
			{
				// 节点无法触及, 直接忽略.
				form.setAuditState(ModelProcessForm.EProcessFormStatus.IGNORED.getValue());
			}
			
			// Sets the first task node status be approving. 
			if (form.getAuditState() == null && isFistStep)
			{
				form.setAuditState(ModelProcessForm.EProcessFormStatus.ONAPPROVING.getValue());
			}
			
			// Sets the destination district as master
			if (form.getToDistrictIds() == null)
			{
				if (ModelProcessTask.EProcessTaskType.MASTER_DEPS_AGAINST.getValue().equals(task.getProcessTaskType()) || 
					ModelProcessTask.EProcessTaskType.MASTER_DEPS_SINGLE.getValue().equals(task.getProcessTaskType()))
				{
					form.setToDistrictIds("1");
				}
				else
				{
					form.setToDistrictIds(employee.getEmployeeDistrict().getId());
					form.setToDistrictNames(employee.getEmployeeDistrict().getDistrictName());
				}
			}
			return form;
		}
		
		return null;
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.flow.ServiceWorkFlow#completeTask(java.lang.String, java.lang.String, java.lang.String)
	 */
	@Override
	public void completeTask(String procFormId, 
			Integer auditState, String comments) throws ServiceException
	{
		completeTask(this.serviceProcessForm.get(procFormId), auditState, comments);
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.flow.ServiceWorkFlow#cleanProcess(java.lang.String)
	 */
	@Override
	public ModelProcessForm resetProcess (String procFormNo) throws ServiceException
	{
		ModelProcessForm fistFormNode = null;
		
		List<ModelProcessForm> forms = this.serviceProcessForm.getProcessFormsByFormNo(procFormNo);
		if (forms != null)
		{
			boolean isFirstStep = false;
			for (ModelProcessForm form : forms)
			{
				if (ModelProcessForm.EProcessFormStatus.IGNORED.getValue().equals(form.getAuditState()))
				{
					continue;
				}
				
				if (!isFirstStep)
				{
					isFirstStep = true;
					form.setAuditState(ModelProcessForm.EProcessFormStatus.ONAPPROVING.getValue());
					fistFormNode = form;
				}
				else
				{
					form.setAuditState(null);
				}
				
				form.setAuditDate(null);
				form.setAuditIdea(null);
				
				this.serviceProcessForm.save(form);
			}
		}
		
		return fistFormNode;
	}
	
	/**
	 * Completes the task with the specified process form entity.
	 * 
	 * @param procForm
	 *                 the process form entity
	 * @param auditState
	 *                 the audit state
	 * @param comments
	 *                 the audit comments
	 * @throws ServiceException
	 */
	private void completeTask(ModelProcessForm procForm, 
			Integer auditState, String comments) throws ServiceException
	{
		this.completeTask(procForm, auditState, auditState, comments);
	}
	
	/**
	 * Completes the task with the specified process form entity.
	 * 
	 * @param procForm
	 *                 the process form entity
	 * @param auditState
	 *                 the audit state
	 * @param historyAuditState
	 *                 the history audit state
	 * @param comments
	 *                 the audit comments
	 * @throws ServiceException
	 */
	private void completeTask(ModelProcessForm procForm, 
			Integer auditState, Integer historyAuditState, String comments) throws ServiceException
	{
		if (procForm != null)
		{
			// 设置审批状态
			procForm.setAuditState(auditState);
			
			// 设置审批人相关信息
			ModelAppUser user = ContextUtil.getCurrentUser();
			if (user != null)
			{
				procForm.setAuditUserIds(user.getId());
				procForm.setAuditUserNames(user.getFullName());
				
				if (user.getEmployee() != null)
				{
					if (user.getEmployee().getEmployeeDepartment() != null)
					{
						procForm.setAuditDepartmentIds(user.getEmployee().getEmployeeDepartment().getId());
						procForm.setAuditDepartmentNames(user.getEmployee().getEmployeeDepartment().getDepName());
					}
					
					if (user.getEmployee().getEmployeePosition() != null)
					{
						procForm.setAuditPositionIds(user.getEmployee().getEmployeePosition().getId());
						procForm.setAuditPositionNames(user.getEmployee().getEmployeePosition().getPositionName());
					}
					
					if (user.getEmployee().getEmployeeDistrict() != null)
					{
						procForm.setAuditDistrictIds(user.getEmployee().getEmployeeDistrict().getId());
						procForm.setAuditDistrictNames(user.getEmployee().getEmployeeDistrict().getDistrictName());
					}
				}
				
				procForm.setAuditUserIds(user.getId());
				procForm.setAuditUserNames(user.getFullName());
			}
			else
			{
				throw new ServiceException("No session user entity found.");
			}
			
			procForm.setAuditIdea(comments);
			procForm.setAuditDate(new Date());
			
			this.serviceProcessForm.save(procForm);
			
			// 记录流程审批历史记录...
			doRecordProcessHistory(procForm, historyAuditState);
			
			// 审批未通过
			if (ModelProcessForm.EProcessFormStatus.NOTPASSED.getValue().equals(auditState))
			{
				this.doEndProcess(procForm.getApplyFormNo());
			}
		}
		else
		{
			throw new ServiceException("Nullpointer exception was found when completing the task.");
		}
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
	
	/**
	 * Records process operation as history.
	 * 
	 * @param formId
	 *                the process form id
	 * @return
	 */
	@SuppressWarnings("unused")
	private boolean doRecordProcessHistory (String formId) throws ServiceException
	{
		return this.doRecordProcessHistory(this.serviceProcessForm.get(formId), null);
	}
	
	/**
	 * Records process operation as history.
	 * 
	 * @param formEntity
	 *                  the process form entity
	 * @param auditState
	 *                  the audit state
	 * @return
	 */
	private boolean doRecordProcessHistory (ModelProcessForm formEntity, Integer auditState) throws ServiceException
	{
		if (formEntity != null)
		{
			try
			{
				ModelProcessHistory procHistory = new ModelProcessHistory();
				
				// 将ProcessForm中的属性值拷贝至历史数据中.
				UtilBean.copyNotNullProperties(procHistory, formEntity);
				
				// 避免对象未被有效赋值
				procHistory.setAuditDate(formEntity.getAuditDate());
				
				if (auditState != null)
				{
					procHistory.setAuditState(auditState);
				}
				
				procHistory.setId(null);
				
				this.serviceProcessHistory.save(procHistory);
				
				return true;
			}
			catch (Exception e)
			{
				throw new ServiceException("Exception raised when do record the process history.", e);
			}
		}
		
		return false;
	}
	
	/**
	 * Returns true if the process set as ignored.
	 * 
	 * @param procForm
	 * @return
	 */
	private boolean isProcessIgnored (ModelProcessForm procForm)
	{
		if (procForm != null)
		{
			return !UtilString.isNotEmpty(procForm.getToPositionIds()) || 
					(procForm.getAuditState() != null && ModelProcessForm.EProcessFormStatus.IGNORED.getValue().equals(procForm.getAuditState()));
		}
		
		return false;
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

	public void setServiceProcessType(ServiceProcessType serviceProcessType)
	{
		this.serviceProcessType = serviceProcessType;
	}

	public ServiceProcessType getServiceProcessType()
	{
		return serviceProcessType;
	}
	
	public static Logger getLogger()
	{
		return LOGGER;
	}

	public ServiceHrmEmployee getServiceHrmEmployee()
	{
		return serviceHrmEmployee;
	}

	public void setServiceHrmEmployee(ServiceHrmEmployee serviceHrmEmployee)
	{
		this.serviceHrmEmployee = serviceHrmEmployee;
	}
}

package org.shengrui.oa.service.flow;

import java.util.List;

import org.shengrui.oa.model.flow.ModelProcessDefinition;
import org.shengrui.oa.model.system.ModelSchoolDepartmentPosition;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.ServiceGeneric;

/**
 * The service for process definition.
 * 
 * @author Jeccy.Zhao
 *
 */
public interface ServiceProcessDefinition
extends ServiceGeneric<ModelProcessDefinition>
{
	
	/**
	 * Obtains list of process definitions with the specified type id.
	 * 
	 * @param processTypeId
	 *           the process type id
	 * @return list of process definition entities
	 * @throws ServiceException
	 */
	List<ModelProcessDefinition> getProcessDefinitionByType (String processTypeId) 
		throws ServiceException;
	
	/**
	 * Obtains list of process definition entities with the specified 
	 * process type and some conditions, like e.g. the filter positions and condition
	 * 
	 * @param processTypeId
	 *            the process type id
	 * @param filterPosition
	 *            the filtered position
	 * @param condParamValue
	 *            the condition parameter value
	 * @return list of process definition entities
	 * @throws ServiceException
	 */
	List<ModelProcessDefinition> getProcessDefinition (String processTypeId,
			ModelSchoolDepartmentPosition filterPosition, Object condParamValue) throws ServiceException;
	
	/**
	 * Obtains list of process definitions filtered by position set id.
	 * 
	 * @param procTypeId
	 *           the process type id
	 * @param posetId
	 *           the position set id
	 * @return list of process definition entities
	 * @throws ServiceException
	 */
	List<ModelProcessDefinition> getProcessDefinitionFilterByPoset (String procTypeId, 
			String posetId) throws ServiceException;
	
	/**
	 * Returns true if 
	 * 
	 * @param procTypeId
	 * @param filterPosetId
	 * @return
	 * @throws ServiceException
	 */
	boolean removeByTypeAndPoset (String procTypeId, String filterPosetId) throws ServiceException;
	
}

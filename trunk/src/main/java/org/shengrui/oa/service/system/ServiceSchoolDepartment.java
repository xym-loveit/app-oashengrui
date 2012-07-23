package org.shengrui.oa.service.system;

import java.util.List;

import org.shengrui.oa.model.system.ModelSchoolDepartment;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.ServiceGeneric;

/**
 * The service of school department
 * 
 * @author Jeccy.Zhao
 *
 */
public interface ServiceSchoolDepartment
extends ServiceGeneric<ModelSchoolDepartment>
{
	/**
	 * 
	 * @param orgType
	 * @return
	 * @throws ServiceException
	 */
	 List<ModelSchoolDepartment> getDepartmentByOrganization(Integer orgType) throws ServiceException;
	 
	 /**
	  * Obtains distinct names of department.
	  * 
	  * @return
	  * @throws ServiceException
	  */
	 List<Object> getDistinctDepartmentNames () throws ServiceException;
	 
}

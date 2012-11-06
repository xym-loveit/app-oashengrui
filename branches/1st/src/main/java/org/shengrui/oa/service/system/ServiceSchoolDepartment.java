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
	 
	 /**
	  * 根据部门名称获取部门
	  * @author pyc
	  * */
	 ModelSchoolDepartment getDepartmentByName(String departmentName) throws ServiceException;
	 
	 /**
	  * 根据部门名称和所属校区类型获取部门
	  * 
	  * @param departmentName
	  * @return
	  * @throws ServiceException
	  */
	 ModelSchoolDepartment getDepartmentByName(String departmentName, 
			 Integer districtType) throws ServiceException;
	 
	 /**
	  * Obtains department ids with the specified department name
	  * 
	  * @param departmentName
	  *                    the department name
	  * @return list of department ids
	  * @throws ServiceException
	  */
	 List<Object> getDepartmentIdsByName (String departmentName) throws ServiceException;
}

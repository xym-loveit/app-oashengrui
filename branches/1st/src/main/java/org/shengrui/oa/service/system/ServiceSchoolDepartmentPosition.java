package org.shengrui.oa.service.system;

import java.util.List;

import org.shengrui.oa.model.system.ModelSchoolDepartmentPosition;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.ServiceGeneric;

/**
 * The service of school department
 * 
 * @author Jeccy.Zhao
 *
 */
public interface ServiceSchoolDepartmentPosition
extends ServiceGeneric<ModelSchoolDepartmentPosition>
{
	/**
	 * 根据部门ID获取岗位列表
	 * 
	 * @param departmentId
	 * @return
	 * @throws ServiceException
	 */
	List<ModelSchoolDepartmentPosition> getPositionByDepartmentId(String departmentId) throws ServiceException;
	/**
	 * 根据岗位名称获取岗位信息
	 * @author pyc
	 * 
	 * */
	ModelSchoolDepartmentPosition getPositionByName(String positionName) throws ServiceException;
}

package org.shengrui.oa.dao.system;

import java.util.List;

import org.shengrui.oa.model.system.ModelSchoolDepartmentPosition;

import cn.trymore.core.dao.DAOGeneric;
import cn.trymore.core.exception.DAOException;

/**
 * The department position repository.
 * 
 * @author Jeccy.Zhao
 *
 */
public interface DAOSchoolDepartmentPosition
extends DAOGeneric<ModelSchoolDepartmentPosition>
{
	/**
	 * 根据部门ID获取岗位列表
	 * 
	 * @param departmentId
	 * @return
	 * @throws DAOException
	 */
	List<ModelSchoolDepartmentPosition> getPositionByDepartmentId (String departmentId) throws DAOException;
	
	/**
	 * 根据岗位名称获取岗位信息
	 * @author pyc
	 * 
	 * */
	ModelSchoolDepartmentPosition getPositionByName(String positionName) throws DAOException;
}

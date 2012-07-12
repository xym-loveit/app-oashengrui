package org.shengrui.oa.dao.system;

import java.util.List;

import org.shengrui.oa.model.system.ModelSchoolDepartment;

import cn.trymore.core.dao.DAOGeneric;
import cn.trymore.core.exception.DAOException;

/**
 * The department repository.
 * 
 * @author Jeccy.Zhao
 *
 */
public interface DAOWorkTemplate
extends DAOGeneric<ModelSchoolDepartment>
{
	
	/**
	 * 根据结构类型获取部门列表
	 * 
	 * @param orgType
	 * @return
	 * @throws DAOException
	 */
	List<ModelSchoolDepartment> getDepartmentByOrganization (Integer orgType) throws DAOException;
	
}

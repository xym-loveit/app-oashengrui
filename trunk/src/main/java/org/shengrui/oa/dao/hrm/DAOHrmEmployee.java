package org.shengrui.oa.dao.hrm;

import java.util.List;

import org.shengrui.oa.model.hrm.ModelHrmEmployee;

import cn.trymore.core.dao.DAOGeneric;
import cn.trymore.core.exception.DAOException;

/**
 * The repository for HRM employee.
 * 
 * @author Jeccy.Zhao
 *
 */
public interface DAOHrmEmployee
extends DAOGeneric<ModelHrmEmployee>
{
	/**
	 * Obtains the user with the specified user full name.
	 * 
	 * @param userName
	 *                 the user full name
	 * @param fetchAll
	 *                 fetch all if the user full name not given
	 * @return user entity if existed with the name; null returned otherwise.
	 * @throws DAOException
	 */
	List<ModelHrmEmployee> findByFullName (String fullName, 
			boolean fetchAll) throws DAOException;
	
	/**
	 * Obtains the user with the specified user full name.
	 * 
	 * @param userName
	 *                 the user full name
	 * @param localDistrictId
	 *                 the local district id
	 * @param fetchAll
	 *                 fetch all if the user full name not given
	 * @return user entity if existed with the name; null returned otherwise.
	 * @throws DAOException
	 */
	List<ModelHrmEmployee> findByFullName (String fullName, 
			String localDistrictId, boolean fetchAll) throws DAOException;
	
	/**
	 * 
	 * 根据员工编号查询员工信息
	 * @author pyc
	 * */
	ModelHrmEmployee getEmployeeByEmpNo(String empNo) throws DAOException;
}

package org.shengrui.oa.service.hrm;

import java.util.List;

import org.shengrui.oa.model.hrm.ModelHrmEmployee;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.ServiceGeneric;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

/**
 * The employee service.
 * 
 * @author Jeccy.Zhao
 *
 */
public interface ServiceHrmEmployee
extends ServiceGeneric<ModelHrmEmployee>
{
	
	/**
	 * Obtains employees with the specified full name.
	 * 
	 * @param fullName
	 *            the employee full name
	 * @return list of employee entities if existed with the specified full name; null returned otherwise.
	 * @throws ServiceException
	 */
	List<ModelHrmEmployee> findByFullName (String fullName) throws ServiceException;
	
	/**
	 * Obtains employees with the specified full name.
	 * 
	 * @param fullName
	 *             the employee full name
	 * @param fetchAll
	 *             fetch all if the full name not given
	 * @return list of employee entities if existed with the specified full name; null returned otherwise.
	 * @throws ServiceException
	 */
	List<ModelHrmEmployee> findByFullName (String fullName, boolean fetchAll) throws ServiceException;
	
	/**
	 * 根据员工信息查分页数据
	 * 
	 * @param entity
	 * @param pagingBen
	 * @return
	 * @throws ServiceException
	 */
	PaginationSupport<ModelHrmEmployee> getEmployeeInfoPagination (ModelHrmEmployee entity, 
			PagingBean pagingBen) throws ServiceException;
	
	/**
	 * 根据部门和岗位获取员工集合
	 * 
	 * @param depId
	 *                部门ID
	 * @param posId
	 *                岗位ID
	 * @return
	 * @throws ServiceException
	 */
	List<ModelHrmEmployee> getByDepartmentAndPosition (String depId, 
			String posId) throws ServiceException;
	
	/**
	 * 根据校区和部门查员工
	 */
	List<ModelHrmEmployee> getEmployeeByDistrictIdAndDeptId(ModelHrmEmployee entity) throws ServiceException;
	
	/**
	 * 根据校区和部门查员工
	 */
	List<ModelHrmEmployee> getEmployeeByDistrictIdAndDeptId(String depId, String districtId) throws ServiceException;
	
	/**
	 * 根据校区和部门ID获取拥有的员工数量
	 * 
	 * @param districtId
	 *                 校区ID
	 * @param depId
	 *                 部门ID
	 * @return 员工数量
	 * @throws ServiceException
	 */
	int getEmployeeAmoutByDistrictIdAndDepId (String districtId, 
			String depId) throws ServiceException;
	
	/**
	 * 根据员工编号查询员工信息
	 * @author pyc
	 * */
	ModelHrmEmployee getEmployeeByEmpNo(String empNo) throws ServiceException;
}

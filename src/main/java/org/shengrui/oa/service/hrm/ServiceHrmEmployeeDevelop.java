package org.shengrui.oa.service.hrm;

import org.shengrui.oa.model.hrm.ModelHrmEmployeeDevelop;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.ServiceGeneric;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

/**
 * The employee develop service.
 * 
 * @author Jeccy.Zhao
 *
 */
public interface ServiceHrmEmployeeDevelop
extends ServiceGeneric<ModelHrmEmployeeDevelop>
{
	
	/**
	 * Obtains employee develop entity with the specified form no.
	 * 
	 * @param formNo
	 * @return
	 * @throws ServiceException
	 */
	ModelHrmEmployeeDevelop getByFormNo (String formNo) throws ServiceException;
	
	/**
	 * 人力资源发展查分页数据
	 * 
	 * @param entity
	 * @param pagingBean
	 * @return
	 * @throws ServiceException
	 */
	PaginationSupport<ModelHrmEmployeeDevelop> getEmployeeDevelopInfoPagination (ModelHrmEmployeeDevelop entity, 
			PagingBean pagingBean) throws ServiceException;
	
	/**
	 * 人力资源发展查分页数据
	 * 
	 * @param entity
	 * @param pagingBean
	 * @return
	 * @throws ServiceException
	 */
	PaginationSupport<ModelHrmEmployeeDevelop> getEmployeeDevelopInfoPagination (ModelHrmEmployeeDevelop entity, 
			PagingBean pagingBean, boolean filterCurrentProcessNodes) throws ServiceException;
	
	/**
	 * 人力资源发展查分页数据
	 * 
	 * @param entity
	 * @param empId
	 * @param pagingBean
	 * @return
	 * @throws ServiceException
	 */
	PaginationSupport<ModelHrmEmployeeDevelop> getEmployeeDevelopInfoPagination (ModelHrmEmployeeDevelop entity, 
			String empId, PagingBean pagingBean, boolean filterCurrentProcessNodes) throws ServiceException;

	/**
	 * 查询未审批过的人资申请
	 * @author cqx
	 * */
	PaginationSupport<ModelHrmEmployeeDevelop> getfinanHr (ModelHrmEmployeeDevelop entity, 
			String query, PagingBean pagingBean) throws ServiceException;
	
	/**
	 * 
	 * 查询已审批过的人资申请
	 * @author cqx
	 * */
	PaginationSupport<ModelHrmEmployeeDevelop> getfinanHrRec (ModelHrmEmployeeDevelop entity, 
			PagingBean pagingBean) throws ServiceException;
}

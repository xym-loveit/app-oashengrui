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
	 * @param pagingBen
	 * @return
	 * @throws ServiceException
	 */
	PaginationSupport<ModelHrmEmployeeDevelop> getEmployeeDevelopInfoPagination (ModelHrmEmployeeDevelop entity, 
			PagingBean pagingBen) throws ServiceException;

	/**
	 * 查询未审批过的人资申请
	 * @author cqx
	 * */
	PaginationSupport<ModelHrmEmployeeDevelop> getfinanHr (ModelHrmEmployeeDevelop entity, 
			PagingBean pagingBean) throws ServiceException;
	
	/**
	 * 
	 * 查询已审批过的人资申请
	 * @author cqx
	 * */
	PaginationSupport<ModelHrmEmployeeDevelop> getfinanHrRec (ModelHrmEmployeeDevelop entity, 
			PagingBean pagingBean) throws ServiceException;
}

package org.shengrui.oa.service.hrm;

import org.shengrui.oa.model.hrm.ModelHrmEmployeeApply;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.ServiceGeneric;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

public interface ServiceHrmEmployeeDevelop
extends ServiceGeneric<ModelHrmEmployeeApply>
{
	
	/**
	 * 人力资源发展查分页数据
	 * 
	 * @param entity
	 * @param pagingBen
	 * @return
	 * @throws ServiceException
	 */
	PaginationSupport<ModelHrmEmployeeApply> getEmployeeDevelopInfoPagination (ModelHrmEmployeeApply entity, 
			PagingBean pagingBen) throws ServiceException;

}
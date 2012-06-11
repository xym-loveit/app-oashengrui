package org.shengrui.oa.service.hrm;

import org.shengrui.oa.model.hrm.ModelHrmEmployee;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.ServiceGeneric;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

public interface ServiceHrmEmployee
extends ServiceGeneric<ModelHrmEmployee>
{
	
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

<<<<<<< .mine
	/**
	 * 
	 * @param entity
	 * @param pagingBean
	 * @return
	 * @throws ServiceException
	 */
	PaginationSupport<ModelHrmEmployee> getPagination(ModelHrmEmployee entity,
			PagingBean pagingBean) throws ServiceException;

=======
>>>>>>> .r78
}

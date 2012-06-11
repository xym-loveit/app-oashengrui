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
	 * 
	 * @param entity
	 * @param pagingBean
	 * @return
	 * @throws ServiceException
	 */
	PaginationSupport<ModelHrmEmployee> getPagination(ModelHrmEmployee entity,
			PagingBean pagingBean) throws ServiceException;
}

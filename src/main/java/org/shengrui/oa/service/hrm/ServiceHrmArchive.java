package org.shengrui.oa.service.hrm;

import org.shengrui.oa.model.hrm.ModelHrmArchive;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.ServiceGeneric;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

public interface ServiceHrmArchive
extends ServiceGeneric<ModelHrmArchive>
{
	/**
	 * 
	 * @param entity
	 * @param pagingBean
	 * @return
	 * @throws ServiceException
	 */
	PaginationSupport<ModelHrmArchive> getPaginationByEntity (ModelHrmArchive entity, 
				PagingBean pagingBean) throws ServiceException;
	
}

package org.shengrui.oa.dao.hrm;

import org.shengrui.oa.model.hrm.ModelHrmArchive;

import cn.trymore.core.dao.DAOGeneric;
import cn.trymore.core.exception.DAOException;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

public interface DAOHrmArchive
extends DAOGeneric<ModelHrmArchive>
{
	
	/**
	 * @param entity
	 * @param pagingBean
	 * @return
	 * @throws DAOException
	 */
	PaginationSupport<ModelHrmArchive> getPagination (ModelHrmArchive entity, 
			PagingBean pagingBean) throws DAOException;
	
}

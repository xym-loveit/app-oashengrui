package org.shengrui.oa.dao.hrm;

import org.shengrui.oa.model.hrm.ModelHrmArchive;

import cn.trymore.core.dao.DAOGeneric;
import cn.trymore.core.exception.DAOException;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

/**
 * The repository for HRM archive.
 * 
 * @author Jeccy.Zhao
 *
 */
public interface DAOHrmArchive
extends DAOGeneric<ModelHrmArchive>
{
	
	/**
	 * Obtains archive entities with pagination wrapper. 
	 * 
	 * @param entity
	 *          the archive entity that used for criteria
	 * @param pagingBean
	 *          the paging bean object
	 * @return pagination of archive entities
	 * @throws DAOException
	 */
	PaginationSupport<ModelHrmArchive> getPagination (ModelHrmArchive entity, 
			PagingBean pagingBean) throws DAOException;
	
}

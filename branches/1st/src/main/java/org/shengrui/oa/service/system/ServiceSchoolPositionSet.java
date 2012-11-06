package org.shengrui.oa.service.system;

import org.shengrui.oa.model.system.ModelSchoolPositionSet;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.ServiceGeneric;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

/**
 * The interface for school position set service.
 * 
 * @author Jeccy.Zhao
 *
 */
public interface ServiceSchoolPositionSet
extends ServiceGeneric<ModelSchoolPositionSet>
{
	/**
	 * Obtains position set entity with the specified position set name.
	 * 
	 * @param posetName
	 *           the position set entity name
	 * @return entity of position set
	 * @throws ServiceException
	 */
	ModelSchoolPositionSet getByName(String posetName) 
			throws ServiceException;
	
	/**
	 * Obtains pagination of school position set entities.
	 * 
	 * @param entity
	 *           the school position set entity
	 * @param pagingBean
	 *           the paging bean.
	 * @return pagination of school position set entities
	 * @throws ServiceException
	 */
	PaginationSupport<ModelSchoolPositionSet> getPagination(ModelSchoolPositionSet entity,
			PagingBean pagingBean) throws ServiceException;
	
}

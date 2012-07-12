package org.shengrui.oa.service.admin;

import org.shengrui.oa.model.admin.ModelAdminWorkArrange;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.ServiceGeneric;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

/**
 * The service for admin work arrange
 * 
 * @author Tang
 *
 */
public interface ServiceAdminWorkArrange
extends ServiceGeneric<ModelAdminWorkArrange>
{
	
	/**
	 * 根据id得到一条工作安排记录
	 * @author Tang 
	 */
	public ModelAdminWorkArrange getById(String id)throws ServiceException;
	
	/**
	 * 根据信息查分页数据
	 * 
	 * @param entity
	 * @param pagingBean
	 * @return
	 * @throws ServiceException
	 */
	PaginationSupport<ModelAdminWorkArrange> getPaginationByEntity (ModelAdminWorkArrange entity, 
			PagingBean pagingBean) throws ServiceException;
	
}

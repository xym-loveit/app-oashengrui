package org.shengrui.oa.service.admin;

import java.util.List;

import org.shengrui.oa.model.admin.ModelAdminWorkArrange;
import org.shengrui.oa.model.admin.ModelDoc;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.ServiceGeneric;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

/**
 * The service for admin doc manage
 * 
 * @author Tang
 *
 */
public interface ServiceDocManage
extends ServiceGeneric<ModelDoc>
{
	
	/**
	 * 得到所有的文档信息
	 * @author Tang
	 */
	public List<ModelDoc> getAllDocInfo()throws ServiceException;
	
	/**
	 * 根据信息查分页数据
	 * 
	 * @param entity
	 * @param pagingBean
	 * @return
	 * @throws ServiceException
	 */
	PaginationSupport<ModelDoc> getPaginationByEntity (ModelDoc entity, 
			PagingBean pagingBean) throws ServiceException;
}

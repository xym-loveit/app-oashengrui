package org.shengrui.oa.service.finan;

import org.shengrui.oa.model.finan.ModelFinanProject;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.ServiceGeneric;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

/**
 * The financial project service.
 * 
 * @author Jeccy.Zhao
 *
 */
public interface ServiceFinanProject
extends ServiceGeneric<ModelFinanProject>
{
	
	/**
	 *根据申请单号 获取财物费用申请数据
	 * 
	 * @param formNo
	 *                申请单号
	 * @return
	 * @throws ServiceException
	 */
	ModelFinanProject getByFormNo (String formNo) throws ServiceException;
	
	/**
	 * 财务费用查分页数据
	 * 
	 * @param entity
	 * @param pagingBean
	 * @return
	 * @throws ServiceException
	 */
	PaginationSupport<ModelFinanProject> getFinanProjectInfoPagination (ModelFinanProject entity, 
			PagingBean pagingBean) throws ServiceException;
	
}

/**
 * 
 */
package org.shengrui.oa.service.system;

import java.util.List;

import org.shengrui.oa.model.system.ModelBaseWorkContent;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.ServiceGeneric;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

/**
 * @author Tank.L
 *
 */
public interface ServiceBaseWorkContent extends ServiceGeneric<ModelBaseWorkContent> {
	/**
	 * 根据id得到一条基础工作记录
	 * @author Tang 
	 */
	public ModelBaseWorkContent getById(String id)throws ServiceException;
	
	/**
	 * 根据信息查分页数据
	 * 
	 * @param entity
	 * @param pagingBean
	 * @return
	 * @throws ServiceException
	 */
	PaginationSupport<ModelBaseWorkContent> getPaginationByEntity (ModelBaseWorkContent entity, 
			PagingBean pagingBean) throws ServiceException;
	
	public List<ModelBaseWorkContent> getListByCriteria(ModelBaseWorkContent entity) throws ServiceException;
}

package org.shengrui.oa.service.system;


import java.util.List;

import org.shengrui.oa.model.system.ModelAppDictionary;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.ServiceGeneric;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

/**
 * The application dictionary service
 * 
 * @author Tang
 *
 */
public interface ServiceAppDictionary
extends ServiceGeneric<ModelAppDictionary>
{
	/**
	 * 
	 * @param itemName
	 * @return
	 * @throws ServiceException
	 */
	ModelAppDictionary getByName (String name) 
			throws ServiceException;
	
	/**
	 * 根据数据字典类型查询出新闻类型名称
	 * @param type
	 * @author pyc
	 * 
	 * */
	List<ModelAppDictionary> getByType(String type) throws ServiceException;
	
	/**
	 * 分页输出
	 * @param entity
	 * @param pagingBean
	 * @return
	 * @throws ServiceException
	 */
	PaginationSupport<ModelAppDictionary> getPaginationByCriteria(ModelAppDictionary entity,PagingBean pagingBean) throws ServiceException;
}

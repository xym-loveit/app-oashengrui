package org.shengrui.oa.service.news;

import org.shengrui.oa.model.news.ModelNewsMag;
import org.shengrui.oa.model.system.ModelAppDictionary;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.ServiceGeneric;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

public interface ServiceNewsManage
extends ServiceGeneric<ModelNewsMag>
{
	PaginationSupport<ModelNewsMag> getPaginationByNews(ModelNewsMag news,
			PagingBean pagingBean)throws ServiceException;
	
	/**
	 * 用于删除新闻纪录
	 * @param newsId
	 * @author pyc
	 * */
	public void deleteNewsByNewsId(String newsId) throws ServiceException;
	
	/**
	 * 根据newsId获取对象
	 * @param newsId
	 * @return ModelNewsMag
	 * @author pyc
	 * */
	public ModelNewsMag getModelNewsMag(String newsId) throws ServiceException;
	
	
	/**
	 * 修改新闻
	 * @param newsId
	 * @author pyc
	 * */
	public ModelNewsMag updateNews(ModelNewsMag modelNewsMag) throws ServiceException;
	
	
}

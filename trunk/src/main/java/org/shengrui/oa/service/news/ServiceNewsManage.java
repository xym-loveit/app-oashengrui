package org.shengrui.oa.service.news;

import org.shengrui.oa.model.news.ModelNewsMag;

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
	
	/**
	 * 查询新闻类别为”公司新闻“的新闻纪录
	 * @author pyc
	 * */
	PaginationSupport<ModelNewsMag> getCompanyNews(ModelNewsMag news,
			PagingBean pagingBean)throws ServiceException;
	
	/**
	 * 查询新闻类别为”校区新闻“的新闻纪录
	 * @author pyc
	 * */
	PaginationSupport<ModelNewsMag> getDistrictNews(ModelNewsMag news,
			PagingBean pagingBean)throws ServiceException;
	
	/**
	 * 查询新闻状态为等待审批的新闻记录
	 * @author pyc
	 * */
	PaginationSupport<ModelNewsMag> getNewsRec(ModelNewsMag news,
			PagingBean pagingBean)throws ServiceException;
	/**
	 * 查询已审批新闻记录
	 * @author pyc
	 * */
	PaginationSupport<ModelNewsMag> getNewsApprovalRec(ModelNewsMag news,
			PagingBean pagingBean)throws ServiceException;
}

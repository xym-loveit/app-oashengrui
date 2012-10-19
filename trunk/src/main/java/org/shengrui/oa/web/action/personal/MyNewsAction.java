package org.shengrui.oa.web.action.personal;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.shengrui.oa.model.news.ModelNewsMag;
import org.shengrui.oa.service.news.ServiceNewsManage;
import org.shengrui.oa.web.action.BaseAppAction;

import cn.trymore.core.exception.WebException;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

/**
 * WebAction: 我的新闻
 * 
 * @author intern (unknown name)
 *
 */
public class MyNewsAction
extends BaseAppAction
{
	/**
	 * The LOGGER
	 */
	private static final Logger LOGGER = Logger.getLogger(MyNewsAction.class);
	
	/**
	 * The service of news management
	 */
	@Resource
	protected ServiceNewsManage serviceNewsManage;
	
	public ActionForward pageMyNews(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws WebException
	{
		try 
		{
			PagingBean pagingBean = this.getPagingBean(request);
			PagingBean pagingBean1 = this.getPagingBean(request);
			ModelNewsMag formNews = new ModelNewsMag();
			
			formNews.setStatus(ModelNewsMag.newsStatus.APPROVED.getValue());
			
			// 公司新闻
			formNews.setNewsLevel(0);
			PaginationSupport<ModelNewsMag> newsCompany = 
					this.serviceNewsManage.getPaginationByNews(formNews, pagingBean);
			
			// 校区新闻
			formNews.setNewsLevel(1);
			PaginationSupport<ModelNewsMag> newsDistrict = 
					this.serviceNewsManage.getPaginationByNews(formNews, pagingBean1);
			
			request.setAttribute("newsCompany", newsCompany);
			request.setAttribute("newsDistrict", newsDistrict);
			request.setAttribute("op", request.getParameter("op"));
			
			// 输出分页信息至客户端
			outWritePagination(request, pagingBean, newsCompany);
			outWritePagination(request, pagingBean1, newsDistrict, "pagingBeanDistrict");
			
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
			LOGGER.error("Exception raised when open the archive index page.", e);
			return ajaxPrint(response, getErrorCallback("加载新闻发布与管理数据失败:" + e.getMessage()));
		}
		
		return mapping.findForward("page.my.news");
	}
	
	public ServiceNewsManage getServiceNewsManage() {
		return serviceNewsManage;
	}

	public void setServiceNewsManage(ServiceNewsManage serviceNewsManage) {
		this.serviceNewsManage = serviceNewsManage;
	}
}

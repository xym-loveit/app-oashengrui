package org.shengrui.oa.web.action.personal;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.shengrui.oa.model.admin.ModelTaskPlan;
import org.shengrui.oa.model.news.ModelNewsMag;
import org.shengrui.oa.web.action.BaseAppAction;

import cn.trymore.core.exception.WebException;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

/**
 * WebAction: 我的新闻
 * 
 * @author Jeccy.Zhao
 *
 */
public class MyNewsAction
extends BaseAppAction
{
	/**
	 * The LOGGER
	 */
	private static final Logger LOGGER = Logger.getLogger(MyNewsAction.class);
	
	public ActionForward pageMyNews(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws WebException
	{
		try {
			ModelNewsMag myNews = (ModelNewsMag) form;
			PagingBean pagingBean = this.getPagingBean(request);
			PagingBean pagingBean1 = this.getPagingBean(request);
			PaginationSupport<ModelNewsMag> news = this.serviceNewsManage.getCompanyNews(myNews, pagingBean);
			PaginationSupport<ModelNewsMag> newsdistrict = this.serviceNewsManage.getDistrictNews(myNews, pagingBean1);
			request.setAttribute("newsdistrict", newsdistrict);
			request.setAttribute("news", news);
			request.setAttribute("formNews", myNews);
			request.setAttribute("op", request.getParameter("op"));
			// 输出分页信息至客户端
			outWritePagination(request, pagingBean, news);
			outWritePagination1(request, pagingBean1, newsdistrict);
			
		} catch (Exception e) {
			e.printStackTrace();
			LOGGER.error("Exception raised when open the archive index page.", e);
			return ajaxPrint(response, getErrorCallback("加载新闻发布与管理数据失败:" + e.getMessage()));
		}
		
		return mapping.findForward("page.my.news");
	}
}

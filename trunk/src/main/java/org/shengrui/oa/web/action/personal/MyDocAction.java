package org.shengrui.oa.web.action.personal;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.shengrui.oa.model.admin.ModelDoc;
import org.shengrui.oa.model.admin.ModelDocLevel;

import cn.trymore.core.util.UtilCollection;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

/**
 * WebAction: 我的文档
 * 
 * @author Jeccy.Zhao
 *
 */
public class MyDocAction
extends BasePersonalAction
{
	
	/**
	 * The LOGGER
	 */
	private static final Logger LOGGER = Logger.getLogger(MyDocAction.class);
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 显示文档下载主界面
	 */
	public ActionForward pageMyDoc (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		try 
		{
			ModelDocLevel level1=this.getServiceDocLevel().get("1");//公司文档
			ModelDocLevel level2=this.getServiceDocLevel().get("2");//校区文档
			ModelDocLevel level3=this.getServiceDocLevel().get("3");//总部文档
			ModelDocLevel level4=this.getServiceDocLevel().get("4");//部分文档
			
			PagingBean pagingBean=new PagingBean();
			pagingBean.setPageSize(5);
			
			List<ModelDoc> company_docs1   =this.getServiceDocManage().getDocsByLevel(level1,null);

			List<ModelDoc> district_docs1  =this.getServiceDocManage().getDocsByLevel(level2,null);
			
			List<ModelDoc> department_docs1=this.getServiceDocManage().getDocsByLevel(level3,null);
			
			List<ModelDoc> deparent_docs1  =this.getServiceDocManage().getDocsByLevel(level4,null);
			
		    request.setAttribute("company_docs1",company_docs1);
		    request.setAttribute("district_docs1",district_docs1);
		    request.setAttribute("department_docs1",department_docs1);
		    request.setAttribute("deparent_docs1",deparent_docs1);
		    
		    // 首页我的文档加载视图渲染...
			if (request.getParameter("objOut") != null)
			{
				PaginationSupport<ModelDoc> items = new PaginationSupport<ModelDoc>();
				
				if (UtilCollection.isNotEmpty(company_docs1))
				{
					items.getItems().addAll(company_docs1);
				}
				
				if (UtilCollection.isNotEmpty(district_docs1))
				{
					items.getItems().addAll(district_docs1);
				}
				
				if (UtilCollection.isNotEmpty(department_docs1))
				{
					items.getItems().addAll(department_docs1);
				}
				
				if (UtilCollection.isNotEmpty(deparent_docs1))
				{
					items.getItems().addAll(deparent_docs1);
				}
				
				response.getWriter().write(ObjectToString(items));
				
				return null;
			}
				
		} 
		catch (Exception e)
		{
			LOGGER.error("Exception raised when  download docs.", e);
		}
		return mapping.findForward("page.my.doc");
	}
	
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 显示更多文档
	 */
	public ActionForward pageMyDocMore (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		try 
		{
			ModelDoc formDoc = (ModelDoc) form;
			String levelId=request.getParameter("levleId");
			String typeId=request.getParameter("typeId");
			
			ModelDocLevel level=this.getServiceDocLevel().get(levelId);
			
			formDoc.setDocLevel(level);
			
			PagingBean pagingBean = this.getPagingBean(request);
			PaginationSupport<ModelDoc> docs =
				this.getServiceDocManage().getPaginationByEntity(formDoc, pagingBean);
			
			request.setAttribute("docs", docs);
			request.setAttribute("levelId", levelId);
			request.setAttribute("typeId", typeId);
			request.setAttribute("docTypes", this.getServiceAppDictionary().getByType("docType"));
			request.setAttribute("formDoc", formDoc);
			
			// 输出分页信息至客户端
			outWritePagination(request, pagingBean, docs);
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
			LOGGER.error("Exception raised when  download docs.", e);
		}
		return mapping.findForward("page.my.doc.more");
	}
	
	private String ObjectToString(PaginationSupport<ModelDoc> list)
	{
		StringBuffer sb =new StringBuffer();
		if (list != null)
		{
			for (ModelDoc doc : list.getItems()) 
			{
				sb.append("<tr><td style=\"display: none;\">");
				sb.append(doc.getId()+"</td><td alt=\"" + doc.getFile().getFilePath() + "\">");
				sb.append(doc.getDocName());
				sb.append("</td><td>");
				sb.append(doc.getType().getValue()+"</td>");
				sb.append("<td>"+doc.getCreateTime()+"</td></tr>");
			}
			return sb.toString();
		}
		return "";
	}
}

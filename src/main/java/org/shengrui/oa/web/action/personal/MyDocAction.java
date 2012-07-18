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
import org.shengrui.oa.model.system.ModelAppDictionary;

import cn.trymore.core.exception.DAOException;
import cn.trymore.core.exception.ServiceException;
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
			
			ModelAppDictionary type1=this.getServiceAppDictionary().getByName("人资文档");
			ModelAppDictionary type2=this.getServiceAppDictionary().getByName("行政文档");
			
			PagingBean pagingBean=new PagingBean();
			pagingBean.setPageSize(5);
			
			List<ModelDoc> company_docs1   =this.getServiceDocManage().getDocsByLevel(level1,type1);
			List<ModelDoc> company_docs2   =this.getServiceDocManage().getDocsByLevel(level1,type2);
			
			List<ModelDoc> district_docs1  =this.getServiceDocManage().getDocsByLevel(level2,type1);
			List<ModelDoc> district_docs2  =this.getServiceDocManage().getDocsByLevel(level2,type2);
			
			List<ModelDoc> department_docs1=this.getServiceDocManage().getDocsByLevel(level3,type1);
			List<ModelDoc> department_docs2=this.getServiceDocManage().getDocsByLevel(level3,type2);
			
			List<ModelDoc> deparent_docs1  =this.getServiceDocManage().getDocsByLevel(level4,type1);
			List<ModelDoc> deparent_docs2  =this.getServiceDocManage().getDocsByLevel(level4,type2);
			
		    request.setAttribute("company_docs1",company_docs1);
		    request.setAttribute("company_docs2",company_docs2);
		    request.setAttribute("district_docs1",district_docs1);
		    request.setAttribute("district_docs2",district_docs2);
		    request.setAttribute("department_docs1",department_docs1);
		    request.setAttribute("department_docs2",department_docs2);
		    request.setAttribute("deparent_docs1",deparent_docs1);
		    request.setAttribute("deparent_docs2",deparent_docs2);
				
		} catch (ServiceException e)
		{
			LOGGER.error("Exception raised when  download docs.", e);
		} catch (DAOException e)
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
			
			System.out.println(levelId+"/"+typeId);
			
			ModelDocLevel level=this.getServiceDocLevel().get(levelId);
			ModelAppDictionary type=null;
			
			if("1".equals(typeId))
			{
				type=this.getServiceAppDictionary().getByName("人资文档");
			}else if("2".equals(typeId))
			{
				type=this.getServiceAppDictionary().getByName("行政文档");
			}
			
			formDoc.setDocLevel(level);
			formDoc.setType(type);
			
			PagingBean pagingBean = this.getPagingBean(request);
			PaginationSupport<ModelDoc> docs =
				this.getServiceDocManage().getPaginationByEntity(formDoc, pagingBean);
			
			request.setAttribute("docs", docs);
			request.setAttribute("levelId", levelId);
			request.setAttribute("typeId", typeId);
			
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
}

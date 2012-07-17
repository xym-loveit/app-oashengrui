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

import cn.trymore.core.exception.DAOException;
import cn.trymore.core.exception.ServiceException;

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
	 * The presentation page action for my work plan
	 */
	public ActionForward pageMyDoc (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		System.out.println("进入文档下载模块");
		try {
			ModelDocLevel level1=this.getServiceDocLevel().get("1");
			ModelDocLevel level2=this.getServiceDocLevel().get("2");
			ModelDocLevel level3=this.getServiceDocLevel().get("3");
			ModelDocLevel level4=this.getServiceDocLevel().get("4");
			
			List<ModelDoc> company_docs   =this.getServiceDocManage().getDocsByLevel(level1);
			List<ModelDoc> district_docs  =this.getServiceDocManage().getDocsByLevel(level2);
			List<ModelDoc> department_docs=this.getServiceDocManage().getDocsByLevel(level3);
			List<ModelDoc> deparent_docs  =this.getServiceDocManage().getDocsByLevel(level4);
			
			if(company_docs!=null)
			{
				if(company_docs.size()>=5)
				{
					List<ModelDoc> subLists1=company_docs.subList(0, 5);
					request.setAttribute("company_docs",subLists1);
				}
				else
				{
					request.setAttribute("company_docs",company_docs);
				}
				
			}
			else
			{
				request.setAttribute("company_docs",null);
			}
			
			if(district_docs!=null)
			{
				if(district_docs.size()>=5){
					List<ModelDoc> subLists2=district_docs.subList(0, 5);
					request.setAttribute("district_docs",subLists2);
				}
				else
				{
					request.setAttribute("district_docs",district_docs);
				}
			}
			else
			{
				request.setAttribute("district_docs",null);
			}
			
			if(department_docs!=null)
			{
				if(department_docs.size()>=5)
				{
					List<ModelDoc> subLists3=department_docs.subList(0, 5);
					request.setAttribute("department_docs",subLists3);
				}
				else
				{
					request.setAttribute("department_docs",department_docs);
				}
			}
			else
			{
				request.setAttribute("department_docs",null);
			}
			
			if(deparent_docs!=null)
			{
				if(deparent_docs.size()>=5)
				{
					List<ModelDoc> subLists4=deparent_docs.subList(0, 5);
					request.setAttribute("deparent_docs",subLists4);
				}
				else
				{
					request.setAttribute("deparent_docs",deparent_docs);
				}
				
			}
			else
			{
				request.setAttribute("deparent_docs",null);
			}
			
		} catch (ServiceException e) {
			LOGGER.error("Exception raised when  download docs.", e);
		} catch (DAOException e) {
			LOGGER.error("Exception raised when  download docs.", e);
		}
		return mapping.findForward("page.my.doc");
	}
}

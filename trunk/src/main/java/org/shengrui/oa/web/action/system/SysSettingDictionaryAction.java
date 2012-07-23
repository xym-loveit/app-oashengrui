package org.shengrui.oa.web.action.system;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.shengrui.oa.model.system.ModelAppDictionary;
import org.springframework.beans.BeanUtils;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

/**
 * @author tank
 *
 */
public class SysSettingDictionaryAction extends sysSettingBaseAction {
	/**
	  * The LOGGER
	  */
	private static final Logger LOGGER = Logger.getLogger(sysSettingWorkTimeAction.class);

	public ActionForward actionDictionaryPage(ActionMapping mapping,ActionForm form,HttpServletRequest request,HttpServletResponse response)
	{
		ModelAppDictionary formModel = (ModelAppDictionary)form;
		PagingBean pagingBean = this.getPagingBean(request);
		try {
			PaginationSupport<ModelAppDictionary> dictionarys = this.serviceAppDictionary.getPaginationByCriteria(formModel, pagingBean);
			request.setAttribute("dictionary", formModel);
			request.setAttribute("dictionarys", dictionarys);
	        outWritePagination(request, pagingBean, dictionarys);
		} catch (ServiceException e) {
			// TODO Auto-generated catch block
			LOGGER.error("查询出错", e);
		}
		return mapping.findForward("page.sys.setting.dictionary.index");
	}
	
	public ActionForward actionSaveDictionary(ActionMapping mapping,ActionForm form,HttpServletRequest request,HttpServletResponse response)
	{
		String id= request.getParameter("id");
		ModelAppDictionary formEntity = (ModelAppDictionary)form;
		Date date = new Date();
		ModelAppDictionary entity = null;
		if(this.isObjectIdValid(id)){
			//edit
			try { 
				entity= this.serviceAppDictionary.get(id);
				if(entity!=null){
					formEntity.setModifiedDate(date);
					BeanUtils.copyProperties(formEntity, entity);
				}
	            else
	            {
	               return ajaxPrint(response, AjaxResponse.RESPONSE_ERROR);
	            }

				try {
					this.serviceAppDictionary.save(entity);
					return ajaxPrint(response, 
				               getSuccessCallback("数据字典修改成功.", CALLBACK_TYPE_CLOSE, CURRENT_NAVTABID, null, false));
				} catch (ServiceException e) {
					// TODO Auto-generated catch block
					return ajaxPrint(response, AjaxResponse.RESPONSE_ERROR);
				}
			} catch (ServiceException e) {
				// TODO Auto-generated catch block
	            return ajaxPrint(response, AjaxResponse.RESPONSE_ERROR);
			}
		}else{
			formEntity.setCreateDate(date);
			formEntity.setModifiedDate(date);
			entity = formEntity;
			try {
				this.serviceAppDictionary.save(entity);
			} catch (ServiceException e) {
				// TODO Auto-generated catch block
				return ajaxPrint(response, AjaxResponse.RESPONSE_ERROR);
			}
		}
		PagingBean pagingBean = this.getPagingBean(request);
		try {
			PaginationSupport<ModelAppDictionary> dictionarys = this.serviceAppDictionary.getPaginationByCriteria(formEntity, pagingBean);
			request.setAttribute("dictionary", formEntity);
			request.setAttribute("dictionarys", dictionarys);
	        outWritePagination(request, pagingBean, dictionarys);
		} catch (ServiceException e) {
			// TODO Auto-generated catch block
			LOGGER.error("查询出错", e);
		}
		return mapping.findForward("page.sys.setting.dictionary.index");
	}
	
	public ActionForward actionLoadDictionaryListPage(ActionMapping mapping,ActionForm form,HttpServletRequest request,HttpServletResponse response)
	{
		ModelAppDictionary formModel = (ModelAppDictionary)form;
		PagingBean pagingBean = this.getPagingBean(request);
		try {
			PaginationSupport<ModelAppDictionary> dictionarys = this.serviceAppDictionary.getPaginationByCriteria(formModel, pagingBean);
			request.setAttribute("dictionary", formModel);
			request.setAttribute("dictionarys", dictionarys);
	        outWritePagination(request, pagingBean, dictionarys);
		} catch (ServiceException e) {
			// TODO Auto-generated catch block
			LOGGER.error("查询出错", e);
		}
		return mapping.findForward("page.sys.setting.dictionary.list");
	}
	
	public ActionForward actionLoadDictionaryEditPage(ActionMapping mapping,ActionForm form,HttpServletRequest request,HttpServletResponse response)
	{
		String id= request.getParameter("id");
		if(this.isObjectIdValid(id)){
			try {
				ModelAppDictionary entity = this.serviceAppDictionary.get(id);
				request.setAttribute("dictionary", entity);
			} catch (ServiceException e) {
				// TODO Auto-generated catch block
				return ajaxPrint(response, AjaxResponse.RESPONSE_ERROR);
			}
			
		}else{
			return ajaxPrint(response, "非法的ID");
		}
		
		return mapping.findForward("dialog.sys.setting.dictionary.edit");
	}
	
	public ActionForward actionDeleteDictionary(ActionMapping mapping,ActionForm form,HttpServletRequest request,HttpServletResponse response)
	{
		String id= request.getParameter("id");
		if(this.isObjectIdValid(id)){
			try {
				this.serviceAppDictionary.remove(id);
				return ajaxPrint(response, 
	                     getSuccessCallback("数据字典删除成功.", CALLBACK_TYPE_CLOSE, CURRENT_NAVTABID, null, false));
			} catch (ServiceException e) {
				// TODO Auto-generated catch block
				return ajaxPrint(response, AjaxResponse.RESPONSE_ERROR);
			}
			
		}else{
			return ajaxPrint(response, "非法的ID");
		}
		
	}
	
	public ActionForward actionLoadByTypeAndLevel(ActionMapping mapping,ActionForm form,HttpServletRequest request,HttpServletResponse response)
	{
		String type = request.getParameter("type");
		String level = request.getParameter("level");
		try {
			List<ModelAppDictionary> list = this.serviceAppDictionary.getByTypeAndLevel(type, level);
			if (list != null)
			{
				StringBuilder sb = new StringBuilder();
				sb.append("[");
				int loop = 1;
				for(ModelAppDictionary entity : list){
					sb.append("[\"").append(entity.getId()).append("\",").append("\"")
					.append(entity.getName())
					.append("\"]");
					if(loop != list.size()){
						sb.append(",");
					}
					loop++;
				}
				sb.append("]");
				System.out.println(sb.toString());
				return ajaxPrint(response, sb.toString());
			}
		} catch (ServiceException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return ajaxPrint(response,"[]");
	}
}

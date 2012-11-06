package org.shengrui.oa.web.action.system;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.shengrui.oa.model.system.ModelSchoolDistrict;
import org.shengrui.oa.web.action.BaseAppAction;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;
import cn.trymore.oa.model.system.ModelSystemLog;

/**
 * @author tank
 *
 */
public class SysMgrLogAction extends BaseAppAction {
	private static final Logger LOGGER = Logger.getLogger(SysMgrLogAction.class);
	
	public ActionForward actionLoadLogPage(ActionMapping mapping,ActionForm form,HttpServletRequest request,HttpServletResponse response)
	{
		ModelSystemLog entity = (ModelSystemLog) form;
		PagingBean pagingBean = this.getPagingBean(request);
		try {
			PaginationSupport<ModelSystemLog> logs = this.serviceSystemLog.getPaginationByEntity(entity, pagingBean);
			request.setAttribute("logs", logs);
			 //获得校区信息
	        List<ModelSchoolDistrict> districts=this.getAllDistricts();
	        request.setAttribute("districts", districts);
	        request.setAttribute("logInfo", entity);
	        outWritePagination(request, pagingBean, logs);
		} catch (ServiceException e) {
			// TODO Auto-generated catch block
			LOGGER.debug("查询日志出错："+e.getMessage());
		}
		return mapping.findForward("page.sys.mgr.log.index");
	}
}

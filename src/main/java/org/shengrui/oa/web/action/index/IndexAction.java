package org.shengrui.oa.web.action.index;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.shengrui.oa.model.admin.ModelTaskPlan;
import org.shengrui.oa.model.system.ModelAppUser;
import org.shengrui.oa.model.system.ModelSchoolDepartment;
import org.shengrui.oa.util.AppUtil;
import org.shengrui.oa.util.ContextUtil;
import org.shengrui.oa.util.WebActionUtil;
import org.shengrui.oa.web.action.BaseAppAction;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

/**
 * The index web action, it shows the index page for system.
 * 
 * @author  Jeccy.Zhao
 *
 */
public class IndexAction 
extends BaseAppAction
{
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * The index presentation page action.
	 */
	public ActionForward index (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
	{
		// loads all configured menus, aims to present the left menu items.
		this.getRootMenus(request);
		
		// initialization.
		init(request);
		
		return mapping.findForward("index");
	}
	
	@SuppressWarnings("unused")
	public ActionForward addressBookInfo (ActionMapping mapping,ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
	{
		ModelAppUser modelAppUser = (ModelAppUser) form;
		PagingBean pagingBean = this.getPagingBean(request);
		String id = request.getParameter("id");
		String depId = request.getParameter("depId");
		try {
			modelAppUser.setDistrict(this.serviceSchoolDistrict.get(id));
//			modelAppUser.setDepartment(this.serviceSchoolDepartment.get(depId));
			PaginationSupport<ModelAppUser> userInfo = 
				this.serviceAppUser.getUserPagination(modelAppUser, pagingBean);
			request.setAttribute("userInfo", userInfo);
			request.setAttribute("modelAppUser", modelAppUser);
			request.setAttribute("districts" , this.getServiceSchoolDistrict().getAll());
			// 获取按校区所有部门列表
			Map<Integer, List<ModelSchoolDepartment>> departments = this.getAllDepartments(request, false);
			if (departments != null)
			{
				List<Object> depNames = this.serviceSchoolDepartment.getDistinctDepartmentNames();
				if (depNames != null)
				{
					request.setAttribute("depNames", depNames);
					
					Map<String, String> depSetIds = new HashMap<String, String>();
					
					// 总部部门
					List<ModelSchoolDepartment> depMasters = departments.get(AppUtil.EAppSchoolType.HEADQUARTERS.getValue());
					if (depMasters != null)
					{
						for (ModelSchoolDepartment dep : depMasters)
						{
							if (depNames.contains(dep.getDepName()))
							{
								// depSetIds.put(dep.getDepName(), value)
							}
						}
					}
					
					// 校区部门
					List<ModelSchoolDepartment> depCampus = departments.get(AppUtil.EAppSchoolType.AREA_CAMPUS.getValue());
				}
			}
		} catch (ServiceException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return mapping.findForward("personal.page.addressBook");
	}
	
	/**
	 * Initialization for current loggon user
	 * 
	 * @param request
	 */
	private void init(HttpServletRequest request)
	{
		String empId = ContextUtil.getCurrentUser().getEmployee().getId();
		
		request.setAttribute("numMsgUnread", 
				this.getUnreadMessageByUserId(empId));
		
		request.setAttribute(WebActionUtil.MENU_KEY_ADMIN_TASK, 
			this.serviceTaskPlan.getAffectedNumByQuery(ModelTaskPlan.class, 
				this.getModelDataPolicyQuery(
					"app/admin/task.do?action=pageTaskDelegateIndex", 
					ModelTaskPlan.class, 
					new String[] {
						"(approval_status = " + ModelTaskPlan.ETaskApprovalStatus.TOAPPROVE.getValue() + " OR approval_status IS NULL)"
					}
				)
			)
		);
		
	}
	
}

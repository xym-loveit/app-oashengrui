package org.shengrui.oa.web.action.admin;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.shengrui.oa.model.admin.ModelDoc;
import org.shengrui.oa.model.admin.ModelDocLevel;
import org.shengrui.oa.model.admin.ModelDocVisiableRange;
import org.shengrui.oa.model.system.ModelAppDictionary;
import org.shengrui.oa.model.system.ModelAppUser;
import org.shengrui.oa.model.system.ModelSchoolDepartment;
import org.shengrui.oa.model.system.ModelSchoolDistrict;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.exception.WebException;
import cn.trymore.core.util.UtilString;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;
/**
 * The administrator doc manage action.
 * 
 * @author  Tang
 *
 */
public class DocManageAction 
extends BaseAdminAction
{
	/**
	 * The LOGGER
	 */
	private static final Logger LOGGER = Logger.getLogger(DocManageAction.class);
	
	@SuppressWarnings("unused")
	private static final String ACTION_FORM_FLAG_APPROVAL = "1";
	
	@SuppressWarnings("unused")
	private static final String ACTION_FORM_FLAG_RETURNED = "2";
	
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 文档上传与管理主界面
	 * @throws WebException 
	 * @throws ServiceException 
	 */
	public ActionForward adminPageDocumentIndex (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws WebException, ServiceException 
	{
		try
		{
				ModelDoc formDoc = (ModelDoc) form;
				
				if(formDoc.getType().getId()!=null && formDoc.getType().getId()!="-1") {
					formDoc.setType(this.getServiceAppDictionary().get(formDoc.getType().getId()));
				}

				PagingBean pagingBean = this.getPagingBean(request);
				PaginationSupport<ModelDoc> docs =
					this.getServiceDocManage().getPaginationByEntity(formDoc, pagingBean);
				
				request.setAttribute("docs", docs);
				request.setAttribute("formDoc", formDoc);
				
				// 输出分页信息至客户端
				outWritePagination(request, pagingBean, docs);
				request.setAttribute("docTypes", this.getServiceAppDictionary().getByType("docType"));
			
			
		} 
		catch (ServiceException e)
		{
			LOGGER.error("Exception raised when fetch all doc manages.", e);
		}
		
		
		return mapping.findForward("admin.page.document.index");
	}
	
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 文档删除操作(传入id进行删除操作)
	 * @throws WebException 
	 * @throws ServiceException 
	 */
	public ActionForward adminPageDocumentDelete (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws WebException, ServiceException 
	{
		try
		{
			//判断从前台是否传入了id值，如果有，则进行删除操作
			String id=request.getParameter("id");
			if (this.isObjectIdValid(id))
			{
				this.getServiceDocManage().remove(id);
				System.out.println("123");
				return ajaxPrint(response, getSuccessCallback("文档删除成功.", CALLBACK_TYPE_CLOSE, CURRENT_NAVTABID, null, false));
			}
			else
			{
				return ajaxPrint(response, getErrorCallback("文档删除失败,原因:非法文档ID(" + id + ")被传递"));
			}
		} 
		catch (ServiceException e)
		{
			e.printStackTrace();
			LOGGER.error("Exception raised when delete doc manages.", e);
			return ajaxPrint(response, getErrorCallback("删除失败,原因:" + e.getMessage()));
		}
		
	}
	
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 文档上传与管理 - 文档详细页面
	 * @throws WebException 
	 */
	public ActionForward adminPageDocumentDetail (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws WebException 
	{
		
		try
		{
			//判断从前台是否传入了id值，如果有，则进行编辑操作
			String id=request.getParameter("id");
			String op=request.getParameter("op");
			if (this.isObjectIdValid(id))
			{
				request.setAttribute("formDoc", this.getServiceDocManage().get(id));
				request.setAttribute("op", "op");
			}
			//否则进行上传文档操作
			else if(!op.equals("loding"))
			{
			}
			request.setAttribute("docTypes", this.getServiceAppDictionary().getByType("docType"));
			request.setAttribute("districts" , this.getServiceSchoolDistrict().getAll());
			request.setAttribute("docLevels" , this.getServiceDocLevel().getAll());
			request.setAttribute("docRanges" , this.getServiceDocVisiableRange().getAll());
			request.setAttribute("deps" , this.getServiceSchoolDepartment().getDepartmentByOrganization(0));
			
		} 
		catch (ServiceException e)
		{
			LOGGER.error("Exception raised when fetch all doc manages.", e);
		}
		
		return mapping.findForward("admin.page.document.detail");
	}
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 文档上传与管理 - 文档上传信息保存
	 * @throws WebException 
	 */
	public ActionForward adminPageDocumentSave (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws WebException 
	{
		
		try
		{
				ModelDoc formDoc = (ModelDoc) form;
				
				System.out.println("打印上传文档Id"+formDoc.getFileIds());
				
				ModelDoc entity = null;
				
				if(formDoc!=null)
				{
					
					System.out.println("111:"+formDoc.getDocVisiableRange().getId());
					
					//封装设置个人可见数据
					if( "2".equals(formDoc.getDocVisiableRange().getId())&&UtilString.isNotEmpty(formDoc.getDocUserNames()))
					{
						
						try {
							String strUserNames = formDoc.getDocUserNames();
							String userIds = "";
							String[] names = strUserNames.split(",");
							for (int i = 0; i < names.length; i++)
							{
								
								try {
									ModelAppUser user = this.getServiceAppUser()
											.findByUserName(names[i]);
									userIds = userIds + user.getId() + ",";
								} catch (NullPointerException e) {
									LOGGER.error("Exception raised when fetch all doc manages.", e);
									return ajaxPrint(response, getErrorCallback("文档可见人不存在，请重新输入."));
								}
							}
							userIds = userIds.substring(0, userIds.length() - 1);
							formDoc.setDocUserIds(userIds);
						} 
						catch (Exception e)
						{
							LOGGER.error("Exception raised when fetch all doc manages.", e);
							return ajaxPrint(response, getErrorCallback("请按正确格式输入可见人姓名，用逗号分开."));
						}
						
						
					}else if(formDoc.getDocVisiableRange().getId()!="2"&&UtilString.isNotEmpty(formDoc.getDocUserNames()))
					{
						return ajaxPrint(response, getErrorCallback("当前不是设置为个人可见!"));
					}
				
					if(!UtilString.isNotEmpty(formDoc.getDocName()))
					{
						return ajaxPrint(response, getErrorCallback("文档名称不能为空!"));
					}
					ModelAppDictionary type     =this.getServiceAppDictionary().get(formDoc.getType().getId());
					ModelDocLevel level         =this.getServiceDocLevel().get(formDoc.getDocLevel().getId());
					ModelDocVisiableRange range =this.getServiceDocVisiableRange().get(formDoc.getDocVisiableRange().getId());
					ModelSchoolDistrict district=this.getServiceSchoolDistrict().get(formDoc.getDistrict().getId());
					ModelSchoolDepartment dep   =this.getServiceSchoolDepartment().get(formDoc.getDepartment().getId());
					ModelAppUser author         = this.getServiceAppUser().findByUserName((String)request.getSession().getAttribute("SPRING_SECURITY_LAST_USERNAME"));
					
					formDoc.setType(type);
					formDoc.setAuthor(author);
					formDoc.setDepartment(dep);
					formDoc.setDocLevel(level);
					formDoc.setDocVisiableRange(range);
					formDoc.setDistrict(district);
					formDoc.setCreateTime(new Date());
					
					entity=this.getServiceDocManage().get(formDoc.getId());
					if(formDoc.equals(entity)){
						return ajaxPrint(response, getErrorCallback("您没有做任何修改!"));
					}
					
					entity=formDoc;
					
					this.serviceDocManage.merge(entity);
				}
				// 保存成功后, Dialog进行关闭
				return ajaxPrint(response, 
						getSuccessCallback("上传成功.", CALLBACK_TYPE_CLOSE, CURRENT_NAVTABID, null, false));
				
		} 
		catch (ServiceException e)
		{
			LOGGER.error("Exception raised when fetch all doc manages.", e);
			return ajaxPrint(response, getErrorCallback("文档上传失败."));
		}
	}

}

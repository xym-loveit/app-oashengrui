package org.shengrui.oa.web.action.admin;

import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.shengrui.oa.model.admin.ModelDoc;
import org.shengrui.oa.model.admin.ModelDocLevel;
import org.shengrui.oa.model.hrm.ModelHrmEmployee;
import org.shengrui.oa.model.system.ModelAppDictionary;
import org.shengrui.oa.model.system.ModelAppUser;
import org.shengrui.oa.model.system.ModelSchoolDepartment;
import org.shengrui.oa.model.system.ModelSchoolDistrict;
import org.shengrui.oa.util.AppUtil;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.exception.WebException;
import cn.trymore.core.util.UtilString;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;
import cn.trymore.oa.model.system.ModelFileAttach;
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
	 * 首页显示我的文档
	 * */
	public ActionForward adminPageDocumentIndex1 (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws WebException, ServiceException 
	{
		try
		{
				ModelDoc formDoc = (ModelDoc) form;
				
				if(formDoc.getType().getId()!=null && formDoc.getType().getId()!="-1") {
					formDoc.setType(this.getServiceAppDictionary().get(formDoc.getType().getId()));
				}

				PagingBean pagingBean = this.getPagingBean1(request);
				PaginationSupport<ModelDoc> docs =
					this.getServiceDocManage().getPaginationByEntity(formDoc, pagingBean);
				
				request.setAttribute("docs", docs);
				request.setAttribute("formDoc", formDoc);
				try {
					response.getWriter().write(ObjectToString(docs));
				} catch (IOException e) { 
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				// 输出分页信息至客户端
				outWritePagination(request, pagingBean, docs);
				request.setAttribute("docTypes", this.getServiceAppDictionary().getByType("docType"));
			
			
		} 
		catch (ServiceException e)
		{
			LOGGER.error("Exception raised when fetch all doc manages.", e);
		}
		
		
		return null;
	}
	
	private String ObjectToString(PaginationSupport<ModelDoc> list){
		StringBuffer sb =new StringBuffer();
		if(list != null){
			for (ModelDoc doc : list.getItems()) {
				sb.append("<tr><td style=\"display: none;\">");
				sb.append(doc.getId()+"</td><td>");
				sb.append(doc.getType().getValue()+"</td>");
				sb.append("<td>"+doc.getCreateTime()+"</td></tr>");
			}
			return sb.toString();
		}
		return "";
	}
	
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
				return ajaxPrint(response, getSuccessCallback("文档删除成功.", CALLBACK_TYPE_CLOSE, CURRENT_NAVTABID, null, false));
			}
			else
			{
				return ajaxPrint(response, getErrorCallback("文档删除失败,原因:非法文档ID(" + id + ")被传递"));
			}
		} 
		catch (ServiceException e)
		{
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
			if (this.isObjectIdValid(id))
			{
				ModelDoc doc = this.getServiceDocManage().get(id);
				Set<ModelFileAttach> files = doc.getAttachFiles();
				if(files!=null){
					System.out.println("附件个数:"+files.size());
					Iterator<ModelFileAttach> it = files.iterator();
					while(it.hasNext()){
						ModelFileAttach file = it.next();
						System.out.println(file.getFilePath()+"\t"+file.getFileName());
					}
				}else{
					System.out.println("没有附件");
				}
				
				request.setAttribute("formDoc", doc);
				request.setAttribute("op", "op");
			}

			request.setAttribute("docTypes", this.getServiceAppDictionary().getByType("docType"));
			request.setAttribute("districts" , this.getServiceSchoolDistrict().getAll());
			request.setAttribute("docLevels" , this.getServiceDocLevel().getAll());
			
			
			request.setAttribute("docRanges" , this.getServiceDocVisiableRange().getAll());
			
			request.setAttribute("deps" , this.getServiceSchoolDepartment().getDepartmentByOrganization(0));
			
			// 获取所有校区
			request.setAttribute("districts", this.serviceSchoolDistrict.getAll());
			
			// 获取按校区所有部门列表
			Map<Integer, List<ModelSchoolDepartment>> departments = this.getAllDepartments(request, false);
			
			if (departments != null)
			{
				List<Object> depNames = this.serviceSchoolDepartment.getDistinctDepartmentNames();
				if (depNames != null)
				{
					request.setAttribute("depNames", depNames);
					
					Map<Integer, Map<String, String>> depSetIds = new HashMap<Integer, Map<String, String>>();
					
					depSetIds.put(AppUtil.EAppSchoolType.HEADQUARTERS.getValue(), 
							new HashMap<String, String>());
					
					depSetIds.put(AppUtil.EAppSchoolType.AREA_CAMPUS.getValue(), 
							new HashMap<String, String>());
					
					depSetIds.put(AppUtil.EAppSchoolType.AREA_SLOT.getValue(), 
							new HashMap<String, String>());
					
					// 总部部门
					List<ModelSchoolDepartment> depMasters = departments.get(AppUtil.EAppSchoolType.HEADQUARTERS.getValue());
					if (depMasters != null)
					{
						for (ModelSchoolDepartment dep : depMasters)
						{
							if (depNames.contains(dep.getDepName()))
							{
								depSetIds.get(AppUtil.EAppSchoolType.HEADQUARTERS.getValue()).put(dep.getDepName(), dep.getId());
							}
						}
					}
					
					// 校区部门
					List<ModelSchoolDepartment> depCampus = departments.get(AppUtil.EAppSchoolType.AREA_CAMPUS.getValue());
					if (depCampus != null)
					{
						for (ModelSchoolDepartment dep : depCampus)
						{
							if (depNames.contains(dep.getDepName()))
							{
								depSetIds.get(AppUtil.EAppSchoolType.AREA_CAMPUS.getValue()).put(dep.getDepName(), dep.getId());
							}
						}
					}
					
					// 片区部门
					List<ModelSchoolDepartment> depSlot = departments.get(AppUtil.EAppSchoolType.AREA_SLOT.getValue());
					if (depSlot != null)
					{
						for (ModelSchoolDepartment dep : depSlot)
						{
							if (depNames.contains(dep.getDepName()))
							{
								depSetIds.get(AppUtil.EAppSchoolType.AREA_SLOT.getValue()).put(dep.getDepName(), dep.getId());
							}
						}
					}
					
					request.setAttribute("depSetIds", depSetIds);
					
				}
			}
		} 
		catch (ServiceException e)
		{
			e.printStackTrace();
			LOGGER.error("Exception raised when fetch all doc manages.", e);
		}
		
		return mapping.findForward("admin.page.document.detail");
	}
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 文档上传与管理 - 编辑文档详细页面
	 * @throws WebException 
	 */
	public ActionForward adminPageDocumentEditDetail (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws WebException 
	{
		
		try
		{
			//判断从前台是否传入了id值，如果有，则进行编辑操作
			String id=request.getParameter("id");
			if (this.isObjectIdValid(id))
			{
				//request.setAttribute("formDoc", this.getServiceDocManage().get(id));
				ModelDoc doc = this.getServiceDocManage().get(id);
				ModelFileAttach file = doc.getFile();
				Set<ModelFileAttach> files = new HashSet<ModelFileAttach>();
				if(file!=null){
					files.add(file);
				}
				doc.setAttachFiles(files);
				request.setAttribute("formDoc", doc);
				request.setAttribute("op", "op");
				String doc_user_ids = doc.getDocUserIds();
				System.out.println(doc_user_ids);
				String doc_use_name_show = "[";
				if(doc_user_ids!=null && UtilString.isNotEmpty(doc_user_ids)){
					if(doc_user_ids.contains(",")){
						String[] ids = doc_user_ids.split(",");
						int loop = 1;
						for(String eid : ids){
							ModelHrmEmployee employee = this.serviceHrmEmployee.get(eid);
							if (employee != null)
							{
								doc_use_name_show+="{\"id\":\""+employee.getId()+"\",\"empName\":\""+employee.getEmpName()+"\",\"empNo\":\""+employee.getEmpNo()+"\"}";
							}
							else
							{
								LOGGER.warn("The employee does not exist with id:" + eid);
							}
							if(loop < ids.length && employee!=null){
								doc_use_name_show += ",";
							}
							loop ++;
						}
					}else{
						ModelHrmEmployee employee = this.serviceHrmEmployee.get(doc_user_ids);
						doc_use_name_show+="{\"id\":\""+employee.getId()+"\",\"empname\":\""+employee.getFullName()+"\"}";
					}
					doc_use_name_show +="]";
					System.out.println(doc_use_name_show);
					request.setAttribute("doc_use_name_show", doc_use_name_show);
				}
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
		
		return mapping.findForward("admin.page.document.detail.edit");
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
				
				ModelDoc entity = null;
				
				if(formDoc!=null)
				{
					// 保存文档可见人
					Map<String, List<String>> paramEmpIds = this.getAllRequestParameters(request, new String[] {"empid"});
					
					//封装设置个人可见数据
					if(ModelDoc.EDocVisibleRange.PERSONALS.getValue().equals(formDoc.getDocVisiableRange()) && 
							paramEmpIds != null && paramEmpIds.size() > 0)
					{
						
						try {
							String strUserNames = "";
							String userIds = "";
							List<String> empIds = paramEmpIds.get("empid");
							for (String empId : empIds)
							{
								ModelHrmEmployee employee = this.serviceHrmEmployee.get(empId);
								if (employee != null)
								{
									strUserNames+=employee.getEmpName()+",";
									userIds+=employee.getId()+",";
								}
								else
								{
									LOGGER.warn("The employee does not exist with id:" + empId);
								}
							}
							userIds = userIds.substring(0, userIds.length() - 1);
							strUserNames = strUserNames.substring(0,strUserNames.length()-1);
							formDoc.setDocUserIds(userIds);
							formDoc.setDocUserNames(strUserNames);
						} 
						catch (Exception e)
						{
							LOGGER.error("Exception raised when fetch all doc manages.", e);
							return ajaxPrint(response, getErrorCallback("请按正确格式输入可见人姓名，用逗号分开."));
						}
						
						
					}
					else if (!ModelDoc.EDocVisibleRange.PERSONALS.getValue().equals(
							formDoc.getDocVisiableRange()) && paramEmpIds != null && paramEmpIds.size() > 0)
					{
						return ajaxPrint(response, getErrorCallback("当前不是设置为个人可见!"));
					}
				
					if(!UtilString.isNotEmpty(formDoc.getDocName()))
					{
						return ajaxPrint(response, getErrorCallback("文档名称不能为空!"));
					}
					ModelAppDictionary type     =this.getServiceAppDictionary().get(formDoc.getType().getId());
					ModelDocLevel level         =this.getServiceDocLevel().get(formDoc.getDocLevel().getId());
					// ModelDocVisiableRange range =this.getServiceDocVisiableRange().get(formDoc.getDocVisiableRange().getId());
					ModelSchoolDistrict district=this.getServiceSchoolDistrict().get(formDoc.getDistrict().getId());
					ModelSchoolDepartment dep   =this.getServiceSchoolDepartment().get(formDoc.getDepartment().getId());
					ModelAppUser author         = this.getServiceAppUser().findByUserName((String)request.getSession().getAttribute("SPRING_SECURITY_LAST_USERNAME"));
					
					formDoc.setType(type);
					formDoc.setAuthor(author);
					formDoc.setDepartment(dep);
					formDoc.setDocLevel(level);
					// formDoc.setDocVisiableRange(range);
					formDoc.setDistrict(district);
					formDoc.setCreateTime(new Date());
					
					entity=this.getServiceDocManage().get(formDoc.getId());
					if(formDoc.equals(entity)){
						return ajaxPrint(response, getErrorCallback("您没有做任何修改!"));
					}
					
					entity=formDoc;
					
					//在数据上传的FileUploadServlet中传过来的session值，用完销毁掉。
					String fileIds=(String)request.getSession().getAttribute("fileIds");
					if(fileIds==null)
					{
						return ajaxPrint(response, getErrorCallback("上传文档不能为空，请添加文件!"));
					}
					else
					{
						String []ids=fileIds.split(",");
						if(ids.length>=2)
						{
							request.getSession().removeAttribute("fileIds");
							return ajaxPrint(response, getErrorCallback("一个文档只能上传一个附件，请重新上传!", CALLBACK_TYPE_CLOSE, CURRENT_NAVTABID, null, false));
						}else{
							ModelFileAttach file=this.getServiceFileAttach().get(fileIds);
							entity.setFile(file);
							this.serviceDocManage.merge(entity);
						}
					}
					request.getSession().removeAttribute("fileIds");
					
				}
				// 保存成功后, Dialog进行关闭
				return ajaxPrint(response, 
						getSuccessCallback("文档上传成功.", CALLBACK_TYPE_CLOSE, CURRENT_NAVTABID, null, false));
				
		} 
		catch (ServiceException e)
		{
			LOGGER.error("Exception raised when fetch all doc manages.", e);
			return ajaxPrint(response, getErrorCallback("文档上传失败."));
		}
	}
	
	
	/**
	 * <b>[WebAction]</b> 
	 * <br/>
	 * 文档上传与管理 - 文档上传信息编辑
	 * @throws WebException 
	 */
	public ActionForward adminPageDocumentEdit (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws WebException 
	{
		
		try
		{
				ModelDoc formDoc = (ModelDoc) form;
				
				ModelDoc entity = null;
				
				if(formDoc!=null)
				{
					//封装设置个人可见数据
					if(ModelDoc.EDocVisibleRange.PERSONALS.getValue().equals(
							formDoc.getDocVisiableRange()) && UtilString.isNotEmpty(formDoc.getDocUserNames()))
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
						
						
					}
					else if (!ModelDoc.EDocVisibleRange.PERSONALS.getValue().equals(formDoc.getDocVisiableRange()) && 
							UtilString.isNotEmpty(formDoc.getDocUserNames()))
					{
						return ajaxPrint(response, getErrorCallback("当前不是设置为个人可见!"));
					}
					
					if(!UtilString.isNotEmpty(formDoc.getDocName()))
					{
						return ajaxPrint(response, getErrorCallback("文档名称不能为空!"));
					}
					ModelAppDictionary type     =this.getServiceAppDictionary().get(formDoc.getType().getId());
					ModelDocLevel level         =this.getServiceDocLevel().get(formDoc.getDocLevel().getId());
					// ModelDocVisiableRange range =this.getServiceDocVisiableRange().get(formDoc.getDocVisiableRange().getId());
					ModelSchoolDistrict district=this.getServiceSchoolDistrict().get(formDoc.getDistrict().getId());
					ModelSchoolDepartment dep   =this.getServiceSchoolDepartment().get(formDoc.getDepartment().getId());
					ModelAppUser author         = this.getServiceAppUser().findByUserName((String)request.getSession().getAttribute("SPRING_SECURITY_LAST_USERNAME"));
					
					formDoc.setType(type);
					formDoc.setAuthor(author);
					formDoc.setDepartment(dep);
					formDoc.setDocLevel(level);
					//formDoc.setDocVisiableRange(range);
					formDoc.setDistrict(district);
					formDoc.setCreateTime(new Date());
					//在数据上传的FileUploadServlet中传过来的session值，用完销毁掉。
					String fileIds=(String)request.getSession().getAttribute("fileIds");
					if(fileIds==null)
					{
						return ajaxPrint(response, getErrorCallback("上传文档不能为空，请添加文件!"));
					}
					else
					{
						String []ids=fileIds.split(",");
						if(ids.length>=2)
						{
							request.getSession().removeAttribute("fileIds");
							return ajaxPrint(response, getErrorCallback("一个文档只能上传一个附件，请重新上传!", CALLBACK_TYPE_CLOSE, CURRENT_NAVTABID, null, false));
						}else{
							ModelFileAttach file=this.getServiceFileAttach().get(fileIds);
							formDoc.setFile(file);
						}
					}
					request.getSession().removeAttribute("fileIds");
					entity=this.getServiceDocManage().get(formDoc.getId());
					if(formDoc.equals(entity)){
						return ajaxPrint(response, getErrorCallback("您没有做任何修改!"));
					}
					
					entity=formDoc;
					
					this.serviceDocManage.merge(entity);
				}
				// 保存成功后, Dialog进行关闭
				return ajaxPrint(response, 
						getSuccessCallback("文档编辑成功.", CALLBACK_TYPE_CLOSE, CURRENT_NAVTABID, null, false));
				
		} 
		catch (ServiceException e)
		{
			LOGGER.error("Exception raised when fetch all doc manages.", e);
			return ajaxPrint(response, getErrorCallback("文档编辑失败."));
		}
	}

}

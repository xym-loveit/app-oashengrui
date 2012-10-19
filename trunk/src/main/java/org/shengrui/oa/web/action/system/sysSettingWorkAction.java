package org.shengrui.oa.web.action.system;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.shengrui.oa.model.hrm.ModelHrmEmployee;
import org.shengrui.oa.model.system.ModelBaseWorkContent;
import org.shengrui.oa.model.system.ModelBaseWorkTime;
import org.shengrui.oa.model.system.ModelSchoolDepartment;
import org.shengrui.oa.model.system.ModelSchoolDistrict;
import org.shengrui.oa.model.system.ModelWorkTemplate;
import org.springframework.beans.BeanUtils;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.log.LogAnnotation;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

/**
 * 工作安排设置-工作模板设置
 * 
 * @author Lee
 * 
 */
public class sysSettingWorkAction extends sysSettingBaseAction {
   /**
    * The LOGGER
    */
   private static final Logger LOGGER = Logger
         .getLogger(sysSettingWorkAction.class);

   /**
    * <b>[WebAction]</b> <br/>
    * 工作安排设置-工作模板设置
    */
   public ActionForward pageWorkTemplateIndex(ActionMapping mapping,
         ActionForm form, HttpServletRequest request,
         HttpServletResponse response) {
      ModelWorkTemplate formWorkTemplate = (ModelWorkTemplate) form;
      if (formWorkTemplate.getTemplateId() == null) {
         formWorkTemplate.setTemplateId("-1");
      }
      if (formWorkTemplate.getDistrict().getId() == null) {
         formWorkTemplate.getDistrict().setId("-1");
      }
      try {
         List<ModelWorkTemplate> listWorkTemplate = this.serviceWorkTemplate
               .getListByCriteria(formWorkTemplate);

         String[] zam = { "", "", "", "", "", "", "", "" };
         String[] zpm = { "", "", "", "", "", "", "", "" };
         for (ModelWorkTemplate entity : listWorkTemplate) {
        	
        	// added by Jeccy.Zhao on 24/09/2012, aims to check the nullpointer exception.
        	if (entity.getWorkTime() == null) 
        	{
        		continue;
        	}
        	 
        	 
            if ("周一".equals(entity.getWorkDay())) {
               if ("AM".equals(checkWorkTime(entity.getWorkTime()
                     .getWorkEtime())))
                  zam[1] += entity.getStaffName() + ",";
               else if ("PM".equals(checkWorkTime(entity.getWorkTime()
                     .getWorkEtime())))
                  zpm[1] += entity.getStaffName() + ",";
            } else if ("周二".equals(entity.getWorkDay())) {
               if ("AM".equals(checkWorkTime(entity.getWorkTime()
                     .getWorkEtime())))
                  zam[2] += entity.getStaffName() + ",";
               else if ("PM".equals(checkWorkTime(entity.getWorkTime()
                     .getWorkEtime())))
                  zpm[2] += entity.getStaffName() + ",";
            } else if ("周三".equals(entity.getWorkDay())) {
               if ("AM".equals(checkWorkTime(entity.getWorkTime()
                     .getWorkEtime())))
                  zam[3] += entity.getStaffName() + ",";
               else if ("PM".equals(checkWorkTime(entity.getWorkTime()
                     .getWorkEtime())))
                  zpm[3] += entity.getStaffName() + ",";
            } else if ("周四".equals(entity.getWorkDay())) {
               if ("AM".equals(checkWorkTime(entity.getWorkTime()
                     .getWorkEtime())))
                  zam[4] += entity.getStaffName() + ",";
               else if ("PM".equals(checkWorkTime(entity.getWorkTime()
                     .getWorkEtime())))
                  zpm[4] += entity.getStaffName() + ",";
            } else if ("周五".equals(entity.getWorkDay())) {
               if ("AM".equals(checkWorkTime(entity.getWorkTime()
                     .getWorkEtime())))
                  zam[5] += entity.getStaffName() + ",";
               else if ("PM".equals(checkWorkTime(entity.getWorkTime()
                     .getWorkEtime())))
                  zpm[5] += entity.getStaffName() + ",";
            } else if ("周六".equals(entity.getWorkDay())) {
               if ("AM".equals(checkWorkTime(entity.getWorkTime()
                     .getWorkEtime())))
                  zam[6] += entity.getStaffName() + ",";
               else if ("PM".equals(checkWorkTime(entity.getWorkTime()
                     .getWorkEtime())))
                  zpm[6] += entity.getStaffName() + ",";
            } else if ("周日".equals(entity.getWorkDay())) {
               if ("AM".equals(checkWorkTime(entity.getWorkTime()
                     .getWorkEtime())))
                  zam[7] += entity.getStaffName() + ",";
               else if ("PM".equals(checkWorkTime(entity.getWorkTime()
                     .getWorkEtime())))
                  zpm[7] += entity.getStaffName() + ",";
            }
         }
         for(int i=1;i<8;i++){
        	 if(!"".equals(zam[i])&&zam[i].endsWith(",")){
        		 zam[i] = zam[i].substring(0, zam[i].length()-1);
        	 }
        	 if(!"".equals(zpm[i])&&zpm[i].endsWith(",")){
        		 zpm[i] = zpm[i].substring(0, zpm[i].length()-1);
        	 }
         }
         request.setAttribute("staffOnAM", zam);
         request.setAttribute("staffOnPM", zpm);
         List<ModelSchoolDistrict> districts = this.getAllDistricts();
         request.setAttribute("districts", districts);
         List<ModelBaseWorkTime> dayWorkTimes = this.serviceBaseWorkTime
               .getDayWorkTimeByDistrictIdAndTemplateId(formWorkTemplate
                     .getDistrict().getId(), formWorkTemplate
                     .getTemplateId());
         String startWorkTimePM = "";
         String endWorkTimePM = "";
         String startWorkTimeWeekAM = "";
         String endWorkTimeWeekAM = "";
         String startWorkTimeWeekendAM = "";
         String endWorkTimeWeekendAM = "";
         int loop1 = 1;
         int loop2 = 1;
         int loop3 = 1;
         for (ModelBaseWorkTime entity : dayWorkTimes) {
            if ("PM".equals(checkWorkTime(entity.getWorkStime()))) { // 工作时间在晚上
               if (loop1 == 1) {
                  startWorkTimePM = entity.getWorkStime();
                  endWorkTimePM = entity.getWorkEtime();
                  loop1++;
               } else {
                  if (startWorkTimePM.compareTo(entity.getWorkStime()) > 0) {
                     startWorkTimePM = entity.getWorkStime();
                  }
                  if (endWorkTimePM.compareTo(entity.getWorkEtime()) < 0) {
                     endWorkTimePM = entity.getWorkEtime();
                  }
               }
            } else { // 工作时间在白天
               if (entity.getAdjustDays().contains("周六")
                     || entity.getAdjustDays().contains("周日")) {
                  if (loop2 == 1) {
                     startWorkTimeWeekendAM = entity.getWorkStime();
                     endWorkTimeWeekendAM = entity.getWorkEtime();
                     loop2++;
                  } else {
                     if (startWorkTimeWeekendAM.compareTo(entity
                           .getWorkStime()) > 0) {
                        startWorkTimeWeekendAM = entity.getWorkStime();
                     }
                     if (endWorkTimeWeekendAM.compareTo(entity
                           .getWorkEtime()) < 0) {
                        endWorkTimeWeekendAM = entity.getWorkEtime();
                     }
                  }
               }
               if (entity.getAdjustDays().contains("周一")
                     || entity.getAdjustDays().contains("周二")
                     || entity.getAdjustDays().contains("周三")
                     || entity.getAdjustDays().contains("周四")
                     || entity.getAdjustDays().contains("周五")) {
                  if (loop3 == 1) {
                     startWorkTimeWeekAM = entity.getWorkStime();
                     endWorkTimeWeekAM = entity.getWorkEtime();
                     loop3++;
                  } else {
                     if (startWorkTimeWeekAM.compareTo(entity
                           .getWorkStime()) > 0) {
                        startWorkTimeWeekAM = entity.getWorkStime();
                     }
                     if (endWorkTimeWeekAM.compareTo(entity
                           .getWorkEtime()) < 0) {
                        endWorkTimeWeekAM = entity.getWorkEtime();
                     }
                  }
               }
            }
         }
         request.setAttribute("startWorkTimePM", startWorkTimePM);
         request.setAttribute("endWorkTimePM", endWorkTimePM);
         request.setAttribute("startWorkTimeWeekAM", startWorkTimeWeekAM);
         request.setAttribute("endWorkTimeWeekAM", endWorkTimeWeekAM);
         request.setAttribute("startWorkTimeWeekendAM",
               startWorkTimeWeekendAM);
         request.setAttribute("endWorkTimeWeekendAM", endWorkTimeWeekendAM);
         request.setAttribute("formWorkTemplate", formWorkTemplate);
         ModelWorkTemplate enabledTemplate = this.serviceWorkTemplate
               .getEnabledWorkTemplate(formWorkTemplate.getDistrict()
                     .getId());
         request.setAttribute("enabledTemplate", enabledTemplate);
      } catch (ServiceException e) {
         // TODO Auto-generated catch block
         LOGGER.error(
               "Exception raised when fetch all work template by template id.",
               e);
      }
      return mapping.findForward("page.sys.setting.work.template.index");
   }

   /**
    * 弹出添加工作安排的dialog
    * @param mapping
    * @param form
    * @param request
    * @param response
    * @return
    */
   public ActionForward dialogWorkArrangePage(ActionMapping mapping,
         ActionForm form, HttpServletRequest request,
         HttpServletResponse response) {
      String[] week = { "", "周一", "周二", "周三", "周四", "周五", "周六", "周日" };
      String districtId = request.getParameter("districtId");
      String templateId = request.getParameter("templateId");
      if (this.isObjectIdValid(districtId)
            && this.isObjectIdValid(templateId)) {
         request.setAttribute("districtId", districtId);
         request.setAttribute("templateId", templateId);
         request.setAttribute("workDay",
               week[Integer.parseInt(request.getParameter("workDay"))]);
         try {
            List<ModelBaseWorkTime> workTimes = this.serviceBaseWorkTime
                  .getDayWorkTimeByDistrictIdAndTemplateId(districtId,
                        templateId);
            ModelBaseWorkContent entity = new ModelBaseWorkContent();
    		entity.getBaseWorkDistrict().setId(request.getParameter("districtId"));
            List<ModelBaseWorkContent> workContents = this.serviceBaseWorkContent.getListByCriteria(entity);
            request.setAttribute("workTimes", workTimes);
            request.setAttribute("workContents", workContents);
            ModelSchoolDistrict district = this.serviceSchoolDistrict
                  .get(districtId);
            List<ModelSchoolDepartment> departments = this.serviceSchoolDepartment
                  .getDepartmentByOrganization(district.getDistrictType());
            request.setAttribute("district", district);
            request.setAttribute("departments", departments);
         } catch (ServiceException e) {
            // TODO Auto-generated catch block
            LOGGER.error(
                  "Exception raised when fetch all work content by district.",
                  e);
         }
      } else {
         return ajaxPrint(response, getErrorCallback("请先选择校区和模板"));
      }
      return mapping.findForward("dialog.sys.setting.work.template.addpage");
   }

   /**
    * 暂时不用该方法
    * @param mapping
    * @param form
    * @param request
    * @param response
    * @return
    */
   public ActionForward getAllStaffByDprtId(ActionMapping mapping,
         ActionForm form, HttpServletRequest request,
         HttpServletResponse response) {
      ModelHrmEmployee employee = new ModelHrmEmployee();
      employee.getEmployeeDepartment()
            .setId(request.getParameter("departId"));
      employee.getEmployeeDistrict()
            .setId(request.getParameter("districtId"));
      try {
         List<ModelHrmEmployee> listStaff = this.serviceHrmEmployee
               .getEmployeeByDistrictIdAndDeptId(employee);
         StringBuffer staffNames = new StringBuffer();
         StringBuffer staffIds = new StringBuffer();
         for (ModelHrmEmployee entity : listStaff) {
            staffNames.append(entity.getEmpName()).append(",");
            staffIds.append(entity.getId()).append(",");
         }
         return ajaxPrint(response,
               "[{\"staffNames\":" + staffNames.toString()
                     + ",\"staffIds\":" + staffIds.toString() + "}]");
      } catch (ServiceException e) {
         // TODO Auto-generated catch block
         LOGGER.error(
               "Exception raised when fetch all work content by district.",
               e);
      }

      return ajaxPrint(response, "[]");
   }

   /**
    * 保存工作安排到模板中
    * @param mapping
    * @param form
    * @param request
    * @param response
    * @return
    */
   public ActionForward actionSaveWorkArrange(ActionMapping mapping,
         ActionForm form, HttpServletRequest request,
         HttpServletResponse response) {
        ModelWorkTemplate formModeWorkTemplate = (ModelWorkTemplate) form;

        ModelWorkTemplate t = null;
		try {
			t = this.serviceWorkTemplate.getEnabledWorkTemplate(formModeWorkTemplate.getDistrict().getId());
		} catch (ServiceException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
        String enableId = "0";
        if(t != null)
        	enableId = "1";
        // 保存工作人员
		Map<String, List<String>> paramEmpIds = this.getAllRequestParameters(request, new String[] {"empid"});
		if (paramEmpIds != null && paramEmpIds.size() > 0)
		{
			List<String> empIds = paramEmpIds.get("empid");
			List<ModelWorkTemplate> list = new ArrayList<ModelWorkTemplate>();
			for (String empId : empIds)
			{
				ModelHrmEmployee employee;
				try {
					employee = this.serviceHrmEmployee.get(empId);
					if (employee != null)
					{
						ModelWorkTemplate template = new ModelWorkTemplate();
						template.setWorkDay(formModeWorkTemplate.getWorkDay());
						template.getWorkTime().setId(formModeWorkTemplate.getWorkTime().getId());
						template.getWorkContent().setId(formModeWorkTemplate.getWorkContent().getId());
						template.setStaffName(employee.getEmpName());
						template.getStaff().setId(empId);
						template.setTemplateId(formModeWorkTemplate.getTemplateId());
						template.setEnable(enableId);
						template.getDistrict().setId(formModeWorkTemplate.getDistrict().getId());
						list.add(template);
					}
					else
					{
						LOGGER.warn("The employee does not exist with id:" + empId);
						return ajaxPrint(response,"提交的数据异常");
					}
				} catch (ServiceException e) {
					// TODO Auto-generated catch block
					return ajaxPrint(response,"提交的数据异常");
				}
			}
			try {
				if(list!=null && list.size() >0){
					this.serviceWorkTemplate.delete(formModeWorkTemplate.getWorkDay(), formModeWorkTemplate.getTemplateId());
				   this.serviceWorkTemplate.batchInsert(list);
		         // 保存成功后, Dialog进行关闭
		         return ajaxPrint(response, 
		               getSuccessCallback("添加工作安排成功.", CALLBACK_TYPE_CLOSE, CURRENT_NAVTABID, null, 
		            		   "{'district.id': '" + request.getParameter("district.id") + "', " +
		            		   	 "'templateId': '" + request.getParameter("templateId") + "'}", false));
				}
				else
					return ajaxPrint(response,"工作人员不能为空");
			} catch (ServiceException e) {
				// TODO Auto-generated catch block
				return ajaxPrint(response,"提交的数据异常");
			}
		}else{
        	return ajaxPrint(response,"提交的数据异常");
        }
   }

   /**
    * 启动当前模板
    * @param mapping
    * @param form
    * @param request
    * @param response
    * @return
    */
   public ActionForward actionEnableWorkTemplate(ActionMapping mapping,
         ActionForm form, HttpServletRequest request,
         HttpServletResponse response) {
      try {
         String id = request.getParameter("templateId");
         ModelWorkTemplate entity = (ModelWorkTemplate)form;
         if (this.isObjectIdValid(id)) {
        	 List<ModelWorkTemplate> list = this.serviceWorkTemplate.getListByCriteria(entity);
        	 if(list!=null && list.size()>0){
        		 int rows = this.serviceWorkTemplate.enableWorkTemplate(id);
	            if ( rows > 0) {
	               // 保存成功后, Dialog进行关闭
	               return ajaxPrint(
	                     response,
	                     getSuccessCallbackAndReloadCurrent("启动模板成功."));
	            } else {
	               return ajaxPrint(response, getErrorCallback("启动模板失败."));
	            }
        	 }else{
        		 return ajaxPrint(response, getErrorCallback("请先设置模板."));
        	 }
         } else {
            return ajaxPrint(response, getErrorCallback("启动模板失败."));
         }

      } catch (ServiceException e) {
         LOGGER.error(
               "It failed to save the base work content item entity!", e);

         return ajaxPrint(response, getErrorCallback("启动模板失败."));
      }
   }

   /**
    * <b>[WebAction]</b> <br/>
    * 工作安排设置-工作基础设置
    */
   public ActionForward pageWorkBaseIndex(ActionMapping mapping,
         ActionForm form, HttpServletRequest request,
         HttpServletResponse response) {
      // 获得校区信息
      List<ModelSchoolDistrict> districts = this.getAllDistricts();
      request.setAttribute("districts", districts);

      return mapping.findForward("page.sys.setting.work.base.index");
   }

   /**
    * <b>[WebAction]</b> <br/>
    * 工作安排设置-工作基础设置
    */
   public ActionForward pageWorkBaseContent(ActionMapping mapping,
         ActionForm form, HttpServletRequest request,
         HttpServletResponse response) {
      ModelBaseWorkContent formBaseWorkContent = (ModelBaseWorkContent) form;
      if (request.getParameter("districtId") != null)
         formBaseWorkContent.getBaseWorkDistrict().setId(
               request.getParameter("districtId"));
      PagingBean pagingBean = this.getPagingBean(request);
      try {
         PaginationSupport<ModelBaseWorkContent> baseWorkContents = this.serviceBaseWorkContent
               .getPaginationByEntity(formBaseWorkContent, pagingBean);
         request.setAttribute("baseWorkContents", baseWorkContents);
         outWritePagination(request, pagingBean, baseWorkContents);
      } catch (ServiceException e) {
         // TODO Auto-generated catch block
         LOGGER.error(
               "Exception raised when fetch all work content by district.",
               e);
      }
      return mapping.findForward("data.sys.setting.work.base.content");
   }

   /**
    * <b>[WebAction]</b> <br/>
    * 工作内容设置-工作内容配置弹框页面
    */
   public ActionForward dialogBaseWorkBasePage(ActionMapping mapping,
         ActionForm form, HttpServletRequest request,
         HttpServletResponse response) {
      try {
         String contentId = request.getParameter("contentId");
         if (this.isObjectIdValid(contentId)) {
            ModelBaseWorkContent baseWorkContent = this.serviceBaseWorkContent
                  .get(contentId);
            if (baseWorkContent != null) {
               request.setAttribute("baseWorkContent", baseWorkContent);
            } else {
               return ajaxPrint(response, getErrorCallback("该工作内容不存在!"));
            }
         }

         return mapping.findForward("dialog.sys.setting.work.content.page");
      } catch (ServiceException e) {
         LOGGER.error("Exception raised when fetch menu function entity!", e);
         return ajaxPrint(response,
               getErrorCallback("数据加载失败,原因:" + e.getMessage()));
      }
   }

   /**
    * <b>[WebAction]</b> <br/>
    * 工作内容设置-工作内容修改保存
    */
   public ActionForward actionSaveBaseWorkContent(ActionMapping mapping,
         ActionForm form, HttpServletRequest request,
         HttpServletResponse response) {

      try {
         ModelBaseWorkContent formModelBaseWorkContent = (ModelBaseWorkContent) form;
         Date date = new Date();
         formModelBaseWorkContent.setUpdateTime(date);
         ModelBaseWorkContent entity = null;

         boolean isCreation = !this.isObjectIdValid(formModelBaseWorkContent
               .getId());

         if (!isCreation) {
            // 更新
            entity = this.serviceBaseWorkContent
                  .get(formModelBaseWorkContent.getId());
            if (entity != null) {
               // 用表单输入的值覆盖实体中的属性值
               BeanUtils.copyProperties(formModelBaseWorkContent, entity);
            } else {
               return ajaxPrint(response, AjaxResponse.RESPONSE_ERROR);
            }
         } else {
            // 新建
            entity = formModelBaseWorkContent;
         }

         this.serviceBaseWorkContent.save(entity);

         // 保存成功后, Dialog进行关闭
         return ajaxPrint(
               response,
               getSuccessCallback("工作内容保存成功.", CALLBACK_TYPE_CLOSE,
                     CURRENT_NAVTABID, null, false));
      } catch (ServiceException e) {
         LOGGER.error(
               "It failed to save the base work content item entity!", e);

         return ajaxPrint(response, getErrorCallback("工作内容保存失败."));
      }
   }

   /**
    * <b>[WebAction]</b> <br/>
    * 工作内容设置-工作内容删除
    */
   @LogAnnotation(description = "删除基础工作内容",type="系统设置")
   public ActionForward actionRemoveBaseWorkContent(ActionMapping mapping,
         ActionForm form, HttpServletRequest request,
         HttpServletResponse response) {
      try {
         String contentId = request.getParameter("contentId");
         if (this.isObjectIdValid(contentId)) {
            // 删除
            this.serviceBaseWorkContent.remove(contentId);

            return ajaxPrint(
                  response,
                  getSuccessCallback("工作内容删除成功.", CALLBACK_TYPE_CLOSE,
                        CURRENT_NAVTABID, null, false));
         } else {
            return ajaxPrint(response,
                  getErrorCallback("工作内容删除失败,原因:非法工作内容ID(" + contentId
                        + ")被传递"));
         }
      } catch (ServiceException e) {
         LOGGER.error("Exception raised when fetch menu function entity!", e);
         return ajaxPrint(response,
               getErrorCallback("工作内容删除失败,原因:" + e.getMessage()));
      }
   }

   public static Logger getLogger() {
      return LOGGER;
   }

   /**
    * <b>[WebAction]</b> <br/>
    * 工作内容配置-添加工作内容配置
    */
   public ActionForward dialogAddWorkContent(ActionMapping mapping,
         ActionForm form, HttpServletRequest request,
         HttpServletResponse response) {
      request.setAttribute("districtId", request.getParameter("districtId"));
      return mapping.findForward("dialog.sys.setting.work.content.addpage");
   }

   public String checkWorkTime(String time) {
      if (time == null || "".equals(time))
         return "";
      String hour = time.substring(0, time.indexOf(":"));
      if (hour != null && !"".equals(hour)) {
         if (Integer.parseInt(hour) < 18)
            return "AM";
         else
            return "PM";
      }
      return "";
   }
   
   public ActionForward actionLoadArragedStaffByWorkContent(ActionMapping mapping,
         ActionForm form, HttpServletRequest request,
         HttpServletResponse response) {
	   ModelWorkTemplate templete = (ModelWorkTemplate)form;
	   try {
		   String arragedStaffs = "[";
		   if(this.isObjectIdValid(templete.getWorkContent().getId())){
			   List<ModelWorkTemplate> list = this.serviceWorkTemplate.getListByCriteria(templete);
			   int loop = 1;
			   for(ModelWorkTemplate entity : list){
				   arragedStaffs+="{\"id\":\""+entity.getStaff().getId()+"\",\"empName\":\""+entity.getStaffName()+"\"}";
				   if(loop < list.size()){
					   arragedStaffs += ",";
				   }
				   loop ++;
			   }
		   }
		   arragedStaffs += "]";
		   request.setAttribute("arragedStaffs", arragedStaffs);
	   } catch (ServiceException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	   return mapping.findForward("page.sys.setting.work.template.staff");
   }
}

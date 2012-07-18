package org.shengrui.oa.web.action.system;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.shengrui.oa.model.system.ModelBaseWorkTime;
import org.shengrui.oa.model.system.ModelSchoolDistrict;
import org.springframework.beans.BeanUtils;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.log.LogAnnotation;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

/**
 *工作时间设置-工作时间设置
 * 
 * @author Lee
 *
 */
public class sysSettingWorkTimeAction
extends sysSettingBaseAction
{
   /**
    * The LOGGER
    */
   private static final Logger LOGGER = Logger.getLogger(sysSettingWorkTimeAction.class);
   
   
   /**
    * <b>[WebAction]</b> 
    * <br/>
    * 工作安排设置-工作模板设置
    */
   public ActionForward pageWorkTemplateIndex (ActionMapping mapping, ActionForm form,
         HttpServletRequest request, HttpServletResponse response) 
   {
      
      return mapping.findForward("page.sys.setting.work.template.index");
   }
   

   
   
   /**
    * <b>[WebAction]</b> 
    * <br/>
    * 工作安排设置-工作基础设置
    */
   public ActionForward pageWorkBaseIndex (ActionMapping mapping, ActionForm form,
         HttpServletRequest request, HttpServletResponse response) 
   {
      System.out.println("进入工作基础设置");
      //获得校区信息
        List<ModelSchoolDistrict> districts=this.getAllDistricts();
        request.setAttribute("districts", districts);
      return mapping.findForward("page.sys.setting.work.base.time.index");
   }
   
   /**
    * <b>[WebAction]</b> 
    * <br/>
    * 工作安排设置-工作基础设置
    */
   public ActionForward pageWorkBaseTime (ActionMapping mapping, ActionForm form,
         HttpServletRequest request, HttpServletResponse response) 
   {
      ModelBaseWorkTime formBaseWorkTime = (ModelBaseWorkTime)form;
      if(request.getParameter("districtId")!=null)formBaseWorkTime.getBaseTimeDistrict().setId(request.getParameter("districtId"));
        PagingBean pagingBean = this.getPagingBean(request);
      try {
         PaginationSupport<ModelBaseWorkTime> baseWorkTiems =
               this.serviceBaseWorkTime.getPaginationByEntity(formBaseWorkTime, pagingBean);
         request.setAttribute("districtId", request.getParameter("districtId"));
         request.setAttribute("baseWorkTime", baseWorkTiems);
         outWritePagination(request, pagingBean, baseWorkTiems);
      } catch (ServiceException e) {
         // TODO Auto-generated catch block
         LOGGER.error("Exception raised when fetch all work content by district.", e);
      }
      return mapping.findForward("data.sys.setting.work.base.time");
   }
   
   /**
    * <b>[WebAction]</b> 
    * <br/>
    * 工作时间设置-工作时间配置弹框页面
    */
   public ActionForward dialogBaseWorkTimePage (ActionMapping mapping, ActionForm form,
         HttpServletRequest request, HttpServletResponse response) 
   {
      try
      {
         String id = request.getParameter("workTmId");
         if (this.isObjectIdValid(id))
         {
            // 工作时间更新操作
            ModelBaseWorkTime baseWorkTime = this.serviceBaseWorkTime.get(id);
            if (baseWorkTime != null)
            {
               request.setAttribute("baseWorkTime", baseWorkTime);
            }
            else
            {
               return ajaxPrint(response, getErrorCallback("该工作时间不存在!"));
            }
         }
         
         return mapping.findForward("dialog.sys.setting.work.time.page");
      }
      catch (ServiceException e)
      {
         LOGGER.error("Exception raised when fetch menu function entity!", e);
         return ajaxPrint(response, getErrorCallback("数据加载失败,原因:" + e.getMessage()));
      }
   }
   
   
   /**
    * <b>[WebAction]</b> 
    * <br/>
    *  工作内容设置-工作时间修改保存
    */
   public ActionForward actionSaveBaseWorkTime (ActionMapping mapping, ActionForm form,
         HttpServletRequest request, HttpServletResponse response) 
   {
      //拼接适用天数
      String[] adjustDays = request.getParameterValues("adjustDays");
      String adjustDay = "";
      for(String day : adjustDays){
         adjustDay+=day+",";
      }
      try
      {
         ModelBaseWorkTime formModelBaseWorkTime = (ModelBaseWorkTime) form;
         Date date = new Date();
         formModelBaseWorkTime.setUpdateTime(date);
         formModelBaseWorkTime.setAdjustDays(adjustDay.substring(0, adjustDay.length()-1));
         ModelBaseWorkTime entity = null;
         
         boolean isCreation = !this.isObjectIdValid(formModelBaseWorkTime.getId());
         
         if (!isCreation)
         {
            // 工作时间更新
            entity = this.serviceBaseWorkTime.get(formModelBaseWorkTime.getId());
            if (entity != null)
            {
               // 用表单输入的值覆盖实体中的属性值
               BeanUtils.copyProperties(formModelBaseWorkTime, entity);
            }
            else
            {
               return ajaxPrint(response, AjaxResponse.RESPONSE_ERROR);
            }
         }
         else
         {
            // 新建
            entity = formModelBaseWorkTime;
         }
         
         this.serviceBaseWorkTime.save(entity);
         
         // 保存成功后, Dialog进行关闭
         return ajaxPrint(response, 
               getSuccessCallback("工作时间保存成功.", CALLBACK_TYPE_CLOSE, CURRENT_NAVTABID, null, false));
      } 
      catch (ServiceException e)
      {
         LOGGER.error("It failed to save the base work content item entity!", e);
         
         return ajaxPrint(response, getErrorCallback("工作时间保存失败."));
      }
   }
   
   /**
    * <b>[WebAction]</b> 
    * <br/>
    * 工作安排基础设置-工作时间删除
    */
   @LogAnnotation(description="删除基础工作内容")
   public ActionForward actionRemoveBaseWorkTime (ActionMapping mapping, ActionForm form,
         HttpServletRequest request, HttpServletResponse response) 
   {
      try
      {
         String id = request.getParameter("workTmId");
         if (this.isObjectIdValid(id))
         {
            // 删除
             this.serviceBaseWorkTime.remove(id);
             
             return ajaxPrint(response, 
                     getSuccessCallback("工作时间删除成功.", CALLBACK_TYPE_CLOSE, CURRENT_NAVTABID, null, false));
         }
         else
         {
            return ajaxPrint(response, getErrorCallback("工作时间删除失败,原因:非法工作内容ID(" + id + ")被传递"));
         }
      }
      catch (ServiceException e)
      {
         LOGGER.error("Exception raised when fetch menu function entity!", e);
         return ajaxPrint(response, getErrorCallback("工作内容删除失败,原因:" + e.getMessage()));
      }
   }

   public static Logger getLogger()
   {
      return LOGGER;
   }

   /**
    * <b>[WebAction]</b> 
    * <br/>
    * 工作基础配置-添加工作时间配置
    */
   public ActionForward dialogAddWorkTime (ActionMapping mapping, ActionForm form,
         HttpServletRequest request, HttpServletResponse response) 
   {
      request.setAttribute("districtId", request.getParameter("districtId"));
      return mapping.findForward("dialog.sys.setting.work.time.addpage");
   }
}

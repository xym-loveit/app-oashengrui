package org.shengrui.oa.web.action.system;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.shengrui.oa.model.system.ModelBaseWorkContent;
import org.shengrui.oa.model.system.ModelSchoolDistrict;
import org.springframework.beans.BeanUtils;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.log.LogAnnotation;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

/**
 *工作安排设置-工作模板设置
 * 
 * @author Lee
 *
 */
public class sysSettingWorkAction
extends sysSettingBaseAction
{
   /**
    * The LOGGER
    */
   private static final Logger LOGGER = Logger.getLogger(sysSettingWorkAction.class);
   
   
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
      
      return mapping.findForward("page.sys.setting.work.base.index");
   }
   
   /**
    * <b>[WebAction]</b> 
    * <br/>
    * 工作安排设置-工作基础设置
    */
   public ActionForward pageWorkBaseContent (ActionMapping mapping, ActionForm form,
         HttpServletRequest request, HttpServletResponse response) 
   {
      ModelBaseWorkContent formBaseWorkContent = (ModelBaseWorkContent)form;
      if(request.getParameter("districtId")!=null)formBaseWorkContent.getBaseWorkDistrict().setId(request.getParameter("districtId"));
        PagingBean pagingBean = this.getPagingBean(request);
      try {
         PaginationSupport<ModelBaseWorkContent> baseWorkContents =
               this.serviceBaseWorkContent.getPaginationByEntity(formBaseWorkContent, pagingBean);
         request.setAttribute("baseWorkContents", baseWorkContents);
         outWritePagination(request, pagingBean, baseWorkContents);
      } catch (ServiceException e) {
         // TODO Auto-generated catch block
         LOGGER.error("Exception raised when fetch all work content by district.", e);
      }
      return mapping.findForward("data.sys.setting.work.base.content");
   }
   
   /**
    * <b>[WebAction]</b> 
    * <br/>
    * 工作内容设置-工作内容配置弹框页面
    */
   public ActionForward dialogBaseWorkBasePage (ActionMapping mapping, ActionForm form,
         HttpServletRequest request, HttpServletResponse response) 
   {
      try
      {
         String contentId = request.getParameter("contentId");
         if (this.isObjectIdValid(contentId))
         {
            ModelBaseWorkContent baseWorkContent = this.serviceBaseWorkContent.get(contentId);
            if (baseWorkContent != null)
            {
               request.setAttribute("baseWorkContent", baseWorkContent);
            }
            else
            {
               return ajaxPrint(response, getErrorCallback("该工作内容不存在!"));
            }
         }
         
         return mapping.findForward("dialog.sys.setting.work.content.page");
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
    *  工作内容设置-工作内容修改保存
    */
   public ActionForward actionSaveBaseWorkContent (ActionMapping mapping, ActionForm form,
         HttpServletRequest request, HttpServletResponse response) 
   {
      
      try
      {
         ModelBaseWorkContent formModelBaseWorkContent = (ModelBaseWorkContent) form;
         Date date = new Date();
         formModelBaseWorkContent.setUpdateTime(date);
         ModelBaseWorkContent entity = null;
         
         boolean isCreation = !this.isObjectIdValid(formModelBaseWorkContent.getId());
         
         if (!isCreation)
         {
            // 更新
            entity = this.serviceBaseWorkContent.get(formModelBaseWorkContent.getId());
            if (entity != null)
            {
               // 用表单输入的值覆盖实体中的属性值
               BeanUtils.copyProperties(formModelBaseWorkContent, entity);
            }
            else
            {
               return ajaxPrint(response, AjaxResponse.RESPONSE_ERROR);
            }
         }
         else
         {
            // 新建
            entity = formModelBaseWorkContent;
         }
         
         this.serviceBaseWorkContent.save(entity);
         
         // 保存成功后, Dialog进行关闭
         return ajaxPrint(response, 
               getSuccessCallback("工作内容保存成功.", CALLBACK_TYPE_CLOSE, CURRENT_NAVTABID, null, false));
      } 
      catch (ServiceException e)
      {
         LOGGER.error("It failed to save the base work content item entity!", e);
         
         return ajaxPrint(response, getErrorCallback("工作内容保存失败."));
      }
   }
   
   /**
    * <b>[WebAction]</b> 
    * <br/>
    * 工作内容设置-工作内容删除
    */
   @LogAnnotation(description="删除基础工作内容")
   public ActionForward actionRemoveBaseWorkContent (ActionMapping mapping, ActionForm form,
         HttpServletRequest request, HttpServletResponse response) 
   {
      try
      {
         String contentId = request.getParameter("contentId");
         if (this.isObjectIdValid(contentId))
         {
            // 删除
             this.serviceBaseWorkContent.remove(contentId);
             
             return ajaxPrint(response, 
                     getSuccessCallback("工作内容删除成功.", CALLBACK_TYPE_CLOSE, CURRENT_NAVTABID, null, false));
         }
         else
         {
            return ajaxPrint(response, getErrorCallback("工作内容删除失败,原因:非法工作内容ID(" + contentId + ")被传递"));
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
    * 工作内容配置-添加工作内容配置
    */
   public ActionForward dialogAddWorkContent (ActionMapping mapping, ActionForm form,
         HttpServletRequest request, HttpServletResponse response) 
   {
      request.setAttribute("districtId", request.getParameter("districtId"));
      return mapping.findForward("dialog.sys.setting.work.content.addpage");
   }
}

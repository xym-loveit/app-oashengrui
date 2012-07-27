package org.shengrui.oa.web.action.info;

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
import org.shengrui.oa.model.info.ModelInMessage;
import org.shengrui.oa.model.info.ModelShortMessage;
import org.shengrui.oa.util.ContextUtil;
import org.shengrui.oa.web.action.BaseAppAction;

import cn.trymore.core.util.UtilString;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

/**
 * 站内消息
 * 
 * @author Jeccy.Zhao
 *
 */
public class InfoMessageAction
extends BaseAppAction
{
	/**
	 * The LOGGER
	 */
	private static final Logger LOGGER = Logger.getLogger(InfoMessageAction.class);
	
	/**
	 * <b>[WebAction]</b> <br/>
	 * 收到的消息
	 */
	public ActionForward pageMessageReceivedIndex (ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) 
	{
		try
		{
			ModelShortMessage formEntity = (ModelShortMessage) form;
			
			PagingBean pagingBean = this.getPagingBean(request);
			PaginationSupport<ModelInMessage> inMsgs = 
					this.serviceInMessage.getPaginationByUser(
							ContextUtil.getCurrentUser().getEmployee().getId(), 
							formEntity,
							request.getParameter("readFlag"),
							pagingBean);
			
			request.setAttribute("dataList", inMsgs);
			request.setAttribute("formEntity", formEntity);
			request.setAttribute("readFlag", request.getParameter("readFlag"));
			
			// 输出分页信息至客户端
			outWritePagination(request, pagingBean, inMsgs);
			
			return mapping.findForward("page.info.msg.index");
		}
		catch (Exception e)
		{
			LOGGER.error("Exception raised when open my received message page..", e);
			return ajaxPrint(response, getErrorCallback("页面加载失败:" + e.getMessage()));
		}
	}
	
	/**
	 * <b>[WebAction]</b> <br/>
	 * 发送的消息
	 */
	public ActionForward pageMessageSentIndex (ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) 
	{
		try
		{
			PagingBean pagingBean = this.getPagingBean(request);
			PaginationSupport<ModelShortMessage> sentMsgs = 
					this.serviceShortMessage.getPaginationByUser(ContextUtil.getCurrentUser().getEmployee().getId(), pagingBean);
			
			request.setAttribute("dataList", sentMsgs);
			
			// 输出分页信息至客户端
			outWritePagination(request, pagingBean, sentMsgs);
			
			request.setAttribute("mailSent", "true");
			
			return mapping.findForward("page.info.msg.index");
		}
		catch (Exception e)
		{
			LOGGER.error("Exception raised when open my sent message page..", e);
			return ajaxPrint(response, getErrorCallback("页面加载失败:" + e.getMessage()));
		}
	}
	

	/**
	 * <b>[WebAction]</b> <br/>
	 * 消息详细页面
	 */
	public ActionForward dialogMessagePage (ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) 
	{
		String msgId = request.getParameter("msgId");
		
		if (UtilString.isNotEmpty(msgId))
		{
			if (this.isObjectIdValid(msgId))
			{
				try
				{
					ModelShortMessage entity = this.serviceShortMessage.get(msgId);
					if (entity != null)
					{
						String msgInId = request.getParameter("msgInId");
						if (UtilString.isNotEmpty(msgInId))
						{
							if (this.isObjectIdValid(msgInId))
							{
								ModelInMessage msgIn = this.serviceInMessage.get(msgInId);
								if (msgIn == null)
								{
									return ajaxPrint(response, getErrorCallback("消息不存在或者已删除..."));
								}
								else
								{
									if (msgIn.getReadFlag().equals(ModelInMessage.FLAG_UNREAD))
									{
										msgIn.setReadFlag(ModelInMessage.FLAG_READ);
										this.serviceInMessage.save(msgIn);
									}
								}
							}
							else
							{
								return ajaxPrint(response, getErrorCallback("需传入合法的接收消息Id..."));
							}
						}
						request.setAttribute("entity", entity);
					}
					else
					{
						return ajaxPrint(response, getErrorCallback("消息(id:" + msgId + ")不存在..."));
					}
				}
				catch (Exception e)
				{
					LOGGER.error("Exception raised when open the dialog page of message.", e);
					return ajaxPrint(response, getErrorCallback("页面加载失败:" + e.getMessage()));
				}
			}
			else
			{
				return ajaxPrint(response, getErrorCallback("您传入的消息Id不合法..."));
			}
			
			request.setAttribute("msgId", msgId);
		}
		else
		{
			try
			{
				// 设置为个人消息发送
				request.setAttribute("msgType", ModelShortMessage.EMessageType.TYPE_PERSONAL.getValue());
				
				this.loadOrganizationTree(request);
			}
			catch (Exception e)
			{
				LOGGER.error("Exception raised when open the dialog page of message..", e);
				return ajaxPrint(response, getErrorCallback("页面加载失败: " + e.getMessage()));
			}
		}
		
		return mapping.findForward("dialog.info.msg.page");
	}
	
	/**
	 * <b>[WebAction]</b> <br/>
	 * 消息发送保存
	 */
	public ActionForward actionSendShortMessage(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) 
	{
		
		try
		{
			String msgContent = request.getParameter("content");
			String msgSubject = request.getParameter("subject");
			String msgType = request.getParameter("msgType");
			
			ModelShortMessage msgShort = new ModelShortMessage();
			msgShort.setSendTime(new Date());
			msgShort.setSender(ContextUtil.getCurrentUser().getEmployee().getEmpName());
			msgShort.setSenderId(Long.valueOf(ContextUtil.getCurrentUser().getEmployee().getId()));
			msgShort.setContent(msgContent);
			msgShort.setSubject(msgSubject);
			msgShort.setMsgType(Integer.valueOf(msgType));
			this.serviceShortMessage.save(msgShort);
			
			Map<String, List<String>> paramReceiverIds = this.getAllRequestParameters(
					request, new String[] {"empid"});
			
			if (paramReceiverIds != null && paramReceiverIds.size() > 0)
			{
				List<String> empIds = paramReceiverIds.get("empid");
				for (String empId : empIds)
				{
					ModelHrmEmployee employee = this.serviceHrmEmployee.get(empId);
					if (employee != null)
					{
						ModelInMessage msgIn = new ModelInMessage();
						msgIn.setUserId(Long.valueOf(empId));
						msgIn.setUserFullName(employee.getEmpName());
						msgIn.setReceiveTime(new Date());
						msgIn.setShortMessage(msgShort);
						msgIn.setReadFlag(ModelInMessage.FLAG_UNREAD);
						msgIn.setDelFlag(ModelInMessage.FLAG_UNDEL);
						this.serviceInMessage.save(msgIn);
					}
					else
					{
						LOGGER.warn("The specified employee with id:" + empId + " does not exist.");
					}
				}
			}
			
			// 发送成功后, Dialog进行关闭
			return ajaxPrint(response, 
					getSuccessCallback("消息发送成功.", CALLBACK_TYPE_CLOSE, CURRENT_NAVTABID, null, false));
		}
		catch (Exception e)
		{
			LOGGER.error("Exception raised when sending short message.", e);
			return ajaxPrint(response, getErrorCallback("消息发送失败:" + e.getMessage()));
		}
	}
	
	/**
	 * <b>[WebAction]</b> <br/>
	 * 消息删除
	 */
	public ActionForward actionRemoveShortMessage(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) 
	{
		try
		{
			String msgInId = request.getParameter("msgInId");
			if (this.isObjectIdValid(msgInId))
			{
				ModelInMessage inMsg = this.serviceInMessage.get(msgInId);
				if (inMsg != null)
				{
					inMsg.setDelFlag(ModelInMessage.FLAG_DEL);
					this.serviceInMessage.save(inMsg);
					
					// 删除成功后, Dialog进行关闭
					return ajaxPrint(response, 
							getSuccessCallback("消息删除成功.", CALLBACK_TYPE_CLOSE, CURRENT_NAVTABID, null, false));
				}
				else
				{
					return ajaxPrint(response, getErrorCallback("消息(id:" + msgInId + ")数据不存在..."));
				}
			}
			else
			{
				return ajaxPrint(response, getErrorCallback("传入的消息ID不合法..."));
			}
		}
		catch (Exception e)
		{
			return ajaxPrint(response, getErrorCallback("消息删除失败:" + e.getMessage()));
		}
	}
	
	/**
	 * <b>[WebAction]</b> <br/>
	 * 获取未读短消息数
	 */
	public ActionForward actionObtainMyUnreadMessageNum(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) 
	{
		try
		{
			int msgCount = this.serviceInMessage.getUnreadMessageCountByUser(
				ContextUtil.getCurrentUser().getEmployee().getId());
			
			return ajaxPrint(response, String.valueOf(msgCount));
		}
		catch (Exception e)
		{
			LOGGER.error("Exception raised when getting unread message count.", e);
			return ajaxPrint(response, "0");
		}
	}
	
	public static Logger getLogger()
	{
		return LOGGER;
	}
}

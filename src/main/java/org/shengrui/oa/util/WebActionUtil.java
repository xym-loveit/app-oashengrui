package org.shengrui.oa.util;

import org.shengrui.oa.model.vo.ModelApprovalVO;

public final class WebActionUtil
{
	
	public static final String MENU_KEY_ADMIN_TASK = "_menu_mod_admin_task";
	
	public static final String URI_KEY_ADMIN_TASK = "app/admin/task.do?action=pageTaskDelegateIndex";
	
	/**
	 * 新闻发布审批操作
	 */
	public static final ModelApprovalVO APPROVAL_ADMIN_NEWS = new ModelApprovalVO(
		"_FUNCKEY_ADMIN_NEWS_APPROVE", "app/admin/news.do?action=actionNewsEditOrSave");
	
	/**
	 * 任务发布审批操作
	 */
	public static final ModelApprovalVO APPROVAL_ADMIN_TASK = new ModelApprovalVO(
		"_FUNCKEY_ADMIN_TASK_APPROVE", "app/personal/task.do?action=actionSaveTaskPlan");
	
	/**
	 * 岗位发布审批操作 - 总部
	 */
	public static final ModelApprovalVO APPROVAL_HRM_JOB_MASTER = new ModelApprovalVO(
		"_FUNCKEY_JOBAPPROVAL_SUBNODE", "app/hrm/hire.do?action=actionJobSave");
	
	/**
	 * 岗位发布审批操作 - 校区
	 */
	public static final ModelApprovalVO APPROVAL_HRM_JOB_ZOON = new ModelApprovalVO(
			"_FUNCKEY_JOBAPPROVAL_ROOT", "app/hrm/hire.do?action=actionJobSave");
	
	/**
	 * 消息更新Script
	 */
	public static final String scriptMessageNotify = "messageNotify";
	
	/**
	 * 短消息页面元素ID
	 */
	public static final String scriptArgMessageKey = "elenum_msg";
	
}

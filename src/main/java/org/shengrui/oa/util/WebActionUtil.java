package org.shengrui.oa.util;

import org.shengrui.oa.model.vo.ModelNotificationVO;

public final class WebActionUtil
{
	
	/**
	 * 新闻发布审批操作
	 */
	public static final ModelNotificationVO<String, String> APPROVAL_ADMIN_NEWS = 
			new ModelNotificationVO<String, String>("_FUNCKEY_ADMIN_NEWS_APPROVE", "app/admin/news.do?action=actionNewsEditOrSave");
	
	/**
	 * 任务发布审批操作
	 */
	public static final ModelNotificationVO<String, String> APPROVAL_ADMIN_TASK = 
			new ModelNotificationVO<String, String>("_FUNCKEY_ADMIN_TASK_APPROVE", "app/personal/task.do?action=actionSaveTaskPlan");
	
	/**
	 * 岗位发布审批操作 - 总部
	 */
	public static final ModelNotificationVO<String, String> APPROVAL_HRM_JOB_MASTER = 
			new ModelNotificationVO<String, String>("_FUNCKEY_JOBAPPROVAL_SUBNODE", "app/hrm/hire.do?action=actionJobSave");
	
	/**
	 * 岗位发布审批操作 - 校区
	 */
	public static final ModelNotificationVO<String, String> APPROVAL_HRM_JOB_ZOON = 
			new ModelNotificationVO<String, String>("_FUNCKEY_JOBAPPROVAL_ROOT", "app/hrm/hire.do?action=actionJobSave");
	
	/**
	 * 人力资源发展审批
	 */
	public static final ModelNotificationVO<String, String> APPROVAL_HRM_JOB_DEVELOP = 
			new ModelNotificationVO<String, String>("_FUNCKEY_HRM_DEVELOP_APPROVE", "app/personal/application_form.do?action=actionApproveProcess");
	
	/**
	 * 费用支出申请审批
	 */
	public static final ModelNotificationVO<String, String> APPROVAL_FINA_EXPENSE = 
			new ModelNotificationVO<String, String>("_FUNCKEY_FINAN_EXPENSE_APPROVE", "app/finan/contract.do?action=actionFinanApplicationApprove");

	/**
	 * 合同申请审批
	 */
	public static final ModelNotificationVO<String, String> APPROVAL_FINA_CONTRACT = 
		new ModelNotificationVO<String, String>("_FUNCKEY_FINAN_CONTRACT_APPROVE", "app/finan/contract.do?action=actionFinanApplicationApprove");
	
	/**
	 * 招聘入职-入职操作
	 */
	public static final ModelNotificationVO<String, String> APPROVAL_HRM_ENTRY_ONBOARD = 
		new ModelNotificationVO<String, String>("_FUNCKEY_HRM_ENTRY_OP_ONBOARD", "app/hrm/entry.do?action=actionEntrySave");
	
	/**
	 * 招聘入职-考察期操作
	 */
	public static final ModelNotificationVO<String, String> APPROVAL_HRM_ENTRY_INSPECT = 
		new ModelNotificationVO<String, String>("_FUNCKEY_HRM_ENTRY_OP_QUALIFY", "app/hrm/entry.do?action=actionEntrySave");
	
	/**
	 * 任务委托管理菜单, 必须具备审批操作权限.
	 */
	public static final ModelNotificationVO<String, ModelNotificationVO<String, String>> MENU_ITEM_ADMIN_TASK = 
			new ModelNotificationVO<String, ModelNotificationVO<String, String>>("_menu_mod_admin_task", 
					new ModelNotificationVO<String, String>(
							APPROVAL_ADMIN_TASK.getKey(), 
							"app/admin/task.do?action=pageTaskDelegateIndex"));
	
	/**
	 * 人力资源发展管理菜单, 必须具备审批操作权限.
	 */
	public static final ModelNotificationVO<String, ModelNotificationVO<String, String>> MENU_ITEM_HRM_DEVELOP = 
			new ModelNotificationVO<String, ModelNotificationVO<String, String>>("_menu_mod_admin_emp_develop", 
					new ModelNotificationVO<String, String>(
							APPROVAL_HRM_JOB_DEVELOP.getKey(), 
							"app/hrm/develop.do?action=actionDevelopLoadRecords"));
	
	/**
	 * 招聘入职菜单, 必须同时具备入职操作及考察期操作权限.
	 */
	public static final ModelNotificationVO<String, ModelNotificationVO<String, String>> MENU_ITEM_HRM_ENTRY = 
			new ModelNotificationVO<String, ModelNotificationVO<String, String>>("_menu_mod_hrm_entry", 
					new ModelNotificationVO<String, String>(
							APPROVAL_HRM_ENTRY_ONBOARD.getKey() + "," + APPROVAL_HRM_ENTRY_INSPECT.getKey(), 
							"app/hrm/entry.do?action=actionEntrySave"));
	
	/**
	 * 费用支出申请菜单, 必须具备审批操作权限.
	 */
	public static final ModelNotificationVO<String, ModelNotificationVO<String, String>> MENU_ITEM_FINA_EXPENSE = 
			new ModelNotificationVO<String, ModelNotificationVO<String, String>>("_menu_mod_fina_exp_records", 
					new ModelNotificationVO<String, String>(
							APPROVAL_FINA_EXPENSE.getKey(), 
							"app/finan/expense.do?action=loadFinaExpenseRecords"));
	
	/**
	 * 合同审批申请菜单, 必须具备审批操作权限.
	 */
	public static final ModelNotificationVO<String, ModelNotificationVO<String, String>> MENU_ITEM_FINA_CONTRACT = 
			new ModelNotificationVO<String, ModelNotificationVO<String, String>>("_menu_mod_fina_contract_records", 
					new ModelNotificationVO<String, String>(
							APPROVAL_FINA_CONTRACT.getKey(), 
							"app/finan/contract.do?action=loadFinaContractRecords"));
	
	/**
	 * 消息更新Script
	 */
	public static final String scriptMessageNotify = "messageNotify";
	
	/**
	 * 短消息页面元素ID
	 */
	public static final String scriptArgMessageKey = "elenum_msg";
	
}

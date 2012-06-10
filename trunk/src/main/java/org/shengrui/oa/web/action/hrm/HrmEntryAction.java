package org.shengrui.oa.web.action.hrm;

import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.shengrui.oa.model.hrm.ModelHrmArchive;
import org.shengrui.oa.model.hrm.ModelHrmJobHireEntry;

import cn.trymore.core.util.UtilString;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

/**
 * 招聘入职
 * 
 * @author Jeccy.Zhao
 *
 */
public class HrmEntryAction
extends BaseHrmAction
{
	/**
	 * The LOGGER
	 */
	private static final Logger LOGGER = Logger.getLogger(HrmEntryAction.class);
	
	/**
	 * 入职状态操作KEY
	 */
	private static final String ACTION_BOARD = "board";
	
	/**
	 * 考察期处理操作KEY
	 */
	private static final String ACTION_QUALIFIED = "qualified";
	
	/**
	 * <b>[WebAction]</b> <br/>
	 * 招聘入职
	 */
	public ActionForward hrmPageEntryIndex(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) 
	{
		try
		{
			ModelHrmJobHireEntry formEntry = (ModelHrmJobHireEntry) form;
			PagingBean pagingBean = this.getPagingBean(request);
			PaginationSupport<ModelHrmJobHireEntry> entries =
					this.serviceHrmJobHireEntry.getPaginationByEntity(formEntry, pagingBean);
			
			request.setAttribute("entries", entries);
			request.setAttribute("formEntry", formEntry);
			
			// 获取所有校区数据
			request.setAttribute("districts", this.serviceSchoolDistrict.getAll());
			
			// 输出分页信息至客户端
			outWritePagination(request, pagingBean, entries);
			
			return mapping.findForward("hrm.page.entry.index");
		}
		catch (Exception e)
		{
			LOGGER.error("Exception raised when open the archive index page.", e);
			return ajaxPrint(response, getErrorCallback("人才库数据数据加载失败:" + e.getMessage()));
		}
	}
	
	/**
	 * <b>[WebAction]</b> <br/>
	 * 入职弹框操作页面
	 */
	public ActionForward dialogEntryBoardPage(ActionMapping mapping,
			ActionForm form, HttpServletRequest request, HttpServletResponse response) 
	{
		try
		{
			String entryId = request.getParameter("entryId");
			if (this.isObjectIdValid(entryId))
			{
				ModelHrmJobHireEntry entry = this.serviceHrmJobHireEntry.get(entryId);
				if (entry != null)
				{
					request.setAttribute("jobHireEntry", entry);
					request.setAttribute("state", request.getParameter("state"));
					request.setAttribute("op", request.getParameter("op"));
					
					request.setAttribute("districts", this.serviceSchoolDistrict.getAll());
					
					if (entry.getEntryDistrict() != null)
					{
						request.setAttribute("departments", 
								this.getDepartmentByOrganization(entry.getEntryDistrict().getDistrictType().toString()));
						
						if (entry.getEntryDepartment() != null)
						{
							request.setAttribute("positions", 
									this.getPositionByDepartment(entry.getEntryDepartment().getId()));
						}
						
					}
					
					return mapping.findForward("dialog.page.entry.onboard");
				}
				else
				{
					return ajaxPrint(response, getErrorCallback("入职信息不存在!"));
				}
			}
			else
			{
				return ajaxPrint(response, getErrorCallback("检测非法入职ID被传入!"));
			}
		}
		catch (Exception e)
		{
			LOGGER.error("Exception raised when open the entry finalize page.", e);
			return ajaxPrint(response, getErrorCallback("页面加载失败:" + e.getMessage()));
		}
	}
	
	/**
	 * <b>[WebAction]</b> <br/>
	 * 入职未到&考察未通过弹框操作页面
	 */
	public ActionForward dialogEntryFinalize(ActionMapping mapping,
			ActionForm form, HttpServletRequest request, HttpServletResponse response) 
	{
		
		try
		{
			String entryId = request.getParameter("entryId");
			if (this.isObjectIdValid(entryId))
			{
				ModelHrmJobHireEntry entry = this.serviceHrmJobHireEntry.get(entryId);
				if (entry != null)
				{
					request.setAttribute("jobHireEntry", entry);
					request.setAttribute("state", request.getParameter("state"));
					request.setAttribute("op", request.getParameter("op"));
					
					return mapping.findForward("dialog.page.entry.finalize");
				}
				else
				{
					return ajaxPrint(response, getErrorCallback("入职信息不存在!"));
				}
			}
			else
			{
				return ajaxPrint(response, getErrorCallback("检测非法入职ID被传入!"));
			}
		}
		catch (Exception e)
		{
			LOGGER.error("Exception raised when open the entry finalize page.", e);
			return ajaxPrint(response, getErrorCallback("页面加载失败:" + e.getMessage()));
		}
	}
	
	/**
	 * <b>[WebAction]</b> <br/>
	 * 入职状态控制 (入职, 未到, 考察)
	 */
	public ActionForward actionEntrySave(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) 
	{
		try
		{
			String state = request.getParameter("state");
			String operation = request.getParameter("op");
			if (UtilString.isNotEmpty(state, operation) && UtilString.isNumeric(state))
			{
				if (operation.equalsIgnoreCase(ACTION_BOARD) || operation.equalsIgnoreCase(ACTION_QUALIFIED))
				{
					String entryId = request.getParameter("entryId");
					if (this.isObjectIdValid(entryId))
					{
						ModelHrmJobHireEntry entry = this.serviceHrmJobHireEntry.get(entryId);
						if (entry != null)
						{
							entry.setFinalStatus(Integer.parseInt(state));
							
							if (ACTION_BOARD.equalsIgnoreCase(operation))
							{
								if (ModelHrmJobHireEntry.EHireEntryFStatus.ONBOARD.getValue().toString().equals(state))
								{
									// 入职
									entry.setInspectStatus(ModelHrmJobHireEntry.EHireEntryInspectStatus.INSPECTING.getValue());
									
									String districtId = request.getParameter("entryDistrictId");
									String depId = request.getParameter("entryDepartmentId");
									String positionId = request.getParameter("entryPositionId");
									String chargerId = request.getParameter("charger.id");
									
									if (UtilString.isNotEmpty(districtId, depId, positionId, chargerId))
									{
										if (!entry.getEntryDistrict().getId().equals(districtId))
										{
											entry.setEntryDistrict(this.serviceSchoolDistrict.get(districtId));
										}
										
										if (!entry.getEntryDepartment().getId().equals(depId))
										{
											entry.setEntryDepartment(this.serviceSchoolDepartment.get(depId));
										}
										
										if (!entry.getEntryPosition().getId().equals(positionId))
										{
											entry.setEntryPosition(this.serviceSchoolDepartmentPosition.get(positionId));
										}
										
										if (!entry.getEntryCharger().getId().equals(chargerId))
										{
											entry.setEntryCharger(this.serviceAppUser.get(chargerId));
										}
									}
									
									entry.setEntryActDate(Timestamp.valueOf(request.getParameter("entryActDate")));
								}
								else if (ModelHrmJobHireEntry.EHireEntryFStatus.OUTOFBOARD.getValue().equals(state))
								{
									// 未到
									entry.setFinalStatus(ModelHrmJobHireEntry.EHireEntryInspectStatus.UNQUALIFIED.getValue());
								}
							}
							else
							{
								// 考察处理
								entry.setInspectStatus(Integer.parseInt(state));
							}
							
							this.serviceHrmJobHireEntry.save(entry);
							
							String archived = request.getParameter("archived");
							if (UtilString.isNotEmpty(archived))
							{
								// 移入人才库
								String archiveStar = request.getParameter("archiveStar");
								ModelHrmArchive hrmArchive = new ModelHrmArchive();
								hrmArchive.setJobHireInfo(entry.getJobHireIssue().getJobHire());
								hrmArchive.setResume(entry.getJobHireIssue().getResume());
								hrmArchive.setSource(ModelHrmArchive.EArchiveSource.OUTOFPROBATION.getValue());
								hrmArchive.setStarLevel(Integer.parseInt(archiveStar));
								this.serviceHrmArchive.save(hrmArchive);
							}
							
							// 保存成功后, Dialog进行关闭
							return ajaxPrint(response, 
									getSuccessCallback("应聘状态切换成功.", CALLBACK_TYPE_CLOSE, CURRENT_NAVTABID, null, false));
						}
						else
						{
							return ajaxPrint(response, getErrorCallback("入职信息不存在!"));
						}
					}
					else
					{
						return ajaxPrint(response, getErrorCallback("检测非法入职ID被传入!"));
					}
				}
				else
				{
					return ajaxPrint(response, getErrorCallback("未知的状态切换操作:" + operation));
				}
			}
			else
			{
				return ajaxPrint(response, getErrorCallback("需要指定需要切换的入职状态或者具体的状态操作!"));
			}
		}
		catch (Exception e)
		{
			LOGGER.error("Exception raised when saving the entry", e);
			return ajaxPrint(response, getErrorCallback("入职状态保存失败:" + e.getMessage()));
		}
	}
	
}

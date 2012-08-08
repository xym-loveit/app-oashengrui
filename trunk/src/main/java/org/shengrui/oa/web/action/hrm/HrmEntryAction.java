package org.shengrui.oa.web.action.hrm;

import java.sql.Timestamp;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.shengrui.oa.model.hrm.ModelHrmArchive;
import org.shengrui.oa.model.hrm.ModelHrmEmployee;
import org.shengrui.oa.model.hrm.ModelHrmEmployeeRoadMap;
import org.shengrui.oa.model.hrm.ModelHrmJobHireEntry;
import org.shengrui.oa.model.hrm.ModelHrmResume;
import org.shengrui.oa.model.system.ModelAppUser;
import org.shengrui.oa.util.ContextUtil;

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
	 * 入职未到操作KEY
	 */
	private static final String ACTION_OUTOFBOARD = "outofboard";
	
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
			
			// 只显示已安排的入职信息.
			formEntry.setCurrentStatus(ModelHrmJobHireEntry.EHireEntryCStatus.ARRANGED.getValue());
			
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
				if (operation.equalsIgnoreCase(ACTION_BOARD) || operation.equalsIgnoreCase(ACTION_QUALIFIED)
						|| operation.equalsIgnoreCase(ACTION_OUTOFBOARD))
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
								else
								{
									return ajaxPrint(response, getErrorCallback("入职状态码不正确..."));
								}
							}
							else if (ACTION_OUTOFBOARD.equalsIgnoreCase(operation))
							{
								// 未到处理
								if (!ModelHrmJobHireEntry.EHireEntryFStatus.OUTOFBOARD.getValue().toString().equals(state))
								{
									return ajaxPrint(response, getErrorCallback("未到状态码不正确..."));
								}
							}
							else
							{
								// 考察处理
								entry.setInspectStatus(Integer.parseInt(state));
							}
							
							if (ACTION_QUALIFIED.equalsIgnoreCase(operation) && 
									state.equals(ModelHrmJobHireEntry.EHireEntryInspectStatus.PASSED.getValue().toString()))
							{
								// 考察通过 -> 生成员工数据
								if (!this.actionEmployeeCreation(entry)) 
								{
									return ajaxPrint(response, getErrorCallback("员工数据生成失败!"));
								}
								else
								{
									// 改变员工在职状态
									ModelHrmEmployee employee = this.serviceHrmEmployee.get(request.getParameter("empId"));
									if (employee != null)
									{
										ModelHrmEmployeeRoadMap roadMap = new ModelHrmEmployeeRoadMap();
										
										// 考察通过 -> 正式员工
										employee.setOnboardStatus(ModelHrmEmployee.EOnBoardStatus.ONREGULAR.getValue());
												
										roadMap.setType(ModelHrmEmployeeRoadMap.ERoadMapType.BEREGULAR.getValue());
										roadMap.setEmployee(employee);
										roadMap.setOrginalDepartment(employee.getEmployeeDepartment());
										roadMap.setOrginalDepartmentPosition(employee.getEmployeePosition());
										roadMap.setOrginalDistrict(employee.getEmployeeDistrict());
										roadMap.setDate(new Date());
										
										employee.getRoadMaps().add(roadMap);
										this.serviceHrmEmployee.save(employee);
									}
									else
									{
										return ajaxPrint(response, getErrorCallback("员工数据不存在!"));
									}
								}
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
								if (operation.equalsIgnoreCase(ACTION_QUALIFIED))
								{
									hrmArchive.setSource(ModelHrmArchive.EArchiveSource.OUTOFPROBATION.getValue());
								}
								else if (operation.equalsIgnoreCase(ACTION_OUTOFBOARD))
								{
									hrmArchive.setSource(ModelHrmArchive.EArchiveSource.OFFERDROPED.getValue());
								}
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
	
	/**
	 * 根据入职信息创建员工.
	 * 
	 * @param entry
	 * @return
	 */
	private boolean actionEmployeeCreation (ModelHrmJobHireEntry entry)
	{
		if (entry != null)
		{
			try
			{
				ModelHrmResume resume = entry.getJobHireIssue().getResume();
				
				ModelHrmEmployee employee = new ModelHrmEmployee();
				employee.setResume(resume);
				employee.setEmployeeDepartment(entry.getEntryDepartment());
				employee.setEmployeeDistrict(entry.getEntryDistrict());
				employee.setEmployeePosition(entry.getEntryPosition());
				employee.setEmpName(resume.getFullName());
				employee.setEntryDateTime(new Date());
				employee.setOnboardStatus(ModelHrmEmployee.EOnBoardStatus.ONINSPECT.getValue());
				employee.setOnboardDate(entry.getEntryActDate());
				
				// 设置员工基本信息
				employee.setPhoneNo(resume.getMobilePhone());
				employee.setBirthdate(resume.getBirthday());
				
				// 设置录入时间及录入人员信息
				employee.setEntryDateTime(new Date());
				employee.setEntryId(Integer.parseInt(ContextUtil.getCurrentUser().getId()));
				
				// 生成员工号编号
				int amount = this.serviceHrmEmployee.getEmployeeAmoutByDistrictIdAndDepId(
						employee.getEmployeeDistrict().getId(), employee.getEmployeeDepartment().getId());
				employee.setEmpNo(this.generateEmployeeNo(
						employee.getEmployeeDistrict(), employee.getEmployeeDepartment(), amount));
				
				// 生成员工的履历
				ModelHrmEmployeeRoadMap employeeRoadMap = new ModelHrmEmployeeRoadMap();
				employeeRoadMap.setEmployee(employee);
				employeeRoadMap.setOrginalDepartment(employee.getEmployeeDepartment());
				employeeRoadMap.setOrginalDepartmentPosition(employee.getEmployeePosition());
				employeeRoadMap.setOrginalDistrict(employee.getEmployeeDistrict());
				employeeRoadMap.setDate(new Date());
				employeeRoadMap.setType(ModelHrmEmployeeRoadMap.ERoadMapType.ONBOARD.getValue());
				
				employee.getRoadMaps().add(employeeRoadMap);
				this.serviceHrmEmployee.save(employee);
				
				// 将员工ID更新到简历的emp_id字段
				resume.setEmployeeId(Integer.parseInt(employee.getId()));
				this.serviceHrmResume.save(resume);
				
				// 生成员工对应的用户数据
				ModelAppUser user = new ModelAppUser();
				user.setEmployee(employee);
				user.setUsername(employee.getEmpNo());
				user.setPassword(UtilString.encryptSha256(employee.getEmpNo()));
				user.setFullName(employee.getEmpName());
				user.setStatus(ModelAppUser.EUserStatus.ACTIVATED.getValue());
				user.setDistrict(employee.getEmployeeDistrict());
				user.setPosition(employee.getEmployeePosition());
				user.setDepartment(employee.getEmployeeDepartment());
				this.serviceAppUser.save(user);
				
				return true;
				
			}
			catch (Exception e)
			{
				LOGGER.error("Exception raised when creates employee data.", e);
			}
		}
		
		return false;
	}
	
}

<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<link rel="stylesheet" href="resources/css/jquerylib/jquery.treeview.css" type="text/css" media="screen" />
<script type="text/javascript" src='resources/js/jquerylib/jquery.cookie.js'></script>
<script type="text/javascript" src='resources/js/jquerylib/jquery.treeview.js'></script>
<style>
	
</style>
<script>
	$(function(){
		$(".submenu").treeview({
			animated: "fast",
			collapsed: true
			//unique: true,
			//persist: "cookie"
		});

		$.each($(".topitem"),function(){
			$(this).click(function(){
				if(!$(this).parent().hasClass("active")){
					var _self = $(this);
					var active_li = $("li.active");
					if(active_li.size() > 0){
						active_li.find(".submenu_wrapper").slideUp("slow",function(){
							active_li.removeClass("active").addClass("inactive");
						});
					}
					_self.wait(2000);
					_self.parent().removeClass("inactive").addClass("active");
					_self.siblings(".submenu_wrapper").slideDown("fast",function(){});
				}
			});
		});

		var _url = window.location.href;
		var _links = $(".nodemenu").find("a");
		
		for(i = 0,size = _links.length; i < size; i++){
			var _ele  = $(_links.get(i));
			var _href = _ele.attr("href");
			if(_url.indexOf(_href) > -1){
				$("li.active").attr("class","inactive");
				_ele.css("color","red");
				_ele.parent().parent().css("display","block");
				_ele.parent().parent().parent().find("span").css("color","red");
				_ele.parent().parent().parent().attr("class","collapsable");
				_ele.parent().parent().parent().parent().parent().parent().attr("class","active");
				break;
			}
		}

	});
</script>

<div id="menu">
	
	<logic:present name="__menuholder" scope="session">
		<ul>
			<logic:iterate name="__menuholder" id="root" indexId="idx">
				<li class="<c:if test='${idx!=0}'>in</c:if>active">
					<span class="${root.menuIconClass} pngfix topitem">${root.menuTitle}</span>
					<div class="submenu_wrapper">
					<logic:notEmpty name="root" property="menuChildren">
						<ul class="submenu">
							<logic:iterate name="root" property="menuChildren" id="child">
								<li>
									<span class="pngfix">${child.menuTitle}</span>
									<logic:notEmpty name="child" property="menuChildren">
										<ul class="nodemenu">
											<logic:iterate name="child" property="menuChildren" id="node">
												<li><a title="${node.menuTitle}" href="${node.menuURL}">${node.menuTitle}</a></li>
											</logic:iterate>
										</ul>
									</logic:notEmpty>
								</li>
							</logic:iterate>
						</ul>
					</logic:notEmpty>
					</div>
				</li>
			</logic:iterate>
		</ul>
	</logic:present> 
	
	<%--<ul>
		<li class="active">
			<span class="admin pngfix topitem">行政管理</span>
			<div class="submenu_wrapper">
				<ul class="submenu">
					<li>
						<span class="pngfix">开班招生</span>
						<ul class="nodemenu">
							<li><a title="开设新班级" href="admin/enroll/new_class">开设新班级</a></li>
							<li><a title="开始报名" href="admin/enroll/apply">开始报名</a></li>
							<li><a title="开始报名" href="admin/enroll/terminal_opr">报名缴费</a></li>
							<li><a title="招生咨询" href="system/maintenance/consult">招生咨询</a></li>	
						</ul>
					</li>

					<li>
						<span class="pngfix">学期事务</span>
						<ul class="nodemenu">
							<li><a title="周行政工作安排" href="admin/affair/staff_work_arrange/weekNumOff=0">周行政工作安排</a></li>
							<li><a title="每日教学运营工作" href="admin/affair/daily_tech_work/dayNumOff=0">每日教学运营工作</a></li>
							<li><a title="每日行政运营工作" href="admin/affair/daily_govern_work/dayNumOff=0">每日行政运营工作</a></li>
							
                                                        <li><a title="安全管理" href="system/maintenance/accident">安全管理</a></li>
							<li><a title="工作提醒" href="system/maintenance/task">工作提醒</a></li>
							<li><a title="通知管理" href="system/maintenance/notice">通知管理</a></li>
						</ul>
					</li>
                                        <li>
						<span class="pngfix">学生管理</span>
						<ul class="nodemenu">
							<li><a title="学生转班/休学" href="admin/affair/student_trans_suspend">学生转班/休学</a></li>
							<li><a title="学生档案" href="admin/maintenance/student">学生档案</a></li>
							<li><a title="学生评奖" href="javascript:void(0);">学生评奖</a></li>
						</ul>
					</li>
					<li>
						<span class="pngfix">班级管理</span>
						<ul class="nodemenu">
							<li><a title="班级停课" href="admin/team/finalize">班级停课</a></li>
							<li><a title="班级续读" href="admin/team/continue">班级续读</a></li>
							<li><a title="班级升段" href="admin/team/level_up">班级升段</a></li>
							<li><a title="班级拆班" href="admin/team/separate">班级拆班</a></li>
							<li><a title="班级状态控制" href="admin/team/states">班级状态控制</a></li>
							<li><a title="班级信息" href="admin/maintenance/class">班级信息</a></li>
						</ul>
					</li>
					<li>
						<span class="pngfix">收费管理</span>
						<ul class="nodemenu">
							<li><a title="订单提交" href="material/material_order/index">订单提交</a></li>
							<li><a title="历史订单" href="material/order_maintain/index">历史订单</a></li>
							<li><a title="物料管理" href="material/material_maintain/index">物料管理</a></li>
						</ul>
					</li>

				</ul>
			</div>
		</li>
		<li class="inactive">
			<span class="tech pngfix topitem">教学管理</span>
			<div class="submenu_wrapper">
				<ul class="submenu">
					<li>
						<span class="pngfix">学期教学</span>
						<ul class="nodemenu">
							<li><a title="周学课表" href="techmgr/week_tech_schedule/weekNumOff=0">周教学课表</a></li>
							<li><a title="教学进度" href="javascript:void(0);">教学进度</a></li>
						</ul>
					</li>
					<li>
						<span class="pngfix">考试成绩</span>
						<ul class="nodemenu">
							<li><a title="月考试安排" href="techmgr/examination/exam_arrange">月考试安排</a></li>
							<li><a title="班级成绩及达标评估分析录入编辑" href="techmgr/examination/score_standards">成绩及达标评估</a></li>
							<li><a title="学生学期评估录入编辑" href="techmgr/examination/sems_assessment">学生学期评估录入</a></li>
							<li><a title="校外成绩" href="techmgr/examination/score_external">校外成绩</a></li>
						</ul>
					</li>
					<li>
						<span class="pngfix">获奖管理</span>
						<ul class="nodemenu">
	
							<li><a title="奖项设置" href="javascript:void(0);">奖项设置</a></li>
							<li><a title="校外获奖" href="javascript:void(0);">校外获奖</a></li>
						</ul>
					</li>

				</ul>
			</div>
		</li>
		<li class="inactive">
			<span class="pngfix topitem hr">人力资源</span>
			<div class="submenu_wrapper">
				<ul class="submenu">
					<li>
						<span class="pngfix">员工管理</span>
						<ul class="nodemenu">
							<li><a title="员工入职" href="hr/staff/new">员工入职</a></li>
							<li><a title="人事调整" href="hr/staff">人事调整</a></li>
							<li><a title="员工档案" href="hr/staff">员工档案</a></li>
							<li><a title="员工评奖" href="javascript:void(0);">员工评奖</a></li>
						</ul>
					</li>
				</ul>
			</div>
		</li>
		<!--<li class="inactive">
			<span class="static pngfix topitem data">统计分析</span>
		</li>-->
		
		<sec:authorize ifAnyGranted="ROLE_USER">
			<li class="inactive">
				<span class="pngfix topitem settings">个人管理</span>
				<div class="submenu_wrapper">
					<ul class="submenu">
						<li>
							<span class="pngfix">密码管理</span>
							<ul class="nodemenu">
								<li><a title="密码修改" href="sysmgr/user/change_password">密码修改</a></li>
							</ul>
						</li>
					</ul>
				</div>
			</li>
		</sec:authorize>
		<sec:authorize ifAnyGranted="ROLE_ADMIN,ROLE_SUPER_ROOT">
			<li class="inactive">
				<span class="pngfix topitem settings">系统管理</span>
				<div class="submenu_wrapper">
					<ul class="submenu">
						<li>
							<span class="pngfix">用户管理</span>
							<ul class="nodemenu">
								<li><a title="权限控制" href="sysmgr/user/roles">用户权限控制</a></li>
								<li><a title="密码修改" href="sysmgr/user/change_password">密码修改</a></li>
								<sec:authorize ifAllGranted="ROLE_SUPER_ROOT">
									<li><a title="权限组管理" href="sysmgr/user/role_groups">权限组管理</a></li>
									<li><a title="访问资源管理" href="sysmgr/user/resources">访问资源管理</a></li>
								</sec:authorize> 
							</ul>
						</li>
						<li>
							<span class="pngfix">菜单管理</span>
							<ul class="nodemenu">
								<li><a title="菜单管理" href="sysmgr/menu">菜单管理</a></li>
							</ul>
						</li>
						<li>
							<span class="pngfix">日志管理</span>
							<ul class="nodemenu">
								<li><a title="系统日志" href="javascript:void(0);">系统日志</a></li>
							</ul>
						</li>
						<li>
							<span class="pngfix">常用数据管理</span>
							<ul class="nodemenu">
								<li><a title="课程类别" href="sysmgr/data/course">课程类别</a></li>
								<li><a title="物品类别" href="sysmgr/data/material">物品类别</a></li>
								<li><a title="教学场地" href="sysmgr/data/tech_place">教学场地</a></li>
								<li><a title="电教座位" href="sysmgr/data/phone_tech_position">电教座位</a></li>
								<!--<li><a title="值班任务" href="sysmgr/data/duty">值班任务</a></li>-->
								<li><a title="员工职称" href="sysmgr/data/staff_title">员工职称</a></li>
								<li><a title="家庭所在区" href="sysmgr/data/home_region">家庭所在区</a></li>
								<li><a title="最高学历" href="sysmgr/data/staff_education">最高学历</a></li>
								<li><a title="岗位类型" href="sysmgr/data/staff_position">岗位类型</a></li>
								<li><a title="员工类型" href="sysmgr/data/school_primary">公立小学</a></li>
								<li><a title="员工类型" href="sysmgr/data/school_middle">公立中学</a></li>
								<li><a title="员工类型" href="sysmgr/data/school_senior">公立高中</a></li>
								<li><a title="安全类型" href="sysmgr/data/accident">安全类型</a></li>
								<li><a title="考试类型" href="sysmgr/data/exam">考试类型</a></li>
								<!--<li><a title="考试时间" href="sysmgr/data/examtime">考试时间(区间)</a></li>-->
							</ul>
						</li>
					</ul>
				</div>
			</li>
		</sec:authorize> 
	</ul>--%>
</div>
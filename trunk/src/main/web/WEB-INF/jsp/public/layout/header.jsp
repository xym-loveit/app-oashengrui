<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<style>
	#cleanup {float: right; margin-right: 15px; }
	ul.cleanup {position: absolute; top: 30px; right: 13px; margin: 0pt; padding: 0pt; background-color:#3F84BB; display:none;}
	ul.cleanup li{color: white; line-height:25px; padding:2px}
	ul.cleanup li a{color: white; line-height:25px; }
	ul.cleanup li a:hover {color: #3F84BB; background-color: white; line-height:25px; }
</style>

<script>
	$(function(){
		$("#cleanup").mouseover(function(){
			$(".cleanup").css("display","block");
		}).mouseout(function(){
			$(".cleanup").css("display","none");
		});
	});
</script>

<div id="header_top">
	<p>玛丽英语内部管理系统
		<c:if test="${__opercode == null}">
			<span id='cleanup'>系统清理
				<ul class="cleanup">
					<li>
						<a href="sysmgr/cleanup/student_no" title="清理重复学号">重复学号</a>
					</li>
					<li>
						<a href="sysmgr/cleanup/student_data" title="清理班级重复学生数据">重复数据</a>
					</li>
					<li>
						<a href="sysmgr/cleanup/team_team" title="清理班级数据, 报名数据">班级数据</a>
					</li>
					<li>
						<a href="sysmgr/cleanup/team_lesson" title="清理班级课表数据, 如非法的家长会数据">课表数据</a>
					</li>
					<li>
						<a href="sysmgr/cleanup/team_staff" title="清理班级内非法员工数据">员工数据</a>
					</li>
					<li>
						<a href="sysmgr/cleanup/enrolls" title="清理非法报名数据, 如重复的报名编号">报名数据</a>
					</li>
					<li>
						<a href="sysmgr/cleanup/team_exam" title="清理学生考试数据">考试数据</a>
					</li>
					
				</ul>
			</span>
		</c:if>
	</p>
</div>

<div id="header_info">
	<div class='logo'><a href="home" name="top"><img src='resources/images/layout/logo.jpg' /></a></div>
	<div class='info'>
		<ul>
			<li class='usr'>
				<p>
					<span><sec:authentication property="principal.username"/></span>
					<span title='<sec:authentication property="principal.userRole"/>'><sec:authentication property="principal.userRole"/></span>
				</p>
				<b class="clear"></b>
			</li>
			<li class='home'><a href="home" title="首页"><span>Home</span></a></li>
			<li class='logout'><a href="logout" title="退出系统"><span>Logout</span></a></li>
		</ul>
	</div>
</div>

<div class="clear"></div>

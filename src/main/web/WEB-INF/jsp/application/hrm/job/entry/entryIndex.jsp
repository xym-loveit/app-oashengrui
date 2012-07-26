<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix='fmt'%>

<style>
	label {width: auto;}
	.opr {margin: 3px 2px;}
	.dispose {text-decoration: line-through; color: red;}
	ul.infoshow {padding:5px 0 0 5px; overflow:auto; width: 80%;}
	ul.infoshow li {line-height: 30px; float:left; margin-right: 15px;}
	.opdisabled {text-decoration: line-through; color: #DDD; line-height: 21px;}
	td.ongoing {background-color: #99FF99; color: #333;}
	td.finished {background-color: #ddd;}
</style>

<!-- SearchBar -->
<div class="pageHeader">
	<h1><span class="icon-jobinfo icon" style="display:block">岗位信息</span></h1>
	<ul class="infoshow">
		<li>岗位名称：<input type="text" value="${jobHireInfo.jobHireTitle}" readonly /></li>
		<li>招聘校区：<input type="text" value="${jobHireInfo.jobHireDistrict ne null ? jobHireInfo.jobHireDistrict.districtName : ''}" readonly /></li>
		<li>招聘部门：<input type="text" value="${jobHireInfo.jobHireDepartment ne null ? jobHireInfo.jobHireDepartment.depName : ''}" readonly /></li>
		<li>招聘范围：<input type="text" value="${jobHireInfo.jobHireRange eq 1 ? '内外兼招' : (jobHireInfo.jobHireRange eq 2 ? '外部招聘' : (jobHireInfo.jobHireRange eq 3 ? '内部招聘' : ''))}" readonly /></li>
		<li>招聘人数：<input type="text" value="${jobHireInfo.jobHireCount}" readonly /></li>
		<li>应聘人数：<input type="text" value="${fn:length(jobHireInfo.jobHireIssues)}" readonly /></li>
		<li>已录人数：<input type="text" value="0" readonly /></li>
	</ul>
</div>

<!-- Body -->
<div class="unitBox" id="jbsxBox">
	<div class="pageContent">
		<div class="panelBar">
			<!--
			<ul class="toolBar">
				<li><a treeicon="icon-edit" class="icon" href="app/hrm.do?action=hrmPageJobEntryDetail" target="dialog"><span class="icon-edit">入职安排</span></a></li>
			</ul>
			-->
		</div>
		<table class="table" width="100%" layoutH="138">
			<thead>
				<tr>
					<th align="center">选择</th>
					<th align="center">应聘者姓名</th>
					<th align="center">联系电话</th>
					<th align="center">简历来源</th>
					<th align="center">申请时间</th>
					<th align="center">状态</th>
					<th align="center">到岗情况</th>
					<th align="center">简历信息</th>
					<th align="center">面试记录</th>
					<th align="center">入职安排</th>
				</tr>
			</thead>
			<tbody>
				<logic:present name="jobHireEntries">
					<logic:iterate name="jobHireEntries" property="items" id="entity">
						<tr target="entry_id" rel="${entity.id}">
							<td><input type="checkbox" name="c1" value="${entity.id}" /></td>
							<td>${entity.jobHireIssue.resume.fullName}</td>
							<td>${entity.jobHireIssue.resume.mobilePhone}</td>
							<td>${entity.jobHireIssue.resume.source eq 0 ? '手工输入' : (entity.jobHireIssue.resume.source eq 1 ? '内部申请' : (entity.jobHireIssue.resume.source eq 2 ? '内部推荐' : entity.jobHireIssue.resume.source eq 3 ? '外部申请' : ''))}</td>
							<td><fmt:formatDate  value="${entity.jobHireIssue.applyDateTime}" pattern="yyyy-MM-dd" /></td>
							<td class="${entity.currentStatus eq 2 ? 'finished' : ''}">${entity.currentStatus eq 1 ? '待安排' : (entity.currentStatus eq 2 ? '已安排' : '未知')}</td>
							<td>${entity.finalStatus ne null ? (entity.finalStatus eq 0 ? '待入职' : (entity.finalStatus eq 1 ? '已入职' : '未到岗')) : '---'}</td>
							<td><a class="oplink" href="app/hrm/hire.do?action=hrmPageJobResume&resumeId=${entity.jobHireIssue.resume.id}&op=view" target="dialog" title="简历信息‘${entity.jobHireIssue.resume.fullName}’" width="900" height="500" rel="hrm_resumeview_${entity.id}" mask="true" rel="hrm_resumedetail_${entity.id}">简历信息</a></td>
							<td><a class="oplink" href="app/hrm/hire/interview.do?action=hrmPageJobOfferInterviewIndex&issueId=${entity.jobHireIssue.id}" target="dialog" title="面试记录‘${entity.jobHireIssue.resume.fullName}’" mask="true" rel="hrm_interviewdetail_${entity.id}">面试记录</a></td>
							<td>
								<c:choose>
									<c:when test="${entity.currentStatus eq 2}">
										<label class="opdisabled">入职安排</label>
									</c:when>
									<c:otherwise>
										<a class="oplink" href="app/hrm/hire.do?action=hrmPageJobEntryDetail&entryId=${entity.id}" mask="true" target="dialog" title="入职安排‘${entity.jobHireIssue.resume.fullName}’" rel="hrm_interviewplan_${entity.id}" height="240">入职安排</a>
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
					</logic:iterate>
				</logic:present>
			</tbody>
		</table>
		<div class="panelBar">
			<div class="pages">
				<span>显示</span>
				<select class="combox" name="numPerPage" onchange="navTabPageBreak({numPerPage:this.value})">
					<option value="20">20</option>
					<option value="50">50</option>
					<option value="100">100</option>
					<option value="200">200</option>
				</select>
				<span>条，共${totalCount}条</span>
			</div>
			
			<div class="pagination" targetType="navTab" totalCount="200" numPerPage="20" pageNumShown="10" currentPage="1"></div>
	
		</div>
	</div>
</div>
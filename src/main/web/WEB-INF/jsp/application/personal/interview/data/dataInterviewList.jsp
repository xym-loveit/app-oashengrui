<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix='fmt'%>
<%@ taglib uri="/tags/trymore" prefix="tm"%>

<style>
	a.oplink {line-height: 21px;}
</style>

<table class="table" width="100%" layoutH="75">
	<thead>
		<tr>
			<th align="center">岗位名称</th>
			<th align="center">招聘人数</th>
			<th align="center">招聘校区</th>
			<th align="center">招聘部门</th>
			<th align="center">招聘截止时间</th>
			<th align="center">应聘人姓名</th>
			<th align="center">联系方式</th>
			<th align="center">简历来源</th>
			<th align="center" class="thover">当前环节</th>
			<th align="center" class="thover">面试时间</th>
			<th align="center" class="thover">面试地点</th>
			<th align="center">岗位详细</th>
			<th align="center">简历信息</th>
			<th align="center">${op ne null && op eq 'history' ? '面试记录' : '面试意见'}</th>
		</tr>
	</thead>
	<tbody>
		<logic:present name="interviews">
			<logic:iterate name="interviews" property="items" id="entity">
				<tr target="mid" rel="${entity.id}">
					<td>${entity.jobHireIssue.jobHire.jobHireTitle}</td>
					<td>${entity.jobHireIssue.jobHire.jobHireCount}</td>
					<td>${entity.jobHireIssue.jobHire.jobHireDistrict ne null ? entity.jobHireIssue.jobHire.jobHireDistrict.districtName : ''}</td>
					<td class="${entity.jobHireIssue.jobHire.jobHireDepartment ne null && entity.jobHireIssue.jobHire.jobHireDepartment.delFlag eq 1 ? 'delflag' : ''}">${entity.jobHireIssue.jobHire.jobHireDepartment ne null ? entity.jobHireIssue.jobHire.jobHireDepartment.depName : ''}</td>
					<td><fmt:formatDate  value="${entity.jobHireIssue.jobHire.jobHireEndDate}" pattern="yyyy-MM-dd" /></td>
					<td>${entity.jobHireIssue.resume.fullName}</td>
					<td>${entity.jobHireIssue.resume.mobilePhone}</td>
					<td>${entity.jobHireIssue.resume.source eq 0 ? '手工输入' : (entity.jobHireIssue.resume.source eq 1 ? '内部申请' : (entity.jobHireIssue.resume.source eq 2 ? '内部推荐' : entity.jobHireIssue.resume.source eq 3 ? '外部申请' : ''))}</td>
					<td class="thover">${entity.sessionSN eq 1 ? '一面' : (entity.sessionSN eq 2 ? '二面' : '三面')}</td>
					<td class="thover"><fmt:formatDate  value="${entity.interviewDate}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
					<td class="thover">${entity.interviewAddress}</td>
					<td>
						<c:choose>
							<c:when test="${tm:ifGranted('_FUNCKEY_PERSONAL_INTERVIEW_JOBVIEW')}">
								<a class="oplink" href="app/hrm/hire.do?action=hrmPageJobDetail&id=${entity.jobHireIssue.jobHire.id}&op=view" target="dialog" title="岗位详细" width="930" height="500">岗位详细</a>
							</c:when>
							<c:otherwise><label class="opdisabled" title="您没有权限进行该操作">---</label></c:otherwise>
						</c:choose>
					</td>
					<td>
						<c:choose>
							<c:when test="${tm:ifGranted('_FUNCKEY_PERSONAL_INTERVIEW_RESUMEVIEW')}">
								<a class="oplink" href="app/hrm/hire.do?action=hrmPageJobResume&resumeId=${entity.jobHireIssue.resume.id}&op=view" target="dialog" title="简历信息‘${entity.jobHireIssue.resume.fullName}’" width="900" height="500" rel="myinterview_resumeview_${entity.jobHireIssue.resume.id}" mask="true" rel="hrm_resumedetail_${entity.jobHireIssue.resume.id}">简历信息</a>
							</c:when>
							<c:otherwise><label class="opdisabled" title="您没有权限进行该操作">---</label></c:otherwise>
						</c:choose>
					</td>
					<td>
						<c:choose>
							<c:when test="${op eq null || op ne 'history'}">
								<c:choose>
									<c:when test="${tm:ifGranted('_FUNCKEY_PERSONAL_INTERVIEW_COMMIT')}">
										<a class="oplink" href="app/personal/interview.do?action=dialogInterviewCommentPage&id=${entity.id}&issueId=${entity.jobHireIssue.id}" target="dialog" title="请输入您对${entity.jobHireIssue.resume.fullName}的面试意见" width="555" height="445">请输入</a>
									</c:when>
									<c:otherwise><label class="opdisabled" title="您没有权限进行该操作">---</label></c:otherwise>
								</c:choose>
							</c:when>
							<c:otherwise>
								<c:choose>
									<c:when test="${tm:ifGranted('_FUNCKEY_PERSONAL_INTERVIEW_RECORDS_VIEW')}">
										<a class="oplink" href="app/hrm/hire/interview.do?action=hrmPageJobOfferInterviewIndex&issueId=${entity.jobHireIssue.id}" target="dialog" title="面试记录‘${entity.jobHireIssue.resume.fullName}’" mask="true" rel="myinterview_interviewdetail_${entity.id}"
										>面试记录</a>
									</c:when>
									<c:otherwise><label class="opdisabled" title="您没有权限进行该操作">---</label></c:otherwise>
								</c:choose>
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
			</logic:iterate>
		</logic:present>
	</tbody>
</table>
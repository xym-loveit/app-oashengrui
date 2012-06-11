<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="pageContent">
	<form method="post" action="app/hrm/hire/interview.do?action=actionJobInterviewPlanSave" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);">
		<div class="pageFormContent" layoutH="56">
			<table cellspacing="10" cellpadding="10" style="border-spacing:12">
				<tr>
					<td>应聘者姓名：</td>
					<td colspan="3"><input name="name" type="text" value="${jobHireIssue.resume.fullName}" style="width:100%" readonly/></td>
				</tr>
				<tr>
					<td>面试官：</td>
					<td>
						<input id="inputOrg1" name="interviewer.id" value="" type="hidden"/>
						<input class="required" name="interviewer.fullName" style="width:170px" type="text" postField="fullName" suggestFields="fullName" 
							suggestUrl="app/hrm/hire/interview.do?action=lookupUserByName" lookupGroup="interviewer"/>
					</td>
					<td>面试地点：</td>
					<td><input name="interviewAddress" type="text" class="required" value="" style="width:170px"/></td>
				</tr>
				<tr>
					<td>面试环节：</td>
					<td>
						<select class="combox" name="sessionSN" class="required" style="width:150px">
							<c:if test="${jobHireIssue['interviewStates']['1'] eq null}"><option value="1">一面</option></c:if>
							<c:if test="${jobHireIssue['interviewStates']['2'] eq null}"><option value="2">二面</option></c:if>
							<c:if test="${jobHireIssue['interviewStates']['3'] eq null}"><option value="3">三面</option></c:if>
						</select>
					</td>
					<td>面试时间：</td>
					<td><input name="interviewDate" class="date required textInput" format="yyyy-MM-dd HH:mm:ss" style="width:170px"/></td>
				</tr>
				<tr>
					<td style="vertical-align: top;">其他备注：</td>
					<td colspan="3">
						<textarea name="meto" rows="3" style="width:100%"></textarea>
					</td>
				</tr>
			</table>
		</div>
		<div class="formBar">
			<ul>
				<li><div class="buttonActive"><div class="buttonContent"><button type="submit">招聘安排</button></div></div></li>
				<li><div class="button"><div class="buttonContent"><button type="button" class="close">取消</button></div></div></li>
			</ul>
		</div>
		<input type="hidden" name="issueId" value="${jobHireIssue.id}" />
	</form>
</div>
<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/tags/trymore" prefix="tm"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<style>
	.fblue {color: blue;}
	.fred {color: red;}
</style>

<div class="pageContent" id="tree_rolefuncs">
	<form id="offerFinalize" method="post" action="app/hrm/entry.do?action=actionEntrySave" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);">
		<div class="pageFormContent" layoutH="56">
			<div style="line-height: 30px;">
				<c:choose>
					<c:when test="${op eq 'qualified'}">
						您确定'<span class="fblue">${jobHireEntry ne null ? jobHireEntry.jobHireIssue.resume.fullName : ''}</span>'<span class="fred">考察期已结束</span>并且<span class="fred">未通过考察</span>吗？
					</c:when>
					<c:when test="${op eq 'board'}">
						您确定<span class="fblue">${jobHireEntry ne null ? jobHireEntry.jobHireIssue.resume.fullName : ''}</span><span class="fred">不到本校区入职了</span>吗？<br/>
						<span class="fred" style="line-height: 30px;">别忘了给他打电话确认一遍哦！</span>
					</c:when>
				</c:choose>
			</div>
			<div style="line-height: 30px;">
				<span style="float:left;">
					<input type="checkbox" name="archived" />加入人才库&nbsp;&nbsp;人才等级
				</span>
				<select class="combox" name="archiveStar">
					<option value="3">三星级</option>
					<option value="2">二星级</option>
					<option value="1">一星级</option>
					<option value="0">无星</option>
				</select>
			</div>
		</div>
		<div class="formBar">
			<ul>
				<li><div class="buttonActive"><div class="buttonContent"><button type="submit">确定</button></div></div></li>
				<li><div class="button"><div class="buttonContent"><button class="close" type="button">关闭</button></div></div></li>
			</ul>
		</div>
		<input type="hidden" name="entryId" value="${jobHireEntry.id}" />
		<input type="hidden" name="state" value="${state}" />
		<input type="hidden" name="op" value="${op}" />
	</form>
</div>

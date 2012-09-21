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
	<form id="offerFinalize" method="post" action="app/hrm/develop.do?action=actionDevelopFinalize&state=${state}&id=${employeeDevelopEntry.id}" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);">
		<div class="pageFormContent" layoutH="56">
			<c:choose>
				<c:when test="${state eq '4'}">
					<div style="line-height: 30px;">
						您确定'<span class="fblue">${employeeDevelopEntry ne null ? employeeDevelopEntry.employee.resume.fullName : ''}</span>'<span class="fred"><span class="fred">离职</span>吗？
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
				</c:when>
				<c:when test="${state eq '3'}">
					<div style="line-height: 30px;">
						您确定'<span class="fblue">${employeeDevelopEntry ne null ? employeeDevelopEntry.employee.resume.fullName : ''}</span>'<span class="fred"><span class="fred">调动</span>吗？
					</div>
					<div style="line-height: 30px;">
						<table style="width:100%" cellpadding="10" cellspacing="10">
							<tr>
								<td>原校区：</td>
								<td><input name="fromDistrict"  type="text" style="width:90px" value="${employeeDevelopEntry ne null ? employeeDevelopEntry.fromDistrict.districtName : ''}" readonly/></td>
								<td>原部门：</td>
								<td><input name="fromDepartment"  type="text" style="width:90px" value="${employeeDevelopEntry ne null ? employeeDevelopEntry.fromDepartment.depName : ''}" readonly/></td>
								<td>原职位：</td>
								<td colspan="4"><input name="fromPosition"  type="text" style="width:90px" value="${employeeDevelopEntry ne null ? employeeDevelopEntry.fromPosition.positionName : ''}" readonly/></td>
							</tr>
							<tr>
								<td>调动校区：</td>
								<td><input name="fromDistrict"  type="text" style="width:90px" value="${employeeDevelopEntry ne null ? employeeDevelopEntry.toDistrict.districtName : ''}" readonly/></td>
								<td>调动部门：</td>
								<td><input name="fromDepartment"  type="text" style="width:90px" value="${employeeDevelopEntry ne null ? employeeDevelopEntry.toDepartment.depName : ''}" readonly/></td>
								<td>调动职务：</td>
								<td colspan="4"><input name="fromPosition"  type="text" style="width:90px" value="${employeeDevelopEntry ne null ? employeeDevelopEntry.toPosition.positionName : ''}" readonly/></td>
							</tr>
							<tr>
							<td>调动时间：</td>
							<td colspan = "5"><input name="finalizedDate" class="date textInput required" yearstart="-80" yearend="0" style="width:90px" value='' /></td>
							</tr>
						</table>
					</div>
				</c:when>
				<c:when test="${state eq '6'}">
					<div style="line-height: 30px;">
						您确定'<span class="fblue">${employeeDevelopEntry ne null ? employeeDevelopEntry.employee.resume.fullName : ''}</span>'<span class="fred"><span class="fred">晋升</span>吗？
					</div>
					
					<div style="line-height: 30px;">
						<table style="width:100%">
							<tr>
								<td>原校区：</td>
								<td><input name="fromDistrict"  type="text" style="width:90px" value="${employeeDevelopEntry ne null ? employeeDevelopEntry.fromDistrict.districtName : ''}" readonly/></td>
								<td>原部门：</td>
								<td><input name="fromDepartment"  type="text" style="width:90px" value="${employeeDevelopEntry ne null ? employeeDevelopEntry.fromDepartment.depName : ''}" readonly/></td>
								<td>原职位：</td>
								<td colspan="4"><input name="fromPosition"  type="text" style="width:90px" value="${employeeDevelopEntry ne null ? employeeDevelopEntry.fromPosition.positionName : ''}" readonly/></td>
							</tr>
							<tr>
								<td>晋升校区：</td>
								<td><input name="fromDistrict"  type="text" style="width:90px" value="${employeeDevelopEntry ne null ? employeeDevelopEntry.toDistrict.districtName : ''}" readonly/></td>
								<td>晋升部门：</td>
								<td><input name="fromDepartment"  type="text" style="width:90px" value="${employeeDevelopEntry ne null ? employeeDevelopEntry.toDepartment.depName : ''}" readonly/></td>
								<td>晋升职务：</td>
								<td colspan="4"><input name="fromPosition"  type="text" style="width:90px" value="${employeeDevelopEntry ne null ? employeeDevelopEntry.toPosition.positionName : ''}" readonly/></td>
							</tr>
							<tr>
							<td>晋升时间：</td>
							<td colspan = "5"><input name="finalizedDate" class="date textInput required" yearstart="-80" yearend="0" style="width:90px" value='' /></td>
							</tr>
						</table>
					</div>
				</c:when>
				<c:when test="${state eq '2'}">
					<div style="line-height: 30px;">
						您确定'<span class="fblue">${employeeDevelopEntry ne null ? employeeDevelopEntry.employee.resume.fullName : ''}</span>'<span class="fred"><span class="fred">转正</span>吗？
					</div>
					<div style="line-height: 30px;">
						<span style="float:left;">
							转正时间：
						</span>
						<input name="finalizedDate" class="date textInput required" yearstart="-80" yearend="0" style="width:90px" value='' />
					</div>
				</c:when>
			</c:choose>
		</div>
		<div class="formBar">
			<ul>
				<li><div class="buttonActive"><div class="buttonContent"><button type="submit">确定</button></div></div></li>
				<li><div class="button"><div class="buttonContent"><button class="close" type="button">关闭</button></div></div></li>
			</ul>
		</div>
		<input type="hidden" name="entryId" value="${employeeDevelopEntry.id}" />
		<input type="hidden" name="op" value="${op}" />
	</form>
</div>

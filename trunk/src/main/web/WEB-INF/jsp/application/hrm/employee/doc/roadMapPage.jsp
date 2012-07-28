<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/tags/trymore" prefix="tm"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix='fmt'%>
<%@ taglib uri="/tags/trymore" prefix="tm"%>

<style>
	.item_file {
		background: url("resources/images/icons/fit_icon.png") no-repeat scroll 0 0 transparent;
		padding-left: 16px;
		line-height: 16px;
		margin-top:5px;
	}
	.item_file a {
		color: blue;
		text-decoration: underline;
	}
	
	#tblroadmap input.textInput {width: 90%; margin: 5px;}
	#tblroadmap td.field {
		background-color: #CFDBEC;
		font-size: 9pt;
		line-height: 35px;
		margin: 0;
		text-align: center;
	}
	#tblroadmap textarea {height: 30px;margin: 5px;width: 98%;}
</style>

<div class="pageContent">
	<form method="post" action="app/hrm/employee.do?action=actionRoadMapSave&id=${employee.id}" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);">
		<div class="pageFormContent" layoutH="${cat eq null ? 98 : 56}">
			<table width="100%" cellspacing="15" cellpadding="10" style="border-spacing:15; border-collapse:collapse;" border="1" id="tblroadmap">
				<tr>
					<td nowrap class="field" style="width: 80px;" align="right">员工编号：</td>
					<td><input name="empNo" type="text" value="${employee ne null ? employee.empNo : ''}" readonly/></td>
					<td nowrap class="field" align="right">预转正时间：</td>
					<td><input name="positiveDueDate" class="date required textInput" yearstart="-80" yearend="10" value="<c:if test='${employee ne null}'><fmt:formatDate value='${employee.positiveDueDate}' pattern='yyyy-MM-dd'/></c:if>" /></td>
					<td nowrap class="field" align="right">合同到期时间：</td>
					<td><input name="contractEndDate" class="date required textInput" yearstart="-80" yearend="10" value="<c:if test='${employee ne null}'><fmt:formatDate value='${employee.contractEndDate}' pattern='yyyy-MM-dd'/></c:if>" /></td>
					<td nowrap class="field">员工状态：</td>
					<td style="padding: 5px;">
						<select class="combox required" name="onboardStatus" style="width:60px" readonly>
							<option value="1" ${employee ne null && employee.onboardStatus eq 1 ? 'selected="selected"' : ''}>试用</option>
							<option value="2" ${employee ne null && employee.onboardStatus eq 2 ? 'selected="selected"' : ''}>正式</option>
							<option value="3" ${employee ne null && employee.onboardStatus eq 3 ? 'selected="selected"' : ''}>离职</option>
							<option value="4" ${employee ne null && employee.onboardStatus eq 4 ? 'selected="selected"' : ''}>辞退</option>
						</select>
					</td>
				</tr>
				<tr>
					<td class="field" align="right">所在校区：</td>
					<td style="padding: 5px;">
						<select class="combox required" name="employeeDistrict.id" id="combox_district_eindex" style="width:108px" >
							<logic:present name="districts">
								<logic:iterate name="districts" id="district">
									<option value="${district.id}" ${employee ne null && employee.employeeDistrict ne null && employee.employeeDistrict.id eq district.id ? 'selected="selected"' : ''}>${district.districtName}</option>
								</logic:iterate>
							</logic:present>
						</select>
					</td>
					<td class="field" align="right">所在部门：</td>
					<td style="padding: 5px;">
						<select class="combox required" name="employeeDepartment.id" id="combox_dept_eindex" style="width:108px" >
							<logic:present name="departments">
								<logic:iterate name="departments" id="department">
									<option value="${department.id}" ${employee ne null && entity.employeeDepartment ne null && employee.employeeDepartment.id eq department.id ? 'selected="selected"' : ''}>${department.depName}</option>
								</logic:iterate>
							</logic:present>
						</select>
					</td>
					<td class="field" align="right">所在岗位：</td>
					<td style="padding: 5px;">
						<select class="combox required" name="employeePosition.id" id="combox_pos_eindex" style="width:108px" >
							<logic:present name="positions">
								<logic:iterate name="positions" id="position">
									<option value="${position.id}" ${employee ne null && employee.employeePosition ne null && employee.employeePosition.id eq position.id ? 'selected="selected"' : ''}>${position.positionName}</option>
								</logic:iterate>
							</logic:present>
						</select>
					</td>
					<td class="field" align="right">办公电话：</td>
					<td><input name="officePhone" type="text"  value="${employee ne null ? employee.officePhone : ''}" /></td>
				</tr>
				<tr>
					<td class="field" align="right">教师星级：</td>
					<td style="padding: 5px;"><!--  Change employee.phoneNo to teacherStar/consultStar -->
						<select class="combox" name="teacherStar" style="width:60px">
							<option value="1" ${employee ne null && employee.teacherStar eq 1 ? 'selected="selected"' : ''}>一星</option>
							<option value="2" ${employee ne null && employee.teacherStar eq 2 ? 'selected="selected"' : ''}>二星</option>
							<option value="3" ${employee ne null && employee.teacherStar eq 3 ? 'selected="selected"' : ''}>三星</option>
							<option value="4" ${employee ne null && employee.teacherStar eq 4 ? 'selected="selected"' : ''}>四星</option>
						</select>
					</td>
					<td align="right">咨询师星级：</td>
					<td style="padding: 5px;">
						<select class="combox" name="consultStar" style="width:60px">
							<option value="1" ${employee ne null && employee.consultStar eq 1 ? 'selected="selected"' : ''}>一星</option>
							<option value="2" ${employee ne null && employee.consultStar eq 2 ? 'selected="selected"' : ''}>二星</option>
							<option value="3" ${employee ne null && employee.consultStar eq 3 ? 'selected="selected"' : ''}>三星</option>
							<option value="4" ${employee ne null && employee.consultStar eq 4 ? 'selected="selected"' : ''}>四星</option>
						</select>
					</td>
					<td colspan="4"></td>
				</tr>
				<tr>
					<td class="field" align="right">教授年级：</td>
					<td colspan="7" style="padding: 5px;">
						<input name="teachClass" type="checkbox" value="A" <c:if test="${tm:inRange(employee.teachClass, 'A', ',')}">checked</c:if>>
						小学
						<input name="teachClass" type="checkbox" value="A1" <c:if test="${tm:inRange(employee.teachClass, 'A1', ',')}">checked</c:if>>
						一年级
						<input name="teachClass" type="checkbox" value="A2" <c:if test="${tm:inRange(employee.teachClass, 'A2', ',')}">checked</c:if>>
						二年级
						<input name="teachClass" type="checkbox" value="A3" <c:if test="${tm:inRange(employee.teachClass, 'A3', ',')}">checked</c:if>>
						三年级
						<input name="teachClass" type="checkbox" value="A4" <c:if test="${tm:inRange(employee.teachClass, 'A4', ',')}">checked</c:if>>
						四年级
						<input name="teachClass" type="checkbox" value="A5" <c:if test="${tm:inRange(employee.teachClass, 'A5', ',')}">checked</c:if>>
						五年级
						<input name="teachClass" type="checkbox" value="A6" <c:if test="${tm:inRange(employee.teachClass, 'A6', ',')}">checked</c:if>>
						六年级
						</br>
						
						<input name="teachClass" type="checkbox" value="B" <c:if test="${tm:inRange(employee.teachClass, 'B', ',')}">checked</c:if>>
						初中
						<input name="teachClass" type="checkbox" value="B1" <c:if test="${tm:inRange(employee.teachClass, 'B1', ',')}">checked</c:if>>
						一年级
						<input name="teachClass" type="checkbox" value="B2" <c:if test="${tm:inRange(employee.teachClass, 'B2', ',')}">checked</c:if>>
						二年级
						<input name="teachClass" type="checkbox" value="B3" <c:if test="${tm:inRange(employee.teachClass, 'B3', ',')}">checked</c:if>>
						三年级
						</br>
						
						<input name="teachClass" type="checkbox" value="C" <c:if test="${tm:inRange(employee.teachClass, 'C', ',')}">checked</c:if>>
						高中
						<input name="teachClass" type="checkbox" value="C1" <c:if test="${tm:inRange(employee.teachClass, 'C1', ',')}">checked</c:if>>
						一年级
						<input name="teachClass" type="checkbox" value="C2" <c:if test="${tm:inRange(employee.teachClass, 'C2', ',')}">checked</c:if>>
						二年级
						<input name="teachClass" type="checkbox" value="C3" <c:if test="${tm:inRange(employee.teachClass, 'C3', ',')}">checked</c:if>>
						三年级
					</td>
				</tr>
				<tr>
					<td class="field" align="right">教授科目：</td>
					<td colspan="7" style="padding: 5px;">
						<input name="teachSubject" type="checkbox" value="A" <c:if test="${tm:inRange(employee.teachSubject, 'A', ',')}">checked</c:if>>
						小学
						<input name="teachSubject" type="checkbox" value="A1" <c:if test="${tm:inRange(employee.teachSubject, 'A1', ',')}">checked</c:if>>
						数学
						<input name="teachSubject" type="checkbox" value="A2" <c:if test="${tm:inRange(employee.teachSubject, 'A2', ',')}">checked</c:if>>
						语文
						<input name="teachSubject" type="checkbox" value="A3" <c:if test="${tm:inRange(employee.teachSubject, 'A3', ',')}">checked</c:if>>
						英语
						</br>
						
						<input name="teachSubject" type="checkbox" value="B"  <c:if test="${tm:inRange(employee.teachSubject, 'B', ',')}">checked</c:if>>
						初中
						<input name="teachSubject" type="checkbox" value="B1" <c:if test="${tm:inRange(employee.teachSubject, 'B1', ',')}">checked</c:if>>
						数学
						<input name="teachSubject" type="checkbox" value="B2" <c:if test="${tm:inRange(employee.teachSubject, 'B2', ',')}">checked</c:if>>
						语文
						<input name="teachSubject" type="checkbox" value="B3" <c:if test="${tm:inRange(employee.teachSubject, 'B3', ',')}">checked</c:if>>
						英语
						<input name="teachSubject" type="checkbox" value="B4" <c:if test="${tm:inRange(employee.teachSubject, 'B4', ',')}">checked</c:if>>
						物理
						<input name="teachSubject" type="checkbox" value="B5" <c:if test="${tm:inRange(employee.teachSubject, 'B5', ',')}">checked</c:if>>
						化学
						<input name="teachSubject" type="checkbox" value="B6" <c:if test="${tm:inRange(employee.teachSubject, 'B6', ',')}">checked</c:if>>
						政治
						<input name="teachSubject" type="checkbox" value="B7" <c:if test="${tm:inRange(employee.teachSubject, 'B7', ',')}">checked</c:if>>
						历史
						</br>
						
						<input name="teachSubject" type="checkbox" value="C" <c:if test="${tm:inRange(employee.teachSubject, 'C', ',')}">checked</c:if>>
						高中
						<input name="teachSubject" type="checkbox" value="C1" <c:if test="${tm:inRange(employee.teachSubject, 'C1', ',')}">checked</c:if>>
						数学
						<input name="teachSubject" type="checkbox" value="C2" <c:if test="${tm:inRange(employee.teachSubject, 'C2', ',')}">checked</c:if>>
						语文
						<input name="teachSubject" type="checkbox" value="C3" <c:if test="${tm:inRange(employee.teachSubject, 'C3', ',')}">checked</c:if>>
						英语
						<input name="teachSubject" type="checkbox" value="C4" <c:if test="${tm:inRange(employee.teachSubject, 'C4', ',')}">checked</c:if>>
						物理
						<input name="teachSubject" type="checkbox" value="C5" <c:if test="${tm:inRange(employee.teachSubject, 'C5', ',')}">checked</c:if>>
						化学
						<input name="teachSubject" type="checkbox" value="C6" <c:if test="${tm:inRange(employee.teachSubject, 'C6', ',')}">checked</c:if>>
						政治
						<input name="teachSubject" type="checkbox" value="C7" <c:if test="${tm:inRange(employee.teachSubject, 'C7', ',')}">checked</c:if>>
						历史
						<input name="teachSubject" type="checkbox" value="C8" <c:if test="${tm:inRange(employee.teachSubject, 'C8', ',')}">checked</c:if>>
						生物
						<input name="teachSubject" type="checkbox" value="C9" <c:if test="${tm:inRange(employee.teachSubject, 'C9', ',')}">checked</c:if>>
						地理
					</td>
				</tr>
				<tr>
					<td class="field" align="right">晟睿旅程：</td>
					<td colspan="7" style="padding: 5px;">
						<table width="100%" class="datalst" rules="all" bordercolor="#CCC">
							<thead>
								<tr>
									<th align="center">所在校区</th>
									<th align="center">所在部门</th>
									<th align="center">岗位</th>
									<th align="center">去向校区</th>
									<th align="center">去向部门</th>
									<th align="center">去向岗位</th>
									<th align="center">类型</th>
									<th align="center">时间</th>
								</tr>
							</thead>
							<tbody>
								<logic:present name="roadmap">
									<logic:iterate name="roadmap" id="entity" indexId="idx">
										<tr target="entry_id" rel="${entity.id}" style="${idx % 2 == 1 ? 'background-color:#F3F7FA' : ''}">
											<td>${entity.orginalDistrict ne null ? entity.orginalDistrict.districtName : ''}</td>
											<td>${entity.orginalDepartment ne null ? entity.orginalDepartment.depName : ''}</td>
											<td>${entity.orginalDepartmentPosition ne null ? entity.orginalDepartmentPosition.positionName : ''}</td>
											<td>${entity.dstDistrict ne null ? entity.dstDistrict.districtName : ''}</td>
											<td>${entity.dstDepartment ne null ? entity.dstDepartment.depName : ''}</td>
											<td>${entity.dstDepartmentPosition ne null ? entity.dstDepartmentPosition.positionName : ''}</td>
											<td>
												<c:choose>
													<c:when test="${entity.type eq 1}">入职</c:when>
													<c:when test="${entity.type eq 2}">转正</c:when>
													<c:when test="${entity.type eq 3}">调动</c:when>
													<c:when test="${entity.type eq 4}">离职</c:when>
													<c:when test="${entity.type eq 5}">辞退</c:when>
													<c:when test="${entity.type eq 6}">晋升</c:when>
													<c:otherwise>未知</c:otherwise>
												</c:choose>
											</td>
											<td><fmt:formatDate  value="${entity.date}" pattern="yyyy-MM-dd" /></td>
										</tr>
									</logic:iterate>
								</logic:present>
							</tbody>
						</table>
					</td>
				</tr>
			</table>
		</div>
		<c:if test="${op eq null || op ne 'view'}">
			<c:if test="${tm:ifGranted('_FUNCKEY_HRM_EMPLOYEE_UPDATE')}">
				<div class="formBar">
					<ul>
						<li>
							<div class="buttonActive"><div class="buttonContent"><button type="submit">保存</button></div></div>
						</li>
					</ul>
				</div>
			</c:if>
		</c:if>
		<input type="hidden" name="source" value="${source ne null ? source : '0'}" />
		<input type="hidden" name="jobId" value="${jobId ne null ? jobId : '0'}" />
	</form>
</div>
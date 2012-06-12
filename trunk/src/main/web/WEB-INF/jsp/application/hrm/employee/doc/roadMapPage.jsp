<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="pageContent">
	<form method="post" action="app/hrm/hire/employee.do?action=actionJobApply" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);">
		<div class="pageFormContent" layoutH="56">
			<table width="100%" cellspacing="15" cellpadding="10" style="border-spacing:15">
				<tr>
					<td nowrap style="width: 80px;" align="right">员工编号：</td>
					<td><input name="empNo" type="text" value="${employee ne null ? employee.empNo : ''}" readonly/></td>
					<td nowrap align="right">预转正时间：</td>
					<td><input name="positiveDueDate" class="textInput" yearstart="-80" yearend="0" style="width: 100%" value="${employee ne null ? employee.positiveDueDate : ''}" readonly/></td>
					<td nowrap align="right">合同到期时间：</td>
					<td><input name="contractEndDate" class="textInput" yearstart="-80" yearend="0" style="width: 100%" value="${employee ne null ? employee.contractEndDate : ''}" readonly/></td>
					<td nowrap align="right">员工状态：</td>
					<td>
						<select class="combox" name="onboardStatus" style="width:60px">
							<option value="1" ${employee ne null && employee.onboardStatus eq 1 ? 'selected="selected"' : ''}>试用</option>
							<option value="2" ${employee ne null && employee.onboardStatus eq 2 ? 'selected="selected"' : ''}>正式</option>
							<option value="3" ${employee ne null && employee.onboardStatus eq 3 ? 'selected="selected"' : ''}>离职</option>
							<option value="4" ${employee ne null && employee.onboardStatus eq 4 ? 'selected="selected"' : ''}>辞退</option>
						</select>
					</td>
				</tr>
				<tr>
					<td align="right">所在校区：</td>
					<td>
						<select class="combox" name="employeeDistrict.id" id="combox_district_eindex" style="width:108px">
							<logic:present name="districts">
								<logic:iterate name="districts" id="district">
									<option value="${district.id}" ${employee ne null && employee.employeeDistrict ne null && employee.employeeDistrict.id eq district.id ? 'selected="selected"' : ''}>${district.districtName}</option>
								</logic:iterate>
							</logic:present>
						</select>
					</td>
					<td align="right">所在部门：</td>
					<td>
						<select class="combox" name="employeeDepartment.id" id="combox_district_eindex" style="width:108px">
							<logic:present name="departments">
								<logic:iterate name="departments" id="department">
									<option value="${department.id}" ${employee ne null && entity.employeeDepartment ne null && employee.employeeDepartment.id eq department.id ? 'selected="selected"' : ''}>${department.deptName}</option>
								</logic:iterate>
							</logic:present>
						</select>
					</td>
					<td align="right">所在岗位：</td>
					<td>
						<select class="combox" name="employeePosition.id" id="combox_district_eindex" style="width:108px">
							<logic:present name="positions">
								<logic:iterate name="positions" id="position">
									<option value="${position.id}" ${employee ne null && employee.employeePosition ne null && employee.employeePosition.id eq position.id ? 'selected="selected"' : ''}>${position.positionName}</option>
								</logic:iterate>
							</logic:present>
						</select>
					</td>
					<td align="right">办公电话：</td>
					<td><input name="phoneNo" type="text"  style="width: 100%" value="${employee ne null ? employee.phoneNo : ''}" ${op ne null && op eq 'view' ? 'readonly' : ''}/></td>
				</tr>
				<tr>
					<td align="right">教师星级：</td>
					<td><!--  Change employee.phoneNo to teacherStar/consultStar -->
						<select class="combox" name="teacherStar" style="width:60px">
							<option value="1" ${employee ne null && employee.phoneNo eq 1 ? 'selected="selected"' : ''}>一星</option>
							<option value="2" ${employee ne null && employee.phoneNo eq 2 ? 'selected="selected"' : ''}>二星</option>
							<option value="3" ${employee ne null && employee.phoneNo eq 3 ? 'selected="selected"' : ''}>三星</option>
							<option value="4" ${employee ne null && employee.phoneNo eq 4 ? 'selected="selected"' : ''}>四星</option>
						</select>
					</td>
					<td align="right">咨询师星级：</td>
					<td>
						<select class="combox" name="consultStar" style="width:60px">
							<option value="1" ${employee ne null && employee.phoneNo eq 1 ? 'selected="selected"' : ''}>一星</option>
							<option value="2" ${employee ne null && employee.phoneNo eq 2 ? 'selected="selected"' : ''}>二星</option>
							<option value="3" ${employee ne null && employee.phoneNo eq 3 ? 'selected="selected"' : ''}>三星</option>
							<option value="4" ${employee ne null && employee.phoneNo eq 4 ? 'selected="selected"' : ''}>四星</option>
						</select>
					</td>
					<td colspan="4"></td>
				</tr>
				<tr>
					<td align="right">教授年级：</td>
					<td colspan="7">
						<label for="u534">小学</label>
						<input id="u534" type="checkbox" checked="" value="checkbox">
					</td>
				</tr>
				<tr>
					<td align="right">教授科目：</td>
					<td colspan="7">
						<label for="u534">小学</label>
						<input id="u534" type="checkbox" checked="" value="checkbox">
					</td>
				</tr>
				<tr>
					<td align="right">晟睿旅程：</td>
					<td colspan="7">
						<table class="table" width="100%" >
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
								<logic:present name="roadMapInfo">
									<logic:iterate name="roadMapInfo" property="items" id="entity">
										<tr target="entry_id" rel="${entity.id}">
											<td>${entity.employeeDistrict ne null ? entity.employeeDistrict.districtName : ''}</td>
											<td>${entity.employeeDepartment ne null ? entity.employeeDepartment.depName : ''}</td>
											<td>${entity.employeePosition ne null ? entity.employeePosition.positionName : ''}</td>
											<td>${entity.toDistrict ne null ? entity.toDistrict.districtName : ''}</td>
											<td>${entity.toDepartment ne null ? entity.toDepartment.depName : ''}</td>
											<td>${entity.toPosition ne null ? entity.toPosition.positionName : ''}</td>
											<td>
												<c:choose>
													<c:when test="${entity.onboardStatus eq 1}">
														试用
													</c:when>
													<c:when test="${entity.onboardStatus eq 2}">
														正式
													</c:when>
													<c:when test="${entity.onboardStatus eq 3}">
														离职
													</c:when>
													<c:when test="${entity.onboardStatus eq 4}">
														辞退
													</c:when>
												</c:choose>
											</td>
											<td><fmt:formatDate  value="${entity.birthdate}" pattern="yyyy-MM-dd" /></td>
										</tr>
									</logic:iterate>
								</logic:present>
							</tbody>
						</table>
					</td>
				</tr>
			</table>
		</div>
		<div class="formBar">
			<ul>
				<c:if test="${op eq null || op ne 'view'}">
					<li>
						<div class="buttonActive"><div class="buttonContent"><button type="submit">保存</button></div></div>
					</li>
				</c:if>
				<li>
					<div class="button"><div class="buttonContent"><button type="button" class="close">关闭</button></div></div>
				</li>
			</ul>
		</div>
		<input type="hidden" name="source" value="${source ne null ? source : '0'}" />
		<input type="hidden" name="jobId" value="${jobId ne null ? jobId : '0'}" />
	</form>
</div>
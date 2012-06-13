<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix='fmt'%>

<script>
	$(function(){
		$("#btnapproval").unbind("click");
		$("#btnapproval").bind("click", function() { 
			$("#formAction").val("1");
			$("#formjob").submit();
		});
		
		$("#btnback").unbind("click");
		$("#btnback").bind("click", function() { 
			$("#formAction").val("0");
			$("#formjob").submit();
		});
	});
</script>

<div class="pageContent">
	<form method="post" action="app/hrm/hire.do?action=actionJobSave" id="formjob" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);">
		<div class="pageFormContent" layoutH="56">
			<table cellspacing="10" cellpadding="10" style="border-spacing:12">
				<tr>
					<td nowrap>岗位名称：</td>
					<td><input name="jobHireTitle" type="text" style="width:140px" class="required" value="${jobHire ne null ? jobHire.jobHireTitle : ''}" ${op ne null && op eq 'view' ? 'readonly' : ''}/></td>
					<td nowrap>招聘校区：</td>
					<td>
						<c:choose>
							<c:when test="${op eq null && op ne 'view'}">
								<select class="combox" name="jobHireDistrictId" id="combox_district" style="width:120px" ref="combox_dept" refUrl="app/hrm/hire.do?action=actionLoadDepartmentByOrg&districtId={value}">
									<option value="">请选择校区</option>
									<logic:present name="districts">
										<logic:iterate name="districts" id="district">
											<option value="${district.id}" ${jobHire ne null && jobHire.jobHireDistrict ne null && jobHire.jobHireDistrict.id eq district.id ? 'selected="selected"' : ''}>${district.districtName}</option>
										</logic:iterate>
									</logic:present>
								</select>
							</c:when>
							<c:otherwise>
								<input name="jobHireDistrictId" type="text" style="width:140px" value="${jobHire ne null && jobHire.jobHireDistrict ne null ? jobHire.jobHireDistrict.districtName : ''}" readonly />
							</c:otherwise>
						</c:choose>
					</td>
					<td nowrap>招聘部门：</td>
					<td>
						<c:choose>
							<c:when test="${op eq null && op ne 'view'}">
								<select class="combox" name="jobHireDepartmentId" id="combox_dept" defOPKey="请选择部门" defOPVal="" style="width:120px">
									<option value="">请选择部门</option>
									<logic:present name="departments">
										<logic:iterate name="departments" id="entity">
											<option value="${entity.id}" ${jobHire ne null && jobHire.jobHireDepartment ne null && jobHire.jobHireDepartment.id eq entity.id ? 'selected="selected"' : ''}>${entity.depName}</option>
										</logic:iterate>
									</logic:present>
								</select>
							</c:when>
							<c:otherwise>
								<input name="jobHireDepartmentId" type="text" style="width:140px" value="${jobHire ne null && jobHire.jobHireDepartment ne null ? jobHire.jobHireDepartment.depName : ''}" readonly />
							</c:otherwise>
						</c:choose>
					</td>
					<td nowrap>截止时间：</td>
					<td><input name="jobHireEndDate" class="date textInput required" style="width:100px;float:left;" value='<logic:present name="jobHire"><fmt:formatDate value="${jobHire.jobHireEndDate}" pattern="yyyy-MM-dd" /></logic:present>' ${op ne null && op eq 'view' ? 'readonly' : ''}/><c:if test="${op eq null || op ne 'view'}"><a class="inputDateButton" href="javascript:;">选择</a></c:if></td>
				</tr>
				<tr>
					<td>招聘范围：</td>
					<td>
						<c:choose>
							<c:when test="${op eq null && op ne 'view'}">
								<select class="combox" name="jobHireRange" id="combox_range" style="width:120px">
									<option value="1" ${jobHire ne null && jobHire.jobHireRange eq 1 ? 'selected="selected"' : ''}>内外兼招</option>
									<option value="2" ${jobHire ne null && jobHire.jobHireRange eq 2 ? 'selected="selected"' : ''}>外部招聘</option>
									<option value="3" ${jobHire ne null && jobHire.jobHireRange eq 3 ? 'selected="selected"' : ''}>内部招聘</option>
								</select>
							</c:when>
							<c:otherwise>
								<input name="jobHireRange" type="text" style="width:140px" value="${jobHire ne null && jobHire.jobHireRange ne null ? (jobHire.jobHireRange eq 1 ? '内外兼招' : (jobHire.jobHireRange eq 2 ? '外部招聘' : '内部招聘')) : ''}" readonly />
							</c:otherwise>
						</c:choose>
					</td>
					<td>招聘人数：</td>
					<td><input name="jobHireCount" type="text" style="width:140px" class="required" value="${jobHire ne null ? jobHire.jobHireCount : ''}" ${op ne null && op eq 'view' ? 'readonly' : ''}/></td>
					<td>可见范围：</td>
					<td>
						<c:choose>
							<c:when test="${op eq null && op ne 'view'}">
								<select class="combox" name="jobHireVisibleDistrictId" id="combox_districtvisible" style="width:120px">
									<option value="">所有校区</option>
									<logic:present name="districts">
										<logic:iterate name="districts" id="district">
											<option value="${district.id}" ${jobHire ne null && jobHire.jobHireVisibleDistrict ne null && jobHire.jobHireVisibleDistrict.id eq district.id ? 'selected="selected"' : ''}>${district.districtName}</option>
										</logic:iterate>
									</logic:present>
								</select>
							</c:when>
							<c:otherwise>
								<input name="jobHireVisibleDistrictId" type="text" style="width:140px" value="${jobHire ne null && jobHire.jobHireVisibleDistrict ne null ? jobHire.jobHireVisibleDistrict.districtName : '所有校区'}" readonly />
							</c:otherwise>
						</c:choose>
					</td>
					<td></td>
					<td></td>
				</tr>
				<tr>
					<td>工作地点：</td>
					<td colspan="5"><input name="jobHireAddress" type="text" value="${jobHire ne null ? jobHire.jobHireAddress : ''}" ${op ne null && op eq 'view' ? 'readonly' : ''} style="width:100%"/></td>
					<td></td>
					<td></td>
				</tr>
				<tr>
					<td style="vertical-align: top;">工作职责：</td>
					<td colspan="5"><textarea name="jobHireResponsibility" rows="3" style="width:100%" ${op ne null && op eq 'view' ? 'readonly' : ''}>${jobHire ne null ? jobHire.jobHireResponsibility : ''}</textarea></td>
					<td></td>
					<td></td>
				</tr>
				<tr>
					<td style="vertical-align: top;">任职要求：</td>
					<td colspan="5"><textarea name="jobHireCondition" rows="3" style="width:100%" ${op ne null && op eq 'view' ? 'readonly' : ''}>${jobHire ne null ? jobHire.jobHireCondition : ''}</textarea></td>
					<td></td>
					<td></td>
				</tr>
				<tr>
					<td style="vertical-align: top;">薪酬福利：</td>
					<td colspan="5"><textarea name="jobHireSalary" rows="3" style="width:100%" ${op ne null && op eq 'view' ? 'readonly' : ''}>${jobHire ne null ? jobHire.jobHireSalary : ''}</textarea></td>
					<td></td>
					<td></td>
				</tr>
				<tr>
					<td>附件区：</td>
					<td colspan="4">具体材料.pdf &nbsp;<a href="javascript:void(0);"><img class="opr" src="resources/images/icons/remove.png" /></a>&nbsp;</td>
					<td colspan="3">
					<logic:present name="op">
						<logic:equal name="op" value="update">
						<a class="oplink" href="app/hrm.do?action=hrmPageJobDetail&id=1" target="dialog" title="上传附件">上传附件</a>
						</logic:equal>
					</logic:present>
					</td>
				</tr>
			</table>
		</div>
		<div class="formBar">
			<ul>
				<c:if test="${op eq null || op ne 'view'}">
					<c:choose>
						<c:when test="${jobHire ne null}">
							<c:choose>
								<c:when test="${jobHire.status eq 1}">
									<li><div class="buttonActive"><div class="buttonContent"><button id="btnapproval" type="submit">提交总部审核</button></div></div></li>
									<li><div class="buttonActive"><div class="buttonContent"><button id="btnback" type="submit">退回发布人员</button></div></div></li>
								</c:when>
								<c:when test="${jobHire.status eq 2}">
									<li><div class="buttonActive"><div class="buttonContent"><button id="btnapproval" type="submit">通过并发布</button></div></div></li>
									<li><div class="buttonActive"><div class="buttonContent"><button id="btnback" type="submit">退回</button></div></div></li>
								</c:when>
							</c:choose>
						</c:when>
						<c:otherwise>
							<li><div class="buttonActive"><div class="buttonContent"><button type="submit">提交并审核</button></div></div></li>
						</c:otherwise>
					</c:choose>
				</c:if>
				<li>
					<div class="button"><div class="buttonContent"><button type="button" class="close">关闭</button></div></div>
				</li>
			</ul>
		</div>
		<c:if test="${jobHire ne null}">
			<input type="hidden" id="formAction" name="formAction" value="" />
		</c:if>
		<input type="hidden" name="id" value="${jobHire ne null ? jobHire.id : '-1'}" />
	</form>
</div>
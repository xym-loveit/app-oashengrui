<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix='fmt'%>

<script>
	/**
     * 向事件面板添加消息
     * @param evt
     * @param msg
     */
    function addMsg(evt, msg) {
        var $panel = $("#J_Panel");
        $panel.append("<p>事件名称：" + evt.type + "，" + msg + "</p>");
    }
	
</script>

<div class="pageContent">
	<form method="post" action="app/hrm/hire.do?action=actionJobSave" id="formjob" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);">
		<div class="pageFormContent" layoutH="56">
			<table cellspacing="10" cellpadding="10" style="border-spacing:12">
			    
				<tr>
					<td>工作日期：</td>
					<td><input name="workArrangeDate" class="date textInput required" style="width:140px;float:left;" value='<logic:present name="workArrange"><fmt:formatDate value="${workArrange.workDate}" pattern="yyyy-MM-dd" /></logic:present>' ${op ne null && op eq 'view' ? 'readonly' : ''}/><c:if test="${op eq null || op ne 'view'}"><a class="inputDateButton" href="javascript:;">请选择</a></c:if></td>
				</tr>
				
				<tr>
    			    <td>上班类型：</td>
	    				<td colspan="5"><select class="combox" name="jobHireDistrictId" id="combox_district" style="width:140px" ref="combox_dept" refUrl="app/base.do?action=actionLoadDepartmentByOrg&districtId={value}">
									<option value="">请选择</option>
									<logic:present name="workTypes">
										<logic:iterate name="workTypes" id="workType">
											<option value="${workType.type}" ${workArrange ne null && workArrange.workType ne null && workArrange.workType.type eq workType.type ? 'selected="selected"' : ''}>${workType.type}</option>
										</logic:iterate>
									</logic:present>
								</select>
						</td>
			    </tr>
			    
			    <tr>
    			    <td>上班时间：</td>
	    				<td colspan="5"><select class="combox" name="jobHireDistrictId" id="combox_district" style="width:140px" ref="combox_dept" refUrl="app/base.do?action=actionLoadDepartmentByOrg&districtId={value}">
									<option value="">请选择</option>
									<logic:present name="workTypes">
										<logic:iterate name="workTypes" id="workType">
											<option value="${workType.type}" ${jobHire ne null && jobHire.jobHireDistrict ne null && jobHire.jobHireDistrict.id eq district.id ? 'selected="selected"' : ''}>${workType.type}</option>
										</logic:iterate>
									</logic:present>
								</select>
						</td>
			    </tr>
			    
			    <tr>
					<td style="vertical-align: top;">工作内容：</td>
					<td colspan="5"><textarea name="workContent" rows="3" style="width:100%" ${op ne null && op eq 'view' ? 'readonly' : ''}>${workArrange ne null ? workArrange.workContent : ''}</textarea></td>
				</tr>
			    
				<tr>
					<td style="vertical-align: top;">工作人员：</td>
					<td colspan="5"><textarea name="staffs" rows="3" style="width:100%" ${op ne null && op eq 'view' ? 'readonly' : ''}>${workArrange ne null ? workArrange.staff.fullName : ''}</textarea></td>
				</tr>
				
			</table>
		</div>
		<div class="formBar">
			<ul>
				<c:if test="${op eq null || op ne 'view'}">
					<c:choose>
						<c:when test="${workArrange ne null}">
							<li><div class="buttonActive"><div class="buttonContent"><button id="btnapproval" type="submit">提交修改</button></div></div></li>
						</c:when>
						<c:otherwise>
							<li><div class="buttonActive"><div class="buttonContent"><button type="submit">添加工作安排</button></div></div></li>
						</c:otherwise>
					</c:choose>
				</c:if>
				<li>
					<div class="button"><div class="buttonContent"><button type="button" class="close">关闭</button></div></div>
				</li>
			</ul>
		</div>
		
		<!-- 这段话什么作用？ -->
		<c:if test="${workArrange ne null}">
			<input type="hidden" id="formAction" name="formAction" value="" />
		</c:if>
		<input type="hidden" name="id" value="${workArrange ne null ? workArrange.id : '-1'}" />
	</form>
</div>
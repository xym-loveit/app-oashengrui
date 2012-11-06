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
	<form method="post" action="app/admin.do?action=adminUpdateWorkArrange" id="formjob" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);">
		<div class="pageFormContent" layoutH="56">
			<table cellspacing="10" cellpadding="10" style="border-spacing:12" border="0">
				<tr>
					<td>工作日期：</td>
					<td><input name="workDate" class="date textInput required" style="width:140px;float:left;" value='<logic:present name="workArrange"><fmt:formatDate value="${workArrange.workDate}" pattern="yyyy-MM-dd" /></logic:present>'"/></td>
				  	<td>工作时间：</td>
	    			<td>
	    				<select class="combox" name="workTime.id" id="dialog_workTimeBranch" style="width:140px">
							<option value="">请选择</option>
							<c:if test="${workTimes ne null}">
								<c:forEach items="${workTimes}" var="workTime">
									<option value='<c:out value="${workTime.id}"/>' <c:if test="${workTime.id == workArrange.workTime.id }">selected="selected"</c:if>><c:out value="${workTime.workStime}" /> - <c:out value="${workTime.workEtime }"/></option>
								</c:forEach>
							</c:if>
						</select>
					</td>
				</tr>
				
				<tr>
    			    <td>上班类型：</td>
	    			<td>
	    				<select class="combox" name="workType.id" id="combox_district" style="width:140px">
							<option value="-1">请选择</option>
							<logic:present name="workTypes">
								<logic:iterate name="workTypes" id="workType">
									<option value="${workType.id}" <c:if test="${workType.id==workArrange.workType.id }">selected="selected"</c:if> >${workType.type}</option>
								</logic:iterate>
							</logic:present>
						</select>
					</td>
					<td style="vertical-align: top;">工作内容：</td>
					<td>
						<select class="combox" name="workContent.id"  id="workCntId">
							<option value="-1">请选择</option>
	                     <c:if test="${workContents ne null}">
	                    	<c:forEach items="${workContents}" var="workContent">
	                    		 <option value='<c:out value="${workContent.id}"/>' <c:if test="${workContent.id==workArrange.workContent.id }">selected="selected"</c:if> ><c:out value="${workContent.itemValue}" /></option>
	                     	</c:forEach>
	                     </c:if>
	                  </select>
					</td>
				</tr>
			    
				<tr>
					<td style="vertical-align: top;">工作人员：</td>
					<td colspan=3><input id="staffName" type="text" name="emp.fullName" style="width: 60%" postField="fullName" suggestFields="fullName,districtName" suggestUrl="app/base.do?action=lookupEmployeeByName" lookupGroup="emp" value="${workArrange.staffName }" />
	                    <input id="staffId" type="hidden" name="emp.id"  lookupGroup="emp" value="${workArrange.staff.id }" />
	                </td>
				</tr>
			</table>
		</div>
		<div class="formBar">
			<ul>
				<li>
					<div class="buttonActive"><div class="buttonContent"><button id="btnapproval" type="submit">提交修改</button></div></div>
				</li>
			</ul>
		</div>
		<input type="hidden" name="id" value="${workArrange ne null ? workArrange.id : '-1'}" />
		<input type="hidden" name="districtId" value="${workArrange ne null ? workArrange.districtId : '-1'}" />
	</form>
</div>
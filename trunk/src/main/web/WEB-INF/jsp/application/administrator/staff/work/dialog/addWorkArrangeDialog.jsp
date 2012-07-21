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
    $(function(){
    	$("#addStaff").bind("click",function(){
    		if($("#staffName").val()!=""){
    			var old_ctx = $("#staffNames").val();
    			$("#staffNames").val((old_ctx==""?"":old_ctx+",")+$("#staffName").val());
    			$("#staffName").val("");
    			var old_staffIds = $("#staffIds").val();
    			$("#staffIds").val((old_staffIds==""?"":old_staffIds+",")+$("#staffId").val())
    			$("#staffId").val("");
    		}
    	});
    });
</script>

<div class="pageContent">
	<form method="post" action="app/admin.do?action=adminAddStaffWorkArrange" id="formjob" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);">
		<div class="pageFormContent" layoutH="56">
			<table cellspacing="10" cellpadding="10" style="border-spacing:12">
			    
				<tr>
					<td>工作日期：</td>
					<td><input name="workDate" class="date textInput required" style="width:140px;float:left;" value='<logic:present name="workArrange"><fmt:formatDate value="${workArrange.workDate}" pattern="yyyy-MM-dd" /></logic:present>' ${op ne null && op eq 'view' ? 'readonly' : ''}/><c:if test="${op eq null || op ne 'view'}"><a class="inputDateButton" href="javascript:;">请选择</a></c:if></td>
				</tr>
				
				<tr>
    			    <td>上班类型：</td>
	    				<td colspan="5"><select class="combox" name="workType.id" id="combox_district" style="width:140px">
									<option value="-1">请选择</option>
									<logic:present name="workTypes">
										<logic:iterate name="workTypes" id="workType">
											<option value="${workType.id}">${workType.type}</option>
										</logic:iterate>
									</logic:present>
								</select>
						</td>
			    </tr>
				<tr>
					<td>工作中心：</td>
					<td>
						<select class="combox" id="districtId"  ref="dialog_workTimeBranch" refUrl="app/system/work/base/time.do?action=actionLoadWorkTimeByDistrict&districtId={value}">
						   <option value="-1">请选择</option>
							<logic:present name="districts">
								<logic:iterate name="districts" id="district">
									<option value="${district.id}">${district.districtName}</option>
								</logic:iterate>
							</logic:present>
						</select>
					</td>
				</tr>
			    <tr>
    			    <td>上班时间：</td>
	    				<td colspan="5">
	    					<select class="combox" name="workTime.id" id="dialog_workTimeBranch" style="width:140px">
								<option value="">请选择</option>
							</select>
						</td>
			    </tr>
			    
			    <tr>
					<td style="vertical-align: top;">工作内容：</td>
					<td colspan="5">
						<select class="combox" name="workContent.id"  id="workCntId">
							<option value="-1">请选择</option>
	                     <c:if test="${workContents ne null}">
	                    	<c:forEach items="${workContents}" var="workContent">
	                    		 <option value='<c:out value="${workContent.id}"/>'><c:out value="${workContent.itemValue}" /></option>
	                     	</c:forEach>
	                     </c:if>
	                  </select>
					</td>
				</tr>
			    
				<tr>
					<td style="vertical-align: top;">工作人员：</td>
					<td><input id="staffName" type="text" name="emp.fullName" style="width: 60%" postField="fullName" suggestFields="fullName,districtName" suggestUrl="app/base.do?action=lookupEmployeeByName" lookupGroup="emp" />
	                    <input id="staffId" type="hidden" name="emp.id"  lookupGroup="emp" />
	                    <div class="button"><div class="buttonContent"><button id="addStaff" type="button" class="submit">添加</button></div>
	                </td>
				</tr>
				<tr>
					<td></td>
					<td colspan="5"><textarea name="staffNames" id="staffNames" rows="3" style="width:100%"}></textarea>
					<input type="hidden" name="staffIds" id="staffIds" value="" /></td>
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
		<input type="hidden" name="id" value="${workArrange ne null ? workArrange.id : '-1'}" />
		<input type="hidden" name="staff.id" value="-1" />
	</form>
</div>
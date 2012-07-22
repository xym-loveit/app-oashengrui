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
    
    function bindDistricId(){
    	alert($("#workDate").val());
    	var relUrl = "app/system/work/base/time.do?action=actionLoadWorkTimeByDistrict&districtId={value}";
    	$("#dialog_arrangedStaffNames").attr("relUrl",relUrl+"&workDate="+$("#workDate").val());
    }
</script>

<div class="pageContent">
	<form method="post" action="app/admin.do?action=adminAddStaffWorkArrange" id="formjob" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);">
		<div class="pageFormContent" layoutH="56">
			<table cellspacing="10" cellpadding="10" style="border-spacing:12">
			    
				<tr>
					<td>工作日期：</td>
					<td colspan="2"><input type="text" id="workDate" name="workDate" class="date textInput required" style="width:140px;float:left;" onchange="bindDistricId()" /><a class="inputDateButton" href="#">选择</a></td>
					<td></td>
					<td></td>
				</tr>
				<tr>
					<td>工作中心：</td>
					<td colspan="2">
						<select class="combox" id="districtId"  ref="dialog_arrangedStaffNames" refUrl="app/system/work/base/time.do?action=actionLoadWorkTimeByDistrict&districtId={value}" onchange="bindDistricId()">
						   <option value="-1">请选择</option>
							<logic:present name="districts">
								<logic:iterate name="districts" id="district">
									<option value="${district.id}">${district.districtName}</option>
								</logic:iterate>
							</logic:present>
						</select>
					</td>
					<td></td>
					<td></td>
				</tr>
			    <tr>
    			    <td>工作时间：</td>
	    				<td colspan="2">
	    					<select class="combox" name="workTime.id" id="dialog_arrangedStaffNames" style="width:140px"  ref="dialog_workTimeBranch" refUrl="app/system/work/base/time.do?action=actionLoadWorkTimeByDistrict&districtId={value}" lookupGroup="staff">
								<option value="">请选择</option>
							</select>
						</td>
					<td></td>
					<td></td>
			    </tr>
				<tr>
					<td>工作人员:</td>
					<td colspan="4"><textarea name="staffNames" id="dialog_arrangedStaffNames" value="staff.staffName" rows="3" style="width:100%"}></textarea>
					</td>
				</tr>
				<tr>
					<td colspan="5"><input type="radio" name="options" value="remove" />不安排工作</td>
				</tr>
				<tr>
					<td><input type="radio" name="options" value="adjust" />调整到</td>
					<td>工作日期:</td>
					<td><input name="newWorkDate" class="date textInput required" style="width:140px;float:left;" /></td>
					<td>工作时间:</td>
					<td>
	    				<select class="combox" name="newWorkTime" id="dialog_arrangedStaffNames" style="width:140px">
							<option value="">请选择</option>
						</select>
					</td>
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
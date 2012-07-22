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
	<form method="post" action="app/admin.do?action=actionImportDataFromTemplate" id="formjob" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);">
		<div class="pageFormContent" layoutH="56">
			<table cellspacing="10" cellpadding="10" style="border-spacing:12">
			    <tr>
					<td>工作中心：</td>
					<td>
						<select class="combox required-validate" id="districtId" name="districtId">
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
					<td>加载日期：</td>
					<td><input type="text" id="workDate" name="startDate" class="date textInput required" style="width:140px;float:left;" onchange="bindDistricId()" /><a class="inputDateButton" href="#">选择</a></td>
					<td>-</td>
					<td><input type="text" id="workDate" name="endDate" class="date textInput required" style="width:140px;float:left;" onchange="bindDistricId()" /><a class="inputDateButton" href="#">选择</a></td>
				</tr>
				
			</table>
		</div>
		<div class="formBar">
			<ul>
				<li><div class="buttonActive"><div class="buttonContent"><button type="submit">批量加载</button></div></div></li>
				<li>
					<div class="button"><div class="buttonContent"><button type="button" class="close">关闭</button></div></div>
				</li>
			</ul>
		</div>
		<input type="hidden" name="id" value="${workArrange ne null ? workArrange.id : '-1'}" />
		<input type="hidden" name="staff.id" value="-1" />
	</form>
</div>
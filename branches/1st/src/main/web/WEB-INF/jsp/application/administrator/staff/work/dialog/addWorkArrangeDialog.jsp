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

    	$('#staffs').manifest({
    		// Use each location's full name as the display text.
    		formatDisplay: function (data, $item, $mpItem) {
    			return data.empName;
    		},
    		// Use each location's ID as the value to be submitted.
    		formatValue: function (data, $value, $item, $mpItem) {
    			return data.id;
    		},
    		valuesName: 'empid',
    		marcoPolo: {
    			url: 'app/base.do?action=lookupEmployeeByName',
    			formatItem: function (data) {
    			  return '"' + data.empName + '" (' + data.districtName + '-' + data.depName + ')';
    			},
    			onSelect: function (data, $item){
    				var count = $('#attendances_count').val();
    				if(count == "" || count == null) count = 0;
    				$('#attendances_count').val(1+parseInt(count));
    			}, 
    			param: 'fullName'
    		}
    	});
    });
    function getWorkContentById(){
    	var relUrl = "app/admin.do?action=actionLoadWorkContent&districtId="+$("#districtId").val();
    	$("#work_content").loadUrl(relUrl,{},function(){});
    	var url = "app/admin.do?action=actionLoadDepartmentsByDistrict&districtId="+$("#districtId").val();
    	$("#district_departments").loadUrl(url,{},function(){});
    }
</script>

<div class="pageContent">
	<form method="post" action="app/admin.do?action=adminAddStaffWorkArrange" id="formjob" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);">
		<div class="pageFormContent" layoutH="56">
			<div style="float: right; width: 200px;">
				<div class="accordion">
					<div class="accordionHeader">
						<h2><span>icon</span>按校区</h2>
					</div>
					<div class="accordionContent" id="district_departments" layoutH="100">
						<%@ include file="../data/dataDistrictTree.jsp"%>
					</div>
				</div>
			</div>
			
			<div style="margin-right: 220px">
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
							<select class="combox" name="districtId" id="districtId"  ref="dialog_workTimeBranch" refUrl="app/system/work/base/time.do?action=actionLoadWorkTimeByDistrict&districtId={value}" onchange="getWorkContentById()">
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
				    
				    <tr id="work_content">
						<%@ include file="../data/workContent.jsp" %>
					</tr>
				    
					<tr>
						<td style="vertical-align: top;">工作人员：</td>
						<td colspan="2"><input id="staffs" type="text" style="width: 100%;${op ne null && op eq 'view' ? 'display:none': ''}" /></td>
					</tr>
				</table>
			</div>
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
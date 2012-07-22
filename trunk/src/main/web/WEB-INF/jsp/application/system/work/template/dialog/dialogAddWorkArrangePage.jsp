<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript">
//高亮显示选中的菜单项, 供功能菜单联动选择
function dep_activated(id) {
	var uroot = $("#dentity_" + id).parent().parent().parent();
	uroot.find("div.selected").removeClass("selected");
	$("#dentity_" + id).parent().addClass("selected");
}
districtId = "-1";
templateId = "-1";
function content_refresh () {
    $("#ajBoxDepPos").loadUrl("app/system/work/template.do?action=pageWorkTemplateIndex&district.id="+districtId+"&templateId="+templateId, {}, function(){
       $.pdialog.closeCurrent();
    });
}
$(function(){
	districtId = $("#districtId").val();
	templateId = $("#templateId").val();
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

function loadData(obj){
}

</script>
<div class="pageContent" style="float:left; width: 600px;">
	<form method="post" action="app/system/work/template.do?action=actionSaveWorkArrange" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);">
		<div class="pageFormContent" layoutH="56">
			<div style="float:left">
				<table cellspacing="5" cellpadding="5" class="dform">
	            <tr>
	               <td>设置时间：</td>
	               <td><input type="text" size="30" name="workDay" value="${workDay}" readonly=readonly class="required" style="width: 88%"/></td>
				      <td>
				         <select class="combox" name="workTime.id"
	                     id="workTmId">
							<c:if test="${workTimes ne null}">
								<c:forEach items="${workTimes}" var="workTime">
									<option value='<c:out value="${workTime.id}"/>'><c:out value="${workTime.workStime}" /> - <c:out value="${workTime.workEtime }"/></option>
								</c:forEach>
							</c:if>
	                  </select>
				      </td>
				   </tr>
	            <tr>
	               <td>工作内容：</td>
	               <td>
	               <select class="combox" name="workContent.id"
	                     id="workCntId">
	                     <c:if test="${workContents ne null}">
	                    	<c:forEach items="${workContents}" var="workContent">
	                    		 <option value='<c:out value="${workContent.id}"/>'><c:out value="${workContent.itemValue}" /></option>
	                     	</c:forEach>
	                     </c:if>
	                  </select>
	               </td>
	               <td></td>
	            </tr>
	            <tr>
	               <td style="vertical-align: top;">工作人员：</td>
	               <td><input id="staffName" type="text" name="emp.fullName" style="width: 88%" postField="fullName" suggestFields="fullName,districtName" suggestUrl="app/base.do?action=lookupEmployeeByName" lookupGroup="emp" />
	                    <input id="staffId" type="hidden" name="emp.id"  lookupGroup="emp" />
	               </td>
	               <td><div class="button"><div class="buttonContent"><button id="addStaff" type="button" class="submit">添加</button></div></td>
	            </tr>
	            <tr>
	               <td></td>
	               <td><textarea id="staffNames" rows="2" cols="40" name="staffNames" class="textInput" readonly=readonly style="width: 88%"></textarea></td>
	               <td><input type="hidden" name="staffIds" id="staffIds" value="" />
 	               </td>
	            </tr>
				</table>
	        </div>       
			<div sytle="float:left">
				<div class="toggleCollapse noborder">
					<h2>校区列表</h2>
				</div>
				<div id="ajBoxDepTree" style="width:200px;float:left">
				    <ul class="tree treeFolder">
						<c:if test="${district ne null}">
							<li class="expand"><a id="org_master"><c:out value="${district.districtName}" /></a>
								<ul>
									<c:forEach items="${departments}" var="entity">
				    	 				<li><a id="dentity_${entity.id}" class='tparam' target="ajax" href="app/system/work/template.do?action=getAllStaffByDprtId&departId=${entity.id }&districtId=${district.id}"><c:out value="${entity.depName }" /></a></li>
									</c:forEach>
				   				</ul>
							</li>
						</c:if>
					</ul>
				</div>
			</div>
		</div>
		<div class="formBar">
			<ul>
				<li><div class="buttonActive"><div class="buttonContent"><button type="submit">保存</button></div></div></li>
				<li>
					<div class="button"><div class="buttonContent"><button type="button" class="close">取消</button></div></div>
				</li>
			</ul>
		</div>
		<input type="hidden" id="templateId" name="templateId" value="${templateId ne null ? templateId : '-1'}" />
		<input type="hidden" id="districtId" name="district.id" value="${districtId ne null ? districtId : '-1'}" />
		<input type="hidden" id="enable" name="enable" value="0" />
	</form>
<div>
		
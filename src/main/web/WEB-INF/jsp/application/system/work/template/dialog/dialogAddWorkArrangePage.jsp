<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<style>

/*** Manifest ***/

/* Manifest container that wraps the elements and now acts as, and should be
   styled as, the input. */
div.mf_container {
  border: 1px solid #000000;
  cursor: text;
  display: inline-block;
  padding: 2px;
  width: 250px;
}

/* Ordered list for displaying selected items. */
div.mf_container ol.mf_list {
  display: inline;
}

/* Selected item, regardless of state (highlighted, selected). */
div.mf_container ol.mf_list li.mf_item {
  border: 1px solid #C0C0C0;
  cursor: pointer;
  display: inline-block;
  margin: 2px;
  padding: 4px 4px 5px;
}

/* Selected item that's highlighted by mouseover. */
div.mf_container ol.mf_list li.mf_item.mf_highlighted {
  background-color: #E0E0E0;
}

/* Selected item that's selected by click or keyboard. */
div.mf_container ol.mf_list li.mf_item.mf_selected {
  background-color: #C0C0C0;
}

/* Remove link. */
div.mf_container ol.mf_list li.mf_item a.mf_remove {
  color: #E0E0E0;
  margin-left: 10px;
  text-decoration: none;
}

/* Remove link that's highlighted. */
div.mf_container ol.mf_list li.mf_item.mf_highlighted a.mf_remove {
  color: #FFFFFF;
}

/* Remove link that's selected. */
div.mf_container ol.mf_list li.mf_item.mf_selected a.mf_remove {
  color: #FFFFFF;
}

/* Actual input, styled to be invisible within the container. */
div.mf_container input.mf_input {
  border: 0;
  font: inherit;
  font-size: 100%;
  margin: 2px;
  outline: none;
  padding: 4px;
}

/*** Marco Polo ***/

/* Ordered list for display results. */
ol.mp_list {
  background-color: #FFFFFF;
  border-left: 1px solid #C0C0C0;
  border-right: 1px solid #C0C0C0;
  overflow: hidden;
  position: absolute;
  width: 498px;
  z-index: 99999;
}

/* Each list item, regardless of success, error, etc. */
ol.mp_list li {
  border-bottom: 1px solid #C0C0C0;
  padding: 4px 4px 5px 9px;
}

/* Each list item from a successful request. */
ol.mp_list li.mp_item {

}

/* Each list item that's selectable. */
ol.mp_list li.mp_selectable {
  cursor: pointer;
}

/* Currently highlighted list item. */
ol.mp_list li.mp_highlighted {
  background-color: #E0E0E0;
}

/* When a request is made that returns zero results. */
ol.mp_list li.mp_no_results {

}

/* When a request is made that doesn't meet the 'minChars' length option. */
ol.mp_list li.mp_min_chars {

}

/* When a request is made that fails during the ajax request. */
ol.mp_list li.mp_error {

}

</style>

<script src="resources/js/jquery/jmainfest/jquery.ui.widget.min.js" type="text/javascript"></script>
<script src="resources/js/jquery/jmainfest/jquery.marcopolo.min.js" type="text/javascript"></script>
<script src="resources/js/jquery/jmainfest/jquery.manifest.js" type="text/javascript"></script>

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
    $("#sysmgr_work_template").loadUrl("app/system/work/template.do?action=pageWorkTemplateIndex&district.id="+districtId+"&templateId="+templateId, {}, function(){
       //$.pdialog.closeCurrent();
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
	               <td colspan="2"><input id="staffs" type="text" style="width: 100%;${op ne null && op eq 'view' ? 'display:none': ''}" /></td>
	            </tr>
				</table>
	        </div>       
			<div sytle="float:left">
				<div class="accordion">
					<div class="accordionHeader">
						<h2><span>icon</span>按校区</h2>
					</div>
					<div class="accordionContent">
						<%@ include file="../data/dataDistrictTree.jsp"%>
					</div>
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
		
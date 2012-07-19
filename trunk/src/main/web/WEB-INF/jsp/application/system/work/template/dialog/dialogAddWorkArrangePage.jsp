<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script type="text/javascript">
districtId = "-1";
function content_refresh () {
    $("#ajBoxDepPos").loadUrl("app/system/work/base/time.do?action=pageWorkBaseTime&districtId="+districtId, {}, function(){
       $.pdialog.closeCurrent();
    });
}
$(function(){districtId = $("#districtId").val();});
</script>

<div class="pageContent">
	<form method="post" action="app/system/work/base/time.do?action=actionSaveBaseWorkTime" class="pageForm required-validate" onsubmit="return validateCallback(this, content_refresh);">
		<div class="pageFormContent" layoutH="56">
			<table cellspacing="5" cellpadding="5" class="dform">
            <tr>
               <td>设置时间：</td>
               <td><input type="text" size="30" value="${workDay}" readonly=readonly class="required" style="width: 88%"/></td>
			      <td>
			         <select class="combox" name="workTime.Id"
                     id="workTmId">
                     <option value="1">08:30-11:30</option>
                     <option value="2">13:30-17:30</option>
                     <option value="3">18:30-21:30</option>
                  </select>
			      </td>
			   </tr>
            <tr>
               <td>工作内容：</td>
               <td>
               <select class="combox" name="workContent.Id"
                     id="workCntId">
                     <option value="1">主管</option>
                     <option value="2">行政</option>
                     <option value="3">收银</option>
                  </select>
               </td>
               <td></td>
            </tr>
            <tr>
               <td style="vertical-align: top;">工作人员：</td>
               <td><textarea rows="2" cols="40" name="meto" class="textInput" style="width: 88%"></textarea></td>
            </tr>
			</table>
		</div>
		<div class="formBar">
			<ul>
				<li><div class="buttonActive"><div class="buttonContent"><button type="submit">保存</button></div></div></li>
				<li>
					<div class="button"><div class="buttonContent"><button type="button" class="close">取消</button></div></div>
				</li>
			</ul>
		</div>
		<input type="hidden" name="templateId" value="${templateId ne null ? templateId : '-1'}" />
		<input type="hidden" id="districtId" name="district.id" value="${districtId ne null ? districtId : '-1'}" />
	</form>
<div>
		
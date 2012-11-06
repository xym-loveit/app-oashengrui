<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<style>
	label {width: auto;}
	.opr {margin: 3px 2px;}
	.dispose {text-decoration: line-through; color: red;}
	a.oplink  {color: blue; text-decoration: underline;}
	
	#workTemplateRow td div{
      display: block;
      height:auto;
      line-height: 21px;
      overflow: hidden;
      white-space: nowrap;
   }
</style>
<!-- SearchBar -->
<form id="formDinctionary" onsubmit="return validateCallback(this, dialogAjaxDone);" action="app/system/dictionary.do?action=actionSaveDictionary" method="post">
	<input type="hidden" name="type" value = "${dictionary ne null ? dictionary.type :''}" />
    <input type="hidden" name="level" value="${dictionary ne null ? dictionary.level:'' }" />
	<!-- Body -->
	<div class="pageContent bol" style="float:left; width: 400px;">
		<div class="pageFormContent">
			<table  class="dform" width="100%">
				<tbody>
					<tr>
						<td>选项名称：</td>
						<td><input type="text" name="name" class="required-validate" value="${dictionary ne null ? dictionary.name :''}" /></td>
					</tr>
					<tr>
						<td>选项值：</td>
						<td><input type="text" name="value" class="required-validate" value="${dictionary ne null ? dictionary.value : ''}" /></td>
					</tr>
					<tr>
						<td>选项说明：</td>
						<td><textarea name="extraValue" value="">${dictionary ne null ? dictionary.extraValue :''}</textarea></td>
					</tr>
					<tr>
						<td>显示顺序：</td>
						<td><input type="text" name="sn" class="required-validate" value="${dictionary ne null ? dictionary.sn :''}" /></td>
					</tr>
					<tr>
						<td></td>
						<td>
							<div class="buttonActive"><div class="buttonContent"><button type="submit">修改</button></div></div>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	
	<input type="hidden" name="id" value="${dictionary ne null ? dictionary.id:'-1' }" />
</form>
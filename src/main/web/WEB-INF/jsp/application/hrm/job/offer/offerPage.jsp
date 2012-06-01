<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="pageContent">
	<form method="post" action="demo/common/ajaxDone.html" class="pageForm required-validate" onsubmit="return validateCallback(this, navTabAjaxDone);">
		<div class="pageFormContent" layoutH="56">
			<table cellspacing="10" cellpadding="10" style="border-spacing:12">
				<tr>
					<td>应聘者姓名：</td>
					<td colspan="3"><input name="name" type="text" value="张三；李四" style="width:100%" readonly/></td>
				</tr>
				<tr>
					<td>面试官：</td>
					<td><input name="owner" type="text" value="" style="width:170px"/></td>
					<td>面试地点：</td>
					<td><input name="address" type="text" value="" style="width:170px"/></td>
				</tr>
				<tr>
					<td>面试环节：</td>
					<td>
						<select class="combox" name="loop" style="width:150px">
							<option value="1">一面</option>
							<option value="2">二面</option>
							<option value="3">三面</option>
						</select>
					</td>
					<td>面试时间：</td>
					<td><input name="interviewDate" class="date" format="yyyy-MM-dd HH:mm:ss" style="width:170px"/></td>
				</tr>
				<tr>
					<td>其他备注：</td>
					<td colspan="3">
						<textarea name="comments" rows="3" style="width:100%"></textarea>
					</td>
				</tr>
			</table>
		</div>
		<div class="formBar">
			<ul>
				<!--<li><a class="buttonActive" href="javascript:;"><span>保存</span></a></li>-->
				<logic:present name="op">
					<li><div class="buttonActive"><div class="buttonContent"><button type="submit">保存</button></div></div></li>
				</logic:present>
				<li>
					<div class="button"><div class="buttonContent"><button type="button" class="close">取消</button></div></div>
				</li>
			</ul>
		</div>
	</form>
</div>
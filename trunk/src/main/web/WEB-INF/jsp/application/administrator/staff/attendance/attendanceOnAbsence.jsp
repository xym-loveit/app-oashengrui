<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- Body -->	
<div class="pageContent">
	<form onsubmit="return navTabSearch(this);" action="app/admin.do?action=adminPageEntryIndex" method="post">
		<div class="pageFormContent" layoutH="56">
			<table cellspacing="10" cellpadding="10" style="border-spacing:12">
				<tr>
					<td>
						<label>员工姓名：</label><input type="text" />
					</td>
				</tr>
				<tr>
					<td>
						<label>工作日期：</label><input type="text" class="date" />
					</td>
				</tr>
				<tr>
					<td>
						<label>工作时间：</label><input type="text" />
					</td>
				</tr>
				<tr>
					<td>
						<label>代班人：</label><input type="text" />
					</td>
				</tr>
				<tr>
					<td>
						<label>旷工说明：</label>
						<textarea rows="2" cols="40" name="textarea1" class="textInput"></textarea>
					</td>
				</tr>
			</table>
		</div>
		<div class="formBar">
			<ul>
				<li><div class="buttonActive"><div class="buttonContent"><button type="submit">旷工处理</button></div></div></li>
				<li>
					<div class="button"><div class="buttonContent"><button type="button" class="close">取消</button></div></div>
				</li>
			</ul>
		</div>
	</form>
</div>
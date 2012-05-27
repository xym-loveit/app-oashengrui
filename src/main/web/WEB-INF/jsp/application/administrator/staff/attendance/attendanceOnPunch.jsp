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
		<div class="searchBar">
			<table class="searchContent">
				<tr>
					<td>
						员工姓名：<input type="text" />
					</td>
					<td>
						工作日期：<input type="text" class="date" /> - <input type="text" class="date" />
					</td>
				</tr>
				<tr>
					<td>
						工作时间：<input type="text" />
					</td>
				</tr>
			</table>
			<div class="subBar">
				<ul>
					<li><div class="buttonActive"><div class="buttonContent"><button type="submit">检索</button></div></div></li>
				</ul>
			</div>
		</div>
	</form>
	<div class="formBar">
		<ul>
			<!--<li><a class="buttonActive" href="javascript:;"><span>保存</span></a></li>-->
			<li><div class="buttonActive"><div class="buttonContent"><button type="submit">提交审核</button></div></div></li>
			<li><div class="buttonActive"><div class="buttonContent"><button type="submit">保存草稿</button></div></div></li>
			<li>
				<div class="button"><div class="buttonContent"><button type="button" class="close">取消</button></div></div>
			</li>
		</ul>
	</div>
		
	</form>
</div>
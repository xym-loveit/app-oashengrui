<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<!-- SearchBar -->
<div class="pageHeader">
	<form onsubmit="return navTabSearch(this);" action="app/admin.do?action=adminPageEntryIndex" method="post">
		<div class="searchBar">
			<table class="searchContent">
				<tr>
					<td>
						<label>文档类型：</label>
						<select class="combox" name="type" id="entry_type">
							<option value="">所有</option>
						</select>
					</td>
					<td>
						<label>文档名称：</label>
						<input type="text" />
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
</div>

<!-- Body -->	
<div class="pageContent">
	<div class="panelBar">
		<ul class="toolBar">
			<li><a class="add" href="app/admin.do?action=adminPageDocumentDetail" target="dialog" title="文档上传" width="850" height="380" rel="dia_admin_entryadd"><span>文档上传</span></a></li>
		</ul>
	</div>
	<table class="table" width="100%" layoutH="138">
		<thead>
			<tr>
				<th align="center">文档类型</th>
				<th align="center">文档名称</th>
				<th align="center">上传时间</th>
				<th align="center">上传校区与部门</th>
				<th align="center">编辑</th>
				<th align="center">删除</th>
			</tr>
		</thead>
		<tbody>
			<tr target="sid" rel="1">
				<td>人资文档</td>
				<td>员工转正考核制度</td>
				<td>2012-02-27</td>
				<td>杭州总部 人资部</td>
				<td>
					<a href="app/admin.do?action=adminPageDocumentDetail&id=1" target="dialog" title="文档编辑" class="oplink" width="850" height="380" rel="admin_docedit_1">编辑</a>
				</td>
				<td>
					<a href="app/admin.do?action=adminOprEntryRemove&id=1" target="ajaxTodo" title="确定删除该文档吗？" class="oplink">删除</a>
				</td>
			</tr>
			<tr target="sid" rel="1">
				<td>人资文档</td>
				<td>员工转正考核制度</td>
				<td>2012-02-27</td>
				<td>杭州总部 人资部</td>
				<td>
					<a href="app/admin.do?action=adminPageDocumentDetail&id=2" target="dialog" title="文档编辑" class="oplink" width="850" height="380" rel="admin_docedit_2">编辑</a>
				</td>
				<td>
					<a href="app/admin.do?action=adminOprEntryRemove&id=1" target="ajaxTodo" title="确定删除该文档吗？" class="oplink">删除</a>
				</td>
			</tr>
		</tbody>
	</table>
	<div class="panelBar">
		<div class="pages">
			<span>显示</span>
			<select class="combox" name="numPerPage" onchange="navTabPageBreak({numPerPage:this.value})">
				<option value="20">20</option>
				<option value="50">50</option>
				<option value="100">100</option>
				<option value="200">200</option>
			</select>
			<span>条，共${totalCount}条</span>
		</div>
		
		<div class="pagination" targetType="navTab" totalCount="200" numPerPage="20" pageNumShown="10" currentPage="1"></div>

	</div>
		
	</form>
</div>
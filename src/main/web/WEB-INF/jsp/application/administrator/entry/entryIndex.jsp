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
</style>

<script type="text/javascript">
	function hello(rsp_msg) {
		alert(rsp_msg.message);
	}
</script>

<!-- SearchBar -->
<div class="pageHeader">
	<form onsubmit="return navTabSearch(this);" action="app/admin.do?action=adminPageEntryIndex" method="post">
		<div class="searchBar">
			<table class="searchContent">
				<tr>
					<td>
						<label>新闻类型：</label>
						<select class="combox" name="type" id="entry_type">
							<option value="">所有</option>
							<option value="1">公司新闻</option>
						</select>
					</td>
					<td>
						<label>新闻状态：</label>
						<select class="combox" name="status" id="entry_status">
							<option value="">所有</option>
							<option value="1">已发布</option>
							<option value="2">待审批</option>
							<option value="3">已退回</option>
							<option value="4">草稿</option>
						</select>
					</td>
					<td>
						新闻标题：<input type="text" />
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
		<ul class="toolBar" style="float:right">
			<li><a treeicon="icon-edit" class="icon" href="app/admin.do?action=adminPageEntryApprovalIndex" target="navTab" rel="admin_entrycheck"><span class="icon-edit">新闻审批和管理</span></a></li>
		</ul>
		<ul class="toolBar">
			<li><a class="add" href="app/admin.do?action=adminPageEntryDetail" target="dialog" title="添加新闻" width="900" height="500" rel="dia_admin_entryadd"><span>添加</span></a></li>
			<li class="line">line</li>
			<li><a class="delete" href="app/admin.do?action=adminPageEntryRemove&id={sid}" target="ajaxTodo" title="确定要删除吗?" callback="hello"><span>删除</span></a></li>
			<li class="line">line</li>
			<li><a class="edit" href="app/admin.do?action=adminPageEntryDetail&id={sid}" target="dialog" title="修改新闻" width="900" height="500" rel="dia_admin_entryedit{sid}"><span>修改</span></a></li>
			<!--
			<li class="line">line</li>
			<li><a class="icon" href="demo/common/dwz-team.xls" target="dwzExport" targetType="navTab" title="实要导出这些记录吗?"><span>导出EXCEL</span></a></li>
			-->
		</ul>
	</div>
	<table class="table" width="100%" layoutH="138">
		<thead>
			<tr>
				<th width="120" align="center">新闻类型</th>
				<th align="center">新闻标题</th>
				<th width="100" align="center">状态</th>
				<th width="150" align="center">发布校区与部门</th>
				<th width="80" align="center">发布时间</th>
				<th align="center">操作</th>
			</tr>
		</thead>
		<tbody>
			<tr target="sid" rel="1">
				<td>公司新闻</td>
				<td>晟睿教育获得资本相亲会本周最具投资价值奖</td>
				<td>已发布</td>
				<td>杭州总部 总经办</td>
				<td>2012-02-22</td>
				<td>
					<a href="app/admin.do?action=adminPageEntryRemove&id=1" target="ajaxTodo" title="确定要删除吗?" callback="hello"><img class="opr" src="resources/images/icons/remove.png" /></a>&nbsp;
					<a href="app/admin.do?action=adminPageEntryDetail&id=1" target="dialog" title="修改新闻" width="900" height="500"><img class="opr" src="resources/images/icons/edit.gif" /></a>
				</td>
			</tr>
			<tr target="sid" rel="1">
				<td>公司新闻</td>
				<td>晟睿教育获得资本相亲会本周最具投资价值奖</td>
				<td>待审批</td>
				<td>杭州总部 总经办</td>
				<td>2012-02-22</td>
				<td>
					<a href="javascript:void(0);"><img class="opr" src="resources/images/icons/remove.png" /></a>&nbsp;
					<a href="javascript:void(0);"><img class="opr" src="resources/images/icons/edit.gif" /></a>
				</td>
			</tr>
			<tr target="sid" rel="1">
				<td>公司新闻</td>
				<td>晟睿教育获得资本相亲会本周最具投资价值奖</td>
				<td class="dispose">已退回</td>
				<td>杭州总部 总经办</td>
				<td>2012-02-22</td>
				<td>
					<a href="javascript:void(0);"><img class="opr" src="resources/images/icons/remove.png" /></a>&nbsp;
					<a href="javascript:void(0);"><img class="opr" src="resources/images/icons/edit.gif" /></a>
				</td>
			</tr>
			<tr target="sid" rel="1">
				<td>公司新闻</td>
				<td>晟睿教育获得资本相亲会本周最具投资价值奖</td>
				<td>草稿</td>
				<td>杭州总部 总经办</td>
				<td>2012-02-22</td>
				<td>
					<a href="javascript:void(0);"><img class="opr" src="resources/images/icons/remove.png" /></a>&nbsp;
					<a href="javascript:void(0);"><img class="opr" src="resources/images/icons/edit.gif" /></a>
				</td>
			</tr>
			<tr target="sid" rel="1">
				<td>公司新闻</td>
				<td>晟睿教育获得资本相亲会本周最具投资价值奖</td>
				<td>已发布</td>
				<td>杭州总部 总经办</td>
				<td>2012-02-22</td>
				<td>
					<a href="javascript:void(0);"><img class="opr" src="resources/images/icons/remove.png" /></a>&nbsp;
					<a href="javascript:void(0);"><img class="opr" src="resources/images/icons/edit.gif" /></a>
				</td>
			</tr>
			<tr target="sid" rel="1">
				<td>公司新闻</td>
				<td>晟睿教育获得资本相亲会本周最具投资价值奖</td>
				<td>已发布</td>
				<td>杭州总部 总经办</td>
				<td>2012-02-22</td>
				<td>
					<a href="javascript:void(0);"><img class="opr" src="resources/images/icons/remove.png" /></a>&nbsp;
					<a href="javascript:void(0);"><img class="opr" src="resources/images/icons/edit.gif" /></a>
				</td>
			</tr>
			<tr target="sid" rel="1">
				<td>公司新闻</td>
				<td>晟睿教育获得资本相亲会本周最具投资价值奖</td>
				<td>已发布</td>
				<td>杭州总部 总经办</td>
				<td>2012-02-22</td>
				<td>
					<a href="javascript:void(0);"><img class="opr" src="resources/images/icons/remove.png" /></a>&nbsp;
					<a href="javascript:void(0);"><img class="opr" src="resources/images/icons/edit.gif" /></a>
				</td>
			</tr>
			<tr target="sid" rel="1">
				<td>公司新闻</td>
				<td>晟睿教育获得资本相亲会本周最具投资价值奖</td>
				<td>已发布</td>
				<td>杭州总部 总经办</td>
				<td>2012-02-22</td>
				<td>
					<a href="javascript:void(0);"><img class="opr" src="resources/images/icons/remove.png" /></a>&nbsp;
					<a href="javascript:void(0);"><img class="opr" src="resources/images/icons/edit.gif" /></a>
				</td>
			</tr>
			<tr target="sid" rel="1">
				<td>公司新闻</td>
				<td>晟睿教育获得资本相亲会本周最具投资价值奖</td>
				<td>已发布</td>
				<td>杭州总部 总经办</td>
				<td>2012-02-22</td>
				<td>
					<a href="javascript:void(0);"><img class="opr" src="resources/images/icons/remove.png" /></a>&nbsp;
					<a href="javascript:void(0);"><img class="opr" src="resources/images/icons/edit.gif" /></a>
				</td>
			</tr>
			<tr target="sid" rel="1">
				<td>公司新闻</td>
				<td>晟睿教育获得资本相亲会本周最具投资价值奖</td>
				<td>已发布</td>
				<td>杭州总部 总经办</td>
				<td>2012-02-22</td>
				<td>
					<a href="javascript:void(0);"><img class="opr" src="resources/images/icons/remove.png" /></a>&nbsp;
					<a href="javascript:void(0);"><img class="opr" src="resources/images/icons/edit.gif" /></a>
				</td>
			</tr>
			<tr target="sid" rel="1">
				<td>公司新闻</td>
				<td>晟睿教育获得资本相亲会本周最具投资价值奖</td>
				<td>已发布</td>
				<td>杭州总部 总经办</td>
				<td>2012-02-22</td>
				<td>
					<a href="javascript:void(0);"><img class="opr" src="resources/images/icons/remove.png" /></a>&nbsp;
					<a href="javascript:void(0);"><img class="opr" src="resources/images/icons/edit.gif" /></a>
				</td>
			</tr>
			<tr target="sid" rel="1">
				<td>公司新闻</td>
				<td>晟睿教育获得资本相亲会本周最具投资价值奖</td>
				<td>已发布</td>
				<td>杭州总部 总经办</td>
				<td>2012-02-22</td>
				<td>
					<a href="javascript:void(0);"><img class="opr" src="resources/images/icons/remove.png" /></a>&nbsp;
					<a href="javascript:void(0);"><img class="opr" src="resources/images/icons/edit.gif" /></a>
				</td>
			</tr>
			<tr target="sid" rel="1">
				<td>公司新闻</td>
				<td>晟睿教育获得资本相亲会本周最具投资价值奖</td>
				<td>已发布</td>
				<td>杭州总部 总经办</td>
				<td>2012-02-22</td>
				<td>
					<a href="javascript:void(0);"><img class="opr" src="resources/images/icons/remove.png" /></a>&nbsp;
					<a href="javascript:void(0);"><img class="opr" src="resources/images/icons/edit.gif" /></a>
				</td>
			</tr>
			<tr target="sid" rel="1">
				<td>公司新闻</td>
				<td>晟睿教育获得资本相亲会本周最具投资价值奖</td>
				<td>已发布</td>
				<td>杭州总部 总经办</td>
				<td>2012-02-22</td>
				<td>
					<a href="javascript:void(0);"><img class="opr" src="resources/images/icons/remove.png" /></a>&nbsp;
					<a href="javascript:void(0);"><img class="opr" src="resources/images/icons/edit.gif" /></a>
				</td>
			</tr>
			<tr target="sid" rel="1">
				<td>公司新闻</td>
				<td>晟睿教育获得资本相亲会本周最具投资价值奖</td>
				<td>已发布</td>
				<td>杭州总部 总经办</td>
				<td>2012-02-22</td>
				<td>
					<a href="javascript:void(0);"><img class="opr" src="resources/images/icons/remove.png" /></a>&nbsp;
					<a href="javascript:void(0);"><img class="opr" src="resources/images/icons/edit.gif" /></a>
				</td>
			</tr>
			<tr target="sid" rel="1">
				<td>公司新闻</td>
				<td>晟睿教育获得资本相亲会本周最具投资价值奖</td>
				<td>已发布</td>
				<td>杭州总部 总经办</td>
				<td>2012-02-22</td>
				<td>
					<a href="javascript:void(0);"><img class="opr" src="resources/images/icons/remove.png" /></a>&nbsp;
					<a href="javascript:void(0);"><img class="opr" src="resources/images/icons/edit.gif" /></a>
				</td>
			</tr>
			<tr target="sid" rel="1">
				<td>公司新闻</td>
				<td>晟睿教育获得资本相亲会本周最具投资价值奖</td>
				<td>已发布</td>
				<td>杭州总部 总经办</td>
				<td>2012-02-22</td>
				<td>
					<a href="javascript:void(0);"><img class="opr" src="resources/images/icons/remove.png" /></a>&nbsp;
					<a href="javascript:void(0);"><img class="opr" src="resources/images/icons/edit.gif" /></a>
				</td>
			</tr>
			<tr target="sid" rel="1">
				<td>公司新闻</td>
				<td>晟睿教育获得资本相亲会本周最具投资价值奖</td>
				<td>已发布</td>
				<td>杭州总部 总经办</td>
				<td>2012-02-22</td>
				<td>
					<a href="javascript:void(0);"><img class="opr" src="resources/images/icons/remove.png" /></a>&nbsp;
					<a href="javascript:void(0);"><img class="opr" src="resources/images/icons/edit.gif" /></a>
				</td>
			</tr>
			<tr target="sid" rel="1">
				<td>公司新闻</td>
				<td>晟睿教育获得资本相亲会本周最具投资价值奖</td>
				<td>已发布</td>
				<td>杭州总部 总经办</td>
				<td>2012-02-22</td>
				<td>
					<a href="javascript:void(0);"><img class="opr" src="resources/images/icons/remove.png" /></a>&nbsp;
					<a href="javascript:void(0);"><img class="opr" src="resources/images/icons/edit.gif" /></a>
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
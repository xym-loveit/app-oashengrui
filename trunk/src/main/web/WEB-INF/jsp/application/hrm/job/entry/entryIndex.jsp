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
	<form onsubmit="return navTabSearch(this);" action="app/hrm.do?action=hrmPageJobEntryIndex" method="post">
		<div class="searchBar">
			<table class="searchContent">
				<tr>
					<td>
						应聘者姓名：<input type="text"  name="entry_name"/>
					</td>
					<td>
						<label>简历来源：</label>
						<select class="combox" name="entry_source" id="entry_source">
							<option value="">所有来源</option>
							<option value="1">内部推荐</option>
							<option value="2">手工录入</option>
							<option value="3">内部应聘</option>
						</select>
					</td>
					<td>
						<label>状态：</label>
						<select class="combox" name="status" id="entry_status">
							<option value="">所有</option>
							<option value="1">待安排</option>
							<option value="1">已安排</option>
						</select>
					</td>
				</tr>
			</table>
			<div class="subBar">
				<ul>
					<li><div class="buttonActive"><div class="buttonContent"><button type="submit">检索</button></div></div></li>
					<li>
						<a class="button" target="navTab" href="app/hrm.do?action=hrmJobIndex"><span>返回</span></a>
					</li>
				</ul>
			</div>
		</div>
	</form>
</div>

<!-- Body -->	
<div style="float: left; display: block; overflow: auto; width: 240px;  border: 1px solid rgb(204, 204, 204); line-height: 21px; background: none repeat scroll 0% 0% rgb(255, 255, 255);">
    <div class="panel" style="display: block;">
			<div class="panelHeader"><div class="panelHeaderContent"><h1><span class="icon-mymsg icon">岗位信息</span></h1></div></div>
			<div class="panelContent" style="height: auto; ">
				<ul style="padding:5px 0 0 5px;line-height:23px;">
					<li>岗位名称：产品经理</li>
					<li>招聘校区：杭州总部</li>
					<li>招聘部门：教研部</li>
					<li>招聘范围：内外皆招</li>
					<li>招聘人数：2</li>
					<li>应聘人数：20</li>
					<li>已录人数：1</li>
				</ul>
			</div>
	</div>
</div>
<div style="margin-left:246px;" class="unitBox" id="jbsxBox">
	<div class="pageContent">
		<div class="panelBar">
			<ul class="toolBar">
				<li><a treeicon="icon-edit" class="icon" href="app/hrm.do?action=hrmPageJobEntryDetail" target="dialog"><span class="icon-edit">入职安排</span></a></li>
			</ul>
		</div>
		<table class="table" width="100%" layoutH="138">
			<thead>
				<tr>
					<th align="center">选择</th>
					<th align="center">应聘者姓名</th>
					<th align="center">联系电话</th>
					<th align="center">简历来源</th>
					<th align="center">申请时间</th>
					<th align="center">状态</th>
					<th align="center">到岗情况</th>
					<th align="center">简历信息</th>
					<th align="center">面试记录</th>
					<th align="center">入职安排</th>
				</tr>
			</thead>
			<tbody>
				<tr target="sid" rel="1">
					<td><input type="checkbox" name="c1" value="1" /></td>
					<td>张三</td>
					<td>××××-×××-×××</td>
					<td>手工录入</td>
					<td>2012/05/31</td>
					<td>待安排</td>
					<td>---</td>
					<td><a class="oplink" href="app/hrm.do?action=hrmJobResumeDetail&id=1" target="dialog" title="查看简历" width="900" height="500">简历信息</a></td>
					<td><a class="oplink" href="app/hrm.do?action=hrmPageJobOfferInterviewIndex&id=1" target="dialog" title="面试记录(张三)" >面试记录</a></td>
					<td><a class="oplink" href="app/hrm.do?action=hrmPageJobEntryDetail&id=1&op=update" target="dialog" title="入职安排" >入职安排</a></td>
				</tr>
				<tr target="sid" rel="1">
					<td><input type="checkbox" name="c1" value="1" /></td>
					<td>张三</td>
					<td>××××-×××-×××</td>
					<td>手工录入</td>
					<td>2012/05/31</td>
					<td>待安排</td>
					<td>---</td>
					<td><a class="oplink" href="app/hrm.do?action=hrmJobResumeDetail&id=1" target="dialog" title="查看简历" width="900" height="500">简历信息</a></td>
					<td><a class="oplink" href="app/hrm.do?action=hrmPageJobOfferInterviewIndex&id=1" target="dialog" title="面试记录(张三)" >面试记录</a></td>
					<td><a class="oplink" href="app/hrm.do?action=hrmPageJobEntryDetail&id=1&op=update" target="dialog" title="入职安排" >入职安排</a></td>
				</tr>
				<tr target="sid" rel="1">
					<td><input type="checkbox" name="c1" value="1" /></td>
					<td>张三</td>
					<td>××××-×××-×××</td>
					<td>手工录入</td>
					<td>2012/05/31</td>
					<td>已安排</td>
					<td>已入职</td>
					<td><a class="oplink" href="app/hrm.do?action=hrmJobResumeDetail&id=1" target="dialog" title="查看简历" width="900" height="500">简历信息</a></td>
					<td><a class="oplink" href="app/hrm.do?action=hrmPageJobOfferInterviewIndex&id=1" target="dialog" title="面试记录(张三)" >面试记录</a></td>
					<td><a class="oplink" href="app/hrm.do?action=hrmPageJobDetail&id=1&op=update" target="dialog" title="入职安排" ></a></td>
				</tr>
				<tr target="sid" rel="1">
					<td><input type="checkbox" name="c1" value="1" /></td>
					<td>张三</td>
					<td>××××-×××-×××</td>
					<td>手工录入</td>
					<td>2012/05/31</td>
					<td>已安排</td>
					<td>未到岗</td>
					<td><a class="oplink" href="app/hrm.do?action=hrmPageJobDetail&id=1" target="dialog" title="查看简历" width="900" height="500">简历信息</a></td>
					<td><a class="oplink" href="app/hrm.do?action=hrmPageJobDetail&id=1&op=update" target="dialog" title="查看面试记录" width="900" height="500">面试记录</a></td>
					<td><a class="oplink" href="app/hrm.do?action=hrmPageJobDetail&id=1&op=update" target="dialog" title="入职安排" width="900" height="500"></a></td>
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
	</div>
</div>
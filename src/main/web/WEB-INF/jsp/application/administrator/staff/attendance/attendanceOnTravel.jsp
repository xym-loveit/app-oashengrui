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
						员工姓名：<input type="text" />
					</td>
					<td>
						<label>上班状态：</label>
						<select class="combox" name="type" id="entry_type">
							<option value="">所有</option>
							<option value="1">在岗</option>
							<option value="1">出差</option>
							<option value="1">请假</option>
						</select>
					</td>
					<td>
						<label>考勤结果：</label>
						<select class="combox" name="status" id="entry_status">
							<option value="">所有</option>
							<option value="1">按时</option>
							<option value="2">迟到</option>
							<option value="3">早退</option>
							<option value="4">旷工</option>
						</select>
					</td>
					<td>
						上班时间：<input type="text" class="date" /> - <input type="text" class="date" />
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
			<li><a class="icon" href="demo/common/dwz-team.xls" target="dwzExport" targetType="navTab" title="确定要导入考勤数据吗?"><span>导入考勤数据</span></a></li>
		</ul>
	</div>
	<table class="table" width="100%" layoutH="138">
		<thead>
			<tr>
				<th width="120" align="center">工作日期</th>
				<th align="center">工作时间</th>
				<th width="100" align="center">姓名</th>
				<th width="150" align="center">上班类型</th>
				<th width="80" align="center">实际上下班时间</th>
				<th align="center">上班状态</th>
				<th align="center">代班人</th>
				<th align="center">考勤结果</th>
				<th align="center">异常数据</th>
				<th align="center">手动打卡</th>
				<th align="center">出差安排</th>
				<th align="center">请假</th>
				<th align="center">旷工</th>
			</tr>
		</thead>
		<tbody>
			<tr target="sid" rel="1">
				<td>2012-02-27</td>
				<td>8:30 - 17:30</td>
				<td>王伟平</td>
				<td>正常上班</td>
				<td>08:25 - 17:25</td>
				<td>在岗</td>
				<td>梅杰</td>
				<td>---</td>
				<td></td>
				<td><a href="javascript:void(0);" class="oplink">打卡</a></td>
				<td><a href="javascript:void(0);" class="oplink">出差安排</a></td>
				<td><a href="javascript:void(0);" class="oplink">请假</a></td>
				<td><a href="javascript:void(0);" class="oplink">旷工</a></td>
			</tr>
			<tr target="sid" rel="1">
				<td>2012-02-27</td>
				<td>8:30 - 17:30</td>
				<td>许老师</td>
				<td>正常上班</td>
				<td>08:25 - 17:25</td>
				<td>出差</td>
				<td>---</td>
				<td>---</td>
				<td></td>
				<td><a href="javascript:void(0);" class="oplink">打卡</a></td>
				<td><a href="javascript:void(0);" class="oplink">出差安排</a></td>
				<td><a href="javascript:void(0);" class="oplink">请假</a></td>
				<td><a href="javascript:void(0);" class="oplink">旷工</a></td>
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
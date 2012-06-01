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
<div class="pageContent">
	<table class="table" width="100%" layoutH="138">
		<thead>
			<tr>
				<th align="center">面试官姓名</th>
				<th align="center">面试环节</th>
				<th align="center">面试时间</th>
				<th align="center">建议结果</th>
				<th align="center" width="30%">备注信息</th>
				<th align="center">附件</th>
			</tr>
		</thead>
		<tbody>
			<tr target="sid" rel="1">
				<td>张老师</td>
				<td>一面</td>
				<td>2012/05/31</td>
				<td>建议通过</td>
				<td>---</td>
				<td><a class="oplink" href="app/hrm.do?action=hrmPageJobDetail&id=1" target="ajaxdo" title="下载附件">下载</a></td>
			</tr>
			<tr target="sid" rel="1">
				<td>张老师</td>
				<td>二面</td>
				<td>2012/05/31</td>
				<td>建议通过</td>
				<td>---</td>
				<td><a class="oplink" href="app/hrm.do?action=hrmPageJobDetail&id=1" target="ajaxdo" title="下载附件">下载</a></td>
			</tr>
			<tr target="sid" rel="1">
				<td>张老师</td>
				<td>三面</td>
				<td>2012/05/31</td>
				<td>建议淘汰</td>
				<td>---</td>
				<td><a class="oplink" href="app/hrm.do?action=hrmPageJobDetail&id=1" target="ajaxdo" title="下载附件">下载</a></td>
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


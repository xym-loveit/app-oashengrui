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
	<form onsubmit="return navTabSearch(this);" action="app/hrm.do?action=hrmJobResumeIndex" method="post">
		<div class="searchBar">
			<table class="searchContent">
				<tr>
					<td>
						<label>曾应聘岗位：</label>
						<input type="text"  name="appliedJob"/>
					</td>
					<td>
						<label>应聘校区：</label>
						<select class="combox" name="school">
							<option value="">所有校区</option>
							<option value="1">临安校区</option>
							<option value="2">柯桥校区</option>
							<option value="3">萧山校区</option>
						</select>
					</td>
					<td>
						<label>应聘部门：</label>
						<select class="combox" name="dept">
							<option value="">所有</option>
							<option value="1">教研部</option>
						</select>
					</td>
					<td>
						<label>评定等级：</label>
						<select class="combox" name="level">
							<option value="">所有</option>
							<option value="1">一星级</option>
							<option value="2">二星级</option>
							<option value="3">三星级</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>
						<label>毕业院校：</label>
						<input type="text"  name="graduation"/>
					</td>
					<td>
						<label>专业：</label>
						<input type="text"  name="class"/>
					</td>
					<td>
						<label>学历：</label>
						<select class="combox" name="education">
							<option value="">所有</option>
							<option value="1">研究生</option>
							<option value="2">本科生</option>
						</select>
					</td>
					<td></td>
				</tr>
				<tr>
					<td>
						<label>师范类专业：</label>
						<select class="combox" name="teachClass">
							<option value="">所有</option>
							<option value="1">是</option>
							<option value="2">否</option>
						</select>
					</td>
					<td>
						<label>教师资格：</label>
						<select class="combox" name="teacher">
							<option value="">所有</option>
							<option value="1">是</option>
							<option value="2">否</option>
						</select>
					</td>
					<td>
						<label>普通话等级：</label>
						<select class="combox" name="speakClass">
							<option value="">所有</option>
							<option value="一级甲等">一级甲等</option>
							<option value="一级乙等">一级乙等</option>
							<option value="二级甲等">二级甲等</option>
							<option value="二级乙等">二级乙等</option>
							<option value="三级甲等">三级甲等</option>
							<option value="三级乙等">三级乙等</option>
							<option value="无">无</option>
						</select>
					</td>
					<td></td>
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
	<table class="table" width="100%" layoutH="138">
		<thead>
			<tr>
				<th align="center">姓名</th>
				<th align="center">来源</th>
				<th align="center">联系电话</th>
				<th align="center">学历</th>
				<th align="center">师范类专业</th>
				<th align="center">教师资格</th>
				<th align="center">外语等级</th>
				<th align="center">普通话等级</th>
				<th align="center">评定等级</th>
				<th align="center">曾应聘岗位</th>
				<th align="center">应聘校区</th>
				<th align="center">应聘部门</th>
				<th align="center">简历信息</th>
				<th align="center">删除</th>
			</tr>
		</thead>
		<tbody>
			<tr target="sid" rel="1">
				<td>张三</td>
				<td>面试未到</td>
				<td>***-***-****</td>
				<td>研究生</td>
				<td>否</td>
				<td>无</td>
				<td>CET-6</td>
				<td>无</td>
				<td>三星</td>
				<td>产品经理</td>
				<td>杭州总部</td>
				<td>教研部</td>
				<td><a class="oplink" href="app/hrm.do?action=hrmPageJobDetail&id=1" target="dialog" title="查看简历" width="900" height="500">查看简历</a></td>
				<td><a class="oplink" href="app/hrm.do?action=hrmPageJobDetail&id=1" target="ajaxTodo" title="确定要删除吗?" callback="hello">删除</a></td>
			</tr>
			<tr target="sid" rel="1">
				<td>张三</td>
				<td>面试未到</td>
				<td>***-***-****</td>
				<td>研究生</td>
				<td>否</td>
				<td>无</td>
				<td>CET-6</td>
				<td>无</td>
				<td>三星</td>
				<td>产品经理</td>
				<td>杭州总部</td>
				<td>教研部</td>
				<td><a class="oplink" href="app/hrm.do?action=hrmPageJobDetail&id=1" target="dialog" title="查看简历" width="900" height="500">查看简历</a></td>
				<td><a class="oplink" href="app/hrm.do?action=hrmPageJobDetail&id=1" target="ajaxTodo" title="确定要删除吗?" callback="hello">删除</a></td>
			</tr>
			<tr target="sid" rel="1">
				<td>张三</td>
				<td>面试未到</td>
				<td>***-***-****</td>
				<td>研究生</td>
				<td>否</td>
				<td>无</td>
				<td>CET-6</td>
				<td>无</td>
				<td>三星</td>
				<td>产品经理</td>
				<td>杭州总部</td>
				<td>教研部</td>
				<td><a class="oplink" href="app/hrm.do?action=hrmPageJobDetail&id=1" target="dialog" title="查看简历" width="900" height="500">查看简历</a></td>
				<td><a class="oplink" href="app/hrm.do?action=hrmPageJobDetail&id=1" target="ajaxTodo" title="确定要删除吗?" callback="hello">删除</a></td>
			</tr>
			<tr target="sid" rel="1">
				<td>张三</td>
				<td>面试未到</td>
				<td>***-***-****</td>
				<td>研究生</td>
				<td>否</td>
				<td>无</td>
				<td>CET-6</td>
				<td>无</td>
				<td>三星</td>
				<td>产品经理</td>
				<td>杭州总部</td>
				<td>教研部</td>
				<td><a class="oplink" href="app/hrm.do?action=hrmPageJobDetail&id=1" target="dialog" title="查看简历" width="900" height="500">查看简历</a></td>
				<td><a class="oplink" href="app/hrm.do?action=hrmPageJobDetail&id=1" target="ajaxTodo" title="确定要删除吗?" callback="hello">删除</a></td>
			</tr>
			<tr target="sid" rel="1">
				<td>张三</td>
				<td>面试未到</td>
				<td>***-***-****</td>
				<td>研究生</td>
				<td>否</td>
				<td>无</td>
				<td>CET-6</td>
				<td>无</td>
				<td>三星</td>
				<td>产品经理</td>
				<td>杭州总部</td>
				<td>教研部</td>
				<td><a class="oplink" href="app/hrm.do?action=hrmPageJobDetail&id=1" target="dialog" title="查看简历" width="900" height="500">查看简历</a></td>
				<td><a class="oplink" href="app/hrm.do?action=hrmPageJobDetail&id=1" target="ajaxTodo" title="确定要删除吗?" callback="hello">删除</a></td>
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
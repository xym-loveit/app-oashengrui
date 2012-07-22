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
<script type="text/javascript">
	function typeChange() {
		//$("#ajaxBox").loadUrl("app/system/dictionary.do?action=actionLoadDictionaryListPage&type="+$("#type").val(),{},function(){});
		$("#load").attr("action","app/system/dictionary.do?action=actionDictionaryPage&type="+$("#type").val());
		$("#load").submit();
	}
	
	function ajaxDialogPost(obj){
		var url = "app/system/work/template.do?action=dialogWorkArrangePage";
		options = {fresh:true};
		$.pdialog.open(url, "sys_chPlanSet", "工作安排",options);
	}
</script>

<!-- SearchBar -->
<form id="load"  onsubmit="return navTabSearch(this);" action="" method="post">
</form>
<form id="formDinctionary" onsubmit="return navTabSearch(this);" action="app/system/dictionary.do?action=actionSaveDictionary" method="post">
	<div class="pageHeader">
		<div class="searchBar">
			<table class="searchContent">
				<tr>
					<td>
						<label>请选择设置内容：</label>
						<select class="combox" name="type" id="type" onchange="typeChange()">
							<option value="news" ${dictionary ne null && dictionary.type eq 'news' ? 'selected="selected"':''}>新闻类型设置</option>
							<option value="task" ${dictionary ne null && dictionary.type eq 'task' ? 'selected="selected"' : ''}>任务委托类型设置</option>
							<option value="docType" ${dictionary ne null && dictionary.type eq 'docType' ? 'selected="selected"' : ''}>文档类型设置</option>
							<option value="meeting" ${dictionary ne null && dictionary.type eq 'meeting' ? 'selected="selected"' : ''}>会议类型设置</option>
							<option value="teacher" ${dictionary ne null && dictionary.type eq 'teacher' ? 'selected="selected"' : ''}>教师星级设置</option>
							<option value="counselor" ${dictionary ne null && dictionary.type eq 'counselor' ? 'selected="selected"' : ''}>咨询师星级设置</option>
						</select>
					</td>
				</tr>
			</table>
		</div>
	</div>

	<!-- Body -->
	<div class="pageContent bol" style="float:left; width: 400px;">
		<div class="pageFormContent">
			<table  class="dform" width="100%">
				<tbody>
				<tr>
				<c:if test="${dictionary ne null && (dictionary.type eq null || dictionary.type == 'news') }">
					<td>请选择新闻级别:</td>
					<td><select name="level">
						<option value="公司总部新闻">公司总部新闻</option>
						<option value="分校区新闻">分校区新闻</option>
					</select>
					</td>
				</c:if>
				<c:if test="${dictionary ne null && dictionary.type == 'docType' }">
					<td>请选择文档级别:</td>
					<td><select name="level">
						<option value="公司总部文档">公司总部文档</option>
						<option value="分校区文档">分校区文档</option>
						<option value="公司部门文档">公司部门文档</option>
						<option value="校区部门文档">校区部门文档</option>
					</select>
					</td>
				</c:if>	
				<c:if test="${dictionary ne null && dictionary.type == 'meeting' }">
					<td>请选择会议级别:</td>
					<td><select name="level">
						<option value="公司级别会议">公司级别会议</option>
						<option value="校区级别会议">校区级别会议</option>	
					</select>
					</td>
				</c:if>
				</tr>
					<tr>
						<td>选项名称：</td>
						<td><input type="text" name="name" class="required-validate" /></td>
					</tr>
					<tr>
						<td>选项值：</td>
						<td><input type="text" name="value" class="required-validate" /></td>
					</tr>
					<tr>
						<td>选项说明：</td>
						<td><textarea name="extraValue"></textarea></td>
					</tr>
					<tr>
						<td>显示顺序：</td>
						<td><input type="text" name="sn" class="required-validate" /></td>
					</tr>
					<tr>
						<td></td>
						<td>
							<div class="buttonActive"><div class="buttonContent"><button type="submit">添加</button></div></div>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	<div class="pageContent bor" style="margin-left: 410px;">
		<div id="ajaxBox">
		<%@ include file="data/listDictionary.jsp" %>
		</div>
	</div>
	<input type="hidden" name="id" value="-1" />
</form>
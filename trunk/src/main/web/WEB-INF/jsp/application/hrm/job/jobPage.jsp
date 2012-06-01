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
					<td nowrap>岗位名称：</td>
					<td><input name="entry_jobName" type="text" value="" style="width:140px"/></td>
					<td nowrap>招聘校区：</td>
					<td>
						<select class="combox" name="entry_school" id="entry_school" style="width:120px">
							<option value="1">临安校区</option>
							<option value="2">柯桥校区</option>
							<option value="3">萧山校区</option>
						</select>
					</td>
					<td nowrap>招聘部门：</td>
					<td>
						<select class="combox" name="entry_dept" id="entry_dept" style="width:120px">
							<option value="1">教研部</option>
						</select>
					</td>
					<td nowrap>截止时间：</td>
					<td><input name="entry_endDate" class="date" style="width:100px"/></td>
				</tr>
				<tr>
					<td>招聘范围：</td>
					<td>
						<select class="combox" name="entry_scope" id="entry_scope" style="width:120px">
							<option value="1">内外兼招</option>
							<option value="2">外部招聘</option>
							<option value="3">内部招聘</option>
						</select>
					</td>
					<td>招聘人数：</td>
					<td><input name="entry_jobCount" type="text" value="" style="width:140px"/></td>
					<td>可见范围：</td>
					<td>
						<select class="combox" name="type" id="entry_svisible" style="width:120px">
							<option value="">所有校区</option>
							<option value="1">临安校区</option>
							<option value="2">柯桥校区</option>
							<option value="3">萧山校区</option>
						</select>
					</td>
					<td></td>
					<td></td>
				</tr>
				<tr>
					<td>工作地点：</td>
					<td colspan="5"><input name="entry_address" type="text" value="" style="width:100%"/></td>
					<td></td>
					<td></td>
				</tr>
				<tr>
					<td>工作职责：</td>
					<td colspan="5"><textarea name="entry_responsibility" rows="3" style="width:100%"></textarea></td>
					<td></td>
					<td></td>
				</tr>
				<tr>
					<td>任职要求：</td>
					<td colspan="5"><textarea name="entry_requirement" rows="3" style="width:100%"></textarea></td>
					<td></td>
					<td></td>
				</tr>
				<tr>
					<td>薪酬福利：</td>
					<td colspan="5"><textarea name="entry_salary" rows="3" style="width:100%"></textarea></td>
					<td></td>
					<td></td>
				</tr>
				<tr>
					<td>附件区：</td>
					<td colspan="4">具体材料.pdf &nbsp;<a href="javascript:void(0);"><img class="opr" src="resources/images/icons/remove.png" /></a>&nbsp;</td>
					<td colspan="3">
					<logic:present name="op">
						<logic:equal name="op" value="update">
						<a class="oplink" href="app/hrm.do?action=hrmPageJobDetail&id=1" target="dialog" title="上传附件">上传附件</a>
						</logic:equal>
					</logic:present>
					</td>
				</tr>
			</table>
		</div>
		<div class="formBar">
			<ul>
				<!--<li><a class="buttonActive" href="javascript:;"><span>保存</span></a></li>
				-->
				<logic:present name="op">
					<logic:equal name="op" value="approval">
						<li><div class="buttonActive"><div class="buttonContent"><button type="submit">通过并发布</button></div></div></li>
						<li><div class="buttonActive"><div class="buttonContent"><button type="submit">退回</button></div></div></li>
					</logic:equal>
					<logic:equal name="op" value="update">
						<li>
							<div class="buttonActive"><div class="buttonContent"><button type="submit">保存</button></div></div>
						</li>
						
					</logic:equal>
				</logic:present>
				<li>
					<div class="button"><div class="buttonContent"><button type="button" class="close">关闭</button></div></div>
				</li>
			</ul>
		</div>
	</form>
</div>
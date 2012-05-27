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
					<td>新闻标题：</td>
					<td colspan="5"><input name="sn" type="text" size="30" value="" style="width:100%"/></td>
				</tr>
				<tr>
					<td>新闻级别：</td>
					<td>
						<select class="combox" name="type" id="entry_level" style="width:150px">
							<option value="">所有</option>
							<option value="1">公司新闻</option>
							<option value="1">校区新闻</option>
						</select>
					</td>
					<td>可见校区</td>
					<td colspan="3">
						<select class="combox" name="type" id="entry_svisible" style="width:150px">
							<option value="">所有校区</option>
							<option value="1">临安校区</option>
							<option value="2">柯桥校区</option>
							<option value="3">萧山校区</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>新闻类别：</td>
					<td>
						<select class="combox" name="type" id="entry_type" style="width:150px">
							<option value="">所有</option>
							<option value="1">重要通知</option>
						</select>
					</td>
					<td>发布校区：</td>
					<td>
						<select class="combox" name="type" id="entry_spost" style="width:150px">
							<option value="">所有</option>
							<option value="">所有校区</option>
							<option value="1">临安校区</option>
							<option value="2">柯桥校区</option>
							<option value="3">萧山校区</option>
						</select>
					</td>
					<td>发布部门：</td>
					<td>
						<select class="combox" name="type" id="entry_depost" style="width:150px">
							<option value="">所有</option>
							<option value="">所有校区</option>
							<option value="1">临安校区</option>
							<option value="2">柯桥校区</option>
							<option value="3">萧山校区</option>
						</select>
					</td>
				</tr>
				<tr>
					<td style="vertical-align:top">新闻内容：</td>
					<td colspan="5"><textarea class="editor" name="description" rows="15" cols="80">内容</textarea></td>
				</tr>
			</table>
		</div>
		<div class="formBar">
			<ul>
				<!--<li><a class="buttonActive" href="javascript:;"><span>保存</span></a></li>-->
				<logic:present name="op">
					<logic:equal name="op" value="approval">
						<li><div class="buttonActive"><div class="buttonContent"><button type="submit">通过</button></div></div></li>
						<li><div class="buttonActive"><div class="buttonContent"><button type="submit">退回</button></div></div></li>
					</logic:equal>
				</logic:present>
				<logic:notPresent name="op">
					<li><div class="buttonActive"><div class="buttonContent"><button type="submit">提交审核</button></div></div></li>
					<li><div class="buttonActive"><div class="buttonContent"><button type="submit">保存草稿</button></div></div></li>
				</logic:notPresent>
				<li>
					<div class="button"><div class="buttonContent"><button type="button" class="close">取消</button></div></div>
				</li>
			</ul>
		</div>
	</form>
</div>
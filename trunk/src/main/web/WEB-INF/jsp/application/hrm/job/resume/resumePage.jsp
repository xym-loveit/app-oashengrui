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
					<td nowrap>姓名：</td>
					<td><input name="name" type="text" value="" style="width:140px"/></td>
					<td nowrap>性别：</td>
					<td>
						<select class="combox" name="gender" style="width:20px">
							<option value="1">男</option>
							<option value="2">女</option>
						</select>
					</td>
					<td nowrap>籍贯：</td>
					<td><input name="birthplace" type="text" value="" style="width:120px"/></td>
					<td nowrap>政治面貌：</td>
					<td>
						<select class="combox" name="zzmm"  style="width:120px">
							<option value="1">党员</option>
							<option value="2">团员</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>出生日期：</td>
					<td><input name="birthdate" class="date" style="width:140px"/></td>
					<td>联系电话：</td>
					<td colspan="3"><input name="telephone" type="text" style="width:230px"/></td>
					<td>婚姻状况：</td>
					<td>
						<select class="combox" name="marriage" style="width:120px">
							<option value="1">已婚</option>
							<option value="2">未婚</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>身份证号：</td>
					<td colspan="3"><input name="idcard" type="text" value="" style="width:100%"/></td>
					<td></td>
					<td></td>
				</tr>
				<tr>
					<td>居住地址：</td>
					<td colspan="3"><input name="address" type="text" value="" style="width:100%"/></td>
					<td></td>
					<td></td>
				</tr>
				<tr>
					<td>电子邮箱：</td>
					<td colspan="3"><input name="email" type="text" value="" style="width:100%"/></td>
					<td></td>
					<td></td>
				</tr>
				<tr>
					<td>毕业院校：</td>
					<td><input name="graduateSchool" type="text" style="width:100px"/></td>
					<td colspan="2">专业：</td>
					<td colspan="2"><input name="learnClass" type="text" style="width:140px"/></td>
					<td>学历：</td>
					<td>
						<select class="combox" name="education" style="width:120px">
							<option value="1">研究生</option>
							<option value="2">本科生</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>师范专业：</td>
					<td>
						<select class="combox" name="teacherClass" style="width:120px">
							<option value="1">是</option>
							<option value="2">否</option>
						</select>
					</td>
					<td colspan="2">教师资格证：</td>
					<td colspan="2">
						<select class="combox" name="teacher" style="width:120px">
							<option value="1">有</option>
							<option value="2">无</option>
						</select>
					</td>
					<td></td>
					<td></td>
				</tr>
				<tr>
					<td>外语等级：</td>
					<td>
						<select class="combox" name="englishLevel" style="width:120px">
							<option value="1">CET-6</option>
							<option value="2">CET-4</option>
						</select>
					</td>
					<td colspan="2">普通话等级：</td>
					<td colspan="2">
						<select class="combox" name="speakClass" style="width:120px">
							<option value="1">一级甲等</option>
							<option value="2">二级甲等</option>
						</select>
					</td>
					<td></td>
					<td></td>
				</tr>
				<tr>
					<td>简历附件：</td>
					<td colspan="6">张思.pdf &nbsp;<a href="javascript:void(0);"><img class="opr" src="resources/images/icons/remove.png" /></a>&nbsp;</td>
					<td>
					<logic:present name="op">
						<logic:equal name="op" value="update">
						<a class="oplink" href="app/hrm.do?action=hrmPageJobDetail&id=1" target="dialog" title="上传简历">上传简历</a>
						</logic:equal>
					</logic:present>
					</td>
				</tr>
			</table>
		</div>
		<div class="formBar">
			<ul>
				<logic:present name="op">
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
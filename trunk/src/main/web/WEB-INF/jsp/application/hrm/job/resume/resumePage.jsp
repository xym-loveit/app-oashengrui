<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="pageContent">
	<form method="post" action="app/hrm/hire/resume.do?action=actionJobApply" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);">
		<div class="pageFormContent" layoutH="56">
			<table cellspacing="15" cellpadding="10" style="border-spacing:15">
				<tr>
					<td nowrap style="width: 80px;" align="right">姓名：</td>
					<td><input name="fullName" type="text" value="${resume ne null ? resume.fullName : ''}" ${op ne null && op eq 'view' ? 'readonly' : ''} style="width: 100%" class="required"/></td>
					<td nowrap align="right">籍贯：</td>
					<td><input name="bornPlace" type="text" value="${resume ne null ? resume.bornPlace : ''}" ${op ne null && op eq 'view' ? 'readonly' : ''} style="width: 100%"/></td>
					<td nowrap align="right">性别：</td>
					<td>
						<select class="combox" name="sex" style="">
							<option value="1" ${resume ne null && resume.sex eq 1 ? 'selected="selected"' : ''}>男</option>
							<option value="2" ${resume ne null && resume.sex eq 2 ? 'selected="selected"' : ''}>女</option>
						</select>
					</td>
					<td nowrap align="right">政治面貌：</td>
					<td>
						<select class="combox" name="party"  style="">
							<option value="1" ${resume ne null && resume.party eq 1 ? 'selected="selected"' : ''}>群众</option>
							<option value="2" ${resume ne null && resume.party eq 2 ? 'selected="selected"' : ''}>党员</option>
							<option value="3" ${resume ne null && resume.party eq 3 ? 'selected="selected"' : ''}>团员</option>
						</select>
					</td>
				</tr>
				<tr>
					<td align="right">出生日期：</td>
					<td><input name="birthday" class="date textInput" yearstart="-80" yearend="0" style="width: 100%" value="${resume ne null ? resume.birthday : ''}" ${op ne null && op eq 'view' ? 'readonly' : ''}/></td>
					<td align="right">联系电话：</td>
					<td colspan="3"><input class="required" name="mobilePhone" type="text" style="width: 100%" value="${resume ne null ? resume.mobilePhone : ''}" ${op ne null && op eq 'view' ? 'readonly' : ''}/></td>
					<td align="right">婚姻状况：</td>
					<td>
						<select class="combox" name="marriage" style="">
							<option value="1" ${resume ne null && resume.marriage eq 1 ? 'selected="selected"' : ''}>未婚</option>
							<option value="2" ${resume ne null && resume.marriage eq 2 ? 'selected="selected"' : ''}>已婚</option>
						</select>
					</td>
				</tr>
				<tr>
					<td align="right">身份证号：</td>
					<td colspan="5"><input name="identityNo" type="text"  style="width: 100%" value="${resume ne null ? resume.identityNo : ''}" ${op ne null && op eq 'view' ? 'readonly' : ''}/></td>
					<td></td>
					<td></td>
				</tr>
				<tr>
					<td align="right">居住地址：</td>
					<td colspan="5"><input name="address" type="text"  style="width: 100%" value="${resume ne null ? resume.address : ''}" ${op ne null && op eq 'view' ? 'readonly' : ''}/></td>
					<td></td>
					<td></td>
				</tr>
				<tr>
					<td align="right">电子邮箱：</td>
					<td colspan="5"><input name="email" type="text"  style="width: 100%" value="${resume ne null ? resume.email : ''}" ${op ne null && op eq 'view' ? 'readonly' : ''}/></td>
					<td></td>
					<td></td>
				</tr>
				<tr>
					<td align="right">毕业院校：</td>
					<td><input name="educationCollege" type="text" style="width: 100%" value="${resume ne null ? resume.educationCollege : ''}" ${op ne null && op eq 'view' ? 'readonly' : ''}/></td>
					<td align="right">专业：</td>
					<td><input name="educationMajority" type="text" style="width:140px" value="${resume ne null ? resume.educationMajority : ''}" ${op ne null && op eq 'view' ? 'readonly' : ''}/></td>
					<td align="right">学历：</td>
					<td>
						<select class="combox" name="educationDegree" style="">
							<option value="1" ${resume ne null && resume.educationDegree eq 1 ? 'selected="selected"' : ''}>研究生</option>
							<option value="2" ${resume ne null && resume.educationDegree eq 2 ? 'selected="selected"' : ''}>本科生</option>
							<option value="3" ${resume ne null && resume.educationDegree eq 3 ? 'selected="selected"' : ''}>大专</option>
							<option value="4" ${resume ne null && resume.educationDegree eq 4 ? 'selected="selected"' : ''}>其他</option>
						</select>
					</td>
				</tr>
				<tr>
					<td align="right">师范专业：</td>
					<td>
						<select class="combox" name="teacherMajority" style="">
							<option value="1" ${resume ne null && resume.teacherMajority eq 1 ? 'selected="selected"' : ''}>是</option>
							<option value="2" ${resume ne null && resume.teacherMajority eq 2 ? 'selected="selected"' : ''}>否</option>
						</select>
					</td>
					<td style="width: 80px" align="right">教师资格：</td>
					<td>
						<select class="combox" name="teacherCertifaciton" style="">
							<option value="1" ${resume ne null && resume.teacherCertifaciton eq 1 ? 'selected="selected"' : ''}>有</option>
							<option value="2" ${resume ne null && resume.teacherCertifaciton eq 2 ? 'selected="selected"' : ''}>无</option>
						</select>
					</td>
					<td></td>
					<td></td>
				</tr>
				<tr>
					<td align="right">外语等级：</td>
					<td>
						<select class="combox" name="englishLevel" style="">
							<option value="1" ${resume ne null && resume.englishLevel eq 1 ? 'selected="selected"' : ''}>CET-4</option>
							<option value="2" ${resume ne null && resume.englishLevel eq 2 ? 'selected="selected"' : ''}>CET-6</option>
							<option value="3" ${resume ne null && resume.englishLevel eq 3 ? 'selected="selected"' : ''}>专业四级</option>
							<option value="4" ${resume ne null && resume.englishLevel eq 4 ? 'selected="selected"' : ''}>专业八级</option>
							<option value="5" ${resume ne null && resume.englishLevel eq 5 ? 'selected="selected"' : ''}>其他</option>
						</select>
					</td>
					<td align="right">普通话等级：</td>
					<td>
						<select class="combox" name="chineseLevel" style="">
							<option value="1" ${resume ne null && resume.chineseLevel eq 1 ? 'selected="selected"' : ''}>一级甲等</option>
							<option value="2" ${resume ne null && resume.chineseLevel eq 2 ? 'selected="selected"' : ''}>一级乙等</option>
							<option value="3" ${resume ne null && resume.chineseLevel eq 3 ? 'selected="selected"' : ''}>二级甲等</option>
							<option value="4" ${resume ne null && resume.chineseLevel eq 4 ? 'selected="selected"' : ''}>二级乙等</option>
							<option value="5" ${resume ne null && resume.chineseLevel eq 5 ? 'selected="selected"' : ''}>三级甲等</option>
							<option value="6" ${resume ne null && resume.chineseLevel eq 6 ? 'selected="selected"' : ''}>三级乙等</option>
							<option value="7" ${resume ne null && resume.chineseLevel eq 7 ? 'selected="selected"' : ''}>无</option>
						</select>
					</td>
					<td></td>
					<td></td>
				</tr>
				<tr>
					<td align="right">简历附件：</td>
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
				<c:if test="${op eq null || op ne 'view'}">
					<li>
						<div class="buttonActive"><div class="buttonContent"><button type="submit">保存</button></div></div>
					</li>
				</c:if>
				<li>
					<div class="button"><div class="buttonContent"><button type="button" class="close">关闭</button></div></div>
				</li>
			</ul>
		</div>
		<input type="hidden" name="source" value="${source ne null ? source : '0'}" />
		<input type="hidden" name="jobId" value="${jobId ne null ? jobId : '0'}" />
	</form>
</div>
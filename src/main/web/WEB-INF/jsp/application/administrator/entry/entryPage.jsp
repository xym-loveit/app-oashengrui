<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="pageContent">
	<form method="post" action="app/admin/news.do?action=actionNewsEditOrSave" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);">
		<div class="pageFormContent" layoutH="56">
			<table cellspacing="10" cellpadding="10" style="border-spacing:12">
				<tr>
					<td>新闻标题：</td>
					<td colspan="5"><input name="newsSubject" type="text" size="30" value="${news.newsSubject}" style="width:100%"/></td>
				</tr>
				<tr>
					<td>新闻级别：</td>
					<td>
						<select class="combox" name="newsLevel" id="entry_level" style="width:150px">
							<option value="">所有</option>
							<option value="0" ${news ne null && news.newsLevel eq 0 ? 'selected="selected"' : '' }>公司新闻</option>
							<option value="1" ${news ne null && news.newsLevel eq 1 ? 'selected="selected"' : '' }>校区新闻</option>
						</select>
					</td>
					<td>可见校区：</td>
					<td>
						<c:choose>
							<c:when test="${op eq null && op ne 'view'}">
								<select class="combox" name="districtVisible" id="combox_VisibleDistrict" style="width:120px" ref="combox_dept" refUrl="app/hrm/hire.do?action=actionLoadDepartmentByOrg&districtId={value}">
									<option value="-1">所有校区</option>
									<logic:present name="districts">
										<logic:iterate name="districts" id="district">
											<option value="${district.id}" ${news ne null && news.districtVisible ne null && news.districtVisible eq district.id? 'selected="selected"' : ''}>${district.districtName}</option>
										</logic:iterate>
									</logic:present>
								</select>
							</c:when>
						</c:choose>
					</td>
				</tr>
				<tr>
					<td>新闻类别：</td>
					<td>
						<select class="combox" name="typeDicid" id="news_type1" style="width:150px">
							<option value="">所有</option>
						  	<logic:present name="newsTypes">
								<logic:iterate name="newsTypes" id="newsType">
									<option value="${newsType.id}" ${news ne null && news.dictionary.id eq newsType.id? 'selected="selected"' : ''}>${newsType.name}</option>
								</logic:iterate>
							</logic:present>
						</select>
					</td>
					<td>发布校区：</td>
					<td>
						<c:choose>
							<c:when test="${op eq null && op ne 'view'}">
								<select class="combox" name="districtPost" id="combox_publishDistrict" style="width:120px" ref="combox_dept" refUrl="app/hrm/hire.do?action=actionLoadDepartmentByOrg&districtId={value}">
									<option value="-1">所有校区</option>
									<logic:present name="districts">
										<logic:iterate name="districts" id="districtPublic">
											<option value="${districtPublic.id}" ${news ne null && news.district.id eq districtPublic.id ? 'selected="selected"' : ''}>${districtPublic.districtName}</option>
										</logic:iterate>
									</logic:present>
								</select>
							</c:when>
						</c:choose>
					</td>
					<td>发布部门：</td>
					<td>
						<c:choose>
							<c:when test="${op eq null && op ne 'view'}">
								<select class="combox" name="depPost" id="combox_department1" style="width:120px" ref="combox_dept" refUrl="app/hrm/hire.do?action=actionLoadDepartmentByOrg&districtId={value}">
									<option value="-1">所有部门</option>
									<logic:present name="departments">
										<logic:iterate name="departments" id="department">
											<option value="${department.id}" ${news ne null && news.department ne null && news.department.id eq department.id ?'selected="selected"' : ''}>${department.depName}</option>
										</logic:iterate>
									</logic:present>
								</select>
							</c:when>
						</c:choose>	
					</td>
				</tr>
				<tr>
					<td style="vertical-align:top">新闻内容：</td>
					<td colspan="5"><textarea class="editor" name="newsContent" rows="15" cols="80">内容</textarea></td>
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
		<c:if test="${news ne null}">
			<input type="hidden" id="formAction" name="formAction" value="" />
		</c:if>
		<input type="hidden" name="id" value="${news ne null ? news.id : '-1'}" />
	</form>
</div>
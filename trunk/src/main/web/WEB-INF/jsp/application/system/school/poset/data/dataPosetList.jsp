<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/tags/trymore" prefix="tm"%>

<table class="table" width="100%" layoutH="142">
	<thead>
		<tr>
			<th align="center">序号</th>
			<th align="center">职位名称</th>
			<th align="center">岗位名称</th>
			<th align="center">配置</th>
			<th align="center">删除</th>
		</tr>
	</thead>
	<tbody>
		<logic:present name="dataList">
			<logic:iterate name="dataList" property="items" id="entity" indexId="idx">
				<tr id="dposet-${entity.id}">
					<td>${idx+1}</td>
					<td>${entity.posetName}</td>
					<td>
						<logic:present name="entity" property="positions">
							<logic:iterate name="entity" property="positions" id="pos">
								${pos.positionName} (${pos.department.depOrgType eq 0 ? '总部' : (pos.department.depOrgType eq 1 ? '校区' : '片区')}${pos.department.depName})&nbsp;
							</logic:iterate>
						</logic:present>
					</td>
					<td>
						<c:choose>
							<c:when test="${tm:ifGranted('_FUNCKEY_SYSTEM_SCHOOL_POSET_EDIT')}">
								<a href="app/system/school/poset.do?action=dialogSchoolPosetPage&posetId=${entity.id}" target="dialog" title="职位编辑" class="oplink" width="550" height="322" rel="sysmgr_posetedit_${idx}">编辑</a>
							</c:when>
							<c:otherwise><label class="opdisabled" title="您没有权限进行该操作">---</label></c:otherwise>
						</c:choose>
					</td>
					<td>
						<c:choose>
							<c:when test="${tm:ifGranted('_FUNCKEY_SYSTEM_SCHOOL_POSET_REMOVE')}">
								<a href="app/system/school/poset.do?action=actionRemovePoset&posetId=${entity.id}" target="ajaxTodo" title="确定删除该职位吗？" class="oplink" callback="callback_posetRemove(${entity.id})">删除</a>
							</c:when>
							<c:otherwise><label class="opdisabled" title="您没有权限进行该操作">---</label></c:otherwise>
						</c:choose>
					</td>
				</tr>
			</logic:iterate>
		</logic:present>
	</tbody>
</table>
		
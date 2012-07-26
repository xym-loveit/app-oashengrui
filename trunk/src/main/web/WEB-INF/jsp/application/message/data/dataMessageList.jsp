<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix='fmt'%>

<style>
	a.oplink {line-height: 21px;}
</style>

<table class="table" width="100%" layoutH="75">
	<thead>
		<tr>
			<th align="center">发送人</th>
			<th align="center">发送标题</th>
			<th align="center">发送时间</th>
			<th align="center">阅读标志</th>
			<th align="center">操作</th>
		</tr>
	</thead>
	<tbody>
		<logic:present name="dataList">
			<logic:iterate name="dataList" property="items" id="entity">
				<tr>
					<td>${entity.shortMessage.sender}</td>
					<td>${entity.shortMessage.subject}</td>
					<td><fmt:formatDate value="${entity.shortMessage.sendTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
					<td></td>
					<td>阅读</td>
				</tr>
			</logic:iterate>
		</logic:present>
	</tbody>
</table>
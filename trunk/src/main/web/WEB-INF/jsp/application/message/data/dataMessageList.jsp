<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix='fmt'%>

<style>a.oplink {line-height: 21px;}</style>
<script>
	function msg_reload(){
		navTab.reload();
	}
</script>

<table class="table" width="100%" layoutH="138">
	<thead>
		<tr>
			<th align="center">序号</th>
			<c:if test="${mailSent eq null}">
			<th align="center">类型</th>
			<th align="center">发送人</th>
			</c:if>
			<th align="center">发送标题</th>
			<th align="center">发送时间</th>
			<c:if test="${mailSent eq null}"><th align="center">状态</th></c:if>
			<th align="center">操作</th>
		</tr>
	</thead>
	<tbody>
		<logic:present name="dataList">
			<c:choose>
				<c:when test="${mailSent eq null}">
					<logic:iterate name="dataList" property="items" id="entity" indexId="idx">
						<tr>
							<td>${idx+1}</td>
							<td style="color:#008000">
								<c:choose>
									<c:when test="${entity.shortMessage.msgType eq 1}">个人信息</c:when>
									<c:when test="${entity.shortMessage.msgType eq 2}">系统消息</c:when>
									<c:otherwise>未知</c:otherwise>
								</c:choose>
							</td>
							<td>${entity.shortMessage.sender}</td>
							<td style="text-align:left">${entity.shortMessage.subject}</td>
							<td><fmt:formatDate value="${entity.shortMessage.sendTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
							<td><img style="padding:3px;" src="resources/images/icons/${entity.readFlag eq 1 ? 'email_open.png' : 'email.png'}" /></td>
							<td>
								<a target="dialog" href="app/message.do?action=dialogMessagePage&msgId=${entity.shortMessage.id}&msgInId=${entity.id}" width="640" height="380" title="查看消息" rel="msg_read_${entity.id}"><img src="resources/images/icons/update.gif" style="padding: 3px;"/></a>&nbsp;
								<a href="app/message.do?action=actionRemoveShortMessage&msgInId=${entity.id}" target="ajaxTodo" title="确定要删除`${entity.shortMessage.subject}`消息吗?" callback="msg_reload()"><img src="resources/images/icons/remove.png" style="padding: 3px;"/></a>
							</td>
						</tr>
					</logic:iterate>
				</c:when>
				<c:otherwise>
					<logic:iterate name="dataList" property="items" id="entity" indexId="idx">
						<tr>
							<td>${idx+1}</td>
							<td>${entity.subject}</td>
							<td><fmt:formatDate value="${entity.sendTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
							<td>
								<a target="dialog" width="640" height="380" href="app/message.do?action=dialogMessagePage&msgId=${entity.id}" title="查看消息" rel="msg_read_${entity.id}"><img src="resources/images/icons/update.gif" style="padding: 3px;"/></a></td>
						</tr>
					</logic:iterate>
				</c:otherwise>
			</c:choose>
		</logic:present>
	</tbody>
</table>
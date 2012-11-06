<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>

<form id="pagerForm" method="post" action="app/message.do?action=pageMessageReceivedIndex">
	<input type="hidden" name="pageNum" value="${pagingBean ne null ? pagingBean.currentPage : 1}" />
	<input type="hidden" name="numPerPage" value="${pagingBean ne null ? pagingBean.pageSize : 20}" />
</form>

<!-- SearchBar -->
<div class="pageHeader">
	<form onsubmit="return navTabSearch(this);" action="app/message.do?action=pageMessageReceivedIndex" method="post" id="searchForm" rel="pagerForm">
		<div class="searchBar">
			<table class="searchContent">
				<tr>
					<td>
						<label>发送人：</label>
						<input type="text" name="sender" value="${formEntity ne null ? formEntity.sender : ''}"/>
					</td>
					<td>
						<label>类型：</label>
						<select class="combox" name="msgType">
							<option value="-1">所有</option>
							<option value="1" ${formEntity ne null && formEntity.msgType eq 1 ? 'selected="selected"' : ''}>个人信息</option>
							<option value="2" ${formEntity ne null && formEntity.msgType eq 2 ? 'selected="selected"' : ''}>系统消息</option>
						</select>
					</td>
					<td>
						<label>状态：</label>
						<select class="combox" name="readFlag">
							<option value="-1">所有</option>
							<option value="1" ${readFlag ne null && readFlag eq 1 ? 'selected="selected"' : ''}>已阅读</option>
							<option value="0" ${readFlag ne null && readFlag eq 0 ? 'selected="selected"' : ''}>未阅读</option>
						</select>
					</td>
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
	<div class="panelBar">
		<ul class="toolBar">
			<li><a treeicon="icon-msgwrite" class="icon" href="app/message.do?action=dialogMessagePage" target="dialog" title="发送信息" width="880" height="400" rel="dia_my_taskadd"><span class="icon-msgwrite">发送短消息</span></a></li>
			<li class="line">line</li>
			<li><a treeicon="icon-msgsent" class="icon" href="app/message.do?action=pageMessageSentIndex" target="navTab" rel="nav_msg"><span class="icon-msgsent">已发信息</span></a></li>
			<li class="line">line</li>
			<li><a treeicon="icon-msgrecv" class="icon" href="app/message.do?action=pageMessageReceivedIndex" target="navTab" rel="nav_msg"><span class="icon-msgrecv">已收信息</span></a></li>
		</ul>
	</div>
	
	<%@ include file="data/dataMessageList.jsp" %>
	
	<!-- Pagination -->
	<div class="panelBar">
		<div class="pages">
			<span>显示</span>
			<select class="combox" name="numPerPage" onchange="navTabPageBreak({numPerPage:this.value})">
				<option value="20" ${pagingBean ne null && pagingBean.pageSize eq 20 ? 'selected="selected"' : ''}>20</option>
				<option value="50" ${pagingBean ne null && pagingBean.pageSize eq 50 ? 'selected="selected"' : ''}>50</option>
				<option value="100" ${pagingBean ne null && pagingBean.pageSize eq 100 ? 'selected="selected"' : ''}>100</option>
				<option value="200" ${pagingBean ne null && pagingBean.pageSize eq 200 ? 'selected="selected"' : ''}>200</option>
			</select>
			<span>条，共${pagingBean ne null ? pagingBean.totalItems : 0}条</span>
		</div>
		
		<div class="pagination" targetType="navTab" totalCount="${pagingBean ne null ? pagingBean.totalItems : 0}" numPerPage="${pagingBean ne null ? pagingBean.pageSize : 20}" pageNumShown="${pagingBean ne null ? pagingBean.pageNumShown : 10}" currentPage="${pagingBean ne null ? pagingBean.currentPage : 1}"></div>

	</div>
		
</div>
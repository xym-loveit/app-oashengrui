<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix='fmt'%>
<%@ taglib uri="/tags/trymore" prefix="tm"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<style>
	label {width: auto;}
	.opr {margin: 3px 2px;}
	.dispose {text-decoration: line-through; color: red;}
	.opdisabled {text-decoration: line-through; color: #DDD; line-height: 21px;}
</style>

<script type="text/javascript">
function callback_funcRemove() {
	$('#conferenceSearchForm').submit();
}
</script>

<form id="pagerForm" method="post" action="app/personal/conference.do?action=myConferenceIndex">
	<input type="hidden" name="pageNum" value="${pagingBean ne null ? pagingBean.currentPage : 1}" />
	<input type="hidden" name="numPerPage" value="${pagingBean ne null ? pagingBean.pageSize : 20}" />
</form>

<!-- SearchBar -->
<div class="pageHeader">
	<form onsubmit="return navTabSearch(this);" action="app/personal/conference.do?action=myConferences" method="post" id="conferenceSearchForm" rel="pagerForm">
		<div class="searchBar">
			<table class="searchContent">
				<tr>
					<td>
						<label>会议类型：</label>
						<select class="combox" name="type.id" id="combox_conference_type" style="width:120px">
							<option value="-1">所有</option>
							<logic:present name="conferenceType">
								<logic:iterate name="conferenceType" id="type_item">
									<option value="${type_item.id}" ${conferenceForm ne null && conferenceForm.type ne null && conferenceForm.type.id eq type_item.id ? 'selected="selected"' : ''}>${type_item.name}</option>
								</logic:iterate>
							</logic:present>
						</select>
					</td>
					<td>
						<label>会议状态：</label>
						<select class="combox" name="status" id="entry_status">
							<option value="">所有</option>
							<option value="1" ${conferenceForm ne null && conferenceForm.status eq 1 ? 'selected="selected"' : ''}>已发起</option>
							<option value="2" ${conferenceForm ne null && conferenceForm.status eq 0 ? 'selected="selected"' : ''}>已结束</option>
							<option value="3" ${conferenceForm ne null && conferenceForm.status eq 0 ? 'selected="selected"' : ''}>已取消</option>
						</select>
					</td>
					<td>
						会议名称：<input type="text"  name="conferenceName" value="${conferenceForm ne null ? conferenceForm.conferenceName : ''}"/>
					</td>
					<td>
						开会日期：<input type="text" name="startDay" class="date" value="${conferenceForm ne null ? conferenceForm.startDay:'' }" /> - <input type="text" name="endDay" class="date" value="${conferenceForm ne null ? conferenceForm.endDay:'' }" />
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
		<c:if test="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.functionRights eq '__ALL' || tm:inRange(sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.functionRights, '_FUNCKEY_JOBAPPROVAL_SUBNODE', ',') || tm:inRange(sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.functionRights, '_FUNCKEY_JOBAPPROVAL_ROOT', ',')}">
			<ul class="toolBar" style="float:right">
				<c:if test="${noSummary ne null && noSummary ne 0 }"><li><span>你有${noSummary }个发起的会议需要总结，请点击下表总结链接进行总结</span></li></c:if>
				<li><a treeicon="icon-edit" class="icon" href="app/personal/conference.do?action=myConferenceIndex" target="navTab" rel="myconference"><span class="icon-edit">返回我参加的会议</span></a></li>
			</ul>
		</c:if>
		<ul class="toolBar">
			<li><a class="add" href="app/personal/conference.do?action=conferenceDetail" target="dialog" title="发起会议" width="960" height="420" rel="dia_hr_entryadd"><span>会议发起</span></a></li>
			<li class="line">line</li>
		</ul>
	</div>
	<table class="table" width="100%" layoutH="138">
		<thead>
			<tr>
				<th align="center">会议类型</th>
				<th align="center">会议名称</th>
				<th align="center">开始时间</th>
				<th align="center">结束时间</th>
				<th align="center">状态</th>
				<th align="center">离会议时间</th>
				<th align="center">发起人</th>
				<th align="center">联系人</th>
				<th align="center">联系电话</th>
				<th align="center">详细</th>
				<th align="center">调整</th>
				<th align="center">取消</th>
				<th align="center">总结</th>
			</tr>
		</thead>
		<tbody>
			<logic:present name="conferences">
				<logic:iterate name="conferences" property="items" id="entity">
					<tr target="sid" rel="${entity.id}"  id="conferencerow-${entity.id}">
						<td>${entity.type.name}</td>
						<td>${entity.conferenceName}</td>
						<td><fmt:formatDate value="${entity.startDay}" type="date" pattern="yyyy-MM-dd"/> ${entity.startHour }:${entity.startMinute }</td>
						<td><fmt:formatDate value="${entity.endDay}" type="date" pattern="yyyy-MM-dd"/> ${entity.endHour }:${entity.endMinute }</td>
						<td><c:if test = "${entity.status == '1'}">已发起</c:if><c:if test = "${entity.status == '2'}">已结束</c:if><c:if test = "${entity.status == '3'}">已取消</c:if></td>
						<td>${entity.result ne null ? entity.result : ''}</td>
						<td>${entity.sponsor.fullName }</td>
						<td>${entity.contactor}</td>
						<td>${entity.phone }</td>
						<td>
							<a class="oplink" href="app/personal/conference.do?action=conferenceDetail&id=${entity.id}&op=view" target="dialog" title="会议详细" width="960" height="420">详细</a></td>
						<td>
							<c:choose>
								<c:when test="${entity.status eq 1}">
									<a class="oplink" href="app/personal/conference.do?action=conferenceDetail&id=${entity.id}&op=edit" target="dialog" title="调整会议" width="960" height="420">调整</a>
								</c:when>
								<c:otherwise>
									<label class="opdisabled">调整</label>
								</c:otherwise>
							</c:choose>
						</td>
						<td>
							<c:choose>
								<c:when test="${entity.status eq 1}">
									<a class="oplink" href="app/personal/conference.do?action=actionCancelConference&id=${entity.id}" target="ajaxTodo" title="取消会议" width="960" height="420" callback="callback_funcRemove()">取消</a>
								</c:when>
								<c:when test="${entity.status eq 3}">
									<a class="oplink" href="app/personal/conference.do?action=actionActivateConference&id=${entity.id}" target="ajaxTodo" title="激活会议" width="960" height="420" callback="callback_funcRemove()">激活</a>
								</c:when>
								<c:otherwise>
									<label class="opdisabled">取消</label>
								</c:otherwise>
							</c:choose>
						</td>
						<td>
							<c:choose>
								<c:when test="${entity.summary eq null || entity.summary eq '' }">
									<c:choose>
										<c:when test="${entity.status ne 3 }">
											<a class="oplink" href="app/personal/conference.do?action=actionLoadActivateDialog&id=${entity.id}" target="dialog" title="会议总结" width="800" height="350"><font color="red">总结</font></a>
										</c:when>
									</c:choose>
								</c:when>
								<c:otherwise>
									<label class="opdisabled">总结</label>
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
				</logic:iterate>
			</logic:present>
		</tbody>
	</table>
	
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

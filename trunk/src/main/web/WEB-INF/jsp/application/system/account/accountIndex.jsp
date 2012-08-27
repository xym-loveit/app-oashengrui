<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix='fmt'%>
<%@ taglib uri="/tags/trymore" prefix="tm"%>

<script type="text/javascript">
	function callback_roleRemove(id) {
		if ($("#drole-" + id).size() > 0) {
			$("#drole-" + id).fadeOut("slow");
		}
	}
</script>

<form id="pagerForm" method="post" action="app/system/account.do?action=pageAccountIndex">
	<input type="hidden" name="pageNum" value="${pagingBean ne null ? pagingBean.currentPage : 1}" />
	<input type="hidden" name="numPerPage" value="${pagingBean ne null ? pagingBean.pageSize : 20}" />
</form>

<!-- SearchBar -->
<div class="pageHeader">
	<form onsubmit="return navTabSearch(this);" action="app/system/account.do?action=pageAccountIndex" method="post" id="searchForm" rel="pagerForm">
		<div class="searchBar">
			<table class="searchContent">
				<tr>
					<td>
						<label>用户账号：</label>
						<input type="text" name="username" rel="pagerForm" value="${userForm ne null ? userForm.username : ''}" />
					</td>
					<td>
						<label>用户姓名：</label>
						<input type="text" name="fullName" rel="pagerForm" value="${userForm ne null ? userForm.fullName : ''}" />
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
	<!--
	<div class="panelBar">
		<ul class="toolBar">
			<li><a class="add" href="app/system/account.do?action=pageAccountIndex" target="dialog" title="添加新权限组" mask="true" width="504" height="348" rel="dia_sys_roleadd"><span>添加新权限组</span></a></li>
		</ul>
	</div>
	-->
	<table class="table" width="100%" layoutH="115">
		<thead>
			<tr>
				<th align="center">账号</th>
				<th align="center">姓名</th>
				<th align="center">所属校区</th>
				<th align="center">所属部门</th>
				<th align="center">在职岗位</th>
				<th align="center">账号状态</th>
				<th align="center">联系电话</th>
				<th align="center">最后登录时间</th>
				<th align="center">最后登录IP</th>
				<th align="center">激活/冻结</th>
				<th align="center">重置密码</th>
			</tr>
		</thead>
		<tbody>
			<logic:present name="users">
				<logic:iterate name="users" property="items" id="user" indexId="idx">
					<tr id="drole-${role.id}">
						<td>${user.username}</td>
						<td>${user.fullName}</td>
						<td>${user.district ne null ? user.district.districtName : '/'}</td>
						<td>${user.position ne null ? user.position.department.depName : '/'}</td>
						<td>${user.position ne null ? user.position.positionName : '/'}</td>
						<td>${user.status eq 1 ? '有效' : '已冻结'}</td>
						<td>${user.employee.phoneNo}</td>
						<td><fmt:formatDate  value="${user.lastLogonTime}" pattern="yyyy.MM.dd HH:mm:ss" /></td>
						<td>${user.lastLogonIP}</td>
						<td>
							<c:choose>
								<c:when test="${user.status eq 1}">
								<c:choose>
									<c:when test="${tm:ifGranted('_FUNCKEY_ADMIN_ACCOUNT_LOCK')}">
										<a href="app/system/account.do?action=actionUserStateChange&userId=${user.id}&status=0" target="ajaxTodo" title="您确定将‘${user.fullName}’ 的账号冻结吗？<br/>冻结以后该账号将不允许登录系统" class="oplink" width="504" height="348" rel="sysmgr_account_freez">冻结</a>
									</c:when>
										<c:otherwise><label class="opdisabled" title="您没有权限冻结账号">---</label></c:otherwise>
								</c:choose>
								</c:when>
								<c:otherwise>
								<c:choose>
									<c:when test="${tm:ifGranted('_FUNCKEY_ADMIN_ACCOUNT_ACTIVE')}">
									<a href="app/system/account.do?action=actionUserStateChange&userId=${user.id}&status=1" target="ajaxTodo" title="您确定将‘${user.fullName}’ 的账号激活吗？" class="oplink" width="504" height="348" rel="sysmgr_account_act">激活</a>
									</c:when>
											<c:otherwise><label class="opdisabled" title="您没有权限激活账号">---</label></c:otherwise>
									</c:choose>
								</c:otherwise>
							</c:choose>
						</td>
						<td>
						<c:choose>
							<c:when test="${tm:ifGranted('_FUNCKEY_ADMIN_ACCOUNT_PASSWORD_RESET')}">
								<a href="app/system/account.do?action=actionUserPwdReset&userId=${user.id}" target="ajaxTodo" title="您确定将‘${user.fullName}’ 的账号重置密码吗？<br/>重置后的密码与登录帐号相同" class="oplink" width="504" height="348" rel="sysmgr_account_pwdreset">重置密码</a>
							</c:when>
							<c:otherwise><label class="opdisabled" title="您没有权限重置密码">---</label></c:otherwise>
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
		
	</form>
</div>
<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/tags/trymore" prefix="tm"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script type="text/javascript">
	function dep_refresh (refresh) {
		if (refresh) {
			$("#ajBoxMenuTree").loadUrl("app/system/school/department.do?action=actionLoadDepartmentTree", {}, function(){
				if ($("#_var_depid", $(navTab.getCurrentPanel())).size() > 0) {
					$("#_var_depid", $(navTab.getCurrentPanel())).remove();
				}
			});
		} else {
			if ($("#_var_depid", $(navTab.getCurrentPanel())).size() > 0) {
				$("#_var_depid", $(navTab.getCurrentPanel())).remove();
			}
		}
		
		$("#ajBoxMenuFunc").loadUrl("app/system/school/department/position.do?action=actionLoadDepartmentPosition", {}, function(){
		});
	}
	function callback_funcRemove(id) {
/*		if (id == undefined && $("tr.selected", "#ajBoxMenuFunc").size() > 0) {
			id = $("tr.selected", "#ajBoxMenuFunc").attr("rel");
		}*/
		if ($("#mfunc-" + id).size() > 0) {
			$("#mfunc-" + id).fadeOut("slow");
		}
	}
</script>
<div class="pageContent">
	<div class="toggleCollapse noborder">
			<h2>工作安排设置</h2>
	</div>
	<div class="panelBar">
		<ul class="toolBar">
			<li><a class="refresh uvar" href="app/system/work/base.do?action=pageWorkBaseContent&districtId={_var_districtId}" warn="请从左侧选择部门!" target="ajax" rel="ajBoxDepPos" title="刷新" rel="dia_admin_entryadd"><span>刷新</span></a></li>
			<li class="line">line</li>
			<c:choose>
				<c:when test="${tm:ifGranted('_FUNCKEY_SYSTEM_ADD_WORK_CONTENT')}">
					<li><a class="add" href="app/system/work/base.do?action=dialogAddWorkContent&districtId={_var_districtId}" mask="true" warn="请从左侧选择部门!" target="dialog" title="添加新工作内容" width="504" height="335" rel="dia_admin_entryadd"><span>添加新工作内容</span></a></li>
				</c:when>
			</c:choose>
		</ul>
	</div>
	<table class="table" width="100%" layoutH="100">
		<thead>
			<tr>
				<th align="center">选项名称</th>
				<th align="center">选项值</th>
				<th align="center">选项说明</th>
				<th align="center">更改时间</th>
				<th align="center">编辑</th>
				<th align="center">删除</th>
			</tr>
		</thead>
		<tbody>
			<logic:present name="baseWorkContents">
				<logic:iterate name="baseWorkContents" property="items" id="entity">
					<tr target="posId" rel="${entity.id}" id="mfunc-${entity.id}">
					    <td>${entity.itemName}</td>
					    <td>${entity.itemValue}</td>
						<td>${entity.meto}</td>
						<td>${entity.updateTime}</td>
						<td>
							<c:choose>
								<c:when test="${tm:ifGranted('_FUNCKEY_SYSTEM_EDIT_WORK_CONTENT')}">
									<a href="app/system/work/base.do?action=dialogBaseWorkBasePage&contentId=${entity.id}" class="oplink" target="dialog" title="工作内容编辑" width="504" height="335" rel="sys_dePosSet-${entity.id}">编辑</a>
								</c:when>
								<c:otherwise><label class="opdisabled" title="您没有权限进行该操作">编辑</label></c:otherwise>
							</c:choose>
						</td>
						<td>
							<c:choose>
								<c:when test="${tm:ifGranted('_FUNCKEY_SYSTEM_DELETE_WORK_CONTENT')}">
									<a href="app/system/work/base.do?action=actionRemoveBaseWorkContent&contentId=${entity.id}" class="oplink" target="ajaxTodo" title="工作内容删除" width="550" height="335"  target="ajaxTodo" title="确定要删除该工作内容吗?" rel="sys_dePosDel-${entity.id}" callback="callback_funcRemove(${entity.id})">删除</a>
								</c:when>
								<c:otherwise><label class="opdisabled" title="您没有权限进行该操作">删除</label></c:otherwise></c:otherwise>
							</c:choose>
						</td>
					</tr>
				</logic:iterate>
			</logic:present>
		</tbody>
	</table>
      <div class="panelBar">
         <div class="pages"><span>显示</span> <select class="combox"
            name="numPerPage" onchange="navTabPageBreak({numPerPage:this.value})">
            <option value="20" ${pagingBean ne null && pagingBean.pageSize
               eq 20 ? 'selected="selected"' : ''}>20</option>
            <option value="50" ${pagingBean ne null && pagingBean.pageSize
               eq 50 ? 'selected="selected"' : ''}>50</option>
            <option value="100" ${pagingBean ne null && pagingBean.pageSize
               eq 100 ? 'selected="selected"' : ''}>100</option>
            <option value="200" ${pagingBean ne null && pagingBean.pageSize
               eq 200 ? 'selected="selected"' : ''}>200</option>
         </select> <span>条，共${pagingBean ne null ? pagingBean.totalItems : 0}条</span></div>
         <div class="pagination" targetType="navTab"
            totalCount="${pagingBean ne null ? pagingBean.totalItems : 0}"
            numPerPage="${pagingBean ne null ? pagingBean.pageSize : 20}"
            pageNumShown="${pagingBean ne null ? pagingBean.pageNumShown : 10}"
            currentPage="${pagingBean ne null ? pagingBean.currentPage : 1}">
         </div>
      </div>
</div>
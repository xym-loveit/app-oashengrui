<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/tags/trymore" prefix="tm"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<script type="text/javascript">
function callback_funcRemove(id) {
	if ($("#dic-" + id).size() > 0) {
		$("#dic-" + id).fadeOut("slow");
	}
	$("#ajaxBox").loadUrl("app/system/dictionary.do?action=actionLoadDictionaryListPage&type="+$("#dicType").val(),{},function(){});
}
</script>
<div class="pageContent">
<input type="hidden" id ="dicType" value="${dictionary ne null ?dictionary.type:'news'}" /> 
	<table class="table" width="100%"  layoutH="90">
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
			<logic:present name="dictionarys">
				<logic:iterate name="dictionarys" property="items" id="entity">
						<tr target="posId" rel="${entity.id}" id="dic-${entity.id}">
						    <td>${entity.name}</td>
						    <td>${entity.value}</td>
							<td>${entity.extraValue}</td>
							<td><fmt:formatDate value="${entity.modifiedDate}" type="date" pattern="yyyy-MM-dd"/></td>
							<td>
								<c:choose>
									<c:when test="${tm:ifGranted('_FUNCKEY_SYSTEM_EDIT_DICTIONARY')}">
										<a href="app/system/dictionary.do?action=actionLoadDictionaryEditPage&id=${entity.id}" class="oplink" target="dialog" title="数据字典编辑" width="504" height="335" rel="sys_dePosSet-${entity.id}">编辑</a>
									</c:when>
									<c:otherwise><label class="opdisabled" title="您没有权限进行该操作">编辑</label></c:otherwise>
								</c:choose>
							</td>
							<td>
								<c:choose>
									<c:when test="${tm:ifGranted('_FUNCKEY_SYSTEM_DELETE_DICTIONARY')}">
										<a href="app/system/dictionary.do?action=actionDeleteDictionary&id=${entity.id}" class="oplink" target="ajaxTodo" title="数据字典删除" width="550" height="335"  target="ajaxTodo" title="确定要删除该工作内容吗?" rel="sys_dePosDel-${entity.id}" callback="callback_funcRemove(${entity.id})">删除</a>
									</c:when>
									<c:otherwise><label class="opdisabled" title="您没有权限进行该操作">删除</label></c:otherwise>
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

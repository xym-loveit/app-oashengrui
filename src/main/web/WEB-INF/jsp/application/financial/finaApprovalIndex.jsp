<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix='fmt'%>
<%@ taglib uri="/tags/trymore" prefix="tm"%>

<style>
	label {width: auto;}
	.opr {margin: 3px 2px;}
	.dispose {text-decoration: line-through; color: red;}
	ul.infoshow {padding:5px 0 0 5px; overflow:auto; width: 80%;}
	ul.infoshow li {line-height: 30px; float:left; margin-right: 15px;}
	.opdisabled {text-decoration: line-through; color: #DDD; line-height: 21px;}
	td.ongoing {background-color: #99FF99; color: #333;}
	td.finished {background-color: #ddd;}
</style>

<form id="pagerForm" method="post" action="app/finan/${PAGE_TYPE eq 'FE' ? 'expense' : 'contract'}.do?action=pageFina${PAGE_TYPE eq 'FE' ? 'Expense' : 'Contract'}Index">
	<input type="hidden" name="pageNum" value="${pagingBean ne null ? pagingBean.currentPage : 1}" />
	<input type="hidden" name="numPerPage" value="${pagingBean ne null ? pagingBean.pageSize : 20}" />
</form>

<!-- SearchBar -->
<div class="pageHeader">
	<form onsubmit="return navTabSearch(this);" action="app/finan/${PAGE_TYPE eq 'FE' ? 'expense' : 'contract'}.do?action=pageFina${PAGE_TYPE eq 'FE' ? 'Expense' : 'Contract'}Index" method="post" id="searchForm" rel="pagerForm">
		<div class="searchBar">
			<table class="searchContent">
				<tr>
					<td>
						<label>所属校区：</label>
						<select class="combox" name="empDistrictId" id="combox_district_emp${PAGE_TYPE}">
							<option value="-1">所有校区</option>
							<logic:present name="districts">
								<logic:iterate name="districts" id="district">
									<option value="${district.id}" ${formEntity ne null && formEntity.empDistrictId eq district.id ? 'selected="selected"' : ''}>${district.districtName}</option>
								</logic:iterate>
							</logic:present>
						</select>
					</td>
					<td>
						<label>申请类型：</label>
						<select class="combox" name="applyFormTypeId">
							<option value="-1">所有</option>
							<logic:present name="types">
								<logic:iterate name="types" id="entity">
									<option value="${entity.id}" ${formEntity ne null && formEntity.applyFormTypeId eq entity.id ? "selected='selected'" : ""}>${entity.processTypeName}</option>
								</logic:iterate>
							</logic:present>
						</select>
					</td>
					<td>
						<label>审批结果：</label>
						<select class="combox" name="auditState">
							<option value="-1">所有</option>
							<option value="2" ${formEntity ne null && formEntity.auditState eq 2 ? 'selected="selected"' : ''}>审批通过</option>
							<option value="3" ${formEntity ne null && formEntity.auditState eq 3 ? 'selected="selected"' : ''}>审批未通过</option>
							<option value="4" ${formEntity ne null && formEntity.auditState eq 4 ? 'selected="selected"' : ''}>审批退回</option>
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
		<input name="page_type" value="${PAGE_TYPE}" type="hidden" />
	</form>
</div>

<!-- Body -->
<div class="unitBox" id="jbsxBox">
	<div class="pageContent">
		<div class="panelBar">
			<ul class="toolBar">
				<li>
					<c:choose>
						<c:when test="${PAGE_TYPE eq 'FE'}">
							<c:if test="${tm:ifGranted('_FUNCKEY_FINAN_EXPENSE_APPLY')}">
								<a class="add" href="app/finan/expense.do?action=diaglogFinaExpensePage" target="dialog" title="财务申请" width="1150" height="550" rel="dia_finexp_add"><span>财务申请</span></a>
							</c:if>
						</c:when>
						<c:when test="${PAGE_TYPE eq 'FC'}">
							<c:if test="${tm:ifGranted('_FUNCKEY_FINAN_CONTRACT_APPLY')}">
								<a class="add" href="app/finan/contract.do?action=diaglogFinaContractPage" target="dialog" title="合同申请" width="1150" height="550" rel="dia_fincta_add"><span>合同申请</span></a>
							</c:if>
						</c:when>	
						<c:when test="${PAGE_TYPE eq 'FP'}">
							<c:if test="${tm:ifGranted('_FUNCKEY_FINAN_PROJECT_APPLY')}">
								<a class="add" href="app/finan/project.do?action=diaglogFinaProjectPage" target="dialog" title="新项目申请" width="1150" height="550" rel="dia_finprj_add"><span>新项目申请</span></a>
							</c:if>
						</c:when>	
					</c:choose>
				</li>
				<li class="line">line</li>
			</ul>
		</div>
		
		<div id="fina_dataset">
			<%@ include file="data/dataFinaFormList.jsp" %>
		</div>
		
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
</div>
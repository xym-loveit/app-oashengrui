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

<script>
	function after_switch(tab_index) {
		$("#currentindex").val(tab_index);
	}
</script>

<form id="pagerForm" method="post" action="app/hrm/develop.do?action=hrmEmployeeDevelopIndex">
	<input type="hidden" name="pageNum" value="${pagingBean ne null ? pagingBean.currentPage : 1}" />
	<input type="hidden" name="numPerPage" value="${pagingBean ne null ? pagingBean.pageSize : 20}" />
	<input type="hidden" name="currentindex" value="${currentindex ne null ? currentindex : 0}" />
</form>

<!-- SearchBar -->
<div class="pageHeader">
	<form onsubmit="return navTabSearch(this);" action="app/hrm/develop.do?action=hrmEmployeeDevelopIndex" method="post" id="searchForm" rel="pagerForm">
		<div class="searchBar">
			<table class="searchContent" id="record_form">
				<tr>
					<td>
						<label>审批人：</label>
						<input name="employee.fullName" type="text" value="${formEntity ne null && formEntity.employee.fullName ne null ? formEntity.employee.fullName : ''}" postField="fullName" suggestFields="fullName,districtName" suggestUrl="app/base.do?action=lookupEmployeeByName" lookupGroup="employee" />
					</td>
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
		<input type="hidden" name="currentindex" id="currentindex" value="${currentindex ne null ? currentindex : 0}" />
	</form>
</div>

<!-- Body -->
<div class="unitBox" id="jbsxBox">
	<div class="pageContent">
		
		<!-- Tabs -->
		<div class="tabs" currentindex="${currentindex ne null ? currentindex : 0}" eventtype="click">
			<div class="tabsHeader">
				<div class="tabsHeaderContent">
					<ul>
						<li class="selected"><a href="app/hrm/develop.do?action=actionDevelopLoadRecords&finished" class="j-ajax" callback="after_switch(0)" paramRef="pagerForm, record_form"><span>审批结束</span></a></li>
						<li class=""><a href="app/hrm/develop.do?action=actionDevelopLoadRecords" class="j-ajax" callback="after_switch(1)" paramRef="pagerForm, record_form"><span>审批中</span></a></li>
					</ul>
				</div>
			</div>
			<div class="tabsContent" style="height:auto;">
				<div inited="1000" style="display: none;">
				</div>
				<div inited="1000" style="display: block;">
				</div>
			</div>
			<div class="tabsFooter">
				<div class="tabsFooterContent"></div>
			</div>
		</div>
	</div>
</div>
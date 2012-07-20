<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix='fmt'%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<style>
	label {width: auto;}
	.opr {margin: 3px 2px;}
	.dispose {text-decoration: line-through; color: red;}
</style>

<div class="pageContent">
	<table class="table" width="100%" layoutH="50">
		<thead>
			<tr>
				<th align="center">面试官姓名</th>
				<th align="center">面试环节</th>
				<th align="center">面试时间</th>
				<th align="center">建议结果</th>
				<th align="center" width="30%">备注信息</th>
				<th align="center">附件</th>
			</tr>
		</thead>
		<tbody>
			<logic:present name="hireJobInterviews">
				<logic:iterate name="hireJobInterviews" property="items" id="entity">
					<tr target="interview_id" rel="${entity.id}">
						<td>${entity.interviewer.fullName}</td>
						<td>${entity.sessionSN eq 1 ? '一面' : (entity.sessionSN eq 2 ? '二面' : (entity.sessionSN eq 3 ? '三面' : '未知'))}</td>
						<td><fmt:formatDate  value="${entity.interviewDate}" pattern="yyyy.MM.dd hh:mm:ss" /></td>
						<td class="iflag-${entity.interviewStatus}">${entity.interviewStatus eq 0 ? '待面试' : (entity.interviewStatus eq 1 ? '面试' : (entity.interviewStatus eq 2 ? '通过' : (entity.interviewStatus eq 3 ? '淘汰' : (entity.interviewStatus eq 4 ? '未到' : ''))))}</td>
						<td>${entity.interviewComments}</td>
						<td>
							<c:if test="${entity ne null && fn:length(entity.attachFiles) gt 0}">
								<logic:iterate name="entity" property="attachFiles" id="file">
									<a title="点击下载`${file.fileName}`文件" href="uploads/${file.filePath}" target="_blank" style="line-height:20px;color: blue;text-decoration: underline;">下载</a>
								</logic:iterate>
							</c:if>
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


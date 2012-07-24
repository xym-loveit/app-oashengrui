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
	.opdisabled {text-decoration: line-through; color: #DDD; line-height: 21px;}
</style>

<table class="table" width="100%" layoutH="75">
	<thead>
		<tr>
			<th align="center">审批类型</th>
			<th align="center">申请内容描述</th>
			<th align="center">申请人姓名</th>
			<th align="center">申请时间</th>
			<c:if test="${op eq null || op ne 'history'}">
			<th align="center" class="thover">审批</th>
			</c:if>
			<!--<c:if test="${op eq null || op ne 'history'}">
			<th align="center" class="thover">详细</th>
			</c:if>-->
		</tr>
	</thead>
	<tbody>
		<logic:present name="entity.list">
			<c:choose>
				<c:when test="${op eq null || op ne 'history'}">
					<logic:iterate name="entity.list" property="items" id="entity">
						<tr target="mjid" rel="${entity.id}">
							<td>${entity.jobHireTitle}</td>
							<td>${entity.jobHireCount}</td>
							<td>${entity.jobHireDistrict ne null ? entity.jobHireDistrict.districtName : ''}</td>
							<td>${entity.jobHireDepartment ne null ? entity.jobHireDepartment.depName : ''}</td>
							<td>${entity.jobHireAddress}</td>
							<td>${entity.jobHireRange eq 1 ? '内外兼招' : (entity.jobHireRange eq 2 ? '外部招聘' : ( entity.jobHireRange eq 3 ? '内部招聘' : '未知'))}</td>
							<td><fmt:formatDate value="${entity.jobHireEndDate}" pattern="yyyy-MM-dd" /></td>
							<td class="thover"><a class="oplink" href="app/hrm/hire.do?action=hrmPageJobDetail&id=${entity.id}&op=view" target="dialog" title="岗位详细" width="930" height="500">岗位详细</a></td>
							<td class="thover">
								<c:choose>
									<c:when test="${myJobApplications['2'][entity.id]}">
										<label class="opdisabled" title="我已经应聘过了.">应聘</label>
									</c:when>
									<c:otherwise>
										<a class="oplink" href="app/hrm/hire.do?action=hrmPageJobResume&jobId=2&source=1" target="dialog" title="我要应聘" width="830" height="460">应聘</a>
									</c:otherwise>
								</c:choose>
							</td>
							<td class="thover">
								<a class="oplink" href="app/hrm/hire.do?action=hrmPageJobResume&jobId=2&source=2" target="dialog" title="我要推荐" width="830" height="460">推荐</a>
							</td>
						</tr>
					</logic:iterate>
				</c:when>
				<c:otherwise>
					<logic:iterate name="entity.list" property="items" id="entity">
						<tr target="mjid" rel="${entity.id}">
							<td>${entity.jobHire.jobHireTitle}</td>
							<td>${entity.jobHire.jobHireCount}</td>
							<td>${entity.jobHire.jobHireDistrict ne null ? entity.jobHire.jobHireDistrict.districtName : ''}</td>
							<td>${entity.jobHire.jobHireDepartment ne null ? entity.jobHire.jobHireDepartment.depName : ''}</td>
							<td>${entity.jobHire.jobHireRange eq 1 ? '内外兼招' : (entity.jobHire.jobHireRange eq 2 ? '外部招聘' : ( entity.jobHire.jobHireRange eq 3 ? '内部招聘' : '未知'))}
							<td><fmt:formatDate  value="${entity.jobHire.jobHireEndDate}" pattern="yyyy-MM-dd" /></td>
							<td>${entity.jobHire.isOpen eq 0 ? '已结束' : '招聘中'}</td>
							<td class="thover">${entity.resume.fullName}</td>
							<td class="thover">${entity.resume.source eq 0 ? '手工输入' : (entity.resume.source eq 1 ? '内部申请' : (entity.resume.source eq 2 ? '内部推荐' : entity.resume.source eq 3 ? '外部申请' : ''))}</td>
							<td class="thover">${entity.finalResult ne null ? (entity.finalResult eq 1 ? '录用' : (entity.finalResult eq 2 ? '淘汰' : (entity.finalResult eq 3 ? '未面试' : '未知'))) : '暂无'}</td>
							<td><a class="oplink" href="app/hrm/hire.do?action=hrmPageJobDetail&id=${entity.jobHire.id}&op=view" target="dialog" title="岗位详细" width="930" height="500">岗位详细</a></td>
							<td><a class="oplink" href="app/hrm/hire.do?action=hrmPageJobResume&resumeId=${entity.resume.id}&op=view" target="dialog" title="简历信息‘${entity.resume.fullName}’" width="900" height="500" rel="myinterview_resumeview_${entity.resume.id}" mask="true" rel="hrm_resumedetail_${entity.resume.id}">简历信息</a></td>
						</tr>
					</logic:iterate>
				</c:otherwise>
			</c:choose>
		</logic:present>
	</tbody>
</table>
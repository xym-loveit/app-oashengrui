<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>

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

<form id="pagerForm" method="post" action="app/hrm/hire.do?action=hrmJobIndex">
	<input type="hidden" name="pageNum" value="${pagingBean ne null ? pagingBean.currentPage : 1}" />
	<input type="hidden" name="numPerPage" value="${pagingBean ne null ? pagingBean.pageSize : 20}" />
</form>

<!-- SearchBar -->
<div class="pageHeader">
	<h1><span class="icon-jobinfo icon" style="display:block">岗位信息</span></h1>
	<ul class="infoshow">
		<li>岗位名称：<input type="text" value="${jobHireInfo.jobHireTitle}" readonly /></li>
		<li>招聘校区：<input type="text" value="${jobHireInfo.jobHireDistrict ne null ? jobHireInfo.jobHireDistrict.districtName : ''}" readonly /></li>
		<li>招聘部门：<input type="text" value="${jobHireInfo.jobHireDepartment ne null ? jobHireInfo.jobHireDepartment.depName : ''}" readonly /></li>
		<li>招聘范围：<input type="text" value="${jobHireInfo.jobHireRange eq 1 ? '内外兼招' : (jobHireInfo.jobHireRange eq 2 ? '外部招聘' : (jobHireInfo.jobHireRange eq 3 ? '内部招聘' : ''))}" readonly /></li>
		<li>招聘人数：<input type="text" value="${jobHireInfo.jobHireCount}" readonly /></li>
		<li>应聘人数：<input type="text" value="${fn:length(jobHireInfo.jobHireIssues)}" readonly /></li>
		<li>已录人数：<input type="text" value="0" readonly /></li>
	</ul>
</div>

<!-- Body -->
<div class="unitBox" id="jbsxBox">
	<div class="pageContent">
		<div class="panelBar">
			<ul class="toolBar">
				<li><a class="add" href="app/hrm/hire.do?action=hrmPageJobResume&jobId=${jobHireInfo.id}&source=0" target="dialog" width="830" height="460"><span class="icon-edit">添加简历</span></a></li>
			</ul>
			<!--
			<ul class="toolBar" style="float:right">
				<li><a treeicon="icon-edit" class="icon" href="app/hrm.do?action=hrmPageJobOfferDetail" target="dialog"><span class="icon-edit">招聘安排</span></a></li>
				<li><a class="icon" target="ajaxTodo" href="app/hrm.do?action=hrmJobIndex" title="您确定廖振魁 王伟平 李小明 3人不参与面试了吗？加入人才库,别忘了给他们打电话确认一遍哦。" callback="hello"><span>未到</span></a></li>
				<li><a class="icon" target="ajaxTodo" href="app/hrm.do?action=hrmJobIndex" title="确定吗?" callback="hello"><span>录用</span></a></li>
				<li><a class="icon" target="ajaxTodo" href="app/hrm.do?action=hrmJobIndex" title="确定吗?" callback="hello"><span>淘汰</span></a></li>
			</ul>
			-->
		</div>
		<table class="table" width="100%" layoutH="138">
			<thead>
				<tr>
					<th align="center">选择</th>
					<th align="center">应聘者姓名</th>
					<th align="center">联系电话</th>
					<th align="center">简历来源</th>
					<th align="center">一面</th>
					<th align="center">二面</th>
					<th align="center">三面</th>
					<th align="center">当前状态</th>
					<th align="center">处理结果</th>
					<th align="center">简历信息</th>
					<th align="center">面试记录</th>
					<th align="center">录用</th>
					<th align="center">淘汰</th>
					<th align="center">未到</th>
					<th align="center">招聘安排</th>
				</tr>
			</thead>
			<tbody>
				<logic:present name="jobHireIssues">
					<logic:iterate name="jobHireIssues" property="items" id="entity">
						<tr target="issue_id" rel="${entity.id}">
							<td><input type="checkbox" name="c1" value="${entity.id}" /></td>
							<td>${entity.resume.fullName}</td>
							<td>${entity.resume.mobilePhone}</td>
							<td>${entity.resume.source eq 0 ? '手工输入' : (entity.resume.source eq 1 ? '内部申请' : (entity.resume.source eq 2 ? '内部推荐' : entity.resume.source eq 3 ? '外部申请' : ''))}<c:if test="${entity.resume.source eq 2}">(${entity.candidate.fullName})</c:if></td>
							<td class="flag-itv${entity['interviewStates']['1']}">
								<c:choose>
									<c:when test="${entity['interviewStates'] ne null &&  entity['interviewStates']['1'] ne null}">
										${entity['interviewStates']['1'] eq 0 ? '待面试' : (entity['interviewStates']['1'] eq 1 ? '面试' : (entity['interviewStates']['1'] eq 2 ? '通过' : (entity['interviewStates']['1'] eq 3 ? '淘汰' : (entity['interviewStates']['1'] eq 4 ? '未到' : ''))))}
									</c:when>
								</c:choose>
							</td>
							<td class="flag-itv${entity['interviewStates']['2']}">
								<c:choose>
									<c:when test="${entity['interviewStates'] ne null &&  entity['interviewStates']['2'] ne null}">
										${entity['interviewStates']['2'] eq 0 ? '待面试' : (entity['interviewStates']['2'] eq 1 ? '面试' : (entity['interviewStates']['2'] eq 2 ? '通过' : (entity['interviewStates']['2'] eq 3 ? '淘汰' : (entity['interviewStates']['2'] eq 4 ? '未到' : ''))))}
									</c:when>
								</c:choose>
							</td>
							<td class="flag-itv${entity['interviewStates']['3']}">
								<c:choose>
									<c:when test="${entity['interviewStates'] ne null &&  entity['interviewStates']['3'] ne null}">
										${entity['interviewStates']['3'] eq 0 ? '待面试' : (entity['interviewStates']['3'] eq 1 ? '面试' : (entity['interviewStates']['3'] eq 2 ? '通过' : (entity['interviewStates']['3'] eq 3 ? '淘汰' : (entity['interviewStates']['3'] eq 4 ? '未到' : ''))))}
									</c:when>
								</c:choose>
							</td>
							<td class="${entity.currentStatus eq 3 ? 'ongoing' : (entity.currentStatus eq 4 ? 'finished' : '')}">${entity.currentStatus eq 0 ? '待处理' : (entity.currentStatus eq 1 ? '待安排' : (entity.currentStatus eq 2 ? '已安排' : ( entity.currentStatus eq 3 ? '面试中' : (entity.currentStatus eq 4 ? '已结束' : ''))))}</td>
							<td>${entity.finalResult ne null ? (entity.finalResult eq 1 ? '录用' : (entity.finalResult eq 2 ? '淘汰' : (entity.finalResult eq 3 ? '未面试' : '未知'))) : '---'}</td>
							<td><a class="oplink" href="app/hrm/hire.do?action=hrmPageJobResume&resumeId=${entity.id}&op=view" target="dialog" title="简历信息‘${entity.resume.fullName}’" width="900" height="500" rel="hrm_resumeview_${entity.id}" mask="true" rel="hrm_resumedetail_${entity.id}">简历信息</a></td>
							<td><a class="oplink" href="app/hrm/hire/interview.do?action=hrmPageJobOfferInterviewIndex&issueId=${entity.id}" target="dialog" title="面试记录‘${entity.resume.fullName}’" mask="true" rel="hrm_interviewdetail_${entity.id}">面试记录</a></td>
							<td>
								<c:choose>
									<c:when test="${entity.currentStatus eq 0 || entity.currentStatus eq 1}">
										<a class="oplink" href="app/hrm/hire.do?action=actionJobIssueFinalize&issueId=${entity.id}&state=1" target="ajaxToDo" title="确定要录用‘${entity.resume.fullName}’吗?" >录用</a>
									</c:when>
									<c:otherwise>
										<label class="opdisabled">录用</label>
									</c:otherwise>
								</c:choose>
							</td>
							<td> 
								<c:choose>
									<c:when test="${entity.currentStatus eq 0 || entity.currentStatus eq 1}">
										<a class="oplink" href="app/hrm/hire.do?action=dialogJobOfferFinalizePage&issueId=${entity.id}&state=2" target="dialog" title="确定要淘汰‘${entity.resume.fullName}’吗?" rel="hrm_eliminate_${entity.id}" width="300" height="160">淘汰</a>
									</c:when>
									<c:otherwise>
										<label class="opdisabled">淘汰</label>
									</c:otherwise>
								</c:choose>
							</td>
							<td>
								<c:choose>
									<c:when test="${entity.currentStatus eq 0 || entity.currentStatus eq 1}">
										<a class="oplink" href="app/hrm/hire.do?action=dialogJobOfferFinalizePage&issueId=${entity.id}&state=3" target="dialog" title="确定‘${entity.resume.fullName}’未到吗?" rel="hrm_absence_${entity.id}" width="300" height="200">未到</a>
									</c:when>
									<c:otherwise>
										<label class="opdisabled">未到</label>
									</c:otherwise>
								</c:choose>
							</td>
							<td>
								<c:choose>
									<c:when test="${entity.currentStatus eq 4}">
										<label class="opdisabled">招聘安排</label>
									</c:when>
									<c:otherwise>
										<a class="oplink" href="app/hrm/hire.do?action=hrmPageJobOfferInterviewPlan&issueId=${entity.id}&op=update" mask="true" target="dialog" title="招聘安排‘${entity.resume.fullName}’" rel="hrm_interviewplan_${entity.id}">招聘安排</a>
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
</div>
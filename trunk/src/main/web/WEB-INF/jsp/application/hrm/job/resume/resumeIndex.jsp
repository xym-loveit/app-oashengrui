<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<style>
	label {width: auto;}
	.opr {margin: 3px 2px;}
	.dispose {text-decoration: line-through; color: red;}
</style>

<script>
	function reload() {
		navTab.reload();
	}
</script>

<form id="pagerForm" method="post" action="app/hrm/archive.do?action=hrmJobResumeIndex">
	<input type="hidden" name="pageNum" value="${pagingBean ne null ? pagingBean.currentPage : 1}" />
	<input type="hidden" name="numPerPage" value="${pagingBean ne null ? pagingBean.pageSize : 20}" />
</form>

<!-- SearchBar -->
<div class="pageHeader">
	<form onsubmit="return navTabSearch(this);" action="app/hrm/archive.do?action=hrmJobResumeIndex" method="post" id="searchForm" rel="pagerForm">
		<div class="searchBar">
			<table class="searchContent">
				<tr>
					<td>
						<label>曾应聘岗位：</label>
						<input type="text"  name="jobHireInfo.jobHireTitle" style="width:128px;" value="${formArchive ne null && formArchive.jobHireInfo ne null ? formArchive.jobHireInfo.jobHireTitle : ''}"/>
					</td>
					<td>
						<label>应聘校区：</label>
						<select class="combox" name="jobHireInfo.jobHireDistrict.id" id="combox_district_rindex" style="width:120px" ref="combox_dept_rindex" refUrl="app/hrm/hire.do?action=actionLoadDepartmentByOrg&districtId={value}">
							<option value="-1">所有校区</option>
							<logic:present name="districts">
								<logic:iterate name="districts" id="district">
									<option value="${district.id}" ${formArchive ne null && formArchive.jobHireInfo ne null && formArchive.jobHireInfo.jobHireDistrict ne null && formArchive.jobHireInfo.jobHireDistrict.id eq district.id ? 'selected="selected"' : ''}>${district.districtName}</option>
								</logic:iterate>
							</logic:present>
						</select>
					</td>
					<td>
						<label>应聘部门：</label>
						<select class="combox" id="combox_dept_rindex" name="jobHireInfo.jobHireDepartment.id" defOPKey="所有部门" defOPVal="-1" style="width:108px;">
							<option value="-1">所有部门</option>
							<logic:present name="departments">
								<logic:iterate name="departments" id="entity">
									<option value="${entity.id}" ${formArchive ne null && formArchive.jobHireInfo ne null && formArchive.jobHireInfo.jobHireDepartment ne null && formArchive.jobHireInfo.jobHireDepartment.id eq entity.id ? 'selected="selected"' : ''}>${entity.depName}</option>
								</logic:iterate>
							</logic:present>
						</select>
					</td>
					<td>
						<label>评定等级：</label>
						<select class="combox" name="starLevel" style="width:108px;">
							<option value="-1">所有</option>
							<option value="1" ${formArchive ne null && formArchive.starLevel eq 1 ? 'selected="selected"' : ''}>一星级</option>
							<option value="2" ${formArchive ne null && formArchive.starLevel eq 2 ? 'selected="selected"' : ''}>二星级</option>
							<option value="3" ${formArchive ne null && formArchive.starLevel eq 3 ? 'selected="selected"' : ''}>三星级</option>
							<option value="0" ${formArchive ne null && formArchive.starLevel eq 0 ? 'selected="selected"' : ''}>无星</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>
						<label>毕业院校：</label>
						<input type="text"  name="resume.educationCollege" style="width:128px;" value="${formArchive ne null && formArchive.resume ne null ? formArchive.resume.educationCollege : ''}"/>
					</td>
					<td>
						<label>专业：</label>
						<input type="text"  name="resume.educationMajority" style="width:128px;" value="${formArchive ne null && formArchive.resume ne null ? formArchive.resume.educationMajority : ''}"/>
					</td>
					<td>
						<label>学历：</label>
						<select class="combox" name="resume.educationDegree" style="width:108px;">
							<option value="-1">所有</option>
							<option value="1" ${formArchive ne null && formArchive.resume ne null &&  formArchive.resume.educationDegree eq 1 ? 'selected="selected"' : ''}>研究生</option>
							<option value="2" ${formArchive ne null && formArchive.resume ne null &&  formArchive.resume.educationDegree eq 2 ? 'selected="selected"' : ''}>本科生</option>
							<option value="3" ${formArchive ne null && formArchive.resume ne null &&  formArchive.resume.educationDegree eq 3 ? 'selected="selected"' : ''}>大专</option>
							<option value="4" ${formArchive ne null && formArchive.resume ne null &&  formArchive.resume.educationDegree eq 4 ? 'selected="selected"' : ''}>其他</option>
						</select>
					</td>
					<td></td>
				</tr>
				<tr>
					<td>
						<label>师范类专业：</label>
						<select class="combox" name="resume.teacherMajority" style="width:108px;">
							<option value="-1">所有</option>
							<option value="1" ${formArchive ne null && formArchive.resume ne null &&  formArchive.resume.teacherMajority eq 1 ? 'selected="selected"' : ''}>是</option>
							<option value="2" ${formArchive ne null && formArchive.resume ne null &&  formArchive.resume.teacherMajority eq 2 ? 'selected="selected"' : ''}>否</option>
						</select>
					</td>
					<td>
						<label>教师资格：</label>
						<select class="combox" name="resume.teacherCertifaciton" style="width:108px;">
							<option value="-1">所有</option>
							<option value="1" ${formArchive ne null && formArchive.resume ne null &&  formArchive.resume.teacherCertifaciton eq 1 ? 'selected="selected"' : ''}>是</option>
							<option value="2" ${formArchive ne null && formArchive.resume ne null &&  formArchive.resume.teacherCertifaciton eq 2 ? 'selected="selected"' : ''}>否</option>
						</select>
					</td>
					<td>
						<label>普通话等级：</label>
						<select class="combox" name="resume.chineseLevel" style="width:108px;">
							<option value="-1">所有</option>
							<option value="1" ${formArchive ne null && formArchive.resume ne null &&  formArchive.resume.chineseLevel eq 1 ? 'selected="selected"' : ''}>一级甲等</option>
							<option value="2" ${formArchive ne null && formArchive.resume ne null &&  formArchive.resume.chineseLevel eq 2 ? 'selected="selected"' : ''}>一级乙等</option>
							<option value="3" ${formArchive ne null && formArchive.resume ne null &&  formArchive.resume.chineseLevel eq 3 ? 'selected="selected"' : ''}>二级甲等</option>
							<option value="4" ${formArchive ne null && formArchive.resume ne null &&  formArchive.resume.chineseLevel eq 4 ? 'selected="selected"' : ''}>二级乙等</option>
							<option value="5" ${formArchive ne null && formArchive.resume ne null &&  formArchive.resume.chineseLevel eq 5 ? 'selected="selected"' : ''}>三级甲等</option>
							<option value="6" ${formArchive ne null && formArchive.resume ne null &&  formArchive.resume.chineseLevel eq 6 ? 'selected="selected"' : ''}>三级乙等</option>
							<option value="7" ${formArchive ne null && formArchive.resume ne null &&  formArchive.resume.chineseLevel eq 7 ? 'selected="selected"' : ''}>无</option>
						</select>
					</td>
					<td></td>
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
	
	<table class="table" width="100%" layoutH="168">
		<thead>
			<tr>
				<th align="center">姓名</th>
				<th align="center">来源</th>
				<th align="center">联系电话</th>
				<th align="center">学历</th>
				<th align="center">师范类专业</th>
				<th align="center">教师资格</th>
				<th align="center">外语等级</th>
				<th align="center">普通话等级</th>
				<th align="center">评定等级</th>
				<th align="center">曾应聘岗位</th>
				<th align="center">应聘校区</th>
				<th align="center">应聘部门</th>
				<th align="center">简历信息</th>
				<th align="center">删除</th>
			</tr>
		</thead>
		<tbody>
			<logic:present name="archives">
				<logic:iterate name="archives" property="items" id="entity">
					<tr target="sid" rel="1">
						<td>${entity.resume ne null ? entity.resume.fullName : '---'}</td>
						<td>${entity.source eq 1 ? '入职未到' : (entity.source eq 2 ? '淘汰' : (entity.source eq 3 ? '未面试' : ( entity.source eq 4 ? '离职' : (entity.source eq 5 ? '考察期未通过' : '未知'))))}</td>
						<td>${entity.resume ne null ? entity.resume.mobilePhone : '---'}</td>
						<td>${entity.resume.educationDegree eq 1 ? '研究生' : (entity.resume.educationDegree eq 2 ? '本科生' : (entity.resume.educationDegree eq 3 ? '大专' : '其他'))}</td>
						<td>${entity.resume.teacherMajority eq 1 ? '是' : '否'}</td>
						<td>${entity.resume.teacherCertifaciton eq 1 ? '是' : '否'}</td>
						<td>${entity.resume.englishLevel eq 1 ? 'CET-4' : (entity.resume.englishLevel eq 2 ? 'CET-6' : (entity.resume.englishLevel eq 3 ? '专业四级' : ( entity.resume.englishLevel eq 4 ? '专业八级' : '其他')))}</td>
						<td>${entity.resume.chineseLevel eq 1 ? '一级甲等' : (entity.resume.chineseLevel eq 2 ? '一级乙等' : (entity.resume.chineseLevel eq 3 ? '二级甲等' : ( entity.resume.chineseLevel eq 4 ? '二级乙等' : (entity.resume.chineseLevel eq 5 ? '三级甲等' : (entity.resume.chineseLevel eq 6 ? '三级乙等' : '无')))))}</td>
						<td>${entity.starLevel eq 1 ? '一星级' : (entity.starLevel eq 2 ? '二星级' : (entity.starLevel eq 3 ? '三星级' : '无星'))}</td>
						<td>${entity.jobHireInfo ne null ? entity.jobHireInfo.jobHireTitle : '---'}</td>
						<td>${entity.jobHireInfo ne null && entity.jobHireInfo.jobHireDistrict ne null ? entity.jobHireInfo.jobHireDistrict.districtName : '---'}</td>
						<td>${entity.jobHireInfo ne null && entity.jobHireInfo.jobHireDepartment ne null ? entity.jobHireInfo.jobHireDepartment.depName : '---'}</td>
						<td><a class="oplink" href="app/hrm/hire.do?action=hrmPageJobResume&resumeId=${entity.resume.id}&op=view" target="dialog" title="简历信息‘${entity.resume.fullName}’" width="900" height="500" rel="hrm_resumeview_${entity.id}" mask="true" rel="hrm_resumedetail_${entity.id}">简历信息</a></td>
						<td><a class="oplink" href="app/hrm/archive.do?action=actionResumeRemove&id=${entity.id}&resumeId=${entity.resume.id}" target="ajaxTodo" title="确定要删除简历`${entiyt.resume.fullName}`吗?" callback="reload()">删除</a></td>
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
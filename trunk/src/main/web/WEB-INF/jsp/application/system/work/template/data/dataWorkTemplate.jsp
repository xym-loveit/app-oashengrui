<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<table class="table" width="100%" layoutH="8">
	<thead>
		<tr>
			<th align="center">工作时间</th>
			<th align="center">周一<a href="app/system/work/template/workplan.do?action=dialogWorkTemplateWorkPlanPage&planId=${entity.id}" class="oplink" target="dialog" title="工作安排" width="504" height="335" rel="sys_chPlanSet-${entity.id}">（安排）</a></th>
			<th align="center">周二<a href="app/system/work/template/workplan.do?action=dialogWorkTemplateWorkPlanPage&planId=${entity.id}" class="oplink" target="dialog" title="工作安排" width="504" height="335" rel="sys_chPlanSet-${entity.id}">（安排）</a></th>
			<th align="center">周三<a href="app/system/work/template/workplan.do?action=dialogWorkTemplateWorkPlanPage&planId=${entity.id}" class="oplink" target="dialog" title="工作安排" width="504" height="335" rel="sys_chPlanSet-${entity.id}">（安排）</a></th>
			<th align="center">周四<a href="app/system/work/template/workplan.do?action=dialogWorkTemplateWorkPlanPage&planId=${entity.id}" class="oplink" target="dialog" title="工作安排" width="504" height="335" rel="sys_chPlanSet-${entity.id}">（安排）</a></th>
			<th align="center">周五<a href="app/system/work/template/workplan.do?action=dialogWorkTemplateWorkPlanPage&planId=${entity.id}" class="oplink" target="dialog" title="工作安排" width="504" height="335" rel="sys_chPlanSet-${entity.id}">（安排）</a></th>
			<th align="center">周六<a href="app/system/work/template/workplan.do?action=dialogWorkTemplateWorkPlanPage&planId=${entity.id}" class="oplink" target="dialog" title="工作安排" width="504" height="335" rel="sys_chPlanSet-${entity.id}">（安排）</a></th>
			<th align="center">周日<a href="app/system/work/template/workplan.do?action=dialogWorkTemplateWorkPlanPage&planId=${entity.id}" class="oplink" target="dialog" title="工作安排" width="504" height="335" rel="sys_chPlanSet-${entity.id}">（安排）</a></th>
		</tr>
	</thead>
	<tbody>
		<logic:present name="positions">
			<logic:iterate name="positions" id="entity">
				<tr target="posId" rel="${entity.id}" id="mfunc-${entity.id}">
				    <td>工作时间</td>
					<td>${entity.positionName}</td>
					<td>${entity.positionRoleRights}</td>
					<td>${entity.positionDesc}</td>
					<td>
						<a href="app/system/school/department/position.do?action=dialogSchoolDepartmentPositionPage&posId=${entity.id}" class="oplink" target="dialog" title="岗位编辑" width="504" height="335" rel="sys_dePosSet-${entity.id}">编辑</a>
					</td>
					<td>
						<a href="app/system/school/department/position.do?action=actionRemoveDepartmentPosition&posId=${entity.id}" class="oplink" target="ajaxTodo" title="岗位删除" width="550" height="335" title="确定要删除该岗位吗?" rel="sys_dePosDel-${entity.id}" callback="callback_funcRemove(${entity.id})">删除</a>
					</td>
				</tr>
			</logic:iterate>
		</logic:present>
	</tbody>
</table>
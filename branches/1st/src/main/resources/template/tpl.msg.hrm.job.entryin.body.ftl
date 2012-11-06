<#--入职安排 - 正文 -->
<div style="line-height: 25px;">
	<div> `${entity.jobHireIssue.resume.fullName}` 入职已安排 </div>
	<div>------------------------------------------------------------------</div>
	<div><b>入职时间 ：</b> ${(entity.entryPlanDate)?string("yyyy-MM-dd hh:mm:ss")}</div>
	<div><b>入职校区：</b> ${entity.entryDistrict.districtName}</div>
	<div><b>入职部门：</b> ${entity.entryDepartment.depName}</div>
	<div><b>入职岗位：</b> ${entity.entryPosition.positionName}</div>
	<div><b>入职操作：</b><a href="javascript:void(0);" 
		onclick="parent.$.pdialog.open(
			'app/hrm/entry.do?action=dialogEntryBoardPage&entryId=${entity.id}',
			'hrm_entry_${entity.id}',  
			'点击进行入职操作',
			{width: 600, height: 240})">点击进行入职操作</a></div>
</div>
<#--会议取消 - 正文 -->
<div style="line-height: 25px;">
	<div>[会议取消] 会议“${entity.conferenceName} ”已取消.</div> 
	<div>------------------------------------------------------------------</div>
	<div><b>会议时间：</b> ${(entity.startDay)?string("yyyy-MM-dd")} ${entity.startHour}：${entity.startMinute}---${(entity.endDay)?string("yyyy-MM-dd")}
 ${entity.endHour}：${entity.endMinute}</div>
	<div><b>会议地址：</b> ${entity.address} </div>
	<div><b>会议发起人：</b> ${entity.sponsor.fullName } </div>
	<div><b>会议联系人：</b> ${entity.contactor} </div>
	<div><b>联系电话：</b> ${entity.phone} </div>
	<div><b>详情点击：</b><a href="javascript:void(0);" 
		onclick="parent.$.pdialog.open(
			'app/personal/conference.do?action=conferenceDetail&id=${entity.id}&op=view', 
			'conference_view_${entity.id}',  
			'`${entity.conferenceName}`会议详情',
			{width: 1150, height: 450})">点击查看会议详细</a></div>
</div>
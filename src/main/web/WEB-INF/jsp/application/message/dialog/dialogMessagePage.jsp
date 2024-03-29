<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script>
	
	function openNavTab() {
		
	}
	
	function openDialog(url, dlgId, title) {
		$.pdialog.open(url, dlgId, title);
	}
	
	$(function(){
		<c:if test="${msgId eq null || reply ne null}">
		$('#task_participants').manifest({
			// Use each location's full name as the display text.
			formatDisplay: function (data, $item, $mpItem) {
				return data.empName;
			},
			// Use each location's ID as the value to be submitted.
			formatValue: function (data, $value, $item, $mpItem) {
				return data.id;
			},
			<logic:present name="entity" property="taskParticipants">
			values: [{}<logic:iterate name="entity" property="taskParticipants" id="p">,{id: ${p.id}, empName: '${p.empName}'}</logic:iterate>],
			</logic:present>
			valuesName: 'empid',
			marcoPolo: {
				url: 'app/base.do?action=lookupEmployeeByName',
				formatItem: function (data) {
				  return '"' + data.empName + '" (' + data.districtName + '-' + data.depName + ')';
				},
				param: 'fullName'
			}
		});
		</c:if>
		
		var editor = KindEditor.create('textarea[name="content"]',{
			basePath: "resources/js/kindeditor/",
			resizeType : 1,
			<logic:present name="msgId">
			minHeight: 200,
			</logic:present>
			allowPreviewEmoticons : true,
			filterMode: false,
			afterBlur: function(){
				this.sync();
			},
			items : [
				'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline',
				'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
				'insertunorderedlist', '|', 'emoticons', 'image', 'link']
			<c:if test="${msgId ne null && reply eq null}">
			,readonlyMode : true
			</c:if>
			
		});
		
		<c:if test="${receiver ne null}">
			$('#task_participants').manifest("add",${receiver});
		</c:if>
		
		<logic:present name="msgId">
			var currentNavTab = navTab.getCurrentPanel();
			if (currentNavTab) {
				var mail_item = $(navTab.getCurrentPanel().find("#mail_item_${msgId}"));
				if (mail_item.size() > 0) {
					var mail_flag = $(mail_item.find(".read_flag img"));
					var img_flag = mail_flag.attr("src");
					if (img_flag.indexOf("email_open") == -1 && img_flag.indexOf("email") > -1) {
						mail_flag.attr("src", img_flag.replace("email", "email_open"));
					}
				}
			}
		</logic:present>
		
	});
	
</script>

<div class="pageContent">
	<form id="formMsgForm" method="post" action="app/message.do?action=actionSendShortMessage" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);">
		<div class="pageFormContent" layoutH="56">
			
			<logic:notPresent name="msgId">
			<div style="float: right; width: 300px;">
				<div class="accordion">
					<div class="accordionHeader">
						<h2><span>icon</span>按校区</h2>
					</div>
					<div class="accordionContent" style="height: 240px">
						<%@ include file="../data/dataDistrictTree.jsp"%>
					</div>
					<div class="accordionHeader">
						<h2><span>icon</span>按部门</h2>
					</div>
					<div class="accordionContent" style="height: 240px">
						<%@ include file="../data/dataDepartmentTree.jsp"%>
					</div>
				</div>
			</div>
			</logic:notPresent>
			
			<div <logic:notPresent name="msgId">style="margin-right: 320px"</logic:notPresent>>
				<table cellspacing="10" cellpadding="10" style="border-spacing: 12; width: 100%;">
					<tr>
						<td style="line-height: 25px;">消息标题：</td>
						<td><input type="text" name="subject" class="required" style="width:100%;"  value="${reply ne null ? '回复: ': ''}${entity ne null ? entity.subject : (subject ne null ? subject : '')}" ${entity ne null && reply eq null ? 'readonly' : ''}/></td>
					</tr>
					<c:if test="${msgId eq null || reply ne null}">
					<tr>
						<td style="line-height: 25px;">收件人：</td>
						<td><input id="task_participants" type="text" name="participants" style="width: 100%; " /></td>
					</tr>
					</c:if>
					<tr>
						<td style="line-height: 25px;vertical-align: top">消息内容：</td>
						<td>
							<textarea name="content" class="" rows="8" cols="60" style="width: 100%" ${entity ne null && reply eq null ? 'readonly' : ''}>${entity ne null && reply eq null ? entity.content : (body ne null ? body : '')}</textarea>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<div class="formBar">
			<ul>
				<c:if test="${msgId eq null || reply ne null}">
				<li><div class="buttonActive"><div class="buttonContent"><button type="submit">发送</button></div></div></li>
				</c:if>
				<c:if test="${msgId ne null && reply eq null}">
				<li><a target="dialog" href="app/message.do?action=dialogMessagePage&msgId=${msgId}&op=reply" mask="true" width="880" height="400" class="buttonActive"><span>回复</span></a></li>
				</c:if>
				<li><div class="button"><div class="buttonContent"><button type="button" class="close">关闭</button></div></div></li>
			</ul>
		</div>
		<input type="hidden" name="id" value="${entity ne null ? entity.id : '-1'}" />
		<input type="hidden" name="msgType" value="${msgType ne null ? msgType : (entity ne null ? entity.msgType : 1)}" />
	</form>
<div>
		
<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/tags/trymore" prefix="tm"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript">
	function getCheckedItems(eles, attr) {
		var items = "";
		var _attr = attr || "alt";
		if (eles && eles.size() > 0) {
			for (i=0;i<eles.size();i++){
				if (!$(eles.get(i)).attr("readonly")) {
					items = items + $(eles.get(i)).attr(_attr);
					if (i < eles.size() - 1) {
						items = items + ",";
					}
				}
			}
		}
		return items;
	}
	$(function(){
		$("#btnOK").unbind("click");
		$("#btnOK").bind("click",function(){
			alertMsg.confirm("您确定保存用户权限么?", {
				okCall: function(){
					var item_ids = getCheckedItems($("a[type='role']", $("div.checked").parent()));
					var item_keys = getCheckedItems($("a[type='role']", $("div.checked").parent()), "key");
					$.post("app/system/account.do?action=actionUserRoleSave", {"uid": ${user.id}, "roleKeys": item_keys}, function(json){
						DWZ.ajaxDone(eval('(' + json + ')'));
						$.pdialog.closeCurrent();
					});
				}
			});
		});
	});
</script>

<div class="pageContent">
	<div class="pageFormContent" layoutH="58">
		<div style="line-height: 25px;padding-left: 5px;color: red;border-bottom: 1px dotted #DDD;">注意: 灰色项为用户所在职位拥有的权限项, 不可重复选择.</div>
		<ul class="tree treeFolder treeCheck expand">
			<logic:present name="roles">
				<logic:iterate name="roles" id="role">
					<li><a id="deprtity_${role.id}" type="role" alt="${role.id}" key="${role.roleKey}" ${user ne null && tm:contains(user.roleKeys, role.roleKey) ? 'checked="true"': ''} ${user ne null && tm:contains(user.positionRoleKeys, role.roleKey) ? 'readonly style="color:#999"': ''}><c:out value="${role.roleName}" /></a></li>
				</logic:iterate>
			</logic:present>
		</ul>
	</div>
	<div class="formBar">
		<ul>
			<li><div class="buttonActive"><div class="buttonContent"><button type="button" id="btnOK">保存</button></div></div></li>
			<li><div class="button"><div class="buttonContent"><button class="close" type="button">关闭</button></div></div></li>
		</ul>
	</div>
</div>

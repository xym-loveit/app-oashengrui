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
				items = items + $(eles.get(i)).attr(_attr);
				if (i < eles.size() - 1) {
					items = items + ",";
				}
			}
		}
		return items;
	}
	$(function(){
		$("#btnOK").unbind("click");
		$("#btnOK").bind("click",function(){
			var item_ids = getCheckedItems($("a[type='role']", $("div.checked").parent()));
			var item_keys = getCheckedItems($("a[type='role']", $("div.checked").parent()), "key");
			$.bringBack({ids:item_ids, keys:item_keys});			
		});
	});
</script>

<div class="pageContent">
	<div class="pageFormContent" layoutH="58">
		<ul class="tree treeFolder treeCheck expand" layoutH="8">
			<li>
				<a id="org_type">${department.depOrgType == 0 ? '总部' : (department.depOrgType == 1 ? '校区' : (department.depOrgType == 2 ? '片区' : '/'))}</a>
				<ul>
					<logic:present name="roles">
						<logic:iterate name="roles" id="role">
							<li><a id="deprtity_${role.id}" type="role" alt="${role.id}" key="${role.roleKey}" ${position ne null && tm:inRange(position.positionRoleRights, role.roleKey, ",") ? 'checked="true"': ''}><c:out value="${role.roleName}" /></a></li>
						</logic:iterate>
					</logic:present>
				</ul>
			</li>
		</ul>
	</div>
	<div class="formBar">
		<ul>
			<li><div class="buttonActive"><div class="buttonContent"><button type="button" id="btnOK">确定</button></div></div></li>
			<li><div class="button"><div class="buttonContent"><button class="close" type="button">关闭</button></div></div></li>
		</ul>
	</div>
</div>

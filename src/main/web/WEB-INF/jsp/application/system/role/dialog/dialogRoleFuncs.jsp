<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/tags/trymore" prefix="tm"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript">
	function getCheckedItems(eles, excludes) {
		var items = "";
		if (eles && eles.size() > 0) {
			for (i=0;i<eles.size();i++){
				items = items + $(eles.get(i)).attr("alt");
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
			var item_ckm = getCheckedItems($("span[type='menu']", $("div.checked").parent()));
			var item_indets = getCheckedItems($("span[type='menu']", $("div.indeterminate").parent()));
			var item_ckf = getCheckedItems($("span[type='func']", $("div.checked").parent()));
			
			var menu_ids = (item_ckm != "" ? (item_ckm + ",") : "") + item_indets;
			var func_rights = item_ckf;
			
			$.bringBack({menuIds:menu_ids, funcRights:func_rights});			
		});
	});
</script>

<div class="pageContent" id="tree_rolefuncs">
	<div class="pageFormContent" layoutH="58">
		<logic:present name="rootMenus">
			<ul class="tree treeFolder treeCheck expand" layoutH="8">
				<logic:iterate name="rootMenus" id="root" indexId="idx">
					<li treeicon="${root.menuIcon}"><a id="mtlink_${root.id}" href="javascript:void(0);" ${view ne null ? 'readonly' : ''} ${role ne null && tm:inRange(role.menuIds, root.id, ',') ? 'checked="true"': ''}>
						<span type="menu" alt="${root.id}">${root.menuTitle}</span></a>
						<logic:notEmpty name="root" property="menuChildren">
							<ul>
								<logic:iterate name="root" property="menuChildren" id="child">
									<li treeicon="${child.menuIcon}"><a id="mtlink_${child.id}" ${view ne null ? 'readonly' : ''} href="javascript:void(0);">
										<span type="menu" alt="${child.id}">${child.menuTitle}</span></a>
										<logic:notEmpty name="child" property="menuChildren">
											<ul>
												<logic:iterate name="child" property="menuChildren" id="node">
													<li treeicon="${node.menuIcon}"><a id="mtlink_${node.id}" href="javascript:void(0);" ${view ne null ? 'readonly' : ''} ${role ne null && tm:inRange(role.menuIds, root.id, ',') ? 'checked="true"': ''}>
														<span type="menu" alt="${node.id}">${node.menuTitle}</span></a>
														<logic:notEmpty name="node" property="functions">
															<ul>
																<logic:iterate name="node" property="functions" id="func">
																	<li treeicon="${func.funcIcon}"><a href="javascript:void(0);" ${view ne null ? 'readonly' : ''} ${role ne null && tm:inRange(role.roleRights, func.funcKey, ",") ? 'checked="true"': ''}><span type="func" alt="${func.funcKey}">${func.funcName}</span></a></li>
																</logic:iterate>
															</ul>
														</logic:notEmpty>
													</li>
												</logic:iterate>
											</ul>
										</logic:notEmpty>
										<logic:notEmpty name="child" property="functions">
											<ul>
												<logic:iterate name="child" property="functions" id="func">
													<li treeicon="${func.funcIcon}"><a href="javascript:void(0);" ${view ne null ? 'readonly' : ''} ${role ne null && tm:inRange(role.roleRights, func.funcKey, ",") ? 'checked="true"': ''}><span type="func" alt="${func.funcKey}">${func.funcName}</span></a></li>
												</logic:iterate>
											</ul>
										</logic:notEmpty>
									</li>
								</logic:iterate>
							</ul>
						</logic:notEmpty>
					</li>
				</logic:iterate>
			</ul>
		</logic:present>
	</div>
	<div class="formBar">
		<ul>
			<logic:notPresent name="view">
			<li><div class="buttonActive"><div class="buttonContent"><button type="button" id="btnOK">确定</button></div></div></li>
			</logic:notPresent>
			<li><div class="button"><div class="buttonContent"><button class="close" type="button">关闭</button></div></div></li>
		</ul>
	</div>
</div>

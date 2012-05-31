<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript">
	// 高亮显示选中的菜单项, 供功能菜单联动选择
	function menu_activated(id) {
		var uroot = $("#mtlink_" + id).parent().parent().parent();
		uroot.find("div.selected").removeClass("selected");
		$("#mtlink_" + id).parent().addClass("selected");
	}
</script>

<logic:present name="lookup">
<div class="pageContent">
	<div class="pageFormContent" layoutH="58">
</logic:present>

<logic:present name="rootMenus">
	<ul class="tree treeFolder" layoutH="8">
		<logic:iterate name="rootMenus" id="root" indexId="idx">
			<li treeicon="${root.menuIcon}"><a id="mtlink_${root.id}" <logic:notPresent name='lookup'>class='tparam' param="_var_menuid" paramRel="${root.id}" href="app/system/menu.do?action=actionLoadMenuFuncList&menuId=${root.id}" target="ajax" rel="ajBoxMenuFunc" callback="menu_activated(${root.id});"</logic:notPresent> <logic:present name='lookup'>href="javascript:void(0);" onclick="$.bringBack({menuKey:'${root.menuKey}', menuTitle:'${root.menuTitle}'})"</logic:present>><span>${root.menuTitle}</span></a>
				<logic:notEmpty name="root" property="menuChildren">
					<ul>
						<logic:iterate name="root" property="menuChildren" id="child">
							<li treeicon="${child.menuIcon}"><a id="mtlink_${child.id}" <logic:notPresent name='lookup'>class='tparam' param="_var_menuid" paramRel="${child.id}" href="app/system/menu.do?action=actionLoadMenuFuncList&menuId=${child.id}" callback="menu_activated(${child.id});" target="ajax" rel="ajBoxMenuFunc"</logic:notPresent> <logic:present name='lookup'>href="javascript:void(0);" onclick="$.bringBack({menuKey:'${child.menuKey}', menuTitle:'${child.menuTitle}'})"</logic:present>><span>${child.menuTitle}</span></a>
								<logic:notEmpty name="child" property="menuChildren">
									<ul>
										<logic:iterate name="child" property="menuChildren" id="node">
											<li><a id="mtlink_${node.id}" <logic:notPresent name='lookup'>class='tparam' param="_var_menuid" paramRel="${node.id}" href="app/system/menu.do?action=actionLoadMenuFuncList&menuId=${node.id}" callback="menu_activated(${node.id});" target="ajax" rel="ajBoxMenuFunc"</logic:notPresent> <logic:present name='lookup'>href="javascript:void(0);" onclick="$.bringBack({menuKey:'${node.menuKey}', menuTitle:'${node.menuTitle}'})"</logic:present>><span>${node.menuTitle}</span></a>
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

<logic:present name="lookup">
	</div>
	<div class="formBar">
		<ul>
			<li><div class="button"><div class="buttonContent"><button class="close" type="button">关闭</button></div></div></li>
		</ul>
	</div>
</div>
</logic:present>

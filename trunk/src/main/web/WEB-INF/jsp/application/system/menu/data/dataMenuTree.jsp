<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<logic:present name="lookup">
<div class="pageContent">
	<div class="pageFormContent" layoutH="58">
</logic:present>

<logic:present name="rootMenus">
	<ul class="tree treeFolder" layoutH="8">
		<logic:iterate name="rootMenus" id="root" indexId="idx">
			<li target="menuid" rel="${root.id}" treeicon="${root.menuIcon}"><a <logic:notPresent name='lookup'>href="app/system/menu.do?action=actionLoadMenuFuncList&menuId=${root.id}" target="ajax" rel="ajBoxMenuFunc"</logic:notPresent> <logic:present name='lookup'>href="javascript:void(0);" onclick="$.bringBack({menuKey:'${root.menuKey}', menuTitle:'${root.menuTitle}'})"</logic:present>><span>${root.menuTitle}</span></a>
				<logic:notEmpty name="root" property="menuChildren">
					<ul>
						<logic:iterate name="root" property="menuChildren" id="child">
							<li target="menuid" rel="${child.id}" treeicon="${child.menuIcon}"><a <logic:notPresent name='lookup'>href="app/system/menu.do?action=actionLoadMenuFuncList&menuId=${child.id}" target="ajax" rel="ajBoxMenuFunc"</logic:notPresent> <logic:present name='lookup'>href="javascript:void(0);" onclick="$.bringBack({menuKey:'${child.menuKey}', menuTitle:'${child.menuTitle}'})"</logic:present>><span>${child.menuTitle}</span></a>
								<logic:notEmpty name="child" property="menuChildren">
									<ul>
										<logic:iterate name="child" property="menuChildren" id="node">
											<li target="menuid" rel="${node.id}" treeicon="${node.menuIcon}"><a <logic:notPresent name='lookup'>href="app/system/menu.do?action=actionLoadMenuFuncList&menuId=${node.id}" target="ajax" rel="ajBoxMenuFunc"</logic:notPresent> <logic:present name='lookup'>href="javascript:void(0);" onclick="$.bringBack({menuKey:'${node.menuKey}', menuTitle:'${node.menuTitle}'})"</logic:present>><span>${node.menuTitle}</span></a>
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

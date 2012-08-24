<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>
<%@ taglib uri="/tags/trymore" prefix="tm"%>

<div id="sidebar_s">
	<div class="collapse">
		<div class="toggleCollapse"><div></div></div>
	</div>
</div>

<div id="sidebar">
	<div class="toggleCollapse"><h2 class="icon-navigation">主菜单</h2><div>收缩</div></div>
	<div class="accordion" fillSpace="sidebar">
		<logic:present name="rootMenus">
			<logic:iterate name="rootMenus" id="root" indexId="idx">
				<c:if test="${tm:ifMenuGranted(root.menuKey)}">
					<div class="accordionHeader">
						<h2><span class="${root.menuIcon}">Folder</span>${root.menuTitle}(${num_menu_mod_admin_task})</h2>
					</div>
					<logic:notEmpty name="root" property="menuChildren">
						<div class="accordionContent">
							<ul class="tree treeFolder">
								<logic:iterate name="root" property="menuChildren" id="child">
									<c:if test="${tm:ifMenuGranted(child.menuKey)}">
										<c:choose>
											<c:when test="${child.menuChildren ne null && fn:length(child.menuChildren) gt 0}">
												<li treeicon="${child.menuIcon}"><a>${child.menuTitle}(${num_menu_mod_admin_task})</a>
													<ul>
														<logic:iterate name="child" property="menuChildren" id="node">
															<c:if test="${tm:ifMenuGranted(node.menuKey)}">
																<li treeicon="${node.menuIcon}">
																	<a href="${node.menuUrl}" target="navTab" rel="${node.menuKey}">
																		${node.menuTitle}
																	</a>
																</li>
															</c:if>
														</logic:iterate>
													</ul>
												</li>
											</c:when>
											<c:otherwise>
												<li treeicon="${child.menuIcon}">
													<a href="${child.menuUrl}" target="navTab" rel="${child.menuKey}">
														${child.menuTitle}
													</a>
												</li>
											</c:otherwise>
										</c:choose>
									</c:if>
								</logic:iterate>
							</ul>
						</div>
					</logic:notEmpty>
				</c:if>
			</logic:iterate>
		</logic:present>
	</div>
</div>
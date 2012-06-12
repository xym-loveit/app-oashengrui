<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="pageContent">
	<form method="post" action="app/hrm/hire/resume.do?action=actionJobApply" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);">
		
	<div class="tabs" currentindex="0" eventtype="click">
		<div class="tabsHeader">
			<div class="tabsHeaderContent">
				<ul>
					<li class="selected"><a href="app/hrm/hire.do?action=hrmPageJobResume&resumeId=${employee.resume.id}&op=view" class="j-ajax"><span>基础信息</span></a></li>
					<li class=""><a href="app/hrm/employee.do?action=hrmEmployeeDocRoadMap&id=${employee.id}&op=view" class="j-ajax"><span>晟睿旅程</span></a></li>
				</ul>
			</div>
		</div>
		<div class="tabsContent" style="height:auto;">
			<div inited="1000" style="display: none;">
			</div>
			<div inited="1000" style="display: block;">
			</div>
		</div>
		<div class="tabsFooter">
			<div class="tabsFooterContent"></div>
		</div>
	</div>
	
	</form>
</div>
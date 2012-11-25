<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/tags/trymore" prefix="tm"%>

<div style="overflow:hidden; margin-bottom: 10px;">
	<div style="margin-bottom: 10px;"><b>审批人：</b></div>
	<div>
		<input type="hidden" name="depName" value="" id="cmb_depId_dt_name" />
		<input id="inputEmpId" name="emp.id" value="${procTask ne null ? procTask.toUserIds : ''}" type="hidden"/>
		<input class="required" name="emp.fullName" type="text" value="${procTask ne null ? procTask.toUserNames : ''}" postField="fullName" suggestFields="fullName,districtName" suggestUrl="app/base.do?action=lookupEmployeeByName" lookupGroup="emp" />
	</div>
</div>

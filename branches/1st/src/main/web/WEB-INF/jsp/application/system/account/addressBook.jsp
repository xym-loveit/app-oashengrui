<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix='fmt'%>



<div class="pageContent">
	<div class="pageFormContent" layoutH="56">
		<div style="float: right; width: 300px;">
			<div class="accordion">
				<div class="accordionHeader">
					<h2><span>icon</span>按校区</h2>
				</div>
				<div class="accordionContent" style="height:380px;">
					<%@ include file="data/dataDistrictTree.jsp"%>
				</div>
				<div class="accordionHeader">
					<h2><span>icon</span>按部门</h2>
				</div>
				<div class="accordionContent" style="height:380px;">
					<%@ include file="data/dataDepartmentTree.jsp"%>
				</div>
			</div>
		</div>

		<div style="margin-right: 320px;border:1px solid green" id="addressbook_participants">
			<%@ include file="data/dataEmployeeInfo.jsp"%>
		</div>
	</div>
</div>


<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="pageContent bor" style="float:left; width: 50%;">
    <div class="toggleCollapse noborder">
		<h2>公司文档区</h2>
	</div>
    <%@ include file="docDownload/companyDocs.jsp" %>
    
    <div class="pageContent bol" style="margin-top: 10px;">
	    <div class="toggleCollapse noborder">
		    <h2>总部文档区</h2>
	    </div>
	    <%@ include file="docDownload/deparentDocs.jsp" %>
    </div>
    
</div>

<div class="pageContent bol" style="margin-left: 10px;">
	<div class="toggleCollapse noborder">
		<h2>校区文档区</h2>
	</div>
	<%@ include file="docDownload/districtDocs.jsp" %>
	
	<div class="pageContent bol" style="margin-top: 10px;">
	    <div class="toggleCollapse noborder">
		    <h2>部门文档区</h2>
	    </div>
	    <%@ include file="docDownload/departmentDocs.jsp" %>
    </div>
</div>


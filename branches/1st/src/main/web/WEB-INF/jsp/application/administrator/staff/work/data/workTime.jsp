<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

	<select class="combox" name="newWorkTime" id="dialog_bindWorkTimeNew" style="width:140px">
		<option value="-1">请选择</option>
	    <c:if test="${workTimes ne null}">
	       <c:forEach items="${workTimes}" var="workTime">
	          <option value='<c:out value="${workTime.id}"/>'><c:out value="${workTime.workStime}" />-<c:out value="${workTime.workEtime}" /></option>
	       </c:forEach>
	    </c:if>
	</select>

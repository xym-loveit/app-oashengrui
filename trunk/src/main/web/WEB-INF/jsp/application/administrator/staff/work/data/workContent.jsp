<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<td style="vertical-align: top;">工作内容：</td>
<td colspan="5">
	<select class="combox" name="workContent.id"  id="workCntId">
		<option value="-1">请选择</option>
	    <c:if test="${workContents ne null}">
	       <c:forEach items="${workContents}" var="workContent">
	          <option value='<c:out value="${workContent.id}"/>'><c:out value="${workContent.itemValue}" /></option>
	       </c:forEach>
	    </c:if>
	</select>
</td>
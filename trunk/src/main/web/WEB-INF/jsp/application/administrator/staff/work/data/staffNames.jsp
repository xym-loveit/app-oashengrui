<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

	<td>工作人员:</td>
	<td colspan="4">
		<textarea name="staffNames" id="dialog_arrangedStaffNames" rows="3" style="width:100%">${staffNames ne null ? staffNames:''} </textarea>
		<input type="hidden" name="staffIds" id="staffIds" value="${staffIds ne null ? staffIds:''}" />
	</td>
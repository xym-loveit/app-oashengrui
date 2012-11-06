<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<c:if test="${leaveType ne null && leaveType eq '1' }">
本年度已请病假${days }天
</c:if>
<c:if test="${leaveType ne null && leaveType eq '2' }">
本年度已请事假${days }天
</c:if>
<c:if test="${leaveType ne null && leaveType eq '3' }">
当前剩余年假${days }天
</c:if>
<c:if test="${leaveType ne null && leaveType eq '4' }">
剩余可调休假${days }天
</c:if>
<c:if test="${leaveType ne null && leaveType eq '5' }">
本年度已请其他假期${days }天
</c:if>
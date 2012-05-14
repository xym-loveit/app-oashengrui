<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix='fmt'%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
	<meta http-equiv="refresh" content="5;url=<bean:write name='success.link' />"> 
	<title><bean:write name='success.title' /></title>
</head>
<style>
	*{
		font-size:9pt;
	}
</style>

<div style="border: 1px solid rgb(221, 221, 221); margin: 20% 0pt 0pt 30%; background-color: rgb(243, 248, 239); text-align: center; line-height: 35px; width: 500px;">  
	<bean:write name='success.msg' /> <br/>
	<a href="<bean:write name='success.link' />">点击该链接返回</a>
</div>
</body>
</html>
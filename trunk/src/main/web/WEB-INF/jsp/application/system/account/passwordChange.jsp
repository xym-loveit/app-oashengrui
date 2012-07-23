<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix='fmt'%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
	String userName =(String) request.getSession().getAttribute("SPRING_SECURITY_LAST_USERNAME");
	
%>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">


<title>Insert title here</title>
</head>
<script type="text/javascript">
	function refresh(){
		navTab.reload();
	}
</script>

<body>
<div class="password" style="background-color:#d2f0f4;">
	<form onsubmit="return validateCallback(this);" action="app/system/password.do?action=changePassword" method="post" ref="" id="passwordChange">
			<hr style="margin-top:20px;"></hr>
			<p>
					<label style="margin-left:400px;">原密码：</label>
					<input type="password" name="oldPassword" value="" class="oldPassword" size="30" style="margin-top:15px"></input>
			</p>
			<p>
					<label style="margin-left:400px;">新密码：</label>
					<input type="password" name="newPassword" value="" class="newPassword" size="30" style="margin-top:15px"></input>
			</p>
			<p>
					<label style="margin-left:352px;">再次确认新密码：</label>
					<input type="password" name="confirmPassword" value="" class="newPasswordAgain" size="30" style="margin-top:15px"></input>
			</p>
			<p>
					<button type="submit" class="buttonContent" style="margin-top:15px;margin-left:540px;background-color:#d2f0f4;" onclick="refresh();">修改保存密码</button>
			</p>
			<hr style="margin-top:20px;"></hr>
	</form>
</div>
</body>
</html>
<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Insert title here</title>
</head>
<body>
<%
	response.sendRedirect(request.getContextPath() + "/app/index.do?action=index");
%>
</body>
</html>
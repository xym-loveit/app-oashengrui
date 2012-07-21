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
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<style>
	.head p {text-align:center; height:20px;margin-top:10px;}
	.color {color:blue;}
	.news {text-align:center;}
	.newsDetail .newsContent p{margin-top:40px;}
	.newsDetail .newsContent{margin:auto;}
</style>
<script>

</script>

<body>
	<div class="buttonActive">
		<div class="buttonContent">
			<button class="close" value="关闭">返回</button>
		</div>
	</div>
	<div class="head">
		<p>${newsScanInfo.newsSubject}</p>
	</div>
	<hr style="margin-top:10px;"></hr>
	<div class="newsinfo">
		<table class="news" width="%100" style="margin:auto">
			<tr>
				<td>
					<label><span class="color">新闻类型：</span> ${newsScanInfo.dictionary.name}</label>
				</td>
				<td width="30"></td>
				<td>
					<label><span class="color">发布校区：</span> ${newsScanInfo.district.districtName }</label>
				</td>
				<td width="30"></td>
				<td>
					<label><span class="color">发布部门：  </span>${newsScanInfo.department.depName}</label>
				</td>
				<td width="30"></td>
				<td>
					<label><span class="color">发布时间：</span> <c:if test="${newsScanInfo.updateTime ne null}"><fmt:formatDate value="${newsScanInfo.updateTime}" pattern="yyyy-MM-dd" /></c:if></label>
				</td>
			</tr>
		</table>
	</div>
	<div class="newsDetail">
		<table class="newsContent" cellspacing="10" cellpadding="10" style="border-spacing:12">
			<tr><td colspan="5"><textarea name="newsContent" rows="20" cols="95">${newsScanInfo.newsContent}</textarea></td></tr>
		</table>
	</div>
</body>
</html>
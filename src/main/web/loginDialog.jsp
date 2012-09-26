<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script>
	$(function(){
		$("#captcha_code").click(function(){
			$(this).attr("src", "CaptchaImg?r=" + Math.random());
		});
	});
</script>
<div class="pageContent">
	<form method="post" action="login.do?action=actionLogon" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);">
		<div class="pageFormContent" layoutH="56">
			<table cellspacing="10" cellpadding="10" class="dform">
				<input type="hidden" name="action" value="actionLogon" />
				<tr>
					<td>用户名：</td>
					<td><input type="text" name="username" size="20" class="required"/></td>
				</tr>
				<tr>
					<td>密码：</td>
					<td><input type="password" name="password" size="20" class="required" /></td>
				</tr>
				<!--
				<tr>
					<td>验证码：</td>
					<td><input class="code required" type="text" size="5" name="checkCode" style="width: 50%"/><span><img id="captcha_code" src="CaptchaImg" alt="" width="98" height="22" title="点击更换验证码" /></span></td>
				</tr>
				-->
			</table>
		</div>
		<div class="formBar">
			<ul>
				<li><div class="buttonActive"><div class="buttonContent"><button type="submit">登录</button></div></div></li>
			</ul>
		</div>
	</form>
<div>
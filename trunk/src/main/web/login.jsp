<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="org.shengrui.oa.util.ContextUtil"%>

<%  
	if (ContextUtil.getCurrentUser() != null) {
		response.sendRedirect(request.getContextPath() + "/app/index.do?action=index");
	}
	
	String path = request.getContextPath();  
	String basePath = request.getScheme()+"://"+request.getServerName()+
		(request.getServerPort() == 80 ? "" : (":"+request.getServerPort())) +path+"/";  
%>

<base href="<%=basePath%>">

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
	<title>学智教育协同办公系统</title>
	<link rel="shortcut icon" href="resources/images/favicon.ico" type="image/x-icon"/>
	
	<link href="resources/themes/default/style.css" rel="stylesheet" type="text/css" media="screen"/>
	<link href="resources/themes/css/core.css" rel="stylesheet" type="text/css" media="screen"/>
	<link href="resources/themes/css/print.css" rel="stylesheet" type="text/css" media="print"/>
	
	<link href="resources/themes/css/login.css" rel="stylesheet" type="text/css" />
	
	<!--[if IE]>
	<link href="resources/themes/css/ieHack.css" rel="stylesheet" type="text/css" media="screen"/>
	<![endif]-->
	
	<script src="resources/js/dwz/speedup.js" type="text/javascript"></script>
	<script src="resources/js/dwz/jquery-1.7.1.js" type="text/javascript"></script>
	<script src="resources/js/dwz/jquery.cookie.js" type="text/javascript"></script>
	<script src="resources/js/dwz/jquery.validate.js" type="text/javascript"></script>
	<script src="resources/js/dwz/jquery.bgiframe.js" type="text/javascript"></script>
	<script src="resources/js/xheditor/xheditor-1.1.12-zh-cn.min.js" type="text/javascript"></script>
	
	<script src="resources/js/dwz/dwz.core.js" type="text/javascript"></script>
	<script src="resources/js/dwz/dwz.util.date.js" type="text/javascript"></script>
	<script src="resources/js/dwz/dwz.validate.method.js" type="text/javascript"></script>
	<script src="resources/js/dwz/dwz.regional.zh.js" type="text/javascript"></script>
	<script src="resources/js/dwz/dwz.barDrag.js" type="text/javascript"></script>
	<script src="resources/js/dwz/dwz.drag.js" type="text/javascript"></script>
	<script src="resources/js/dwz/dwz.tree.js" type="text/javascript"></script>
	<script src="resources/js/dwz/dwz.accordion.js" type="text/javascript"></script>
	<script src="resources/js/dwz/dwz.ui.js" type="text/javascript"></script>
	<script src="resources/js/dwz/dwz.theme.js" type="text/javascript"></script>
	<script src="resources/js/dwz/dwz.switchEnv.js" type="text/javascript"></script>
	<script src="resources/js/dwz/dwz.alertMsg.js" type="text/javascript"></script>
	<script src="resources/js/dwz/dwz.contextmenu.js" type="text/javascript"></script>
	<script src="resources/js/dwz/dwz.navTab.js" type="text/javascript"></script>
	<script src="resources/js/dwz/dwz.tab.js" type="text/javascript"></script>
	<script src="resources/js/dwz/dwz.resize.js" type="text/javascript"></script>
	<script src="resources/js/dwz/dwz.dialog.js" type="text/javascript"></script>
	<script src="resources/js/dwz/dwz.dialogDrag.js" type="text/javascript"></script>
	<script src="resources/js/dwz/dwz.sortDrag.js" type="text/javascript"></script>
	<script src="resources/js/dwz/dwz.cssTable.js" type="text/javascript"></script>
	<script src="resources/js/dwz/dwz.stable.js" type="text/javascript"></script>
	<script src="resources/js/dwz/dwz.taskBar.js" type="text/javascript"></script>
	<script src="resources/js/dwz/dwz.ajax.js" type="text/javascript"></script>
	<script src="resources/js/dwz/dwz.pagination.js" type="text/javascript"></script>
	<script src="resources/js/dwz/dwz.database.js" type="text/javascript"></script>
	<script src="resources/js/dwz/dwz.datepicker.js" type="text/javascript"></script>
	<script src="resources/js/dwz/dwz.effects.js" type="text/javascript"></script>
	<script src="resources/js/dwz/dwz.panel.js" type="text/javascript"></script>
	<script src="resources/js/dwz/dwz.checkbox.js" type="text/javascript"></script>
	<script src="resources/js/dwz/dwz.history.js" type="text/javascript"></script>
	<script src="resources/js/dwz/dwz.combox.js" type="text/javascript"></script>
	<script src="resources/js/dwz/dwz.print.js" type="text/javascript"></script>
	<script src="resources/js/dwz/dwz.regional.zh.js" type="text/javascript"></script>
	
</head>

<style>
	#captcha_code {cursor: pointer;}
	.loginForm p {position: relative;}
	.loginForm span.error {width: auto; left: 210px; top: 0;}
</style>

<script>
	var APP_BASE_PATH = "<%=basePath%>";
	
	function afterSubmit(json) {
		if (json.statusCode == 300) {
			alertMsg.error(json.message);
		} else {
			window.location.href= APP_BASE_PATH + "index.jsp";
		}
	}
	
	$(function(){
		DWZ.init("resources/js/dwz/dwz.frag.xml", {
			loginUrl:"login_dialog.html", loginTitle:"登录",	// 弹出登录对话框
			statusCode:{ok:200, error:300, timeout:301}, 
			pageInfo:{pageNum:"pageNum", numPerPage:"numPerPage", orderField:"orderField", orderDirection:"orderDirection"}, 
			debug:true,	
			callback:function(){
				initUI();
			}
		});
		
		$("#captcha_code").click(function(){
			$(this).attr("src", "CaptchaImg?r=" + Math.random());
		});
	})
</script>

<body>
	<div id="login">
		<div id="login_header">
			<h1 class="login_logo"><a href="http://www.xuezhicn.com/"><img src="resources/themes/default/images/logo.png" style="position: relative;top: -7px;"/></a></h1>
			<div class="login_headerContent">
				<div class="navList"></div>
				<h2 class="login_title"><img src="resources/themes/default/images/login_title.png" /></h2>
			</div>
		</div>
		<div id="login_content">
			<div class="loginForm">
				<form method="post" action="login.do?action=actionLogon" class="pageForm required-validate" onsubmit="return validateCallback(this, afterSubmit);">
					<input type="hidden" name="action" value="actionLogon" />
					<p>
						<label>用户名：</label>
						<input type="text" name="username" size="20" class="required"/>
					</p>
					<p>
						<label>密码：</label>
						<input type="password" name="password" size="20" class="required" />
					</p>
					<p>
						<label>验证码：</label>
						<input class="code required" type="text" size="5" name="checkCode" />
						<span><img id="captcha_code" src="CaptchaImg" alt="" width="98" height="22" title="点击更换验证码" /></span>
					</p>
					<div class="login_bar">
						<button class="sub" type="submit"></button>
					</div>
				</form>
			</div>
			<div class="login_banner"><img src="resources/themes/default/images/login_banner.png" /></div>
			<div class="login_main">
				<div class="login_inner">
					<p>让更多的孩子得到更好的教育是我们不变的追求。</p>
					<p>不同的起点也可以达到同样的高度，态度决定一切。</p>
					<p>专注于个性化辅导，我们的流程更加专业，服务更加到位，每一个细节都力求完美。</p>
				</div>
			</div>
		</div>
		<div id="login_footer">
			Copyright &copy; 2012 杭州池墨科技技术有限公司 Inc. All Rights Reserved.
		</div>
	</div>
</body>
</html>
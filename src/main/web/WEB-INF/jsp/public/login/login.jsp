<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>玛丽英语内部管理系统-登录</title>
<link rel="stylesheet" href="resources/css/login.css" type="text/css" media="screen" />
<script type="text/javascript" src='resources/js/jquery-1.3.2.min.js'></script>
<!--[if lt IE 7]>  
<script type="text/javascript" src="resources/js/pngfix/DD_belatedPNG_0.0.8a.js"></script>  
<script type="text/javascript">  
	$(function(){
		DD_belatedPNG.fix('.pngfix,img');
	});
</script>  
<![endif]-->
<script type="text/javascript">
	function frm_enter(event){ 
		e = event ? event :(window.event ? window.event : null); 
		if(e.keyCode==13){  
			$("#login_btn").trigger("click");
		}
	}
	$(function(){
		
		$("#username").keydown(frm_enter);
		$("#password").keydown(frm_enter);

		$("#login_btn").click(function(){
			if($.trim($("#username").val()) == ""){
				$("#username").focus();
				return;
			}

			if($("#password").val() == ""){
				$("#password").focus();
				return;
			}
			$("#login_frm").submit();
		});

		$("#reset_btn").click(function(){
			$("#username").val("");
			$("#password").val("");
			$("#rmb_pwd").removeAttr("checked");
		});

		if($.browser.msie){
			$("img").attr("align","middle"); 
		}

	});
</script>
</head>
<body>
	<div class="wrapper">
		<div class='login_logo'><img src="resources/images/layout/login/logo.png" /></div>
		<div class="login_wrapper">
			<div class="login_pannel pngfix">
				<br style="line-height:0;"/>
				<div class="login_frm">
					<form action="j_spring_security_check.do" method="post" id="login_frm">						
					    <c:if test="${not empty SPRING_SECURITY_LAST_EXCEPTION}">
							<div class="login_error">
								登陆失败:<c:out value="${SPRING_SECURITY_LAST_EXCEPTION.message}"/>.
							</div>
						</c:if>
						<div class="login_input">
							<span>用户</span>
							<input type="text" id="username" name="j_username" value='<c:choose><c:when test="${__moau != null}"><bean:write name="__moau" /></c:when><c:otherwise><c:out value="${SPRING_SECURITY_LAST_USERNAME}"/></c:otherwise></c:choose>' />
						</div>
						<div class="login_input">
							<span>密码</span>
							<input type="password" id="password" name="j_password" value="<logic:present name='__moas'>${__moas}</logic:present><logic:notPresent name='__moas'></logic:notPresent>"/>
						</div>
						<div class="login_btn">
							<button type="button" id="login_btn" />登录</button>
							<button type="button" id="reset_btn" />重置</button>
						</div>
						<div class="login_rmbpwd">
							<input id="rmb_pwd" type="checkbox" name="j_rememberPWD" <logic:present name='__moarmp'>checked="checked"</logic:present>/>
							<label>记住我<img src="resources/images/layout/help.jpg" title="有效期为一个月" align="absmiddle" style="position:relative;top:-1px;margin-left:2px;cursor:help;" /></label>
						</div>
					</form>
				</div>
			</div>
		</div>
		<div class="site_desc">- 玛丽英语 -</div>
	</div>
</body>
</html>
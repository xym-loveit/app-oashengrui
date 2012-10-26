<%@page import="java.text.SimpleDateFormat"%>
<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.util.*,java.text.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix='fmt'%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
  <head>
  	<tiles:insert name="path"/>
  	<title><tiles:getAsString name="title"/></title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
	
	<link rel="shortcut icon" href="resources/images/favicon.ico" type="image/x-icon"/>
	
	<link href="resources/themes/default/style.css" rel="stylesheet" type="text/css" media="screen"/>
	<link href="resources/themes/css/core.css" rel="stylesheet" type="text/css" media="screen"/>
	<!--<link href="resources/js/uploadify/css/uploadify.css" rel="stylesheet" type="text/css" media="screen"/>-->
	<link href="resources/css/common.css" rel="stylesheet" type="text/css" media="screen"/>
	
	<!--[if IE]>
	<link href="resources/themes/css/ieHack.css" rel="stylesheet" type="text/css" media="screen"/>
	<![endif]-->
	
	<script src="resources/js/dwz/speedup.js" type="text/javascript"></script>
	<script src="resources/js/dwz/jquery-1.7.1.js" type="text/javascript"></script>
	<script src="resources/js/dwz/jquery.cookie.js" type="text/javascript"></script>
	<script src="resources/js/dwz/jquery.validate.js" type="text/javascript"></script>
	<script src="resources/js/dwz/jquery.bgiframe.js" type="text/javascript"></script>
	<script src="resources/js/xheditor/xheditor-1.1.12-zh-cn.min.js" type="text/javascript"></script>
	<!--
	<script src="resources/js/uploadify//scripts/swfobject.js" type="text/javascript"></script>
	<script src="resources/js/uploadify//scripts/jquery.resources/js/uploadify/.v2.1.0.js" type="text/javascript"></script>
	-->
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
	
	<script src="resources/js/app.util.js" type="text/javascript"></script>
	<script src="resources/js/kissyForm/kissy.js" type="text/javascript"></script>
	<script src="resources/js/kissyForm/gallery/form/1.2/uploader/queue.js" type="text/javascript"></script>
	
	<script type="text/javascript" src="resources/js/swfupload/swfupload.js"></script>
	<script type="text/javascript" src="resources/js/swfupload/swfupload.queue.js"></script>
	<script type="text/javascript" src="resources/js/swfupload/fileprogress.js"></script>
	<script type="text/javascript" src="resources/js/swfupload/handlers.js"></script>
	
	<script type="text/javascript" src="resources/js/jquery/jmessager/jquery.messager.js"></script>
	<script type="text/javascript" src="resources/js/jquery/jmessager/jquery.floatDiv.js"></script>
	
	<link href="resources/js/jquery/jmainfest/jquery.manifest.css" rel="stylesheet" type="text/css" media="screen"/>
	
	<script src="resources/js/jquery/jmainfest/jquery.ui.widget.min.js" type="text/javascript"></script>
	<script src="resources/js/jquery/jmainfest/jquery.marcopolo.js" type="text/javascript"></script>
	<script src="resources/js/jquery/jmainfest/jquery.manifest.js" type="text/javascript"></script>
	
	<script src="resources/js/jquery/jtablesorter/jquery.tablesorter.min.js" type="text/javascript"></script>
	
	<script src="resources/js/kindeditor/kindeditor.js" type="text/javascript"></script>
	<script src="resources/js/kindeditor/lang/zh_CN.js" type="text/javascript"></script>
	
	<script src="resources/js/jquery/jprint/jquery.jPrintArea.js" type="text/javascript"></script>
	
	<script type="text/javascript" src="dwr/engine.js"></script>
	<script type="text/javascript" src="dwr/util.js"></script>
	
	<!--[if lt IE 7]>  
	<script type="text/javascript" src="resources/js/pngfix/DD_belatedPNG_0.0.8a.js"></script>  
	<script type="text/javascript">  
		$(function(){
			DD_belatedPNG.fix('.pngfix');
		});
	</script>  
	<![endif]-->
	
	<!--[if lt IE 9]>  
	<script type="text/javascript">  
		$(function(){
			$("a").live("click", function(e){
				 e.preventDefault();
			});
			$("select").live("click", function(e){
				 e.preventDefault();
			});
		});
	</script>  
	<![endif]-->
	
	<%  
		String path = request.getContextPath();  
		String basePath = request.getScheme()+"://"+request.getServerName()+
			(request.getServerPort() == 80 ? "" : (":"+request.getServerPort())) +path+"/";  
	%>
	<script type="text/javascript">
		
		var blnCheckUnload = true;
		
		window.onbeforeunload = function() { 
			if (blnCheckUnload) {
				return("确认要离开？");
			}
		}
		
		function messageNotify (ele_key, item_num, is_message, msg_id, msgin_id) {
			
			var ele_keys = ele_key.split(",");
			for (index = 0; index < ele_keys.length; index++) {
				if ($("#" + ele_keys[index]).size() > 0) {
					// element selector.
					var ele = $("#" + ele_keys[index]).find("span.num");
					
					// initialization item number.
					initItemNum(ele, item_num);
					
					if (is_message) {
						if (parseInt(item_num) > 0) {
							$.messager.show(
								'<font style="color:#093">温馨提醒</font>', '<font style="font-size:9pt;font-weight:normal;">您收到1条新短消息,<a onclick="$.pdialog.open(\'app/message.do?action=dialogMessagePage&msgId=' + msg_id + '&msgInId=' + msgin_id + '\', \'dialog_msg_' + msg_id + '\', \'查看短消息\', {width: 640, height: 380})" href="javascript:void(0);" style="color:blue;text-decoration:underline;">点击查看消息</a>.</font>',5000
							);
						}
					} else {
						var parents = ele.parents();
						for (i = 0; i < parents.length; i++) {
							var node = $(parents[i]);
							if (node.hasClass("accordionContent")) {
								var pre_node = node.prev();
								if (pre_node.hasClass("accordionHeader") && pre_node.find("label.num").size() > 0) {
									initItemNum(pre_node.find("label.num"), item_num);
									break;
								}
							} else if (node.hasClass("sub")) {
								initItemNum(node.find("label.num"), item_num);
							}
						}
					}
				}
			}
		}
		
		// 初始化菜单项的数字提醒
		function initItemNum (ele, item_num) {
			if (ele.size() > 0) {
				var num = ele.text() == "" ? 0 : ele.text();
				if (num == 0) {
					// do nothing here...
				} else if (num.startsWith("(") && num.endsWith(")")) {
					num = parseInt(num.substr(1, num.length - 2));
				}
				
				var inc = parseInt(item_num) > 0 ? 1 : -1;
				if (num + inc > 0) {
					ele.text("(" + (num + inc) + ")") ;
				} else {
					ele.text("");
				}
			}
		}
		
		var APP_BASE_PATH = "<%=basePath%>";
		
		$(function(){
			
			dwr.engine._errorHandler = function(message, ex) {} 
			
			DWZ.init("resources/js/dwz/dwz.frag.xml", {
				loginUrl:"loginDialog.jsp", loginTitle:"登录",	// 弹出登录对话框
				loginRedirectPattern: "DWZ.init",
				accessDeniedPattern: '您没有权限访问该页面',
				accessDeniedMessage: '您没有权限访问该页面!',
				statusCode:{ok:200, error:300, timeout:301}, 
				pageInfo:{pageNum:"pageNum", numPerPage:"numPerPage", orderField:"orderField", orderDirection:"orderDirection"}, 
				debug:false,	
				callback:function(){
					initEnv();
					$("#themeList").theme({themeBase:"resources/themes"}); // themeBase 相对于index页面的主题base路径
				}
			});
			
			//加载上传组件入口文件
			KISSY.config({
				packages:[{
					name:"gallery",
					path:APP_BASE_PATH + "resources/js/kissyForm/",
					charset:"utf-8"
				}]
			});
			
			$.ajax({
				url: "app/message.do?action=actionObtainMyUnreadMessageNum",
				global: false,// 禁用全局Ajax事件.
			});
			
			setInterval(function(){  
				$("#currentTime").text("${SPRING_SECURITY_LAST_USERNAME }，欢迎您登录使用本系统，今天是" + new Date().toLocaleString());  
			},1000);  
			
		});
		
	</script>
	
  </head>

  <body scroll="no" onbeforeunload="return '确认要离开？';" onload="dwr.engine.setActiveReverseAjax(true);dwr.engine.setNotifyServerOnPageUnload(true);">
  	<!-- Container Start -->
	<div id="layout">
		
		<!-- body header -->
		<div id="header">
			<tiles:insert name="header"/>
		</div>
		
		<!-- menu wrapper -->
		<div id="leftside">
			<tiles:insert name="menu"/>
		</div>
		
		<!-- body content -->
		<div id="container">
			<div id="navTab" class="tabsPage">
				<div class="tabsPageHeader">
					<div class="tabsPageHeaderContent"><!-- 显示左右控制时添加 class="tabsPageHeaderMargin" -->
						<ul class="navTab-tab">
							<li tabid="main" class="main"><a href="javascript:;"><span><span class="home_icon">我的主页</span></span></a></li>
						</ul>
					</div>
					<div class="tabsLeft">left</div><!-- 禁用只需要添加一个样式 class="tabsLeft tabsLeftDisabled" -->
					<div class="tabsRight">right</div><!-- 禁用只需要添加一个样式 class="tabsRight tabsRightDisabled" -->
					<div class="tabsMore">more</div>
				</div>
				<ul class="tabsMoreList">
					<li><a href="javascript:;">我的主页</a></li>
				</ul>
				<div class="navTab-panel tabsPageContent layoutBox">
					<tiles:insert name="body"/>
				</div>
			</div>
		</div>
		
		<div class="clear"></div>
	</div>
	
	<!-- body footer -->
	<div id="footer">
		<tiles:insert name="footer" />
	</div>
		
  </body>
 </html>
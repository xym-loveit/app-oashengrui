<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<style>
	.ltxt {color: white; line-height: 50px; padding-left: 5px;}
</style>

<div class="headerNav">
	<a href="#" class="ltxt"><label style="font-size:24px;">晟睿教育协同办公系统</label></a>
	<ul class="nav">
		<li style="background: none;"><label style="color:white">用户名：${SPRING_SECURITY_LAST_USERNAME }</label></li>
		<li style="background: none;"><a href="app/message.do?action=pageMessageReceivedIndex" target="navTab" rel="nav_msg">短消息</a></li>
		<li style="background: none;"><a href="app/personal/addressBook.do?action=addressBookInfo" target="navTab">通讯录</a></li>
		<li style="background: none;"><a href="app/index.do?action=index">首页</a></li>
		<li><a href="j_logout.do">退出</a></li>
	</ul>
	<ul class="themeList" id="themeList">
		<li style="background: none;"><label style="color:white">职位：${POSITION }</label></li>
		<li style="background: none;">&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</li>
		<li theme="default"><div class="selected">蓝色</div></li>
		<li theme="azure"><div>天蓝</div></li>
		<li theme="green"><div>绿色</div></li>
		<!--<li theme="red"><div>红色</div></li>-->
		<li theme="purple"><div>紫色</div></li>
		<li theme="silver"><div>银色</div></li>
	</ul>
</div>

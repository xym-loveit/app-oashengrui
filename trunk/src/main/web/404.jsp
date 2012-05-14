<%@ page pageEncoding="UTF-8"%>
<%  
	String path = request.getContextPath();  
	String basePath = request.getScheme()+"://"+request.getServerName()+
		(request.getServerPort() == 80 ? "" : (":"+request.getServerPort())) +path+"/";  
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>Page Not Found</TITLE>
<META content="MSHTML 6.00.2900.2523" name="GENERATOR"></HEAD>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<STYLE>
BODY {
	FONT-SIZE: 12px; FONT-FAMILY: Tahoma
}
TD {
	FONT-SIZE: 12px; FONT-FAMILY: Tahoma
}
A:link {
	COLOR: #636363; TEXT-DECORATION: none
}
A:visited {
	COLOR: #838383; TEXT-DECORATION: none
}
A:hover {
	COLOR: #a3a3a3; TEXT-DECORATION: underline
}
BODY {
	BACKGROUND-COLOR: #cccccc
}
LI {
	LINE-HEIGHT:25px;
}
</STYLE>
<base href="<%=basePath%>">
<BODY style="TABLE-LAYOUT: fixed; WORD-BREAK: break-all" topMargin=10 marginwidth="10" marginheight="10">
	<TABLE height="95%" cellSpacing=0 cellPadding=0 width="100%" align=center border=0>
		<TBODY>
			<TR vAlign=center align=middle>
				<TD>
					<TABLE cellSpacing=0 cellPadding=0 width=468 bgColor=#ffffff border=0>
						<TBODY>
							<TR>
							  <TD width=20 background="resources/images/public/404/rbox_1.gif" 
					height=20></TD>
							  <TD width=108 background="resources/images/public/404/rbox_2.gif" 
							  height=20></TD>
							  <TD width=56><IMG height=20 src="resources/images/public/404/rbox_ring.gif" 
								width=56></TD>
							  <TD width=100 background="resources/images/public/404/rbox_2.gif"></TD>
							  <TD width=56><IMG height=20 src="resources/images/public/404/rbox_ring.gif" 
								width=56></TD>
							  <TD width=108 background="resources/images/public/404/rbox_2.gif"></TD>
							  <TD width=20 background="resources/images/public/404/rbox_3.gif" 
							height=20></TD></TR>
							<TR>
							  <TD align=left background="resources/images/public/404/rbox_4.gif" 
							  rowSpan=2></TD>
							  <TD align=middle colSpan=5 style="margin:5px 0;line-height:48px;font-size:12pt;color:red;border-bottom:1px solid #eee">
								<P style="background:url(resources/images/public/404/warning-large.png) no-repeat 20px 0"><strong>很抱歉，您要访问的页面不存在。
								</strong></P></TD>
							  <TD align=left background="resources/images/public/404/rbox_6.gif" 
							  rowSpan=2></TD></TR>
							<TR>
							  <TD align=left colSpan=5 height=80>
								<P align=center>
								<P id=LID2>没有找到您要访问的页面，请检查您是否输入正确URL。</P>
								<P>请尝试以下操作：</P>
								<UL>
								  <LI id=list1>如果您已经在地址栏中输入该网页的地址，请确认其拼写正确。<BR>
								  <LI id=list2>打开<a href="home">系统主页</a>，然后查找指向您感兴趣信息的链接。</LI>
								  <LI id=list3>单击后退链接，尝试其他链接</LI>
								  <LI id=list4>单击搜索链接，寻找Internet上的信息。</LI>
								  </UL>
								</TD></TR>
							<TR>
							  <TD align=left background="resources/images/public/404/rbox_7.gif" 
							  height=20></TD>
							  <TD align=left background="resources/images/public/404/rbox_8.gif" colSpan=5 
							  height=20></TD>
							  <TD align=left background="resources/images/public/404/rbox_9.gif" 
							  height=20></TD></TR>
						</TBODY>
					</TABLE>
				</TD>
			</TR>
		</TBODY>
	</TABLE>
</BODY>
</HTML>

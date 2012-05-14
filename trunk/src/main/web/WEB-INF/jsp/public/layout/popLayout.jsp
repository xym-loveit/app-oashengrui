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
  	<tiles:insert name="path"/>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
	<link rel="shortcut icon" href="resources/images/favicon.ico" type="image/x-icon"/>
	<link rel="stylesheet" href="resources/css/layout.css" type="text/css" media="screen" />
	<link rel="stylesheet" href="resources/css/jquerylib/dd.css" type="text/css" />
	<script type="text/javascript" src='resources/js/jquery-1.3.2.min.js'></script>
	<script type="text/javascript" src='resources/js/mary.util.js'></script>
	<script type="text/javascript" src='resources/js/jquerylib/jquery.jPrintArea.js'></script>
	<script type="text/javascript" src="resources/js/jquerylib/uncompressed.jquery.dd.js"></script>
	<link rel='stylesheet' href='resources/css/jquerylib/jquery.vtip.css'/>
	<script src="resources/js/jquerylib/jquery.vtip-min.js" type="text/javascript"></script>

	<!--[if lt IE 7]>  
	<script type="text/javascript" src="resources/js/pngfix/DD_belatedPNG_0.0.8a.js"></script>  
	<script type="text/javascript">  
		$(function(){
			DD_belatedPNG.fix('.pngfix');
		});
	</script>  
	<![endif]-->
	<script>
		$(function(){
			$.each($("input.text"),function(){
				$(this).focus(function(){$(this).addClass("textfocus")}).blur(function(){$(this).removeClass("textfocus")});
			});
			$(".frmbtn").mouseover(function(){$(this).addClass("frmbtnMouseOver");}).mouseout(function(){$(this).removeClass("frmbtnMouseOver")});
			try {
				$("select").filter(function(index){
					return !$(this).hasClass("unbeauty");
				}).msDropDown();
			} catch(e) {
			}
			if($.browser.msie){
				$("img").attr("align","middle"); 
			}
		});
	</script>
  </head>
  <body>
	<tiles:insert name="body"/>
  </body>
 </html>
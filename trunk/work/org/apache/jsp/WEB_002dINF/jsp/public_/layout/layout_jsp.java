package org.apache.jsp.WEB_002dINF.jsp.public_.layout;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class layout_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List _jspx_dependants;

  static {
    _jspx_dependants = new java.util.ArrayList(5);
    _jspx_dependants.add("/WEB-INF/tld/struts-tiles.tld");
    _jspx_dependants.add("/WEB-INF/tld/struts-html.tld");
    _jspx_dependants.add("/WEB-INF/tld/struts-logic.tld");
    _jspx_dependants.add("/WEB-INF/tld/struts-nested.tld");
    _jspx_dependants.add("/WEB-INF/tld/struts-bean.tld");
  }

  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005ftiles_005finsert_0026_005fname_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005ftiles_005fgetAsString_0026_005fname_005fnobody;

  private javax.el.ExpressionFactory _el_expressionfactory;
  private org.apache.AnnotationProcessor _jsp_annotationprocessor;

  public Object getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _005fjspx_005ftagPool_005ftiles_005finsert_0026_005fname_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005ftiles_005fgetAsString_0026_005fname_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
    _jsp_annotationprocessor = (org.apache.AnnotationProcessor) getServletConfig().getServletContext().getAttribute(org.apache.AnnotationProcessor.class.getName());
  }

  public void _jspDestroy() {
    _005fjspx_005ftagPool_005ftiles_005finsert_0026_005fname_005fnobody.release();
    _005fjspx_005ftagPool_005ftiles_005fgetAsString_0026_005fname_005fnobody.release();
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\r\n");
      out.write("\r\n");
      out.write("<html>\r\n");
      out.write("  <head>\r\n");
      out.write("  \t");
      if (_jspx_meth_tiles_005finsert_005f0(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("  \t<title>");
      if (_jspx_meth_tiles_005fgetAsString_005f0(_jspx_page_context))
        return;
      out.write("</title>\r\n");
      out.write("\t<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />\r\n");
      out.write("\t<meta http-equiv=\"X-UA-Compatible\" content=\"IE=EmulateIE7\" />\r\n");
      out.write("\t\r\n");
      out.write("\t<link rel=\"shortcut icon\" href=\"resources/images/favicon.ico\" type=\"image/x-icon\"/>\r\n");
      out.write("\t\r\n");
      out.write("\t<link href=\"resources/themes/default/style.css\" rel=\"stylesheet\" type=\"text/css\" media=\"screen\"/>\r\n");
      out.write("\t<link href=\"resources/themes/css/core.css\" rel=\"stylesheet\" type=\"text/css\" media=\"screen\"/>\r\n");
      out.write("\t<link href=\"resources/themes/css/print.css\" rel=\"stylesheet\" type=\"text/css\" media=\"print\"/>\r\n");
      out.write("\t<link href=\"resources/js/uploadify/css/uploadify.css\" rel=\"stylesheet\" type=\"text/css\" media=\"screen\"/>\r\n");
      out.write("\t<link href=\"resources/css/common.css\" rel=\"stylesheet\" type=\"text/css\" media=\"screen\"/>\r\n");
      out.write("\t\r\n");
      out.write("\t<!--[if IE]>\r\n");
      out.write("\t<link href=\"resources/themes/css/ieHack.css\" rel=\"stylesheet\" type=\"text/css\" media=\"screen\"/>\r\n");
      out.write("\t<![endif]-->\r\n");
      out.write("\t\r\n");
      out.write("\t<script src=\"resources/js/dwz/speedup.js\" type=\"text/javascript\"></script>\r\n");
      out.write("\t<script src=\"resources/js/dwz/jquery-1.7.1.js\" type=\"text/javascript\"></script>\r\n");
      out.write("\t<script src=\"resources/js/dwz/jquery.cookie.js\" type=\"text/javascript\"></script>\r\n");
      out.write("\t<script src=\"resources/js/dwz/jquery.validate.js\" type=\"text/javascript\"></script>\r\n");
      out.write("\t<script src=\"resources/js/dwz/jquery.bgiframe.js\" type=\"text/javascript\"></script>\r\n");
      out.write("\t<script src=\"resources/js/xheditor/xheditor-1.1.12-zh-cn.min.js\" type=\"text/javascript\"></script>\r\n");
      out.write("\t<script src=\"resources/js/uploadify//scripts/swfobject.js\" type=\"text/javascript\"></script>\r\n");
      out.write("\t<script src=\"resources/js/uploadify//scripts/jquery.resources/js/uploadify/.v2.1.0.js\" type=\"text/javascript\"></script>\r\n");
      out.write("\t\r\n");
      out.write("\t<script src=\"resources/js/dwz/dwz.core.js\" type=\"text/javascript\"></script>\r\n");
      out.write("\t<script src=\"resources/js/dwz/dwz.util.date.js\" type=\"text/javascript\"></script>\r\n");
      out.write("\t<script src=\"resources/js/dwz/dwz.validate.method.js\" type=\"text/javascript\"></script>\r\n");
      out.write("\t<script src=\"resources/js/dwz/dwz.regional.zh.js\" type=\"text/javascript\"></script>\r\n");
      out.write("\t<script src=\"resources/js/dwz/dwz.barDrag.js\" type=\"text/javascript\"></script>\r\n");
      out.write("\t<script src=\"resources/js/dwz/dwz.drag.js\" type=\"text/javascript\"></script>\r\n");
      out.write("\t<script src=\"resources/js/dwz/dwz.tree.js\" type=\"text/javascript\"></script>\r\n");
      out.write("\t<script src=\"resources/js/dwz/dwz.accordion.js\" type=\"text/javascript\"></script>\r\n");
      out.write("\t<script src=\"resources/js/dwz/dwz.ui.js\" type=\"text/javascript\"></script>\r\n");
      out.write("\t<script src=\"resources/js/dwz/dwz.theme.js\" type=\"text/javascript\"></script>\r\n");
      out.write("\t<script src=\"resources/js/dwz/dwz.switchEnv.js\" type=\"text/javascript\"></script>\r\n");
      out.write("\t<script src=\"resources/js/dwz/dwz.alertMsg.js\" type=\"text/javascript\"></script>\r\n");
      out.write("\t<script src=\"resources/js/dwz/dwz.contextmenu.js\" type=\"text/javascript\"></script>\r\n");
      out.write("\t<script src=\"resources/js/dwz/dwz.navTab.js\" type=\"text/javascript\"></script>\r\n");
      out.write("\t<script src=\"resources/js/dwz/dwz.tab.js\" type=\"text/javascript\"></script>\r\n");
      out.write("\t<script src=\"resources/js/dwz/dwz.resize.js\" type=\"text/javascript\"></script>\r\n");
      out.write("\t<script src=\"resources/js/dwz/dwz.dialog.js\" type=\"text/javascript\"></script>\r\n");
      out.write("\t<script src=\"resources/js/dwz/dwz.dialogDrag.js\" type=\"text/javascript\"></script>\r\n");
      out.write("\t<script src=\"resources/js/dwz/dwz.sortDrag.js\" type=\"text/javascript\"></script>\r\n");
      out.write("\t<script src=\"resources/js/dwz/dwz.cssTable.js\" type=\"text/javascript\"></script>\r\n");
      out.write("\t<script src=\"resources/js/dwz/dwz.stable.js\" type=\"text/javascript\"></script>\r\n");
      out.write("\t<script src=\"resources/js/dwz/dwz.taskBar.js\" type=\"text/javascript\"></script>\r\n");
      out.write("\t<script src=\"resources/js/dwz/dwz.ajax.js\" type=\"text/javascript\"></script>\r\n");
      out.write("\t<script src=\"resources/js/dwz/dwz.pagination.js\" type=\"text/javascript\"></script>\r\n");
      out.write("\t<script src=\"resources/js/dwz/dwz.database.js\" type=\"text/javascript\"></script>\r\n");
      out.write("\t<script src=\"resources/js/dwz/dwz.datepicker.js\" type=\"text/javascript\"></script>\r\n");
      out.write("\t<script src=\"resources/js/dwz/dwz.effects.js\" type=\"text/javascript\"></script>\r\n");
      out.write("\t<script src=\"resources/js/dwz/dwz.panel.js\" type=\"text/javascript\"></script>\r\n");
      out.write("\t<script src=\"resources/js/dwz/dwz.checkbox.js\" type=\"text/javascript\"></script>\r\n");
      out.write("\t<script src=\"resources/js/dwz/dwz.history.js\" type=\"text/javascript\"></script>\r\n");
      out.write("\t<script src=\"resources/js/dwz/dwz.combox.js\" type=\"text/javascript\"></script>\r\n");
      out.write("\t<script src=\"resources/js/dwz/dwz.print.js\" type=\"text/javascript\"></script>\r\n");
      out.write("\t<script src=\"resources/js/dwz/dwz.regional.zh.js\" type=\"text/javascript\"></script>\r\n");
      out.write("\t\r\n");
      out.write("\t<script src=\"resources/js/app.util.js\" type=\"text/javascript\"></script>\r\n");
      out.write("\t<script src=\"resources/js/kissyForm/kissy-min.js\" type=\"text/javascript\"></script>\r\n");
      out.write("\t\r\n");
      out.write("\t<!--[if lt IE 7]>  \r\n");
      out.write("\t<script type=\"text/javascript\" src=\"resources/js/pngfix/DD_belatedPNG_0.0.8a.js\"></script>  \r\n");
      out.write("\t<script type=\"text/javascript\">  \r\n");
      out.write("\t\t$(function(){\r\n");
      out.write("\t\t\tDD_belatedPNG.fix('.pngfix');\r\n");
      out.write("\t\t});\r\n");
      out.write("\t</script>  \r\n");
      out.write("\t<![endif]-->\r\n");
      out.write("\t");
  
		String path = request.getContextPath();  
		String basePath = request.getScheme()+"://"+request.getServerName()+
			(request.getServerPort() == 80 ? "" : (":"+request.getServerPort())) +path+"/";  
	
      out.write("\r\n");
      out.write("\t<script type=\"text/javascript\">\r\n");
      out.write("\t\tvar APP_BASE_PATH = \"");
      out.print(basePath);
      out.write("\";\r\n");
      out.write("\t\t$(function(){\r\n");
      out.write("\t\t\tDWZ.init(\"resources/js/dwz/dwz.frag.xml\", {\r\n");
      out.write("\t\t\t\tloginUrl:\"loginDialog.jsp\", loginTitle:\"登录\",\t// 弹出登录对话框\r\n");
      out.write("\t\t\t\tloginRedirectPattern: \"DWZ.init\",\r\n");
      out.write("\t\t\t\taccessDeniedPattern: '您没有权限访问该页面',\r\n");
      out.write("\t\t\t\taccessDeniedMessage: '您没有权限访问该页面!',\r\n");
      out.write("\t\t\t\tstatusCode:{ok:200, error:300, timeout:301}, \r\n");
      out.write("\t\t\t\tpageInfo:{pageNum:\"pageNum\", numPerPage:\"numPerPage\", orderField:\"orderField\", orderDirection:\"orderDirection\"}, \r\n");
      out.write("\t\t\t\tdebug:false,\t\r\n");
      out.write("\t\t\t\tcallback:function(){\r\n");
      out.write("\t\t\t\t\tinitEnv();\r\n");
      out.write("\t\t\t\t\t$(\"#themeList\").theme({themeBase:\"resources/themes\"}); // themeBase 相对于index页面的主题base路径\r\n");
      out.write("\t\t\t\t}\r\n");
      out.write("\t\t\t});\r\n");
      out.write("\t\t\t\r\n");
      out.write("\t\t\t//加载上传组件入口文件\r\n");
      out.write("\t\t\tKISSY.config({\r\n");
      out.write("\t\t\t\tpackages:[{\r\n");
      out.write("\t\t\t\t\tname:\"gallery\",\r\n");
      out.write("\t\t\t\t\tpath:APP_BASE_PATH + \"resources/js/kissyForm/\",\r\n");
      out.write("\t\t\t\t\tcharset:\"utf-8\"\r\n");
      out.write("\t\t\t\t}]\r\n");
      out.write("\t\t\t});\r\n");
      out.write("\t\t\t\r\n");
      out.write("\t\t});\r\n");
      out.write("\t</script>\r\n");
      out.write("\t\r\n");
      out.write("  </head>\r\n");
      out.write("\r\n");
      out.write("  <body scroll=\"no\" onbeforeunload=\"return '确认要离开？';\">\r\n");
      out.write("  \t<!-- Container Start -->\r\n");
      out.write("\t<div id=\"layout\">\r\n");
      out.write("\t\t\r\n");
      out.write("\t\t<!-- body header -->\r\n");
      out.write("\t\t<div id=\"header\">\r\n");
      out.write("\t\t\t");
      if (_jspx_meth_tiles_005finsert_005f1(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t\t\r\n");
      out.write("\t\t<!-- menu wrapper -->\r\n");
      out.write("\t\t<div id=\"leftside\">\r\n");
      out.write("\t\t\t");
      if (_jspx_meth_tiles_005finsert_005f2(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t\t\r\n");
      out.write("\t\t<!-- body content -->\r\n");
      out.write("\t\t<div id=\"container\">\r\n");
      out.write("\t\t\t<div id=\"navTab\" class=\"tabsPage\">\r\n");
      out.write("\t\t\t\t<div class=\"tabsPageHeader\">\r\n");
      out.write("\t\t\t\t\t<div class=\"tabsPageHeaderContent\"><!-- 显示左右控制时添加 class=\"tabsPageHeaderMargin\" -->\r\n");
      out.write("\t\t\t\t\t\t<ul class=\"navTab-tab\">\r\n");
      out.write("\t\t\t\t\t\t\t<li tabid=\"main\" class=\"main\"><a href=\"javascript:;\"><span><span class=\"home_icon\">我的主页</span></span></a></li>\r\n");
      out.write("\t\t\t\t\t\t</ul>\r\n");
      out.write("\t\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t\t<div class=\"tabsLeft\">left</div><!-- 禁用只需要添加一个样式 class=\"tabsLeft tabsLeftDisabled\" -->\r\n");
      out.write("\t\t\t\t\t<div class=\"tabsRight\">right</div><!-- 禁用只需要添加一个样式 class=\"tabsRight tabsRightDisabled\" -->\r\n");
      out.write("\t\t\t\t\t<div class=\"tabsMore\">more</div>\r\n");
      out.write("\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t<ul class=\"tabsMoreList\">\r\n");
      out.write("\t\t\t\t\t<li><a href=\"javascript:;\">我的主页</a></li>\r\n");
      out.write("\t\t\t\t</ul>\r\n");
      out.write("\t\t\t\t<div class=\"navTab-panel tabsPageContent layoutBox\">\r\n");
      out.write("\t\t\t\t\t");
      if (_jspx_meth_tiles_005finsert_005f3(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("\t\t\t\t</div>\r\n");
      out.write("\t\t\t</div>\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t\t\r\n");
      out.write("\t\t<div class=\"clear\"></div>\r\n");
      out.write("\t</div>\r\n");
      out.write("\t\r\n");
      out.write("\t<!-- body footer -->\r\n");
      out.write("\t<div id=\"footer\">\r\n");
      out.write("\t\t");
      if (_jspx_meth_tiles_005finsert_005f4(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("\t</div>\r\n");
      out.write("\t\t\r\n");
      out.write("  </body>\r\n");
      out.write(" </html>");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try { out.clearBuffer(); } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }

  private boolean _jspx_meth_tiles_005finsert_005f0(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  tiles:insert
    org.apache.struts.taglib.tiles.InsertTag _jspx_th_tiles_005finsert_005f0 = (org.apache.struts.taglib.tiles.InsertTag) _005fjspx_005ftagPool_005ftiles_005finsert_0026_005fname_005fnobody.get(org.apache.struts.taglib.tiles.InsertTag.class);
    _jspx_th_tiles_005finsert_005f0.setPageContext(_jspx_page_context);
    _jspx_th_tiles_005finsert_005f0.setParent(null);
    // /WEB-INF/jsp/public/layout/layout.jsp(14,3) name = name type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_tiles_005finsert_005f0.setName("path");
    int _jspx_eval_tiles_005finsert_005f0 = _jspx_th_tiles_005finsert_005f0.doStartTag();
    if (_jspx_th_tiles_005finsert_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005ftiles_005finsert_0026_005fname_005fnobody.reuse(_jspx_th_tiles_005finsert_005f0);
      return true;
    }
    _005fjspx_005ftagPool_005ftiles_005finsert_0026_005fname_005fnobody.reuse(_jspx_th_tiles_005finsert_005f0);
    return false;
  }

  private boolean _jspx_meth_tiles_005fgetAsString_005f0(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  tiles:getAsString
    org.apache.struts.taglib.tiles.GetAttributeTag _jspx_th_tiles_005fgetAsString_005f0 = (org.apache.struts.taglib.tiles.GetAttributeTag) _005fjspx_005ftagPool_005ftiles_005fgetAsString_0026_005fname_005fnobody.get(org.apache.struts.taglib.tiles.GetAttributeTag.class);
    _jspx_th_tiles_005fgetAsString_005f0.setPageContext(_jspx_page_context);
    _jspx_th_tiles_005fgetAsString_005f0.setParent(null);
    // /WEB-INF/jsp/public/layout/layout.jsp(15,10) name = name type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_tiles_005fgetAsString_005f0.setName("title");
    int _jspx_eval_tiles_005fgetAsString_005f0 = _jspx_th_tiles_005fgetAsString_005f0.doStartTag();
    if (_jspx_th_tiles_005fgetAsString_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005ftiles_005fgetAsString_0026_005fname_005fnobody.reuse(_jspx_th_tiles_005fgetAsString_005f0);
      return true;
    }
    _005fjspx_005ftagPool_005ftiles_005fgetAsString_0026_005fname_005fnobody.reuse(_jspx_th_tiles_005fgetAsString_005f0);
    return false;
  }

  private boolean _jspx_meth_tiles_005finsert_005f1(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  tiles:insert
    org.apache.struts.taglib.tiles.InsertTag _jspx_th_tiles_005finsert_005f1 = (org.apache.struts.taglib.tiles.InsertTag) _005fjspx_005ftagPool_005ftiles_005finsert_0026_005fname_005fnobody.get(org.apache.struts.taglib.tiles.InsertTag.class);
    _jspx_th_tiles_005finsert_005f1.setPageContext(_jspx_page_context);
    _jspx_th_tiles_005finsert_005f1.setParent(null);
    // /WEB-INF/jsp/public/layout/layout.jsp(127,3) name = name type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_tiles_005finsert_005f1.setName("header");
    int _jspx_eval_tiles_005finsert_005f1 = _jspx_th_tiles_005finsert_005f1.doStartTag();
    if (_jspx_th_tiles_005finsert_005f1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005ftiles_005finsert_0026_005fname_005fnobody.reuse(_jspx_th_tiles_005finsert_005f1);
      return true;
    }
    _005fjspx_005ftagPool_005ftiles_005finsert_0026_005fname_005fnobody.reuse(_jspx_th_tiles_005finsert_005f1);
    return false;
  }

  private boolean _jspx_meth_tiles_005finsert_005f2(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  tiles:insert
    org.apache.struts.taglib.tiles.InsertTag _jspx_th_tiles_005finsert_005f2 = (org.apache.struts.taglib.tiles.InsertTag) _005fjspx_005ftagPool_005ftiles_005finsert_0026_005fname_005fnobody.get(org.apache.struts.taglib.tiles.InsertTag.class);
    _jspx_th_tiles_005finsert_005f2.setPageContext(_jspx_page_context);
    _jspx_th_tiles_005finsert_005f2.setParent(null);
    // /WEB-INF/jsp/public/layout/layout.jsp(132,3) name = name type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_tiles_005finsert_005f2.setName("menu");
    int _jspx_eval_tiles_005finsert_005f2 = _jspx_th_tiles_005finsert_005f2.doStartTag();
    if (_jspx_th_tiles_005finsert_005f2.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005ftiles_005finsert_0026_005fname_005fnobody.reuse(_jspx_th_tiles_005finsert_005f2);
      return true;
    }
    _005fjspx_005ftagPool_005ftiles_005finsert_0026_005fname_005fnobody.reuse(_jspx_th_tiles_005finsert_005f2);
    return false;
  }

  private boolean _jspx_meth_tiles_005finsert_005f3(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  tiles:insert
    org.apache.struts.taglib.tiles.InsertTag _jspx_th_tiles_005finsert_005f3 = (org.apache.struts.taglib.tiles.InsertTag) _005fjspx_005ftagPool_005ftiles_005finsert_0026_005fname_005fnobody.get(org.apache.struts.taglib.tiles.InsertTag.class);
    _jspx_th_tiles_005finsert_005f3.setPageContext(_jspx_page_context);
    _jspx_th_tiles_005finsert_005f3.setParent(null);
    // /WEB-INF/jsp/public/layout/layout.jsp(152,5) name = name type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_tiles_005finsert_005f3.setName("body");
    int _jspx_eval_tiles_005finsert_005f3 = _jspx_th_tiles_005finsert_005f3.doStartTag();
    if (_jspx_th_tiles_005finsert_005f3.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005ftiles_005finsert_0026_005fname_005fnobody.reuse(_jspx_th_tiles_005finsert_005f3);
      return true;
    }
    _005fjspx_005ftagPool_005ftiles_005finsert_0026_005fname_005fnobody.reuse(_jspx_th_tiles_005finsert_005f3);
    return false;
  }

  private boolean _jspx_meth_tiles_005finsert_005f4(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  tiles:insert
    org.apache.struts.taglib.tiles.InsertTag _jspx_th_tiles_005finsert_005f4 = (org.apache.struts.taglib.tiles.InsertTag) _005fjspx_005ftagPool_005ftiles_005finsert_0026_005fname_005fnobody.get(org.apache.struts.taglib.tiles.InsertTag.class);
    _jspx_th_tiles_005finsert_005f4.setPageContext(_jspx_page_context);
    _jspx_th_tiles_005finsert_005f4.setParent(null);
    // /WEB-INF/jsp/public/layout/layout.jsp(162,2) name = name type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_tiles_005finsert_005f4.setName("footer");
    int _jspx_eval_tiles_005finsert_005f4 = _jspx_th_tiles_005finsert_005f4.doStartTag();
    if (_jspx_th_tiles_005finsert_005f4.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005ftiles_005finsert_0026_005fname_005fnobody.reuse(_jspx_th_tiles_005finsert_005f4);
      return true;
    }
    _005fjspx_005ftagPool_005ftiles_005finsert_0026_005fname_005fnobody.reuse(_jspx_th_tiles_005finsert_005f4);
    return false;
  }
}

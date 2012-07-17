package org.apache.jsp.WEB_002dINF.jsp.public_.layout;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class menu_jsp extends org.apache.jasper.runtime.HttpJspBase
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

  private javax.el.ExpressionFactory _el_expressionfactory;
  private org.apache.AnnotationProcessor _jsp_annotationprocessor;

  public Object getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
    _jsp_annotationprocessor = (org.apache.AnnotationProcessor) getServletConfig().getServletContext().getAttribute(org.apache.AnnotationProcessor.class.getName());
  }

  public void _jspDestroy() {
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
      out.write("<div id=\"sidebar_s\">\r\n");
      out.write("\t<div class=\"collapse\">\r\n");
      out.write("\t\t<div class=\"toggleCollapse\"><div></div></div>\r\n");
      out.write("\t</div>\r\n");
      out.write("</div>\r\n");
      out.write("<div id=\"sidebar\">\r\n");
      out.write("\t<div class=\"toggleCollapse\"><h2 class=\"icon-navigation\">主菜单</h2><div>收缩</div></div>\r\n");
      out.write("\t<div class=\"accordion\" fillSpace=\"sidebar\">\r\n");
      out.write("\t\t\r\n");
      out.write("\t\t<!-- 个人工作区 -->\r\n");
      out.write("\t\t<div class=\"accordionHeader\">\r\n");
      out.write("\t\t\t<h2><span id=\"menu-desktop\">Folder</span>我的工作区</h2>\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t\t<div class=\"accordionContent\">\r\n");
      out.write("\t\t\t<ul class=\"tree treeFolder\">\r\n");
      out.write("\t\t\t\t<li treeicon=\"icon-myplan\"><a href=\"app/personal.do?action=pageMyWorkplan\" target=\"navTab\" rel=\"myplan\">我的任务</a></li>\r\n");
      out.write("\t\t\t\t<li treeicon=\"icon-myconference\"><a href=\"app/personal.do?action=pageMyConference\" target=\"navTab\" rel=\"myconference\">我的会议</a></li>\r\n");
      out.write("\t\t\t\t<li treeicon=\"icon-mynews\"><a href=\"app/personal.do?action=pageMyNews\" target=\"navTab\" rel=\"mynews\">我的新闻</a></li>\r\n");
      out.write("\t\t\t\t<li treeicon=\"icon-infodoc\"><a href=\"app/personal.do?action=pageMyDoc\" target=\"navTab\" rel=\"mydoc\">文档下载区</a></li>\r\n");
      out.write("\t\t\t\t<li treeicon=\"icon-hrjobreg\"><a href=\"app/personal/jobapplication.do?action=pageJobOnHiring\" target=\"navTab\" rel=\"personal_myjobform\">我要应聘</a></li>\r\n");
      out.write("\t\t\t\t<li treeicon=\"icon-myinvite\"><a href=\"app/personal/interview.do?action=pageMyInterviewToDo\" target=\"navTab\" rel=\"personal_myinterviews\">我做伯乐</a></li>\r\n");
      out.write("\t\t\t\t<li treeicon=\"icon-myapply\"><a href=\"blank.jsp\" target=\"navTab\" rel=\"myapply\">我的申请</a></li>\r\n");
      out.write("\t\t\t\t<li treeicon=\"icon-myapproval\"><a href=\"blank.jsp\" target=\"navTab\" rel=\"mytodo\">待我审批</a></li>\r\n");
      out.write("\t\t\t</ul>\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t\t\r\n");
      out.write("\t\t<!-- 行政管理 -->\r\n");
      out.write("\t\t<div class=\"accordionHeader\">\r\n");
      out.write("\t\t\t<h2><span id=\"menu-administrator\">Folder</span>行政管理</h2>\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t\t<div class=\"accordionContent\">\r\n");
      out.write("\t\t\t<ul class=\"tree treeFolder\">\r\n");
      out.write("\t\t\t\t<li treeicon=\"icon-adminnews\"><a href=\"app/admin.do?action=adminPageEntryIndex\" target=\"navTab\" rel=\"admin_entry\">新闻发布与管理</a></li>\r\n");
      out.write("\t\t\t\t<li treeicon=\"icon-admintask\"><a href=\"app/admin.do?action=adminPageTaskDelegateIndex\" target=\"navTab\" rel=\"admin_task\">任务委托管理</a></li>\r\n");
      out.write("\t\t\t\t<li treeicon=\"icon-admindutyStaff\"><a>员工考勤管理</a>\r\n");
      out.write("\t\t\t\t\t<ul>\r\n");
      out.write("\t\t\t\t\t\t<li treeicon=\"icon-admindutyArrange\"><a href=\"app/admin.do?action=adminPageStaffWorkArrange\" target=\"navTab\" rel=\"admin_workArrange\">工作安排</a></li>\r\n");
      out.write("\t\t\t\t\t\t<li treeicon=\"icon-adminduty\"><a href=\"app/admin.do?action=adminPageStaffAttendance\" target=\"navTab\" rel=\"admin_staffAttendance\">员工考勤</a></li>\r\n");
      out.write("\t\t\t\t\t</ul>\r\n");
      out.write("\t\t\t\t</li>\r\n");
      out.write("\t\t\t\t<li treeicon=\"icon-infoshared\"><a href=\"app/admin/doc.do?action=adminPageDocumentIndex\" target=\"navTab\" rel=\"admin_doc\">文档上传与管理</a></li>\r\n");
      out.write("\t\t\t</ul>\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t\t\r\n");
      out.write("\t\t<!-- 人资管理 -->\r\n");
      out.write("\t\t<div class=\"accordionHeader\">\r\n");
      out.write("\t\t\t<h2><span id=\"menu-hr\">Folder</span>人资管理</h2>\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t\t<div class=\"accordionContent\">\r\n");
      out.write("\t\t\t<ul class=\"tree treeFolder\">\r\n");
      out.write("\t\t\t\t<li treeicon=\"icon-hrjobm\"><a>招聘管理</a>\r\n");
      out.write("\t\t\t\t\t<ul>\r\n");
      out.write("\t\t\t\t\t\t<li treeicon=\"icon-hrjobmIssue\"><a href=\"app/hrm/hire.do?action=hrmJobIndex\" target=\"navTab\" rel=\"hrm_jobIndex\">当前招聘管理</a></li>\r\n");
      out.write("\t\t\t\t\t\t<li treeicon=\"icon-hrjobmProfile\"><a href=\"app/hrm/archive.do?action=hrmJobResumeIndex\" target=\"navTab\" rel=\"hrm_archiveIndex\">公司人才库</a></li>\r\n");
      out.write("\t\t\t\t\t</ul>\r\n");
      out.write("\t\t\t\t</li>\r\n");
      out.write("\t\t\t\t<li treeicon=\"icon-hrstaffm\"><a>员工档案管理</a>\r\n");
      out.write("\t\t\t\t\t<ul>\r\n");
      out.write("\t\t\t\t\t\t<li treeicon=\"icon-hrjobreg\"><a href=\"app/hrm/entry.do?action=hrmPageEntryIndex\" target=\"navTab\" rel=\"hrm_entryIndex\">招聘入职</a></li>\r\n");
      out.write("\t\t\t\t\t\t<li treeicon=\"icon-hrstaffmProfile\"><a href=\"app/hrm/employee.do?action=hrmEmployeeDocIndex\" target=\"navTab\" rel=\"hrm_employeeIndex\">员工档案</a></li>\r\n");
      out.write("\t\t\t\t\t</ul>\r\n");
      out.write("\t\t\t\t</li>\r\n");
      out.write("\t\t\t\t<li treeicon=\"icon-hrmcheck\"><a href=\"app/hrm/develop.do?action=hrmEmployeeDevelopIndex\" target=\"navTab\" rel=\"demo_page1\">人力发展管理</a></li>\r\n");
      out.write("\t\t\t</ul>\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t\t\r\n");
      out.write("\t\t<!-- 财务管理 -->\r\n");
      out.write("\t\t<div class=\"accordionHeader\">\r\n");
      out.write("\t\t\t<h2><span id=\"menu-financial\">Folder</span>财务管理</h2>\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t\t<div class=\"accordionContent\">\r\n");
      out.write("\t\t\t<ul class=\"tree treeFolder\">\r\n");
      out.write("\t\t\t\t<li treeicon=\"icon-finmrmb\"><a>费用支出管理</a>\r\n");
      out.write("\t\t\t\t\t<ul>\r\n");
      out.write("\t\t\t\t\t\t<li treeicon=\"icon-finmrmbApply\"><a href=\"app/finan/expense.do?action=pageFinaExpenseIndex\" target=\"navTab\" rel=\"fina_expense_index\">费用支出申请</a></li>\r\n");
      out.write("\t\t\t\t\t\t<li treeicon=\"icon-finmrmbApproval\"><a href=\"blank.jsp\" target=\"navTab\" rel=\"demo_page2\">费用审批记录</a></li>\r\n");
      out.write("\t\t\t\t\t</ul>\r\n");
      out.write("\t\t\t\t</li>\r\n");
      out.write("\t\t\t\t<li treeicon=\"icon-finmcontracts\"><a>合同管理</a>\r\n");
      out.write("\t\t\t\t\t<ul>\r\n");
      out.write("\t\t\t\t\t\t<li treeicon=\"icon-finmcontractsApply\"><a href=\"app/finan/contract.do?action=pageFinaContractIndex\" target=\"navTab\" rel=\"fina_contract_index\">合同审批申请</a></li>\r\n");
      out.write("\t\t\t\t\t\t<li treeicon=\"icon-finmcontractsRecords\"><a href=\"blank.jsp\" target=\"navTab\" rel=\"demo_page2\">合同审批记录</a></li>\r\n");
      out.write("\t\t\t\t\t</ul>\r\n");
      out.write("\t\t\t\t</li>\r\n");
      out.write("\t\t\t</ul>\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t\t\r\n");
      out.write("\t\t<!-- 系统管理 -->\r\n");
      out.write("\t\t<div class=\"accordionHeader\">\r\n");
      out.write("\t\t\t<h2><span id=\"menu-system\">Folder</span>系统管理</h2>\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t\t<div class=\"accordionContent\">\r\n");
      out.write("\t\t\t<ul class=\"tree treeFolder\">\r\n");
      out.write("\t\t\t\t<li treeicon=\"icon-sysmpwd\"><a href=\"blank.jsp\" target=\"navTab\" rel=\"demo_page1\">密码修改</a></li>\r\n");
      out.write("\t\t\t\t<li treeicon=\"icon-sysmusr\"><a href=\"app/system/account.do?action=pageAccountIndex\" target=\"navTab\" rel=\"sysmgr_account\">用户管理</a></li>\r\n");
      out.write("\t\t\t\t<li treeicon=\"icon-sysmlogs\"><a href=\"blank.jsp\" target=\"navTab\" rel=\"demo_page1\">系统日志</a></li>\r\n");
      out.write("\t\t\t</ul>\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t\t\r\n");
      out.write("\t\t<!-- 系统设置 -->\r\n");
      out.write("\t\t<div class=\"accordionHeader\">\r\n");
      out.write("\t\t\t<h2><span id=\"menu-settings\">Folder</span>系统设置</h2>\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t\t<div class=\"accordionContent\">\r\n");
      out.write("\t\t\t<ul class=\"tree treeFolder\">\r\n");
      out.write("\t\t\t\t<li treeicon=\"icon-setdic\"><a href=\"blank.jsp\" target=\"navTab\" rel=\"demo_page1\">数据字典设置</a></li>\r\n");
      out.write("\t\t\t\t<li treeicon=\"icon-setaskm\"><a>工作安排设置</a>\r\n");
      out.write("\t\t\t\t\t<ul>\r\n");
      out.write("\t\t\t\t\t\t<li treeicon=\"icon-setaskmTpl\"><a href=\"app/system/work/template.do?action=pageWorkTemplateIndex\" target=\"navTab\" rel=\"sysmgr_work_template\">工作安排模板设置</a></li>\r\n");
      out.write("\t\t\t\t\t\t<li treeicon=\"icon-setaskmBase\"><a href=\"app/system/work/base.do?action=pageWorkBaseIndex\" target=\"navTab\" rel=\"sysmgr_work_base\">工作安排基础设置</a></li>\r\n");
      out.write("\t\t\t\t\t</ul>\r\n");
      out.write("\t\t\t\t</li>\r\n");
      out.write("\t\t\t\t<li treeicon=\"icon-setflowm\"><a>审批流程设置</a>\r\n");
      out.write("\t\t\t\t\t<ul>\r\n");
      out.write("\t\t\t\t\t\t<li treeicon=\"icon-setflowmhr\"><a href=\"blank.jsp\" target=\"navTab\" rel=\"sysmgr_flow_hrm\">人资审批流程设置</a></li>\r\n");
      out.write("\t\t\t\t\t\t<li treeicon=\"icon-setflowmfin\"><a href=\"app/flow/financial.do?action=pageFlowIndex\" target=\"navTab\" rel=\"sysmgr_flow_financial\">财务审批流程设置</a></li>\r\n");
      out.write("\t\t\t\t\t</ul>\r\n");
      out.write("\t\t\t\t</li>\r\n");
      out.write("\t\t\t\t<li treeicon=\"icon-setorg\"><a>学校设置</a>\r\n");
      out.write("\t\t\t\t\t<ul>\r\n");
      out.write("\t\t\t\t\t\t<li treeicon=\"icon-setorgDep\"><a href=\"app/system/school/district.do?action=pageSchoolDistrictIndex\" target=\"navTab\" rel=\"sysmgr_school_district\">校区设置</a></li>\r\n");
      out.write("\t\t\t\t\t\t<li treeicon=\"icon-setorgRepo\"><a href=\"app/system/school/department.do?action=pageSchoolDepartmentIndex\" target=\"navTab\" rel=\"sysmgr_school_depindex\">部门岗位设置</a></li>\r\n");
      out.write("\t\t\t\t\t\t<!--<li treeicon=\"icon-setorgBricks\"><a href=\"blank.jsp\" target=\"navTab\" rel=\"demo_page2\">岗位权限设置</a></li>-->\r\n");
      out.write("\t\t\t\t\t</ul>\r\n");
      out.write("\t\t\t\t</li>\r\n");
      out.write("\t\t\t\t<li treeicon=\"icon-setrole\"><a href=\"app/system/role.do?action=pageRoleIndex\" target=\"navTab\" rel=\"sysmgr_role\">权限组配置</a></li>\r\n");
      out.write("\t\t\t\t<li treeicon=\"icon-setres\"><a href=\"app/system/menu.do?action=pageMenuIndex\" target=\"navTab\" rel=\"sysmgr_resmenu\">菜单设置</a></li>\r\n");
      out.write("\t\t\t</ul>\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t</div>\r\n");
      out.write("</div>");
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
}

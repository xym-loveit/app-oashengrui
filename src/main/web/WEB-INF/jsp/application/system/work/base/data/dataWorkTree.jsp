<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript">
	// 高亮显示选中的菜单项, 供功能菜单联动选择
	function dep_activated(id) {
		var uroot = $("#dentity_" + id).parent().parent().parent();
		uroot.find("div.selected").removeClass("selected");
		$("#dentity_" + id).parent().addClass("selected");
	}
	
	function district_activated(id) {
	      var uroot = $("#district_" + id).parent().parent().parent();
	      uroot.find("div.selected").removeClass("selected");
	      $("#district_" + id).parent().addClass("selected");
	   }
	function template_activated(id) {
		var uroot = $("#template_" + id).parent().parent().parent();
        uroot.find("div.selected").removeClass("selected");
        $("#template_" + id).parent().addClass("selected");
	}
</script>

<logic:present name="lookup">
	<div class="pageContent">
	<div class="pageFormContent" layoutH="58">
</logic:present>

<ul class="tree treeFolder" layoutH="8">
	<c:if test="${districts ne null}">
		<c:forEach items="${districts}" var="entity">
			<li class="expand"><a id="org_master"><c:out value="${entity.districtName}" /></a>
			   <ul>
			     <li><a id="dentity_${entity.id}" class='tparam' param="_var_districtId" paramRel="${entity.id}" href="app/system/work/base.do?action=pageWorkBaseContent&districtId=${entity.id}" callback="dep_activated(${entity.id});" target="ajax" rel="ajBoxDepPos"><c:out value="工作内容设置" /></a></li>
			     <li><a id="district_${entity.id}" class='tparam' param="_var_districtId" paramRel="${entity.id}" href="app/system/work/base/time.do?action=pageWorkBaseTime&districtId=${entity.id}" callback="district_activated(${entity.id});" target="ajax" rel="ajBoxDepPos"><c:out value="工作时间设置" /></a>
			         <ul>
                     <li><a id="template_${entity.id}" class='tparam' param="_var_districtId" paramRel="${entity.id}" href="app/system/work/base/time.do?action=pageWorkBaseTime&districtId=${entity.id}&templateId=1" callback="template_activated(${entity.id});" target="ajax" rel="ajBoxDepPos">第一套</a></li>
                     <li><a id="template_${entity.id}" class='tparam' param="_var_districtId" paramRel="${entity.id}" href="app/system/work/base/time.do?action=pageWorkBaseTime&districtId=${entity.id}&templateId=2" callback="template_activated(${entity.id});" target="ajax" rel="ajBoxDepPos">第二套</a></li>
                     <li><a id="template_${entity.id}" class='tparam' param="_var_districtId" paramRel="${entity.id}" href="app/system/work/base/time.do?action=pageWorkBaseTime&districtId=${entity.id}&templateId=3" callback="template_activated(${entity.id});" target="ajax" rel="ajBoxDepPos">第三套</a></li>
                     <li><a id="template_${entity.id}" class='tparam' param="_var_districtId" paramRel="${entity.id}" href="app/system/work/base/time.do?action=pageWorkBaseTime&districtId=${entity.id}&templateId=4" callback="template_activated(${entity.id});" target="ajax" rel="ajBoxDepPos">第四套</a></li>
                  </ul>
			     </li>
			   </ul>
			</li>
		</c:forEach>
	</c:if>
</ul>

<logic:present name="lookup">
	</div>
	<div class="formBar">
	<ul>
		<li>
		<div class="button">
		<div class="buttonContent">
		<button class="close" type="button">关闭</button>
		</div>
		</div>
		</li>
	</ul>
	</div>
	</div>
</logic:present>

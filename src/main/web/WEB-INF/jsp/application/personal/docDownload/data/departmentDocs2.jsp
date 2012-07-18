<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix='fmt'%>


<!-- Body -->	
<div class="pageContent">
	<div class="panelBar">
		<ul class="toolBar">
		    <li><a class="add" href="app/personal/doc.do?action=pageMyDocMore&typeId=2&levleId=3" target="navTab" rel="moreDocs"><span>行政文档</span></a></li>
			<li><a class="add" href="app/personal/doc.do?action=pageMyDocMore&typeId=2&levleId=3" target="navTab" rel="moreDocs"><span>More</span></a></li>
		</ul>
	</div>
	<table class="table" width="100%" layoutH="350px">
		<thead>
			<tr>
				<th align="center">文档名称</th>
				<th align="center">上传时间</th>
			</tr>
		</thead>
		
		<tbody>
		<logic:present name="department_docs2">
		   <logic:iterate name="department_docs2" id="entity">
			<tr id="doc_entity-${entity.id}">
                <td>${entity.docName}</td>
                <td><fmt:formatDate value="${entity.createTime}" pattern="yyyy-MM-dd" /></td>
			</tr>
			</logic:iterate>
		  </logic:present>
		</tbody>
	</table>
</div>
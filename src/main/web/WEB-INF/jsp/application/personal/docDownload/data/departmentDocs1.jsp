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
    		<li><a class="add" href="app/personal/doc.do?action=pageMyDocMore&typeId=1&levleId=3" target="navTab" rel="moreDocs"><span>More人资文档</span></a></li>
			<li><a class="add" href="app/personal/doc.do?action=pageMyDocMore&typeId=2&levleId=3" target="navTab" rel="moreDocs"><span>More行政文档</span></a></li>
		</ul>
	</div>
	<table class="table" width="100%" layoutH="380px">
		<thead>
			<tr>
				<th align="center">文档名称</th>
				<th align="center">上传时间</th>
			</tr>
		</thead>
		
		<tbody>
		<logic:present name="department_docs1">
		   <logic:iterate name="department_docs1" id="entity">
			<tr id="doc_entity-${entity.id}" target="sid" rel="${entity.file.filePath}">
                <td><a href="/soa/file-download?path=${entity.file.filePath}" target="_blank">${entity.docName}</a></td>
                <td><fmt:formatDate value="${entity.createTime}" pattern="yyyy-MM-dd" /></td>
			</tr>
			</logic:iterate>
		  </logic:present>
		</tbody>
	</table>
</div>
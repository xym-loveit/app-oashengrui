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
		<ul class="toolBar" style="float:right">
		    <li><a class="add" href="app/personal/doc.do?action=pageMyDocMore&levleId=2" target="navTab" rel="moreDocs"><span>更多文档</span></a></li>
		</ul>
	</div>
	<table class="table" width="100%" layoutH="380px">
		<thead>
			<tr>
				<th align="center">文档名称</th>
				<th align="center">文档类型</th>
				<th align="center">上传时间</th>
			</tr>
		</thead>
		
		<tbody>
		<logic:present name="district_docs1">
		   <logic:iterate name="district_docs1" id="entity">
			<tr id="doc_entity-${entity.id}" target="sid" rel="${entity.file.filePath}">
                <td><a href="file-download?path=${entity.file.filePath}" target="_blank">${entity.docName}</a></td>
				<td>${entity ne null && entity.type ne null ? entity.type.value:"" }</td>
                <td><fmt:formatDate value="${entity.createTime}" pattern="yyyy-MM-dd" /></td>
			</tr>
			</logic:iterate>
		  </logic:present>
		</tbody>
	</table>
</div>
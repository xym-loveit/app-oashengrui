<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<!-- Body -->	
<div class="pageContent">
	<div class="panelBar">
		<ul class="toolBar">
			<li>公司文档区&nbsp;&nbsp;&nbsp;&nbsp;</li>
			<li><a class="add" href="">More</a></li>
		</ul>
	</div>
	<table class="table" width="100%" layoutH="138">
		<thead>
			<tr>
				<th align="center">文档名称</th>
				<th align="center">上传时间</th>
			</tr>
		</thead>
		
		<tbody>
		<logic:present name="company_docs">
		   <logic:iterate name="company_docs" id="entity">
			<tr id="doc_entity-${entity.id}">
                <td>${entity.docName}</td>
                <td>${entity.createTime}</td>
			</tr>
			</logic:iterate>
		  </logic:present>
		</tbody>
		
	</table>
	
</div>
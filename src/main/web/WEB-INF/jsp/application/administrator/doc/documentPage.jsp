<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="pageContent">
	<form method="post" action="demo/common/ajaxDone.html" class="pageForm required-validate" onsubmit="return validateCallback(this, navTabAjaxDone);">
		<div class="pageFormContent" layoutH="56">
			<div style="float:right; width: 300px;">
				<div class="accordion">
					<div class="accordionHeader">
						<h2><span>icon</span>按校区</h2>
					</div>
					<div class="accordionContent" style="height:200px">
						<ul class="tree treeFolder">
							<li><a href="javascript:;">杭州总部</a>
								<ul>
									<li><a href="javascript:;" rel="ac_10">总经办</a></li>
									<li><a href="javascript:;" rel="ac_11">行政办</a></li>
									<li><a href="javascript:;" rel="ac_12">财务部</a></li>
								</ul>
							</li>
							<li><a href="javascript:;">柯桥校区</a>
								<ul>
									<li><a href="javascript:;" rel="ac_10">总经办</a></li>
									<li><a href="javascript:;" rel="ac_11">行政办</a></li>
									<li><a href="javascript:;" rel="ac_12">财务部</a></li>
								</ul>
							</li>
							<li><a href="javascript:;">萧山校区</a>
								<ul>
									<li><a href="javascript:;" rel="ac_10">总经办</a></li>
									<li><a href="javascript:;" rel="ac_11">行政办</a></li>
									<li><a href="javascript:;" rel="ac_12">财务部</a></li>
								</ul>
							</li>
						</ul>
					</div>
					<div class="accordionHeader">
						<h2><span>icon</span>按部门</h2>
					</div>
					<div class="accordionContent">
						<ul class="tree treeFolder">
							<li><a href="javascript:;">总部人资部</a>
								<ul>
									<li><a href="javascript:;" rel="ac_10">柯桥校区人资部</a></li>
									<li><a href="javascript:;" rel="ac_11">萧山校区人资部</a></li>
									<li><a href="javascript:;" rel="ac_12">临安校区人资部</a></li>
								</ul>
							</li>
							<li><a href="javascript:;">总部总经办</a>
								<ul>
									<li><a href="javascript:;" rel="ac_10">柯桥校区校长室</a></li>
									<li><a href="javascript:;" rel="ac_11">萧山校区校长室</a></li>
									<li><a href="javascript:;" rel="ac_12">临安校区校长室</a></li>
								</ul>
							</li>
							<li><a href="javascript:;">总部学馆部</a>
								<ul>
									<li><a href="javascript:;" rel="ac_10">柯桥校区学馆部</a></li>
									<li><a href="javascript:;" rel="ac_11">萧山校区学馆部</a></li>
									<li><a href="javascript:;" rel="ac_12">临安校区学馆部</a></li>
								</ul>
							</li>
						</ul>
					</div>
				</div>
			</div>
			<div style="margin-right: 320px">
				<table cellspacing="10" cellpadding="10" style="border-spacing:12; width: 100%;">
					<tr>
						<td width="100px;">文档类型：</td>
						<td>
							<select class="combox" name="type" id="doc_type" style="width:100px">
								<option value="1">人资文档</option>
							</select>
						</td>
						<td>文档级别：</td>
						<td>
							<select class="combox" name="type" id="doc_level" style="width:100px">
								<option value="1">公司级别</option>
								<option value="2">校区级别</option>
								<option value="3">本校区部门级别</option>
							</select>
						</td>
					</tr>
					<tr>
						<td>文档名称：</td>
						<td colspan="3">
							<input type="text" style="width: 100%" />
						</td>
					</tr>
					<tr>
						<td>文档范围：</td>
						<td colspan="3">
							<select class="combox" name="type" id="doc_visible" style="width:100px">
								<option value="1">所有校区</option>
								<option value="2">杭州总部</option>
								<option value="3">萧山校区</option>
								<option value="3">设置个人可见</option>
							</select>
						</td>
					</tr>
					<tr>
						<td style="vertical-align:top">文档可见人：</td>
						<td colspan="3"><textarea name="description" rows="5" cols="60" style="width: 100%">内容</textarea></td>
					</tr>
					<tr>
						<td>上传中心：</td>
						<td>
							<select class="combox" name="type" id="doc_ucenter" style="width:100px">
								<option value="1">杭州总部</option>
							</select>
						</td>
						<td>上传部门：</td>
						<td>
							<select class="combox" name="type" id="doc_udep" style="width:100px">
								<option value="1">人资部</option>
							</select>
						</td>
					</tr>
					<tr>
						<td>文档上传：</td>
						<td colspan="3">
							
						</td>
					</tr>
				</table>
			</div>
		</div>
		<div class="formBar">
			<ul>
				<!--<li><a class="buttonActive" href="javascript:;"><span>保存</span></a></li>-->
				<logic:present name="op">
					<logic:equal name="op" value="new">
						<li><div class="buttonActive"><div class="buttonContent"><button type="submit">文档上传</button></div></div></li>
					</logic:equal>
				</logic:present>
				<logic:notPresent name="op">
					<li><div class="buttonActive"><div class="buttonContent"><button type="submit">文档编辑</button></div></div></li>
				</logic:notPresent>
				<li>
					<div class="button"><div class="buttonContent"><button type="button" class="close">取消</button></div></div>
				</li>
			</ul>
		</div>
	</form>
</div>
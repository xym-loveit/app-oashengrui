<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script>
	/**
     * 向事件面板添加消息
     * @param evt
     * @param msg
     */
    function addMsg(evt, msg) {
        var $panel = $("#J_Panel");
        $panel.append("<p>事件名称：" + evt.type + "，" + msg + "</p>");
    }

	$(function() {
		
		//加载上传组件入口文件
		KISSY.use('gallery/form/1.2/uploader/index', function (S, RenderUploader) {
			var ru = new RenderUploader('#J_UploaderBtn', '#J_UploaderQueue',{
				 //服务器端配置
				serverConfig:{
					//处理上传的服务器端脚本路径
					action:"file-upload",
					data: {
						"test" : "a"
					}
				},
				// 文件域
				name:"Filedata",
				//用于放服务器端返回的url的隐藏域
				urlsInputName:"fileUrls"
			});
			
			ru.on('init', function (ev) {
				//上传组件实例
				var uploader = ev.uploader;
				//上传按钮实例
				var button = uploader.get('button');
				
				uploader.on('progress', function (ev) {
					var file = ev.file, loaded = ev.loaded, total = ev.total;
					addMsg(ev, '正在上传,文件名：' + file.name + '，大小：' + total + '，已经上传：' + loaded);
				});
				
				uploader.on('success', function (ev) {
					var index = ev.index, file = ev.file;
					addMsg(ev, '上传成功,文件名：' + file.name + '，队列索引为：' + index);
				});
				
				uploader.on('complete', function (ev) {
					var index = ev.index, file = ev.file;
					addMsg(ev, '上传结束,文件名：' + file.name + '，队列索引为：' + index);
				});
				
				uploader.on('error', function (ev) {
					var index = ev.index, file = ev.file;
					addMsg(ev, '上传成功,文件名：' + file.name + '，队列索引为：' + index);
				});
			});
			
		});

	});
</script>

<div class="pageContent" layoutH="42" style="padding:5px">
	
	<!-- Uploader Demo-->
	<div>
		<!-- 上传按钮，组件配置请写在data-config内 -->
		<a id="J_UploaderBtn" class="uploader-button" href="javascript:void(0);"> 选择要上传的文件 </a>

		<!-- 文件上传队列 -->
		<ul id="J_UploaderQueue">
		</ul>
		
		<div id="J_Panel" class="event-panel">
		</div>
		
		<input type="hidden" value="" name="fileUrls">
	</div>
	
	<div class="sortDrag x-panel x-panel-left">
		<div class="panel" minH="60">
			<h1><span class="icon-mymsg icon">个人消息</span></h1>
			<div></div>
		</div>
		
		<div class="panel" minH="60">
			<h1><span class="icon-myconference icon">我的会议</span></h1>
			<div></div>
		</div>
		
		<div class="panel" minH="60">
			<h1><span class="icon-mynews icon">我的新闻</span></h1>
			<div></div>
		</div>
		
		<div class="panel" minH="60">
			<h1><span class="icon-infodoc icon">我的文档</span></h1>
			<div></div>
		</div>
	</div>
	
	<div class="sortDrag x-panel x-panel-right">
		
		<div class="panel" minH="60">
			<h1><span class="icon-myapproval icon">待我审批</span></h1>
			<div></div>
		</div>
		
		<div class="panel" minH="60">
			<h1><span class="icon-myplan icon">我的任务</span></h1>
			<div></div>
		</div>
		
		<div class="panel" minH="60">
			<h1><span class="icon-myapply icon">我的申请</span></h1>
			<div></div>
		</div>
		
	</div>
	
</div>


	


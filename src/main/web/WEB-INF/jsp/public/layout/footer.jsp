<%@ page pageEncoding="UTF-8"%>
Copyright © 2012 杭州池墨科技技术有限公司

<div style="float:right; margin-right: 15px;">
	<div id="time" style="color:blue;">
		<label></label>
		<script>
			document.getElementById('time').innerHTML=
				new Date().toLocaleString()+' 星期'+'日一二三四五六'.charAt(new Date().getDay());
			setInterval("document.getElementById('time').innerHTML='${FULLNAME}，欢迎您登录使用本系统，今天是' + new Date().toLocaleString()+' 星期'+'日一二三四五六'.charAt(new Date().getDay());",1000);
		</script>
	</div>
</div>
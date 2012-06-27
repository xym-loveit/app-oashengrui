
/** 
 * The generic method of Ajax operation through JQuery
 * 
 * @param url: the request url for ajax
 * @param data_params: params to be appended to the request url
 * @param send_handler: the handler to process before the request sends
 * @param successs_handler: the handler to process after the request succeeds
 * 
 * @author Zhao.Xiang
 *
 **/
function generic_ajax_op(url,data_params,send_handler,success_handler,error_handler,asyn){
	var _url = url || "BTS_Ajax.aspx";
	var _asyn = asyn && 1;
	var param_obj = eval('(' + data_params + ')');
	var param_str = "";
	var callback_args = [];

	for(param_key in param_obj){
		//query_char = (param_str == "") ? "?" : "&";
		query_char = "&";
		
		if(param_key != "callback_args"){
			param_str += param_key + "=" + param_obj[param_key] + query_char;
		}else{
			var cb_all_keys = param_obj[param_key];
			var cb_list_keys = cb_all_keys.split(",");
			for(i = 0, size = cb_list_keys.length; i < size; i++){
				callback_args[i] = param_obj[cb_list_keys[i]];		
			}
		}

	}
	param_str = param_str.substr(0,param_str.length-1);
	
	$.ajax({
		type: "post",
		url: _url,
		async: _asyn > 0 ? true : false,
		data: param_str,
		beforeSend: function(){
			if(send_handler != undefined && typeof(send_handler) == "function" ){
				callback_args.length > 0 ? send_handler(callback_args) : send_handler();
			}
		},
		success: function(e){
			if(success_handler != undefined && typeof(success_handler) == "function"){
				callback_args.length > 0 ? success_handler(e,callback_args) : success_handler(e);
			}
		},
		error: function(){
			if(error_handler != undefined && typeof(error_handler) == "function"){
				error_handler();
			}
		}
	});
}

/** 
 * The format helper for date using javascript. In fact,it's revised from others
 * 
 * @param fmt: the formatter rule,like 'yy-MM-dd','dd-m-s' and so on
 *
 * @author Zhao.Xiang
 *
 **/
Date.prototype.Format = function(fmt)  { 
   
   var o = {   
     "M+" : this.getMonth()+1,					//月份   
	 "d+" : this.getDate(),						//日   
     "h+" : this.getHours(),					//小时   
     "m+" : this.getMinutes(),					//分   
     "s+" : this.getSeconds(),					//秒   
	 "q+" : Math.floor((this.getMonth()+3)/3),  //季度   
	 "S"  : this.getMilliseconds()				//毫秒   
   };   
  
   if(/(y+)/.test(fmt)){
		fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length));   
   }

   for(var k in o){   
		if(new RegExp("("+ k +")").test(fmt)){
			fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));   
		}
	}

	return fmt;   
 } 
 
 /**
  * Sub days and get the day offset 
  *
  * @param orn_date:
  * @param dst_date: 
  * @param type: 
  * @author Zhao.Xiang
  */
 function sub_date(orn_date,dst_date,type){

	var sub_type = type || "day";
	var orn_date_obj = typeof(orn_date) == "object" ? orn_date : new Date(Date.parse(orn_date.replace(/-/g,"/")));
	var dst_date_obj = typeof(dst_date) == "object" ? dst_date : new Date(Date.parse(dst_date.replace(/-/g,"/")));
	
	if(sub_type == "day"){
		return Math.ceil((dst_date_obj - orn_date_obj) / (24*60*60*1000));	
	}

 }
 
/**
 * Polish current menu style
 *
 * @author Zhao.Xiang
 **/
function polish_menu(cid, css){
	var current_url = (window.location.href.lastIndexOf("/") == window.location.href.length -1) 
							? window.location.href.substr(0,window.location.href.length -1) 
							: window.location.href.substr(0,window.location.href.indexOf("?") > -1 ? window.location.href.indexOf("?") : window.location.href.length);
	
	if (current_url.indexOf("/admin") < 0 && (current_url.indexOf("/contact") > -1 || current_url.indexOf("/search") > -1)) {
		return;
	}
	
	var up_current_url = current_url.substr(0,current_url.lastIndexOf("/"));
	var has_found = false;
	var matched = "";
	var container = cid ? $(cid) : $("ul#adminmenu a.is-submenu"); 
	var style = css || "current";
	
	// checks the first-menu before iterates the sub-menu-items
	if ($("li#menu-dashboard a.wp-first-item").size() > 0) {
		var admin_index = $("li#menu-dashboard a.wp-first-item").attr("href");		
		if (base_path + admin_index == current_url) {
			$("li#menu-dashboard").addClass(style).addClass("current");
			$("li#menu-dashboard a.wp-first-item").addClass(style).addClass("current");
			return;
		}
	}
	
	for(i = 0, size = container.size(); i < size; i++){
		var current_ele = $(container.get(i));
		var current_ele_url = base_path + current_ele.attr("href");
		
		current_ele_url = current_ele_url.substr(0, current_ele_url.indexOf("?") > -1 ? current_ele_url.indexOf("?") : current_ele_url.length);
		
		if (current_ele_url == current_url 
			|| (current_url.indexOf("admin/entry") > -1 && current_ele_url == current_url.replace("admin/entry", "admin/subnav"))
			|| (current_url.indexOf("admin/subnav") > -1 && current_ele_url == current_url.replace("admin/subnav", "admin/entry"))
			|| (current_url.indexOf("admin/album") > -1 && current_ele_url == current_url.replace("admin/album", "admin/entry"))
			|| (current_url.indexOf("admin/cats") > -1 && current_ele_url == current_url.replace("admin/cats", "admin/subnav"))
			|| (current_url.indexOf("admin/list") > -1 && current_ele_url == current_url.replace("admin/list", "admin/subnav"))
			|| (current_url.indexOf("admin/account/subject") > -1 && current_ele_url == current_url.replace("admin/account/subject", "admin/account/list"))) {
			if(current_ele.parent().attr("id") != "menu-dashboard"){
				matched = current_ele;
				has_found = true;
				break;
			}
		}

		if (current_url.indexOf("activity") > -1 && current_url.indexOf("photos") > -1) {
			current_url = base_path + "admin/activity/edit/list";
		}
		
		if(!has_found && current_url.indexOf(current_ele_url) >= 0 
				|| (current_ele_url.indexOf(up_current_url) >= 0) 
				|| (current_url.indexOf("admin/entry") > -1 && up_current_url.replace("admin/entry", "admin/subnav").indexOf(current_ele_url) >= 0)
				|| (current_url.indexOf("admin/subnav") > -1 && up_current_url.replace("admin/subnav", "admin/entry").indexOf(current_ele_url) >= 0)
				|| (current_url.indexOf("admin/album") > -1 && up_current_url.replace("admin/album", "admin/entry").indexOf(current_ele_url) >= 0)
				|| (current_url.indexOf("admin/cats") > -1 && up_current_url.replace("admin/cats", "admin/subnav").indexOf(current_ele_url) >= 0)
				|| (current_url.indexOf("admin/list") > -1 && up_current_url.replace("admin/list", "admin/subnav").indexOf(current_ele_url) >= 0)
				|| (current_url.indexOf("admin/account/subject") > -1 && up_current_url.replace("admin/account/subject", "admin/account/list").indexOf(current_ele_url) >= 0)) {
			if(current_ele.parent().attr("id") != "menu-dashboard"){
				matched = current_ele;
				has_found = true;
			}
			//return;
		}
	}

	if(!has_found){
		var topMenu = $("ul#adminmenu a.menu-top");
		for(i = 0, size = topMenu.size(); i < size; i++){
			var current_ele = $(topMenu.get(i));
			var current_ele_url = base_path + current_ele.attr("href");
			if(current_url == current_ele_url){
				current_ele.addClass(style).addClass("current");
				return;
			}
		}
	} else {
		matched.addClass(style).addClass("current");
		matched.parent().addClass(style).addClass("current");
		root_ele = matched.parent().parent().parent().parent();
		root_ele.addClass("wp-menu-open").addClass("wp-has-current-submenu").find("a.wp-has-submenu").addClass("wp-has-current-submenu");
	}

	//$("li#menu-dashboard").addClass(style).addClass("current");
	//$("li#menu-dashboard a.wp-first-item").addClass(style).addClass("current");
 }

function polish_home_menu(new_ver){
	var current_url = (window.location.href.lastIndexOf("/") == window.location.href.length -1) 
							? window.location.href.substr(0,window.location.href.length -1) 
							: window.location.href;
	if (new_ver == undefined) {
		if(current_url.indexOf("/home") > 0){
			$("a.index").addClass("index_active");
		}else if(current_url.indexOf("/course") > 0){
			$("a.course").addClass("course_active");
		}else if(current_url.indexOf("/awards") > 0){
			$("a.student").addClass("student_active");
		}else if(current_url.indexOf("/blog") > 0){
			$("a.blog").addClass("blog_active");
		}else if(current_url.indexOf("news") > 0){
			$("a.campus").addClass("campus_active");
		}else if(current_url.indexOf("recruitment") > 0 || current_url.indexOf("staff") > 0 || current_url.indexOf("career") > 0){
			$("a.hire").addClass("hire_active");
		}else if(current_url.indexOf("cooperation") > 0){
			$("a.corp").addClass("corp_active");
		}
	} else {
		if(current_url.indexOf("/newhome/school") > 0
			|| current_url.indexOf("album/list") > 0
			|| current_url.indexOf("album/view") > 0) {
			// 学校介绍
			$("a.navlink_school").addClass("navlink_active");
		}else if(current_url.indexOf("/course") > 0 || current_url.indexOf("/newcourse") > 0){
			// 学校课程
			$("a.navlink_course").addClass("navlink_active");
		}else if(current_url.indexOf("/creativity/list") > 0 
			|| current_url.indexOf("/creativity/view") > 0 
			|| current_url.indexOf("/train/list") > 0 
			|| current_url.indexOf("/train/view") > 0){
			// 教学科研
			$("a.navlink_creativity").addClass("navlink_active");
		}else if(current_url.indexOf("/blog/activity") > 0 
			|| current_url.indexOf("/paper/list") > 0 || current_url.indexOf("/paper/view") > 0 || current_url.indexOf("/team/view") > 0){
			// 教学风采
			$("a.navlink_activity").addClass("navlink_active");
		}else if(current_url.indexOf("/parent/list") > 0 
			|| current_url.indexOf("/awards") > 0 
			|| current_url.indexOf("album/pagelist") > 0 
			|| current_url.indexOf("/awardnews") > 0){
			// 学生风采
			$("a.navlink_student").addClass("navlink_active");
		}else if(current_url.indexOf("/news") > 0) {
			// 新闻动态
			$("a.navlink_news").addClass("navlink_active");
		}else if(current_url.indexOf("/recruitment/jobs") > 0) {
			// 人员招聘
			$("a.navlink_jobs").addClass("navlink_active");
		}else if(current_url.indexOf("/guestbook") > 0) {
			// 在线留言
			$("a.navlink_guestbook").addClass("navlink_active");
		}else if(current_url.indexOf("/newhome") > 0){
			// 首页
			$("a.navlink_home").addClass("navlink_active");
		}
	}
	
}

/**
 *
 * @param id
 * @param clas
 * @author Zhao.Xiang
 */
function polish_table(prefix_id,clas){
	var _clas = clas || "alternate";
	var tr_eles = $("tr[id^=" + prefix_id + "]");
	if(tr_eles.size() > 0){
		for(i = 0,len = tr_eles.size(); i < len; i++){
			i % 2 == 0 ? $(tr_eles.get(i)).addClass(clas) : $(tr_eles.get(i)).removeClass(clas);
		}
	}
}

/**
 * The implementation of Waiting event by JQuery
 * #Example: $("#ele_id").fadeIn("normal").wait().fadeOut("fast")
 *
 * @author Zhao.Xiang
 */
$.fn.wait = function(time, type) {
	time = time || 1000;
	type = type || "fx";
	return this.queue(type, function() {
		var self = this;
		setTimeout(function() {
			$(self).dequeue();
		}, time);
	});
};

var pop_window		= new Object();		// Global variable for the pop_window object
var mtrx_pop_window = new Object();
var pop_flag		= false;

/**
 * Popup a modal window, it's based on BOXY plugin
 * The lib of `boxy` should be imported first if using this function
 * 
 * @param title: Popup window caption
 * @param args:  Argument object for event handler
 * @param content_wrapper_id: The wrapper of content to shown in the popup window 
 * @param after_handler: Handler after closing popup window 
 * @param evt_handler: Events attach on the elements in popup window
 *
 * @author Zhao.Xiang
 **/
function pop_win(title,content_wrapper_id,args,after_hide_handler,evt_handler,after_show_handler,pwin_obj) {
	
	Boxy.DEFAULTS.title = title;
	
	//var _nflag = false;
	//_pwin_obj = pwin_obj == undefined ? pop_window : mtrx_pop_window;
	
	var _html = $("#"+content_wrapper_id).size() > 0 ? $("#"+content_wrapper_id).html() : "Test";
	
	//if(_nflag) 
	
	//pop_window = null;
	
	if(pwin_obj == undefined){
		if(pop_window.boxy != null){
			pop_window.show();
			pop_window.center();
			//return;
		}
		if(pop_window.boxy == null){
			pop_window = new Boxy(
				_html,{
					modal: true, 
					afterHide: after_hide_handler != null && typeof(after_hide_handler) == "function" ? after_hide_handler : function(){}
					//afterShow: after_show_handler != undefined && typeof(after_show_handler) == "function" ? after_show_handler : function(){} 
				}
			);
		}
	}else{
		if(mtrx_pop_window.boxy != null){
			mtrx_pop_window.show();
			mtrx_pop_window.center();
			//return;
		}
		if(mtrx_pop_window.boxy == null){
			mtrx_pop_window = new Boxy(
				_html,{
					modal: true, 
					afterHide: after_hide_handler != null && typeof(after_hide_handler) == "function" ? after_hide_handler : function(){}
					//afterShow: after_show_handler != undefined && typeof(after_show_handler) == "function" ? after_show_handler : function(){} 
				}
			);
		}
	}
	
	if($("#"+content_wrapper_id).size() > 0){
		$("#"+content_wrapper_id).remove();
	}

	if(evt_handler != null && typeof(evt_handler) == "function"){
		evt_handler(args);
	}
	
	if(after_show_handler != null && typeof(after_show_handler) == "function"){
		after_show_handler(args);
	}

	//polish_btn_hover();
	
	position_fixed(100,100);

};

/**
 * Simulating the `fixed` position property for IE6
 *
 * @param el:     id of element to be applied the simulator
 * @param eltop:  top margin the screen 
 * @param elleft: left margin the screen
 *
 * @author Zhao.Xiang
 **/
function position_fixed(eltop, elleft){  
     // check is IE6  
	 var el = $(".boxy-wrapper").get(0);
     if(!window.XMLHttpRequest)  
		 window.onscroll = function(){
			 $(".boxy-wrapper").get(0).style.position = "absolute";
			 $(".boxy-wrapper").get(0).style.top = (document.documentElement.scrollTop + eltop)+"px";  
			 $(".boxy-wrapper").get(0).style.left = (document.documentElement.scrollLeft +  $(".boxy-wrapper").get(0).offsetLeft)+"px";  
		 }  
     else 
		 $(".boxy-wrapper").get(0).style.position = "fixed";  
} 


function isEmail(strMail){
	/* 如果长度为0则返回假 */
	if(strMail.length==0) return false

	/* 验证邮件地址的格式是否合法，如: abc@def.com/net等 */
	var objReg = new RegExp("[a-z0-9-_]+@[a-z0-9-_]+[\.]{1}(com|net|bta|cn|org|edu|mil)","gi")
	var IsRightFmt = objReg.test(strMail)

	/* 验证邮件地址中是否含有非法字符，结果等于-1表示不含有 */
	var objRegErrChar = new RegExp("[^a-z0-9-._@]","ig")
	var IsRightChar = (strMail.search(objRegErrChar)==-1)

	/* 邮件地址最大长度为60字符 */
	var IsRightLength = strMail.length <= 60

	/* 判断字符'@'和'.'的位置，不能为第一个或者最后一个 */
	var IsRightPos = (strMail.indexOf("@",0) != 0 && strMail.indexOf(".",0) != 0 && strMail.lastIndexOf("@")+1 != strMail.length && strMail.lastIndexOf(".")+1 != strMail.length)

	/* 判断字符'@'是否唯一 */
	var IsNoDupChar = (strMail.indexOf("@",0) == strMail.lastIndexOf("@"))

	/* 将'格式'、'字符'、'长度'、'@唯一'四者做“与”操作，任一条件不满足都将返回假 */
	return (IsRightFmt && IsRightChar && IsRightLength && IsRightPos && IsNoDupChar)
} 

function isMobilePhone(strMobilePhone){
   return (/^(?:13\d|15[0689])-?\d{5}(\d{3}|\*{3})$/.test(strMobilePhone)); 
}

//"兼容格式: 国家代码(2到3位)-区号(2到3位)-电话号码(7到8位)-分机号(3位)"
function isTelPhone(strTelPhone){
	 return (/^(([0\+]\d{2,3}-)?(0\d{2,3})-)(\d{7,8})(-(\d{3,}))?$/.test(strTelPhone));
}

function getUrlQueryArgs()   
{   
   var    args=new    Object();   
   var    query=location.search.substring(1);//获取查询串   
   var    pairs=query.split(",");//在逗号处断开   
   for(var    i=0;i<pairs.length;i++)   
   {   
		   var    pos=pairs[i].indexOf('=');//查找name=value   
		   if(pos==-1)    continue;//如果没有找到就跳过   
		   var    argname=pairs[i].substring(0,pos);//提取name   
		   var    value=pairs[i].substring(pos+1);//提取value   
		   args[argname]=unescape(value);//存为属性   
   }   
   return    args;//返回对象   
} 

function polish_year_droplist(drop_id,val_year,seed){
	if($("#"+drop_id).size() > 0){
		var now = new Date();
		var yval = val_year || null;
		var _seed = seed || 5;
		var year = now.getFullYear();
		
		for(i=year,end=year-_seed;i>=end;i--){
			var jqOpt = $("<option value='"+i+"' " + (yval != null && parseInt(yval) == i ? "selected" : "")+ ">"+i+" 年</option>")
			jqOpt.appendTo($("#"+drop_id));
		}
	}
}

function polish_month_droplist(drop_id,val_month,sflag){
	if($("#"+drop_id).size() > 0){
		var now = new Date();
		var vmoth = val_month || null;
		var month = now.getMonth() + 1;
		var flag = sflag;
		
		if(sflag == undefined){
			flag = true;
		}

		for(i=1;i<=12;i++){	
			var jqOpt = $("<option " + (i == month && flag ? "selected" : "") + " value='"+(i<10?("0"+i):i)+"' " + (vmoth != null && parseInt(vmoth) == i ? "selected" : "")+ ">"+(i<10?("0"+i):i)+" 月</option>")
			jqOpt.appendTo($("#"+drop_id));
		}
	}
}

function polish_select_value(drop_id,select_value){
	if($("#"+drop_id).size() > 0){
		var opts = $("#"+drop_id).find("option");
		for(i=0,len=opts.length;i<len;i++){
			if(opts.get(i).value == select_value){
				$(opts.get(i)).attr("selected","selected");
				break;
			}
		}
	}
}

function polish_select_list(jq_obj,json_data,key){
	
	selected_key = key || "";

	if(jq_obj.size() > 0){
		jq_obj.html("");
		for(key in json_data){
			jq_obj.append("<option value='" + key + "' " + (key == selected_key ? "selected='selected'" : "") + ">" + json_data[key] + "</option>");
		}
	}
}

function polish_js_page(page_id,page_total,page_size){
	if($("#"+page_id).size() > 0){
		var page_count = Math.ceil(page_total / page_size);
		var page_str = "";
		for(i=1;i<=page_count;i++){
			page_str += "<span><a id='page" + i + "' class='" + (i == 1 ? "active" : "") + "' href='javascript:void(0);'>" + i + "</a></span>";
		}
		$("#"+page_id).html(page_str);
	}
}

/**
  * Get the generated paginator string
  * #style: <Prev 1 2 ... 7 8 9 10 11 ... 19 Next>
  *
  * @param page_size: the total page size
  * @param current_page: current page index
  *
  * @author Zhao.Xiang	
  */
 function get_pager_str(total,size,current_page,row_prefix_id,append_body,seed,numeric){
	
	if(total == "" || total == 0){
		return "";
	}
	
	if (parseInt(total) < size) {
		return;
	}
	
	current_page = parseInt(current_page) || 1;
	step_seed = seed || 3;
	numeric_show = numeric == undefined ? true : numeric;
		
	page_size = Math.ceil(total/size);

	var page_str  = "";
	var page_index = current_page || 1;
	
	// Prev page 
	page_str = "<a title=\"第1页\" href=\"javascript:switch_page(1,'"+append_body+"')\" class=\"page_head\"><img align=\"absmiddle\" src='resources/images/home/page_head.jpg' style=\"border:none\"/></a>";
	page_str += page_index > 1 ? ("<a title=\"第" + (current_page - 1) + "页\" href=\"javascript:switch_page(" + (current_page - 1 > 0 ? current_page -1 : 1)+ ",'"+append_body+"')\"><img src=\"resources/images/home/page_pre.jpg\" align=\"absmiddle\" style=\"border:none\"></a>") : "<img src=\"resources/images/home/page_pre.jpg\" align=\"absmiddle\" style=\"border:none\">";
	
	page_str = "<span class=\"prev\">" + page_str + "</span>";
	
	if(numeric_show){
		// Page index
		for(index  = 1; index <= parseInt(page_size); index++){
			
			var crc_hrow = (index + step_seed - page_size) > 0 ? (index + step_seed - page_size) : 0; 
			var crc_trow = (index - step_seed - 1) > 0 ? 0 : Math.abs(index - step_seed - 1);

			if(index == page_index){
				
				var flag = false;

				if(index - 2*step_seed >= 2){

					for(i = 1; i <=2; i++){
						page_str += "<a href=\"javascript:switch_page(" + i + ",'"+append_body+"')\">" + i + "</a>";
					}
					page_str += "<span class=\"break\">...</span>";
					
					flag = true;
				}

				for(i = flag ? (index - step_seed - crc_hrow) : 1 ; i < index; i++){
					if(i > 0){
						page_str += "<a href=\"javascript:switch_page(" + i + ",'"+append_body+"')\">" + i + "</a>";
					}
				}
		
				page_str += "<span class=\"thispage\">" + index + "</span>";
				
				flag = (page_size - 2*step_seed) <= index;

				if(!flag && ((page_size - 2*step_seed - 1) == index)){
					flag = true;
				}

				for(i = index + 1; i <= (flag ? page_size : (index + step_seed + crc_trow)); i++){
					if(i > page_size){
						break;
					}
					i = i <= page_size ? i : page_size;
					page_str += "<a href=\"javascript:switch_page(" + i + ",'"+append_body+"')\">" + i + "</a>";
				}

				if(!flag){
					page_str += "<span class=\"break\">...</span>";
					for(i = page_size - 1; i <= page_size; i++){
						page_str += "<a href=\"javascript:switch_page(" + i + ",'"+append_body+"')\">" + i + "</a>";
					}
				} 
			}
		}
	}
    
	// Next page
	page_str += "<span class=\"next\">";
	page_str = page_index < page_size ? (page_str + "<a title=\"第" + (current_page + 1) + "页\"href=\"javascript:switch_page(" + (current_page + 1 > page_size ? page_size : current_page + 1)+ ",'"+append_body+"')\"><img align=\"absmiddle\" src=\"resources/images/home/page_forward.jpg\" style=\"border:none\"></a>") : (page_str + "<a title=\"当前页面(" + current_page + ")\" href=\"javascript:void(0);\"><img align=\"absmiddle\" src=\"resources/images/home/page_forward.jpg\" style=\"border:none\"></a>");
	page_str += "<a title=\"第" + (page_size) + "页\" href=\"javascript:switch_page(" +  page_size + ",'"+append_body+"')\" title=\"\"><img style=\"border:none\" src=\"resources/images/home/page_tail.jpg\" align=\"absmiddle\" style=\"border:none\"></a>";
	page_str += "</span>"; 
	
	return page_str;

 }

 /**
  * Get the generated paginator string
  * #style: <Prev 1 2 ... 7 8 9 10 11 ... 19 Next>
  *
  * @param page_size: the total page size
  * @param current_page: current page index
  *
  * @author Zhao.Xiang	
  */
 function get_new_pager_str(total,size,current_page,row_prefix_id,append_body,seed,numeric){
	
	if(total == "" || total == 0){
		return "";
	}
	
	if (parseInt(total) < size) {
		return;
	}
	
	current_page = parseInt(current_page) || 1;
	step_seed = seed || 3;
	numeric_show = numeric == undefined ? true : numeric;
		
	page_size = Math.ceil(total/size);

	var page_str  = "<ul>";
	var page_index = current_page || 1;
	
	// 1st 
	page_str = page_str + '<li>&nbsp;<a title=\"第1页\" href="javascript:switch_page(1)" class="first nontext">First</a></li>';
	page_str = page_str + (page_index > 1 ? '<li><a title="第' + (current_page - 1) + '页" href="javascript:switch_page(' + (current_page - 1 > 0 ? current_page - 1 : 1) + ')" class="pre nontext">Pre</a></li>' : '<li><a href="javascript:void(0)" class="pre nontext">Pre</a></li>');
	
	// Prev page 
	// page_str = "<a title=\"第1页\" href=\"javascript:switch_page(1,'"+append_body+"')\" class=\"page_head\"><img align=\"absmiddle\" src='resources/images/newhome/pager_pre.png' style=\"border:none\"/></a>";
	//page_str = page_index > 1 ? ("<a title=\"第" + (current_page - 1) + "页\" href=\"javascript:switch_page(" + (current_page - 1 > 0 ? current_page -1 : 1)+ ",'"+append_body+"')\"><img src=\"resources/images/newhome/pager_pre.png\" align=\"absmiddle\" style=\"border:none\"></a>") : ""; //<img src=\"resources/images/newhome/pager_pre.png\" align=\"absmiddle\" style=\"border:none\">";
	
	//page_str = "<span class=\"prev\">" + page_str + "</span>";
	
	if(numeric_show){
		// Page index
		for(index  = 1; index <= parseInt(page_size); index++){
			
			var crc_hrow = (index + step_seed - page_size) > 0 ? (index + step_seed - page_size) : 0; 
			var crc_trow = (index - step_seed - 1) > 0 ? 0 : Math.abs(index - step_seed - 1);

			if(index == page_index){
				
				var flag = false;

				if(index - 2*step_seed >= 2){

					for(i = 1; i <=2; i++){
						//page_str += "<span class='page'><a href=\"javascript:switch_page(" + i + ",'"+append_body+"')\">" + i + "</a></span>";
						page_str += '<li><a href="javascript:switch_page(1)" class="inactive">' + i + '</a></li>';
					}
					page_str += "<span class=\"break\">...</span>";
					
					flag = true;
				}

				for(i = flag ? (index - step_seed - crc_hrow) : 1 ; i < index; i++){
					if(i > 0){
						//page_str += "<span class='page'><a href=\"javascript:switch_page(" + i + ",'"+append_body+"')\">" + i + "</a></span>";
						page_str += '<li><a href="javascript:switch_page(1)" class="inactive">' + i + '</a></li>';
					}
				}
				
				page_str += '<li><a href="javascript:void(0)" class="active">' + index + '</a></li>';
				//page_str += "<span class=\"thispage\">" + index + "</span>";
				
				flag = (page_size - 2*step_seed) <= index;

				if(!flag && ((page_size - 2*step_seed - 1) == index)){
					flag = true;
				}

				for(i = index + 1; i <= (flag ? page_size : (index + step_seed + crc_trow)); i++){
					if(i > page_size){
						break;
					}
					i = i <= page_size ? i : page_size;
					//page_str += "<span class='page'><a href=\"javascript:switch_page(" + i + ",'"+append_body+"')\">" + i + "</a></span>";
					page_str += '<li><a href="javascript:switch_page(' + i + ')" class="inactive">' + i + '</a></li>';
				}

				if(!flag){
					page_str += "<span class=\"break\">...</span>";
					for(i = page_size - 1; i <= page_size; i++){
						//page_str += "<span class='page'><a href=\"javascript:switch_page(" + i + ",'"+append_body+"')\">" + i + "</a></span>";
						page_str += '<li><a href="javascript:switch_page(' + i + ')" class="inactive">' + i + '</a></li>';
					}
				} 
			}
		}
	}
    
	// Next page
	page_str = page_str + '<li><a title="第' + (current_page + 1 > page_size ? page_size : current_page + 1) + '页" href="javascript:switch_page(' + (current_page + 1 > page_size ? page_size : current_page + 1) + ')" class="next nontext">Next</a></li>';
	page_str = page_str + '<li><a title="第' + page_size + '页" href="javascript:switch_page(' + page_size + ')" class="last nontext">Last</a></li>';
	
	//page_str += "<span class=\"next\">";
	//page_str = page_index < page_size ? (page_str + "<a title=\"第" + (current_page + 1) + "页\"href=\"javascript:switch_page(" + (current_page + 1 > page_size ? page_size : current_page + 1)+ ",'"+append_body+"')\"><img align=\"absmiddle\" src=\"resources/images/newhome/pager_next.png\" style=\"border:none\"></a>") : page_str; //(page_str + "<img align=\"absmiddle\" src=\"resources/images/newhome/pager_next.png\" style=\"border:none\">");
	//page_str += "<a title=\"第" + (page_size) + "页\" href=\"javascript:switch_page(" +  page_size + ",'"+append_body+"')\" title=\"\"><img style=\"border:none\" src=\"resources/images/home/page_tail.jpg\" align=\"absmiddle\" style=\"border:none\"></a>";
	//page_str += "</span>"; 
	
	page_str = page_str + "</ul>";
	
	return page_str;

 }

 function switch_page(page,body){
	var current_url = (window.location.href.lastIndexOf("/") == window.location.href.length -1) 
						? window.location.href.substr(0,window.location.href.length -1) 
						: window.location.href;
	var url_params = current_url.indexOf("?") > -1 ? current_url.substr(current_url.indexOf("?")) : "";
	if (url_params != "") {
		current_url = current_url.substr(0, current_url.indexOf("?"));
	}
	if(url_params.indexOf("page=") > -1){
		url_params = url_params.substr(0,url_params.indexOf("page="));
		window.location.href = current_url + url_params + "page=" + page;
	} else {
		if(current_url.indexOf("/page") > -1){
			current_url = current_url.substr(0,current_url.indexOf("/page"));
		}
		if (current_url.lastIndexOf("/") == current_url.length - 1) {
			window.location.href = current_url + "page/" + page + url_params;
		} else {
			window.location.href = current_url + "/page/" + page + url_params;
		}
	}
	return false;
 }
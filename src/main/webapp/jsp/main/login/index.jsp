<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp"%>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE9" >
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="shortcut icon" href="logo.ico">
<style type="text/css">
.tbmg{
	padding-right: 5px;
	padding-bottom: 3px;
}
body {
	overflow: scroll;
}
</style>
<title>智慧徐圩公共平台</title>
<%-- <%@ include file="/commons/basejs.jsp" %> --%>
<!-- 首页样式 -->
<link rel="stylesheet" href="${staticPath}/static/adminModule/frame/zui/css/zui.min.css">
<link rel="stylesheet" href="${staticPath}/static/adminModule/frame/zui/css/zui-theme.css">
<link rel="stylesheet" href="${staticPath}/static/adminModule/frame/plugins/ionicons/css/ionicons.css">
<link rel="stylesheet" href="${staticPath}/static/adminModule/frame/zui/lib/datatable/zui.datatable.css">
<link rel="stylesheet" href="${staticPath}/static/adminModule/frame/zui/lib/datetimepicker/datetimepicker.css">
<link rel="stylesheet" href="${staticPath}/static/adminModule/frame/zui/lib/kindeditor//kindeditor.min.css">
<link rel="stylesheet" href="${staticPath}/static/adminModule/frame/css/base.css"><!--  -->
<link rel="stylesheet" href="${staticPath}/static/adminModule/frame/css/index.css">
<link rel="stylesheet" href="${staticPath}/static/adminModule/frame/css/main_base.css">
<!-- 结束 -->
<%-- <script type="text/javascript" src="${staticPath}/static/adminModule/frame/js/index.js" charset="utf-8"></script> --%>
<script type="text/javascript">
	function logout(type) {
		if (type==1||window.confirm('确定要退出吗？')) {
			window.location.href = encodeURI('${path}/logout');//普通登出
			//window.location.href = encodeURI('${path}/logoutcas');//CSA单点登出
		} else {
			return false;
		}
	}
	
	
	/**点击左侧菜单，打开连接 start anjl 2017-8-23*/
	function openUrl(obj,url,name,parentName,dataOne) {
		if (url != null && url != "") {
			$("#content").attr("src", url);
		}
		var menuLocationStr = "当前位置：";
		if(dataOne != undefined){
			menuLocationStr += dataOne + ">";
		}
		if(parentName != undefined){
			menuLocationStr += parentName + ">";
		}
		menuLocationStr += name;
		$("#locationDiv").text(menuLocationStr);
		
				
		$('.a-child').css("background","#F8F8F8");
		if($(obj).hasClass('a-child')){
			obj.style.backgroundColor="#B3D4FC";
		}
		refreshIframe();
	}
	/**点击左侧菜单，打开连接 end anjl 2017-8-23*/
</script>
<style>
	body{
		overflow-x:scroll;
	}
</style>
</head>
<body id="body1">
	<div class="container-fluid clearfix" style="position: absolute;">
		<!-- 布局开始 -->
		<div  id="header">
			<img id="topPic" src="${staticPath}/static/adminModule/frame/images/banner_01.png">
			<span class="hj_exit">
				<span>欢迎您，<shiro:user><shiro:principal/></shiro:user></span>
				<a href="javascript:void(0)"  onclick="editPassword()">修改密码</a>
				<a href="javascript:void(0)"  onclick="logout()">安全退出</a>
			</span>
		</div>
		
		<!--一级菜单 开始 -->
		<div class="row yjbz" id="first">
			<ul id="yjul" class="yjul">
			</ul>
		</div>
		<!--一级菜单 结束 -->
		
		<!-- 侧边栏 -->
		<div id="sidenav" class="scrollbar-hover" style="width:210px;">
			<div class="user clearfix">
				<div class="col-xs-12 text-center dropdown" style="width: 110px; margin-left: 29px;" >
					<h3 class="admin-name" data-toggle="dropdown" style="width: 110px;">
						<i class="icon icon-bars"></i>
						<span id="titleSpan" style="margin-left: 0px;" >管理菜单</span>
					</h3>
				</div>
			</div>
			<nav class="menu" id="navUL" data-toggle="menu" style="height: 610;">
				<ul class="nav" style="padding-bottom: 30px;">
					
				</ul>
			</nav>
		</div>
		<div id="lashen" style="cursor:pointer;float: left;margin-left:211px;margin-top:480px;position:relative;z-index: 50 ">
				<img id="lashenImg"  src="${staticPath}/static/adminModule/frame/images/lashen_03.png" onclick="sidenavHide();">
		</div>
		<!-- 结束 -->
		<!-- 正文 -->
		<div id="main" class="row" style="width:100%;position: absolute;z-index:30">
			<!-- 顶部tab栏 -->

			<div id="locationDiv" class="top-title" style="padding: 12px 19px; margin-top:-50px;margin-left:2px;" >当前位置：首页</div>
			<!-- 结束 -->
			<iframe id="content" frameborder="0"   src="" width="100%" style="margin: 0px; float:right; overflow: hidden; "></iframe>
		</div>
		<!-- 结束 -->
	</div>

	<!-- 底部 -->
<!-- 	<div class="row text-center" id="footed">版权所有©中国连云港徐圩新区 Copyright©2016-2020 公司</div> -->
	<!-- 结束 -->
	<script src="${staticPath}/static/adminModule/frame/zui/lib/jquery/jquery.js"></script>
	<script type="text/javascript">
		var baseurl = '${path}';
		var menuObject = null;
		var currentMenu = null;
		$(function() {
			$.getJSON(baseurl + "/resource/userMenu", function(data, status) {
				menuObject = data;//页面保存查询结果
				if (menuObject.length == 0) {
					//alert("此用户未配置菜单");
					return;
				}
				//默认加载点击中第一个一级菜单
				titleHtml(0);
				//加载第一个一级菜单下的二级菜单
				menuHtml(0,0);
			});
		});
		
		
		
		/**从新的页面打开**/
		function openHtml(url){
			window.open(url);
		}
		
		function menuHtml(seq,init) {
			var dataOne = menuObject[seq];//一级菜单JSON对象
			$("#yjul").find("li").each(function(i){
				if((init==0&&seq==i)||(init!=0&&(seq-init+1)==i)){
					$(this).addClass("libg");
					$("#topPic").attr("src","${staticPath}/static/adminModule/frame/images/"+dataOne.pic);
				}else{
					$(this).removeClass("libg");
				}
			});
		
			if(seq == currentMenu){
				return;
			}
			currentMenu = seq;
			var html = "";
			
			if ((dataOne.resourceUrl!=null&&dataOne.resourceUrl!="")&&dataOne.resourceUrl.indexOf("http")!=0 ) {
				$("#content").attr("src", '${path}'+dataOne.resourceUrl);
			}else{
				$("#content").attr("src", "");
			}
			$("#locationDiv").text("当前位置：首页");
			if (dataOne.children.length == 0) {
				//alert("此用户未配置菜单");
				return;
			}
			$("#titleSpan").text(dataOne.resourceName);//改动菜单标题文字
			
			for (var i = 0; i < dataOne.children.length; i++) {
				var dataTwo = dataOne.children[i];//二级菜单JSON对象
				html += '<li class=" nav-parent">';
				if (dataTwo.children.length == 0) {
					if((dataTwo.resourceUrl!=null&&dataTwo.resourceUrl!="")&&dataTwo.resourceUrl.indexOf("http")==0){
						html += '<a class="a-parent" href="javascript:;"  onclick="openHtml(\''+dataTwo.resourceUrl+'\');">';
					}else{
						html += '<a class="a-parent" href="javascript:;"  onclick="openUrl(this,\'${path}' + dataTwo.resourceUrl + '\',\''+dataTwo.resourceName+ '\',\''+dataOne.resourceName+'\');">';
					}
				}else {
					html += '<a class="a-parent" href="javascript:;">';
				}
				
				//设置显示图标
				if(dataTwo.iconCls!=null&&dataTwo.iconCls!=""){
					html += '<i class="'+dataTwo.iconCls+'"></i>';
				}else{
					html += '<i class="icon icon-user"></i>';
				}
				
				html += dataTwo.resourceName;
				html += "<i class='icon-chevron-right nav-parent-fold-icon' ></i>";
				html += '</a>';
				if (dataTwo.children.length > 0) {
					html += '<ul class="nav">';
					for (var ii = 0; ii < dataTwo.children.length; ii++) {
						var dataThree = dataTwo.children[ii];
						html += '<li class="nav-child">';
						if(dataThree.resourceUrl.indexOf("http")==0){
							html += '<a class="a-child" href="javascript:;" onclick="openUrl(this,\'${path}' + dataThree.resourceUrl + '\',\''+dataThree.resourceName+'\',\''+dataTwo.resourceName + '\',\''+dataOne.resourceName+'\');" data-url="ajax-load/a-list/goods-3cphsz.html" data-class="goods-3cphsz">';
						}else{
							html += '<a class="a-child" href="javascript:;" onclick="openUrl(this,\'${path}' + dataThree.resourceUrl + '\',\''+dataThree.resourceName+'\',\''+dataTwo.resourceName + '\',\''+dataOne.resourceName+'\');" data-url="ajax-load/a-list/goods-3cphsz.html" data-class="goods-3cphsz">';
						}
						html += '<i class="icon icon-caret-right"></i>';
						html += dataThree.resourceName;
						html += '</a>';
						html += '</li>';
					}
					html += '</ul>';
				}
				html += '</li>';
			}
			
			$("ul.nav").html(html);
			line();
			refreshIframe();
		//	$("#sidenav nav ul li:first a").click();
		}
		function line() {
			//点击侧栏菜单并在tab-nav中添加此菜单对应的标签名，并在内容区域添加对应此标签的内容块 
			$('.a-parent').on('click', function(event) {
				var liobj = $(this).parent();
				liobj.prevAll("li").removeClass("show");
 				liobj.nextAll("li").removeClass("show");
			 	liobj.find('ul').eq(0).slideToggle();
				liobj.prevAll("li").find("ul").slideUp("slow");
 				liobj.nextAll("li").find("ul").slideUp("slow");	
				liobj.toggleClass("show"); 	
				return false;
			});
			
		}
		
		function sidenavHide(){
			var i =document.getElementById("sidenav").clientWidth;
			if(i>0){
				$("#lashenImg").attr("src","${staticPath}/static/adminModule/frame/images/lashen_02.png");
				$("#sidenav").animate({"width":"0px"},210);
				if (!!window.ActiveXObject || "ActiveXObject" in window){
					$("#lashen").animate({ left:"-=210px"},210);
				}else{
					$("#lashen").animate({ left:"-=210px"},210);
				}
				$("#main").css("padding","170px 0 0 0");
				$("#first").css("padding","0");
				
			}else{
				$("#lashenImg").attr("src","${staticPath}/static/adminModule/frame/images/lashen_03.png");
				$("#sidenav").animate({"width":"210px"},210);
				if (!!window.ActiveXObject || "ActiveXObject" in window){
					$("#lashen").animate({ left:"+=210px"},210);
				}else{
					$("#lashen").animate({ left:"+=210px"},210);
				} 
				$("#main").css("padding","170px 0 0 210px");
				$("#first").css("padding","0 7px 8px 210px");
			}
		}	
		/**修改密码start wangcf 17-10-20 **/
		function editPassword(){
			$("#content").attr("src", "${staticPath}/jsp/admin/userEditPassword.jsp");
			
		}
		/**修改密码end wangcf 17-10-20 **/
		
		/**高度自适应 start  anjl 17-10-19**/
		var oldHeight = 690;
		var timer;
		var i=0;
		var browserVersion = window.navigator.userAgent.toUpperCase();
		var isOpera = browserVersion.indexOf("OPERA") > -1 ? true : false;
		var isFireFox = browserVersion.indexOf("FIREFOX") > -1 ? true : false;
		var isChrome = browserVersion.indexOf("CHROME") > -1 ? true : false;
		var isSafari = browserVersion.indexOf("SAFARI") > -1 ? true : false;
		var isIE = (!!window.ActiveXObject || "ActiveXObject" in window);
		var isIE9More = (! -[1, ] == false);
		//根据子页面高度设置iframe的高度
		function autoIframeHeight(){
		    var iframe = parent.document.getElementById("content");
	        var realHeight = 0;
	        //谷歌浏览器特殊处理
	        if (isFireFox == true){
           		realHeight = iframe.contentWindow.document.documentElement.offsetHeight + 5;
	        }else if(isSafari ==true){
	        	realHeight = iframe.contentWindow.document.documentElement.offsetHeight + 5;
	        }else if (isIE == false && isOpera == false){
	            realHeight = iframe.contentWindow.document.documentElement.scrollHeight + 5;
	        }else if (isIE == true) {//ie 
	            realHeight = iframe.contentWindow.document.documentElement.offsetHeight + 5;
	        } else{
	        	bHeight += 5;
	        }
	        if(oldHeight!=realHeight){
	     	  $(iframe).height(realHeight);
	     	  oldHeight=realHeight;
	     	  //点击连接后超过10秒，则不再进行页面自适应的设定了
	     	  if(i>100){
	     		  i = 0;
	     		  window.clearInterval(timer);
	     	  }else{
	     		  i++;
	     	  }
	        }
		 }
		
		var ifr_el = document.getElementById("content");
		function getIfrData(data){
			//console.log("index:"+data);
			if(oldHeight!=data){
				oldHeight=data;
				ifr_el.style.height = data+"px";
			}
		}
		 
		 //当iframe页面加载时，设置定时监测子页面滚动条长度，以此来设置iframe的高度，每100毫秒一次，持续10秒
		 function refreshIframe(){
		 	//如果上一个定时器还未结束，先结束上一个定时器，再重新设定新的定时器
		 	if(timer){
		 		window.clearInterval(timer);
		 		i = 0;//定时数字归0
		 	}
		 	timer = window.setInterval(function(){
		 		autoIframeHeight();
		 	},100);
		 }
		/**高度自适应 end anjl 17-10-19**/
		
		/**添加二级菜单start anjl 17-10-19**/
		function titleHtml(seq){
			var titleHtml = "";
			var init = 0;
			if(seq>7){
				init = seq-7;
			}
			for (var i = init; i<menuObject.length; i++){
				if(init!=0&&i==init){
					titleHtml += "<li style='width:15px;' onclick='titleHtml("+(i+6)+")'><img alt='左移'style='margin-top:-2px;' src='${staticPath}/static/adminModule/frame/images/arrow-left.png'></li>";
				}
				if((i-init)>7){
					titleHtml += "<li style='width:15px;' onclick='titleHtml("+i+")'><img alt='右移' style='margin-top:-2px;'  src='${staticPath}/static/adminModule/frame/images/arrow-right.png'></li>";
					break;
				}
				var dataOne = menuObject[i];//一级菜单JSON对象
				
				//当一级菜单没有设置图标时，设置默认图标
				if(dataOne.iconCls==null)
					dataOne.iconCls="xtgl.png";
				
				//判断是否为外部链接，如果是则通过新的页面打开
				if((dataOne.resourceUrl!=null||dataOne.resourceUrl!="")&&dataOne.resourceUrl.indexOf("http")==0){
					titleHtml += "<li id='menu"+i+"' onclick='openHtml(\""+dataOne.resourceUrl+"\");' style='cursor:pointer'><img class='tbmg' src='${staticPath}/static/adminModule/frame/images/"+dataOne.iconCls+"''>"+dataOne.resourceName+"</li>";
				}else{
					titleHtml += "<li id='menu"+i+"' onclick='menuHtml("+i+","+init+");' style='cursor:pointer'><img class='tbmg' src='${staticPath}/static/adminModule/frame/images/"+dataOne.iconCls+"''>"+dataOne.resourceName+"</li>";
				}
			}
			$("#yjul").html(titleHtml);
		}
		
		/**添加二级菜单end anjl 17-10-19**/
		
	</script>
	<script src="${staticPath}/static/adminModule/frame/zui/lib/jquery/jquery.js"></script>
	<script src="${staticPath}/static/adminModule/frame/zui/js/zui.min.js"></script>
	<script src="${staticPath}/static/adminModule/frame/plugins/mock.js"></script> 
	<script src="${staticPath}/static/adminModule/frame/zui/lib/bootbox/bootbox.min.js"></script>
	<script src="${staticPath}/static/adminModule/frame/zui/lib/datatable/zui.datatable.min.js"></script> 
	<script src="${staticPath}/static/adminModule/frame/zui/lib/datetimepicker/datetimepicker.min.js"></script> 
	<script src="${staticPath}/static/adminModule/frame/zui/lib/kindeditor/kindeditor.js"></script>
	<script src="${staticPath}/static/adminModule/frame/js/base.js"></script> 
</body>
</html>



<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="shortcut icon" href="logo.ico">
<title>智慧徐圩公共平台</title>
<%-- <%@ include file="/commons/basejs.jsp" %> --%>
<!-- 首页样式 -->
<%-- <link rel="stylesheet" href="${staticPath}/static/adminModule/frame/zui/css/zui.min.css"> 
<link rel="stylesheet" href="${staticPath}/static/adminModule/frame/zui/css/zui-theme.css">
<link rel="stylesheet" href="${staticPath}/static/adminModule/frame/plugins/ionicons/css/ionicons.css">
<link rel="stylesheet" href="${staticPath}/static/adminModule/frame/zui/lib/datatable/zui.datatable.css">
<link rel="stylesheet" href="${staticPath}/static/adminModule/frame/zui/lib/datetimepicker/datetimepicker.css">
<link rel="stylesheet" href="${staticPath}/static/adminModule/frame/zui/lib/kindeditor//kindeditor.min.css">
<link rel="stylesheet" href="${staticPath}/static/adminModule/frame/css/base.css">
<link rel="stylesheet" href="${staticPath}/static/adminModule/frame/css/index.css">
<link rel="stylesheet" href="${staticPath}/static/adminModule/frame/css/main_base.css"> --%>

<link rel="stylesheet" href="${staticPath}/static/commons/platform_v7/css/css.css">
 <link rel="stylesheet" href="${staticPath}/static/commons/platform_v7/css/base.css">
<link rel="stylesheet" href="${staticPath}/static/commons/platform_v7/css/jscss.css">
<link rel="stylesheet" href="${staticPath}/static/commons/platform_v7/css/reset.css"><%-- --%>
<!-- 结束 -->
<%-- <script type="text/javascript" src="${staticPath}/static/adminModule/frame/js/index.js" charset="utf-8"></script> --%>
<style type="text/css">
body {
	min-width: 1050px;
	
}
</style>
<script type="text/javascript">
	function logout() {
		if (window.confirm('确定要退出吗？')) {
			window.location.href = encodeURI('${path}/logout');//普通登出
			//window.location.href = encodeURI('${path}/logoutcas');//CSA单点登出
		
			//window.location.href = encodeURI('${path}/logout');//普通登出
			window.location.href = encodeURI('${path}/logout');//CSA单点登出
		} else {
			return false;
		}
	}
	
/* 	$(function(){
		$(".subNav").click(function(){
					$(this).toggleClass("currentDd").siblings(".subNav").removeClass("currentDd")
					$(this).toggleClass("currentDt").siblings(".subNav").removeClass("currentDt")
					
					// 修改数字控制速度， slideUp(500)控制卷起速度
					$(this).next(".navContent").slideToggle(500).siblings(".navContent").slideUp(500);
			})	
		}) */
	
	
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
		
	}
	
</script>
</head>
<body>
		
	<div class="banner">
     <div class="bannerle fle">
     	<div class="bannerle_a">
        	<div class="bannerle_a01">
            	<img src="${staticPath}/static/commons/platform_v7/images/bannername_03.png"/>
           	</div>
            <span class="bannerle_a02">——公共平台</span>
        </div>
        <img src="${staticPath}/static/commons/platform_v7/images/banner1.png" />
     </div>
   <div class="bannerri fle">
      <div class="fri">
      <div class="fle "><span>欢迎，<shiro:user><shiro:principal/></shiro:user></span></div>
      <div class="fle"><a href="javascript:void(0)" onclick="logout()"><span>安全退出</span></a></div>
    </div>
   </div>
   </div>
   
		<!--一级菜单 开始 -->
		<div class="tab">
			<ul id="yjul">
			</ul>
		</div>
		
		  <div class="w">
    <div class="botle">
        <div class="le_menu"><span id="titleSpan" style="margin-left: 0px;">管理菜单</span></div> 
      <!--tab切换开始-->
      
       <div class="tabchange">
          <!--切换1-->
          
            <div class="zd_box">
            <ul id="main_ul">
              
            </ul>
            </div>
          
          <!--切换1-->
       </div>
      </div>
      <!--tab切换结束-->
      
   </div>
 
	<div class="botri">
      <div class="fle lashenimg"><img src="${staticPath}/static/commons/platform_v7/images/lashen_03.png" /></div>
      <div class="iframe" style="float:left;">
      	<div id="locationDiv" class="top-title" style="padding: 10px 20px;">当前位置：首页</div>
		
        <iframe id="content" src="" frameborder="0" width="100%" style="height:100%; min-height:600px;" scrolling="yes" ></iframe>
      </div>
   </div>
		<!-- 结束 -->
		<!-- 结束-->
	
	<!-- 底部 -->
	<div class="botribot">  版权所有©中国连云港徐圩新区 Copyright©2016-2020 公司 </div>
	<!-- 结束 -->
	<script src="${staticPath}/static/adminModule/frame/zui/lib/jquery/jquery.js"></script>
	<script type="text/javascript">
	var height;
	$(document).ready(function(){
		height = $(window).height();
	});
	 
	$(window).resize(function(){
		var windowHeight = $(window).height();
		if(windowHeight < height){
			$("#content").height(windowHeight - 117);
			$(".botri").height(windowHeight - 117);
			$(".tabchange").height(windowHeight - 117);
			$(".zd_box").height(windowHeight - 117);
			$(".botle").height(windowHeight - 117);
			height = windowHeight;
		}else if(windowHeight > height){
			$("#content").height(windowHeight - 117);
			$(".botri").height(windowHeight - 117);
			$(".tabchange").height(windowHeight - 117);
			$(".zd_box").height(windowHeight - 117);
			$(".botle").height(windowHeight - 117);
			height = windowHeight;
		}
	});
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
				titleHtml();
				menuHtml(0);
			});
		});
		
		function toExturl(url){
			window.open(url);       
		}
		
		
		function titleHtml(){
			var titleHtml = "";
			for (var i = 0; i<menuObject.length; i++){
				var dataOne = menuObject[i];//一级菜单JSON对象
				if(i==0){
					titleHtml += "<li class='selected' id='menu"+i+"' onclick='menuHtml("+i+");' style='cursor:pointer'>";
					if(dataOne.resourceUrl.indexOf("http")>-1){
						titleHtml += "<a target='_target' onclick='toExturl(\""+dataOne.resourceUrl+"\");'>";
						titleHtml += dataOne.resourceName;
						titleHtml += "</a>";
					}else{
						titleHtml += dataOne.resourceName;
					}
					titleHtml  += "</li>";
				}else{
					titleHtml += "<li id='menu"+i+"' onclick='menuHtml("+i+");' style='cursor:pointer'>";
					if(dataOne.resourceUrl.indexOf("http")>-1){
						titleHtml += "<a target='_target' onclick='toExturl();'>";
						titleHtml += dataOne.resourceName;
						titleHtml += "</a>";
					}else{
						titleHtml += dataOne.resourceName;
					}
					titleHtml  += "</li>";
				}
			}
			$("#yjul").html(titleHtml);
		}
		function openwlpage(resourceId){
			if(resourceId=="441"){
				$("#content").attr("src","/Puriew/static/commons/main/wlhjrigindex.html");
			}
		}
		
		function menuHtml(seq) {
			if(seq == currentMenu){
				return;
			}
			currentMenu = seq;
			var html = "";
			var dataOne = menuObject[seq];//一级菜单JSON对象
			if (dataOne.children.length == 0) {
				//alert("此用户未配置菜单");
				return;
			}
			$("#titleSpan").text(dataOne.resourceName);//改动菜单标题文字
			openwlpage(dataOne.resourceId);
			for (var i = 0; i < dataOne.children.length; i++) {
				var dataTwo = dataOne.children[i];//二级菜单JSON对象
			//	html += '<li class="subNav " ';
				if (dataTwo.children.length == 0) {
					html += '<li class="subNav" onclick="openUrl(this,\'${path}' + dataTwo.resourceUrl + '\',\''+dataTwo.resourceName+ '\',\''+dataOne.resourceName+'\');">';
				}else {
					html += '<li class="subNav">';
				}
		//		html += '<i class="icon icon-user"></i>';
		//		html += '<li class="subNav">';
				html += dataTwo.resourceName;
		//		html += '<i class="icon-chevron-right nav-parent-fold-icon"></i>';
				html += '</li>';
				html += '</a>';
				if (dataTwo.children.length > 0) {
					html += '<li class="navContent" >';
					html += '<ul>';
					for (var ii = 0; ii < dataTwo.children.length; ii++) {
						var dataThree = dataTwo.children[ii];
						html += '<li class="navContentli" ';
						if(dataThree.resourceUrl.indexOf("http")>=0){
							html += ' href="javascript:;" onclick="openUrl(this,\'' + dataThree.resourceUrl + '\',\''+dataThree.resourceName+'\',\''+dataTwo.resourceName + '\',\''+dataOne.resourceName+'\');" data-url="ajax-load/a-list/goods-3cphsz.html" data-class="goods-3cphsz">';
						}else{
							html += ' href="javascript:;" onclick="openUrl(this,\'${path}' + dataThree.resourceUrl + '\',\''+dataThree.resourceName+'\',\''+dataTwo.resourceName + '\',\''+dataOne.resourceName+'\');" data-url="ajax-load/a-list/goods-3cphsz.html" data-class="goods-3cphsz">';
						}
				//		html += '<li class="navContentli">';
						html += '<img src="${staticPath}/static/commons/platform_v7/images/jt04.png"/>';
						
						html += dataThree.resourceName;
						html += '</li>';
						html += '</a>';
						
					}
					html += '</ul>';
					html += '</li>';
				}
				html += '</li>';
			}
 	
			$("#main_ul").html(html);

			line();
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
	</script>
<%-- 	<script src="${staticPath}/static/adminModule/frame/zui/lib/jquery/jquery.js"></script>
	 <script src="${staticPath}/static/adminModule/frame/zui/js/zui.min.js"></script>
	<script src="${staticPath}/static/adminModule/frame/plugins/mock.js"></script> 
	<script src="${staticPath}/static/adminModule/frame/zui/lib/bootbox/bootbox.min.js"></script>
	 <script src="${staticPath}/static/adminModule/frame/zui/lib/datatable/zui.datatable.min.js"></script> 
	 <script src="${staticPath}/static/adminModule/frame/zui/lib/datetimepicker/datetimepicker.min.js"></script> 
	 <script src="${staticPath}/static/adminModule/frame/zui/lib/kindeditor/kindeditor.js"></script>
	 <script src="${staticPath}/static/adminModule/frame/js/base.js"></script>  --%>

<script src="${staticPath}/static/commons/platform_v7/js/js.js" type="text/javascript"></script>
</body>
</html>



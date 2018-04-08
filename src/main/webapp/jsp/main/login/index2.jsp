<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>后台首页</title>
<link href="${base}/static/commons/main/css/base.css" rel="stylesheet"
	type="text/css" />
<link href="${base}/static/commons/main/css/reset.css" rel="stylesheet"
	type="text/css" />
<link href="${base}/static/commons/main/css/index.css" rel="stylesheet"
	type="text/css" />
<link href="${base}/static/commons/main/css/css1.css" rel="stylesheet"
	type="text/css" />
<link href="${base}/static/commons/main/css/mobile.css" rel="stylesheet"
	type="text/css">
<script type="text/javascript"
	src="${base}/static/jquery/jquery-1.8.2.min.js"></script>
<script type="text/javascript">
<!--左栏折叠效果-->
	var baseurl ='<%=basePath%>';
	$(function() {
		$.getJSON(baseurl + "/resource/userMenu", function(data, status) {
			menuHtml(data);
		});
	})

	function menuHtml(data) {
		var html = "";
		for (var i = 0; i < data.length; i++) {
			var dataOne = data[i];
			html += '<li>';
			html += '<div class="le_bottom_content">';
			html += '<div class="le_icon">';
			if (dataOne.iconCls) {
				html += '<img src="${base}';
				html += dataOne.iconCls;
				html += '" />';
			}
			html += '</div>';
			html += '<div class="le_text">'
			if (dataOne.children.length == 0) {
				html += '<span name="jump" data-url="${base}'+dataOne.resourceUrl+'">'
						+ dataOne.resourceName + '</span>';
			} else {
				html += dataOne.resourceName;
			}
			html += '</div>';
			html += '<div class="le_jiantou">';
			html += '<img src="${base}/static/commons/main/images/jt3_03.png" />';
			html += '</div>';
			html += '</div>';
			if (dataOne.children.length > 0) {
				html += '<div class="pop" style="height: '
						+ (dataOne.children.length * 48 + 11) + 'px;">';
				html += '<ul><li class="subNavBox">';
				for (var ii = 0; ii < dataOne.children.length; ii++) {
					var dataTwo = dataOne.children[ii];
					if (dataTwo.children.length > 0) {
						html += '<div class="subNav';
						html += '"><a href="#">'
								+ dataTwo.resourceName + '</a></div>';
						html += '<ul class="navContent">';
						for (var iii = 0; iii < dataTwo.children.length; iii++) {
							html += '<li><img src="${base}/static/commons/main/images/icon_jiantou_07.png" />'
							html += '<span name="jump" data-url="${base}'+dataTwo.children[iii].resourceUrl+'">'
									+ dataTwo.children[iii].resourceName
									+ '</span>';
						}
						html += '</ul>';
					} else {
						html += '<div class="subNav1';
						html += '"><span name="jump" data-url="${base}'+dataTwo.resourceUrl+'">'
								+ dataTwo.resourceName + '</span></div>';
					}
				}
				html += '</li></ul>';
				html += '</div>';
			}
			html += '</li>';
		}
		$("ul.icon").html(html);
		$('span[name="jump"]').click(function(event) {
			
			var url = $(this).attr('data-url');
			$('iframe').attr('src', url)
		});
		$(".subNav").click(
				function() {
					$(this).toggleClass("currentDt").siblings(".subNav")
							.removeClass("currentDt");
					// 修改数字控制速度， slideUp(500)控制卷起速度
					$(this).next(".navContent").slideToggle(500).siblings(
							".navContent").slideUp(500).css('', '');
		});
	}
</script>

</head>

<body class="fbl">

	<section>
		<!--左侧-->
		<div class="left" id="left">
			<!--左侧头部开始-->
			<header id="title">
				<p class="titletxt">智慧徐玗公共平台</p>
			</header>
			<!--左侧头部结束-->
			<!--左侧下半部分-->
			<nav class="le_bottom">
				<div>
					<div class="lphoto">
						<img src="${base}/static/commons/main/images/txpic_03.png"
							style="padding-top: 20px;" />
					</div>
					<div class="lname">办公室人员</div>
					<!--菜单-->
					<ul class="icon">
						<li>
							<div class="le_bottom_content">
								<div class="le_icon">
									<img src="${base}/static/commons/main/images/icon2_03.png" />
								</div>
								<div class="le_text">首页</div>
								<div class="le_jiantou">
									<img src="${base}/static/commons/main/images/jt3_03.png" />
								</div>
							</div>
						</li>
						<li>
							<div class="le_bottom_content">
								<div class="le_icon">
									<img src="${base}/static/commons/main/images/icon1_06.png" />
								</div>
								<div class="le_text">决策支持</div>
								<div class="le_jiantou">
									<img src="${base}/static/commons/main/images/jt3_03.png" />
								</div>
							</div>
						</li>
						<li>
							<div class="le_bottom_content">
								<div class="le_icon">
									<img src="${base}/static/commons/main/images/icon1_08.png" />
								</div>
								<div class="le_text">应用支撑服务</div>
								<div class="le_jiantou">
									<img src="${base}/static/commons/main/images/jt3_03.png" />
								</div>
							</div> <!--<div class="pop"></div>-->
						</li>
						<li>
							<div class="le_bottom_content">
								<div class="le_icon">
									<img src="${base}/static/commons/main/images/icon1_10.png" />
								</div>
								<div class="le_text">数据资源</div>
								<div class="le_jiantou">
									<img src="${base}/static/commons/main/images/jt3_03.png" />
								</div>
							</div>
							<div class="pop" style="height: 100px">
								<ul>
									<li class="subNavBox">
										<div class="subNav1">申请审批</div>
										<div class="subNav1">数据资源查询</div>
									</li>
								</ul>
							</div>
						</li>
						<li>
							<div class="le_bottom_content">
								<div class="le_icon">
									<img src="${base}/static/commons/main/images/icon13_03.png" />
								</div>
								<div class="le_text" style="padding-top: 3px;">基本信息统计</div>
								<div class="le_jiantou">
									<img src="${base}/static/commons/main/images/jt3_03.png" />
								</div>
							</div>
						</li>
						<li>
							<div class="le_bottom_content">
								<div class="le_icon">
									<img src="${base}/static/commons/main/images/icon_14.png" />
								</div>
								<div class="le_text">物联汇聚平台</div>
								<div class="le_jiantou">
									<img src="${base}/static/commons/main/images/jt3_03.png" />
								</div>
							</div>
							<div class="pop" style="height: 100px;">
								<ul>
									<li class="subNavBox">
										<div class="subNav">
											<a href="#">实时数据查看</a>
										</div>
										<ul class="navContent">
											<li><img
												src="${base}/static/commons/main/images/icon_jiantou_07.png" />报警实时提醒</li>
											<li><img
												src="${base}/static/commons/main/images/icon_jiantou_07.png" />监测数据查询</li>
										</ul>
										<div class="subNav sjcx">数据查询</div>
										<ul class="navContent" style="padding-bottom: 20px;">
											<li><img
												src="${base}/static/commons/main/images/icon_jiantou_07.png" />监测数据查询统计</li>
											<li><img
												src="${base}/static/commons/main/images/icon_jiantou_07.png" />监测设备查询统计</li>
											<li><img
												src="${base}/static/commons/main/images/icon_jiantou_07.png" />报警信息查询统计</li>
											<li><img
												src="${base}/static/commons/main/images/icon_jiantou_07.png" />物联元素地图查询</li>
										</ul>
									</li>
								</ul>
							</div>
						</li>

						<li>
							<div class="le_bottom_content">
								<div class="le_icon">
									<img src="${base}/static/commons/main/images/icon_16.png" />
								</div>
								<div class="le_text">系统管理</div>
								<div class="le_jiantou">
									<img src="${base}/static/commons/main/images/jt3_03.png" />
								</div>
							</div>
							<div class="pop"
								style="height: 223px; overflow-y: auto; overflow-x: hidden;">
								<ul>
									<li class="subNavBox">
										<div class="subNav1 ">
											<span id="yhgl" data-url="usermanage.html"><a href="#">用户管理</a></span>
										</div>
										<div class="subNav ">角色管理</div>
										<div class="subNav1 ">权限管理</div>
										<div class="subNav1 ">菜单管理</div>
										<div class="subNav ">数据字典管理</div>
										<div class="subNav ">运行监控系统</div>
										<ul class="navContent" style="padding-bottom: 20px;">
											<li><img src="" />硬件资源监控</li>
											<li><img src="" />应用支撑服务运行监控</li>
											<li><img src="" />数据运行监控</li>
											<li><img src="" />物联平台服务运行监控</li>
											<li><img src="" />用户运行监控</li>
											<li><img src="" />日志信息监控</li>
											<li><img src="" />告警信息监控</li>
										</ul>
									</li>
								</ul>
							</div>
						</li>
					</ul>
					<!--菜单结束-->
				</div>
			</nav>
			<!--左侧下半结束-->
		</div>
		<!--右侧开始-->
		<div class="right" id="right">
			<!--右侧头部开始-->
			<header id="title0">
				<p>
					<span class="exit"><img
						src="${base}/static/commons/main/images/menu01_03.png" /></span> <input
						type="text" /> <img
						src="${base}/static/commons/main/images/search_03.png" /> <span
						class="exit_title"> <a href="#"><span
							class="exit_titleimge"> &nbsp;</span>退出</a>
					</span> <span class="password_title"> <a href="#"><span
							class="password_titleimge">&nbsp;</span>修改密码</a>
					</span>
				</p>
			</header>
			<!--右侧头部结束-->
			<!--右侧内容开始-->
			<!--右侧banner-->
			<div class="banner">
				<div style="float: left;">
					<img src="${base}/static/commons/main/images/banner_03.png" />
				</div>

				<div class="bannerimage">
					<img onmousedown="ISL_GoUp()" onmouseup="ISL_StopUp()"
						onmouseout="ISL_StopUp()" class="img2"
						src="${base}/static/commons/main/images/shqm_right_pic.gif"
						width="12" height="31" />
				</div>

				<div class="rollBox">
					<div class="Cont" id="ISL_Cont">
						<div class="ScrCont">
							<div id="List1">
								<!-- 图片列表 begin -->
								<div class="pic">
									<a href="#" target="_blank"><img
										src="${base}/static/commons/main/images/666_03.png" width="50"
										height="50" /></a> <a href="#" target="_blank">视频监控 </a>
								</div>
								<div class="pic">
									<a href="#" target="_blank"><img
										src="${base}/static/commons/main/images/666_05.png" width="50"
										height="50" /></a> <a href="#" target="_blank">智慧安监</a>
								</div>
								<div class="pic">
									<a href="#" target="_blank"><img
										src="${base}/static/commons/main/images/666_07.png" width="50"
										height="50" /></a> <a href="#" target="_blank">能耗与排放</a>
								</div>
								<div class="pic">
									<a href="#" target="_blank"><img
										src="${base}/static/commons/main/images/666_09.png" width="50"
										height="50" /></a> <a href="#" target="_blank">在线监控</a>
								</div>
								<div class="pic">
									<a href="#" target="_blank"><img
										src="${base}/static/commons/main/images/666_03.png" width="50"
										height="50" /></a> <a href="#" target="_blank">在线监控</a>
								</div>
								<div class="pic">
									<a href="#" target="_blank"><img
										src="${base}/static/commons/main/images/666_03.png" width="50"
										height="50" /></a> <a href="#" target="_blank">在线监控</a>
								</div>
								<div class="pic">
									<a href="#" target="_blank"><img
										src="${base}/static/commons/main/images/666_03.png" width="50"
										height="50" /></a> <a href="#" target="_blank">在线监控</a>
								</div>

								<!-- 图片列表 end -->
							</div>
							<div id="List2"></div>
						</div>
					</div>
				</div>
				<!--天气预报结束-->
			</div>
			<!--右侧banner结束-->

			<!--右侧需要切换的内容-->
			<div class="ri_content" id="ri_content">
				<iframe src="shouye.html" name="content" id="content"
					frameborder="0" width="100%" height="100%" scrolling="yes">
					<!--右大决策支持开始-->
				</iframe>
			</div>
			<!--右侧需要切换的内容结束ri_content-->
			<!--<div style="height:28px; clear:both;">&nbsp;</div>-->
			<!--右侧内容结束-->
			<footer>
				<div class="foot">版权所有©中国连云港徐圩新区 Copyright©2016-2020
					www.xwxq.gov.cn 苏ICP备10047703号</div>
			</footer>

		</div>
		<!--右侧结束-->
	</section>
	<!--弹出窗口-->
</body>
<script type="text/javascript">
	num = 5;
	icon = "tqicon1";
</script>
<script type="text/javascript"
	src="${base}/static/commons/main/js/index.js"></script>
<script type="text/javascript">
	$("#main_02,#main1_02,#main4_02,#main5_02,#main6_02").css({
		"opacity" : 0
	});
</script>

<script>
	$(function() {
		$('#yhgl').click(function(event) {
			var url = $(this).attr('data-url');
			$('iframe').attr('src', url)
		});
	})
</script>
<script type="text/javascript">
	//图片滚动列表 mengjia 070816
	var Speed = 10; //速度(毫秒)
	var Space = 10; //每次移动(px)
	var PageWidth = 160; //翻页宽度
	var fill = 0; //整体移位
	var MoveLock = false;
	var MoveTimeObj;
	var Comp = 0;
	var AutoPlayObj = null;
	GetObj("List2").innerHTML = GetObj("List1").innerHTML;
	GetObj('ISL_Cont').scrollLeft = fill;
	GetObj("ISL_Cont").onmouseover = function() {
		clearInterval(AutoPlayObj);
	}
	GetObj("ISL_Cont").onmouseout = function() {
		AutoPlay();
	}
	AutoPlay();
	function GetObj(objName) {
		if (document.getElementById) {
			return eval('document.getElementById("' + objName + '")')
		} else {
			return eval

			('document.all.' + objName)
		}
	}
	function AutoPlay() { //自动滚动
		clearInterval(AutoPlayObj);
		AutoPlayObj = setInterval('ISL_GoDown();ISL_StopDown();', 5000); //间隔时间
	}
	function ISL_GoUp() { //上翻开始
		if (MoveLock)
			return;
		clearInterval(AutoPlayObj);
		MoveLock = true;
		MoveTimeObj = setInterval('ISL_ScrUp();', Speed);
	}
	function ISL_StopUp() { //上翻停止
		clearInterval(MoveTimeObj);
		if (GetObj('ISL_Cont').scrollLeft % PageWidth - fill != 0) {
			Comp = fill - (GetObj('ISL_Cont').scrollLeft % PageWidth);
			CompScr();
		} else {
			MoveLock = false;
		}
		AutoPlay();
	}
	function ISL_ScrUp() { //上翻动作
		if (GetObj('ISL_Cont').scrollLeft <= 0) {
			GetObj('ISL_Cont').scrollLeft = GetObj

			('ISL_Cont').scrollLeft + GetObj('List1').offsetWidth
		}
		GetObj('ISL_Cont').scrollLeft -= Space;
	}
	function ISL_GoDown() { //下翻
		clearInterval(MoveTimeObj);
		if (MoveLock)
			return;
		clearInterval(AutoPlayObj);
		MoveLock = true;
		ISL_ScrDown();
		MoveTimeObj = setInterval('ISL_ScrDown()', Speed);
	}
	function ISL_StopDown() { //下翻停止
		clearInterval(MoveTimeObj);
		if (GetObj('ISL_Cont').scrollLeft % PageWidth - fill != 0) {
			Comp = PageWidth - GetObj('ISL_Cont').scrollLeft % PageWidth + fill;
			CompScr();
		} else {
			MoveLock = false;
		}
		AutoPlay();
	}
	function ISL_ScrDown() { //下翻动作
		if (GetObj('ISL_Cont').scrollLeft >= GetObj('List1').scrollWidth) {
			GetObj('ISL_Cont').scrollLeft = GetObj('ISL_Cont').scrollLeft
					- GetObj('List1').scrollWidth;
		}
		GetObj('ISL_Cont').scrollLeft += Space;
	}
	function CompScr() {
		var num;
		if (Comp == 0) {
			MoveLock = false;
			return;
		}
		if (Comp < 0) { //上翻
			if (Comp < -Space) {
				Comp += Space;
				num = Space;
			} else {
				num = -Comp;
				Comp = 0;
			}
			GetObj('ISL_Cont').scrollLeft -= num;
			setTimeout('CompScr()', Speed);
		} else { //下翻
			if (Comp > Space) {
				Comp -= Space;
				num = Space;
			} else {
				num = Comp;
				Comp = 0;
			}
			GetObj('ISL_Cont').scrollLeft += num;
			setTimeout('CompScr()', Speed);
		}
	}
	//--><!]]>
</script>
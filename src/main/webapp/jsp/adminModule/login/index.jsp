<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="shortcut icon" href="logo.ico">
<title>智慧徐圩管理后台</title>
<%-- <%@ include file="/commons/basejs.jsp" %> --%>
<!-- 首页样式 -->
<link rel="stylesheet" href="${staticPath}/static/adminModule/frame/zui/css/zui.min.css">
<link rel="stylesheet" href="${staticPath}/static/adminModule/frame/zui/css/zui-theme.css">
<link rel="stylesheet" href="${staticPath}/static/adminModule/frame/plugins/ionicons/css/ionicons.css">
<link rel="stylesheet" href="${staticPath}/static/adminModule/frame/zui/lib/datatable/zui.datatable.css">
<link rel="stylesheet" href="${staticPath}/static/adminModule/frame/zui/lib/datetimepicker/datetimepicker.css">
<link rel="stylesheet" href="${staticPath}/static/adminModule/frame/zui/lib/kindeditor//kindeditor.min.css">
<link rel="stylesheet" href="${staticPath}/static/adminModule/frame/css/base.css">
<link rel="stylesheet" href="${staticPath}/static/adminModule/frame/css/index.css">
<!-- 结束 -->
<%-- <script type="text/javascript" src="${staticPath}/static/adminModule/frame/js/index.js" charset="utf-8"></script> --%>
<script type="text/javascript">
	function logout() {
		if (window.confirm('你确定要退出吗？')) {
			//		alert("确定");
			$.post('${path }/admin/logout', function(result) {
				if (result.success) {
					window.location.href = '${path }/admin/login';
				}
			}, 'json');
			//       return true;
		} else {
			//       alert("取消");
			return false;
		}
	}

	function openUrl(url) {
		if (url != null && url != "") {
			$("#content").attr("src", url);
		}
	}
</script>
</head>
<body style="overflow-x:hidden;overflow-y:auto;">
	<div class="container-fluid clearfix">
		<!-- 布局开始 -->
		<div class="row" id="header">
			<img src="${staticPath}/static/adminModule/frame/images/banner_01.png">
			<span class="hj_exit">
				<span>欢迎，${user }</span>
				<a href="javascript:void(0)" onclick="logout()">安全退出</a>
			</span>


		</div>

		<!-- 顶部tab栏 -->
		<div class="row" id="tab-title">
			<div class="top-title" style="padding: 12px 19px;">**当前位置：系统管理 > 用户管理</div>
		</div>
		<!-- 结束 -->

		<!-- 侧边栏 -->
		<div id="sidenav" class="scrollbar-hover">
			<div class="user clearfix">
				<div class="col-xs-12 text-center dropdown" style="width: 89px; margin-left: 29px;">
					<h3 class="admin-name" data-toggle="dropdown" style="width: 89px;">
						<i class="icon icon-bars"></i>
						<span style="margin-left: 5px;">管理菜单</span>
					</h3>
				</div>
			</div>
			<nav class="menu" data-toggle="menu">
				<ul class="nav" style="padding-bottom: 30px;">
					<li class=" nav-parent">
						<a href="javascript:;" onclick="openUrl('${path}/resource/manager');">
							<i class="icon icon-desktop"></i>
							资源管理
						</a>

					</li>
					<li class=" nav-parent">
						<a href="javascript:;" onclick="openUrl('${path}/role/manager');">
							<i class="icon icon-group"></i>
							角色管理
						</a>

					</li>
					<li class="nav-parent">
						<a href="javascript:;" onclick="openUrl('${path}/user/manager');">
							<i class="icon icon-user"></i>
							用户管理
						</a>
						<!-- <ul class="nav">
							<li>
								<a href="javascript:;" data-url="ajax-load/a-list/goods-3cphsz.html" data-class="goods-3cphsz">
									<i class="icon icon-caret-right"></i>
									产品部
								</a>
							</li>
							<li>
								<a href="javascript:;" data-url="ajax-load/a-list/goods-1cplb.html" data-class="goods-1cplb">
									<i class="icon icon-caret-right"></i>
									总经办
								</a>
							</li>

							<li>
								<a href="javascript:;" data-url="ajax-load/a-list/goods-2cpdbsz.html" data-class="goods-2cpdbsz">
									<i class="icon icon-caret-right"></i>
									技术部
								</a>
							</li>
						</ul> -->
					</li>
					<%-- <li class=" nav-parent">
						<a href="javascript:;" onclick="openUrl('${path}/organization/manager');">
							<i class="icon icon-sitemap"></i>
							部门管理
						</a>
					</li>
					<li class=" nav-parent">
						<a href="javascript:;" onclick="openUrl('${path}/puriew/manager');">
							<i class="icon icon-lock"></i>
							权限管理
						</a>
					</li>

					<li class=" nav-parent">
						<a href="javascript:;" onclick="openUrl('${path}/dictionary/manager');">
							<i class="icon icon-lock"></i>
							数据字典
						</a>
					</li>
--%>
					<li class=" nav-parent">
						<a href="javascript:;" onclick="openUrl('${path}/code');">
							<i class="icon icon-lock"></i>
							代码生成
						</a>
					</li> 

					<li class="nav-parent">
						<a href="javascript:;" onblur="ul1();">
							<i class="icon icon-user"></i>
							共享服务平台
						</a>
						
						<ul class="nav">
							<li>
								<a href="javascript:;" onclick="openUrl('${path}/jsp/zh/wd/ssp/manage/wdSspServerList.jsp');" data-url="ajax-load/a-list/goods-3cphsz.html" data-class="goods-3cphsz">
									<i class="icon icon-caret-right"></i>
									服务管理
								</a>
							</li>
							<li>
								<a href="javascript:;" onclick="openUrl('${path}/jsp/zh/wd/ssp/apply/wdSspApplyList.jsp');" data-url="ajax-load/a-list/goods-1cplb.html" data-class="goods-1cplb">
									<i class="icon icon-caret-right"></i>
									服务申请
								</a>
							</li>

							<li>
								<a href="javascript:;" onclick="openUrl('${path}/jsp/zh/wd/ssp/approve/wdSspapplyReviewList.jsp');" data-url="ajax-load/a-list/goods-2cpdbsz.html" data-class="goods-2cpdbsz">
									<i class="icon icon-caret-right"></i>
									服务审批
								</a>
							</li>
						</ul>
						
						 
						
					</li>


					<%-- <li class=" nav-parent"><a href="javascript:;"><i
							class="icon icon-flag"></i>应用服务监控</a>
						<ul class="nav">
							<li><a href="javascript:;"
								onclick="openUrl('${path}/appAnalysis/manager');"
								data-class="goods-3cphsz"><i class="icon icon-caret-right"></i>实时监控</a>
							</li>
							<li><a href="javascript:;"
								onclick="openUrl('${path}/appAnalysis/applyStatis');"
								data-class="goods-1cplb"><i class="icon icon-caret-right"></i>申请统计</a>
							</li>

							<li><a href="javascript:;" 
							onclick="openUrl('${path}/appAnalysis/appCondition');" data-class="goods-2cpdbsz">
							<i class="icon icon-caret-right"></i>运行情况</a></li>
						</ul></li>
						
					<li class=" nav-parent"><a href="javascript:;"><i
							class="icon icon-flag"></i>数据服务监控</a>
						<ul class="nav">
							<li><a href="javascript:;"
								onclick="openUrl('${path}/dataAnalysis/manager');"
								data-class="goods-3cphsz"><i class="icon icon-caret-right"></i>实时监控</a>
							</li>
							<li><a href="javascript:;"
								onclick="openUrl('${path}/dataAnalysis/applyStatis');"
								data-class="goods-1cplb"><i class="icon icon-caret-right"></i>申请统计</a>
							</li>

							<li><a href="javascript:;" 
							onclick="openUrl('${path}/dataAnalysis/dataCondition');" data-class="goods-2cpdbsz">
							<i class="icon icon-caret-right"></i>运行情况</a></li>
						</ul></li>
					<li class=" nav-parent"><a href="javascript:;"
						onclick="openUrl('${path}/log/manager');"><i
							class="icon icon-lock"></i>统一日志管理</a></li>
					<li class=" nav-parent"><a href="javascript:;"><i
							class="icon icon-flag"></i>AIP应用</a>
						<ul class="nav">
							<li><a href="javascript:;"
								onclick="openUrl('${path}/jsp/zh/wd/ssp/aip/wdSspAipAppCatalogsList.jsp');"
								data-class="goods-3cphsz"><i class="icon icon-caret-right"></i>分类管理</a>
							</li>
							<li><a href="javascript:;"
								onclick="openUrl('${path}/jsp/zh/wd/ssp/aip/wdSspAipAppList.jsp');"
								data-class="goods-1cplb"><i class="icon icon-caret-right"></i>应用管理</a>
							</li>
 
						</ul></li> --%>
					<li class=" nav-parent"><a href="javascript:;"><i
							class="icon icon-flag"></i>AIP服务</a>
						<ul class="nav">
							<li><a href="javascript:;"
								onclick="openUrl('${path}/wdSspAipServiceRegister/register');"
								data-class="goods-3cphsz"><i class="icon icon-caret-right"></i>服务注册</a>
							</li>
 							<li><a href="javascript:;"
								onclick="openUrl('${path}/wdSspAipServiceRequestion/requestion');"
								data-class="goods-3cphsz"><i class="icon icon-caret-right"></i>服务申请</a>
							</li>
 							<li><a href="javascript:;"
								onclick="openUrl('${path}/wdSspAipServiceRequestion/approve');"
								data-class="goods-3cphsz"><i class="icon icon-caret-right"></i>服务审批</a>
							</li>
								<li><a href="javascript:;"
								onclick="openUrl('${path}/jsp/zh/wd/ssp/aip/wdSspAipServiceRestfulTest.jsp');"
								data-class="goods-3cphsz"><i class="icon icon-caret-right"></i>发送短信</a>
							</li>
 
						</ul></li>
				</ul>
			</nav>
		</div>
		<!-- 结束 -->
		<!-- 正文 -->
		<div id="main" class="row">
			<iframe id="content" frameborder="0" src="" width="100%" height="100%" style="margin: 0px;padding: 0px;"></iframe>
		</div>
		<!-- 结束 -->
		<!-- 结束 -->
	</div>

	<!-- 底部 -->
	<div class="row text-center" >版权所有©中国连云港徐圩新区 Copyright©2016-2020 公司</div>
	<!-- 结束 -->
	<!-- jQuery v1.11.0  -->
	<script src="${staticPath}/static/adminModule/frame/zui/lib/jquery/jquery.js"></script>
	<script src="${staticPath}/static/adminModule/frame/zui/js/zui.min.js"></script>
	<script src="${staticPath}/static/adminModule/frame/plugins/mock.js"></script>
	<script src="${staticPath}/static/adminModule/frame/zui/lib/bootbox/bootbox.min.js"></script>
	<script src="${staticPath}/static/adminModule/frame/zui/lib/datatable/zui.datatable.min.js"></script>
	<script src="${staticPath}/static/adminModule/frame/zui/lib/datetimepicker/datetimepicker.min.js"></script>
	<script src="${staticPath}/static/adminModule/frame/zui/lib/kindeditor/kindeditor.js"></script>
	<script id="dtjs" src="${staticPath}/static/adminModule/frame/js/base.js"></script>
</body>
</html>



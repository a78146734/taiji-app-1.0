<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>登录页面</title>
<%@ include file="/commons/basejs.jsp"%>
<link href="${staticPath}/static/adminModule/login/css/reset.css"
	rel="stylesheet" type="text/css" />
<link href="${staticPath}/static/adminModule/login/css/base.css"
	rel="stylesheet" type="text/css" />
<link href="${staticPath}/static/adminModule/login/css/css.css"
	rel="stylesheet" type="text/css" />

<script type="text/javascript"
	src="${staticPath}/static/adminModule/login/js/AdminLogin.js"
	charset="utf-8"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$("#password").val("");
	});

	document.onkeydown = keyDownSearch;
	function keyDownSearch(e) {
		// 兼容FF和IE和Opera  
		var theEvent = e || window.event;
		var code = theEvent.keyCode || theEvent.which || theEvent.charCode;
		if (code == 13) {
			submitForm();//具体处理函数  
			return false;
		}
		return true;
	}
</script>

</head>

<body>
	<section class="bg">
		<div class="banner">
			<img
				src="${staticPath}/static/adminModule/login/images/banner_02.png" />
		</div>
		<div class="login">
			<div class="login01">

				<div class="content">
					<span><img
						src="${staticPath}/static/adminModule/login/images/earth_03.png"
						width="181" height="166" /></span> <span>
						<form id="loginform">
							<table>
								<tr>
									<td><img
										src="${staticPath}/static/adminModule/login/images/cion_03.png"
										style="width: 18px; height: 19px; position: absolute; margin-top: 20px; margin-left: 5px;" />

										<input type="text" name="username" value="请输入你的用户名"
										onfocus="if(value=='请输入你的用户名') {value=''}"
										onblur="if (value=='') {value='请输入你的用户名'}" /></td>
								</tr>
								<tr>
									<td><img
										src="${staticPath}/static/adminModule/login/images/cion_06.png"
										style="width: 18px; height: 19px; position: absolute; margin-top: 20px; margin-left: 5px;" />

										<input type="password" id="password" name="password" value=""
										placeholder="请输入密码" onfocus="if(value=='******') {value=''}"
										onblur="if (value=='') {value='******'}" /></td>
								</tr>
							</table>
						</form>
						<button onclick="submitForm();">立即登录</button>

					</span>
				</div>

			</div>
		</div>
	</section>
	<footer>
		<div class="foot">版权所有©中国连云港徐圩新区 Copyright©2016-2020</div>
	</footer>
</html>

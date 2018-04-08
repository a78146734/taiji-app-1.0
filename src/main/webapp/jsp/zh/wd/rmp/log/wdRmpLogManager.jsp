<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<%@include file="../../../../../commons/global.jsp"%>
	<%@include file="../../../../../commons/xw/basejs.jsp"%>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>应用服务监控</title>
<style type="text/css">
	
</style>
</head>
<body>
<div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
  <ul class="layui-tab-title">
    <li class="layui-this" onclick="openUrl('${path}/log/appLog');">应用操作日志</li>
    <li onclick="openUrl('${path}/log/appServiceLog');">应用服务日志</li>
<%--     <li onclick="openUrl('${path}/log/sysLog');">系统管理日志</li>
    <li onclick="openUrl('${path}/log/sysErrorLog');">系统错误日志</li> --%>
    <li onclick="openUrl('${path}/log/appDataServiceLog');">数据服务日志</li>
    <li onclick="openUrl('${path}/log/serviceApplyLog');">服务申请日志</li>
     <li onclick="openUrl('${path}/log/sysUsableLog');">系统错误日志</li>
    <li onclick="openUrl('${path}/log/appEqpLog');">物联设备日志</li>
  </ul>
 
</div> 
			
	 
	<iframe id="content" frameborder="0" src="" width="100%"   height="750px"></iframe>
	
	 
</body>
<script type="text/javascript">
$(function(){
	openUrl("${path}/log/appLog");
});

function openUrl(url){
	if(url != null && url != ""){
		$("#content").attr("src",url);		 
	}
}
</script>
</html>
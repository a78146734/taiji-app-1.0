<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String id = "";
if(StringUtils.isNotBlank(request.getParameter("id").toString())){
	id = request.getParameter("id").toString();
}else{
	out.println("id为空！");
}

String type = "";
if(StringUtils.isNotBlank(request.getParameter("type").toString())){
	type = request.getParameter("type").toString();
}else{
	out.println("type为空！");
}
 %>
<!DOCTYPE html>
<html>
<head>
<title>查看流程图</title>
<%@include file="../../../../../commons/global.jsp"%>
<%@include file="../../../../../commons/xw/basejs.jsp"%>
<script type="text/javascript" src="js/sysJobAdd.js"></script>

<link rel="stylesheet" type="text/css" href="css/sysJobAdd.css">
<style type="text/css">
	html,body{
		min-width: 500px;
	}
	.topdiv{
		text-align:center;
		width: 100%;
		height: 100%;
	}
</style>
</head>
<body>
<div class="topdiv">
	
	<%if(type.equals("re")){
		%>
			<!-- 流程定义流程图 -->
			<img alt="流程图" style="vertical-align: middle;" src="${base}/activiti/resourceRead?processDefinitionId=<%=id%>&resourceType=image">
		<%
		}else{
		%>	
			<!-- 流程追踪流程图 -->
			<img alt="流程图" style="vertical-align: middle;" src="${base}/activiti/traceImage?processInstanceId=<%=id%>&resourceType=image">
		<%
	} %>
</div>
</body>
</html>
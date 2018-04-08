<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<%@include file="../../commons/global.jsp"%>
	<%@include file="../../commons/xw/basejs.jsp"%>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>应用服务监控</title>
</head>
<body>
<div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
  <ul id="tab" class="layui-tab-title">
  	<shiro:hasPermission name="/jsp/admin/puriew.jsp">
    	<li class="layui-this" onclick="openUrl('${path}/jsp/admin/puriew.jsp');">自定义权限管理</li>
    </shiro:hasPermission>
    
    <shiro:hasPermission name="/jsp/admin/puriewMenu.jsp">
    	<li onclick="openUrl('${path}/jsp/admin/puriewMenu.jsp');">资源权限查询</li>
    </shiro:hasPermission>
  </ul>
</div> 
	<iframe id="content" frameborder="0" src="" width="100%"   height="600px"></iframe>
</body>
<script type="text/javascript">
$(function(){
	$("#tab").find("li").eq(0).trigger("click");
});

function openUrl(url){
	if(url != null && url != ""){
		$("#content").attr("src",url);		 
	}
}
</script>
</html>
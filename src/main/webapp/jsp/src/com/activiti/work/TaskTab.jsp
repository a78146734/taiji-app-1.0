<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<%@include file="../../../../../commons/global.jsp"%>
	<%@include file="../../../../../commons/xw/basejs.jsp"%>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>任务列表</title>
</head>
<body>
<div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
  <ul id="tab" class="layui-tab-title">
    	<li class="layui-this" onclick="openUrl('${path}/jsp/src/com/activiti/work/claimedTaskList.jsp');">待办件</li>
    
    	<li onclick="openUrl('${path}/jsp/admin/puriewMenu.jsp');">已办件</li>
    	<li onclick="openUrl('${path}/jsp/admin/puriewMenu.jsp');">已结件</li>
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
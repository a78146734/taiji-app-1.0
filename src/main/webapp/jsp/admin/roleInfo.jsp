<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String id = "";
if(request.getParameter("id")!=null&&request.getParameter("id")!=""){
	id = (String)request.getParameter("id");
}else{
	out.println("没有接受到主键的错误");
}
%>
<%@ include file="../../commons/global.jsp"%>
<%@ include file="../../commons/xw/basejs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<style type="text/css">
	body{
		min-width: 600px;
	}
</style>
</head>
<body>
	<div class="user_manage">
		<div class="user_list">
			<table class="gridtable04 ">
				<tbody id="tb">
				       		
				</tbody>
			</table>
		</div>
	</div>
	<div class="tablebut"> 
		<button type="button" onclick="cancel();">返回</button>
	</div>
</body>
<script type="text/javascript">
$(document).ready(function(){
 	doQuery();
});
//查询执行方法
function doQuery(){
	$.ajax({
 		type: "get",
 		url: "<%=basePath%>/role/selectByPrimaryKey",
 		data:{
 			"id":"<%=id%>"
 		},
 		async: true,
 		dataType: "text",
 		success: function(data){
 			
 			var das = JSON.parse(data);
 			if(!das.success){
 				alert(das.msg);
 			}
 			var sb = new StringBuilder();
 			sb.append("<tr style='display:none'><td>").append(das.obj.roleId).append("</td></tr>");
			sb.append("<tr><td class='tablecolor'>角色名称：").append("</td><td  >").append(das.obj.roleName).append("</td>");
			sb.append("<td  class='tablecolor'>标示：</td><td >").append(das.obj.code).append("</td></tr>");
			
			sb.append("<tr><td  class='tablecolor'>排序：</td><td >").append(das.obj.seq).append("</td>");
			sb.append("<td  class='tablecolor'>描述：</td><td >").append(das.obj.describe).append("</td></tr>");
			
		 	$("#tb").html(sb.toString());
 		}
		});
}
function cancel(){
	parent.layer.closeAll();
}
</script>
</html>
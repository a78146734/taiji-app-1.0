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
<!DOCTYPE html>
<html>
<head>
<%@include file="../../../../../commons/global.jsp"%>
<%@include file="../../../../../commons/xw/basejs.jsp"%>
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
		//初始加载
		$(document).ready(function(){
		 	doQuery();
		});
	
		//查询执行方法
		function doQuery(){
			
			$.ajax({
		 		type: "get",
		 		url: "<%=basePath%>/sysJob/selectByPrimaryKey",
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
		 			sb.append("<tr style='display:none'><td>").append(das.obj.jobId).append("</td></tr>");
					sb.append("<tr><td class='tablecolor'>任务名称：").append("</td><td  >").append(das.obj.jobName).append("</td>");
					sb.append("<td  class='tablecolor'>表达式：</td><td >").append(das.obj.cronExpression).append("</td></tr>");
					sb.append("<tr><td  class='tablecolor'>执行类：</td><td >").append(das.obj.beanClass).append("</td>");
					sb.append("<td  class='tablecolor'>执行方法：</td><td >").append(das.obj.methodName).append("</td></tr>");
					sb.append("<tr><td class='tablecolor'>创建时间：").append("</td><td  >").append(das.obj.createTime).append("</td>");
					sb.append("<td class='tablecolor'>更新时间：").append("</td><td  >").append(das.obj.updatetime).append("</td></tr>");
					sb.append("<tr><td class='tablecolor'>任务描述：").append("</td><td  >").append(das.obj.description).append("</td></tr>");
				 	$("#tb").html(sb.toString());
		 		}
 			});
		}
		function cancel(){
			parent.layer.closeAll();
		}
		
	</script>
</html>
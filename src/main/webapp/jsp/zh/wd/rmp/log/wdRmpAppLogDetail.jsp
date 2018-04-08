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
<!-- <script type="text/javascript" src="js/wdRmpAppLogDetail.js"></script>
<link rel="stylesheet" type="text/css" href="css/wdRmpAppLogDetail.css"> -->
<script type="text/javascript">
     window.onlo
     ad=function(){window.parent.scrollTo(0,0);}
</script>
<style type="text/css">
body {
	min-width: 600px;
}
</style>
</head>
<body>
	<div class="user_manage">
		<p class="ri_jczctitle">
			<span class="ri_jczctitletxt">详情页面</span> <span
				class="ri_jczctitlemore"></span>
		</p>
		<div class="user_list">
			<table class="gridtable04 ">
				<tbody id="tb">

				</tbody>
			</table>
		</div>
	</div>
	<div class="tablebut">
		<button type="button" onclick="cancel();">取消</button>
	</div>
</body>
<script type="text/javascript">
		var Modular = <dic:html nodeId="system" name="Modular" type="jsonByParam1" />;
		//初始加载
		$(document).ready(function(){
		 	doQuery();
		});
	
		//查询执行方法
		function doQuery(){
			
			$.ajax({
		 		type: "get",
		 		url: "<%=basePath%>/wdRmpAppLog/selectByPrimaryKey",
		 		data:{
		 			"id":"<%=id%>"
		 		},
		 		async: true,
		 		dataType: "text",
		 		success: function(data){
		 			var das = JSON.parse(data);
		 			var sb = new StringBuilder();
		 					 						 					sb.append("<tr style='display:none'><td>").append(das.obj.id).append("</td></tr>");
		 						 					 						 				    
		 				
			sb.append("<tr><td style='width:15%;' class='tablecolor'>日志级别：").append("</td><td  >").append(das.obj.logLevel).append("</td>");
			
					 						 					 						 				    
		 				
						sb.append("<td  class='tablecolor'>模块名称：</td><td >").append(Modular[das.obj.logModular]).append("</td></tr>");
					 						 					 						 				    
		 				
			sb.append("<tr><td class='tablecolor'>功能名称：").append("</td><td  >").append(das.obj.logFunction).append("</td>");
			
					 						 					 						 				    
		 				
						sb.append("<td  class='tablecolor'>子系统标识：</td><td >").append(das.obj.sysCode).append("</td></tr>");
					 						 					 						 				    
		 				
		
					 						 					 						 				    
		 				
			sb.append("<tr><td class='tablecolor'>日期：").append("</td><td  >").append(das.obj.logDate).append("</td>");
			
					 						 					 						 				    
		 				
						sb.append("<td  class='tablecolor'>操作人ID：</td><td >").append(das.obj.userId).append("</td></tr>");
					 						 					 						 				    
		 				
			sb.append("<tr><td class='tablecolor'>操作人IP：").append("</td><td  >").append(das.obj.logIp).append("</td>");
			
					 						 					 						 				    
		 				
						sb.append("<td  class='tablecolor'>被访问类：</td><td >").append(das.obj.logClass).append("</td></tr>");
					 						 					 						 				    
		 				
			sb.append("<tr><td class='tablecolor'>被访问方法：").append("</td><td  >").append(das.obj.logMethod).append("</td>");
			
					 						 					 						 				    
		 				
						sb.append("</tr>");
					 						 					 						 				    
		 				
			
					 						 					 	
           	sb.append("<tr><td class='tablecolor'>备注信息：").append("</td><td colspan='3' >").append(das.obj.logMessage).append("</td>");
			
					 						 					 						 				    
		 				
						sb.append("</tr>");					 						 					 	
					 						 					 			$("#tb").html(sb.toString());
		 		}
 			});
		}
		
		
	</script>
</html>
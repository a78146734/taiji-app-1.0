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
<!-- <script type="text/javascript" src="js/wdRmpAppDataServiceLogDetail.js"></script>
<link rel="stylesheet" type="text/css" href="css/wdRmpAppDataServiceLogDetail.css"> -->
<script type="text/javascript">
     window.onload=function(){window.parent.scrollTo(0,0);}
</script>
<style type="text/css">
	body{
		min-width: 600px;
	}
</style>
</head>
<body>
	<div class="user_manage">
		<p class="ri_jczctitle">
         <span class="ri_jczctitletxt">详情页面</span>
         <span class="ri_jczctitlemore"></span>
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
		//初始加载
		$(document).ready(function(){
		 	doQuery();
		});
	
		//查询执行方法
		function doQuery(){
			
			$.ajax({
		 		type: "get",
		 		url: "<%=basePath%>/wdRmpAppDataServiceLog/selectByPrimaryKey",
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
		 					 						 					sb.append("<tr style='display:none'><td>").append(das.obj.id).append("</td></tr>");
		 						 					 						 				    
		 				
			sb.append("<tr><td class='tablecolor'>日志级别：").append("</td><td  >").append(das.obj.logLevel).append("</td>");
			
					 						 					 						 				    
		 				
						sb.append("<td  class='tablecolor'>数据子服务标识：</td><td >").append(das.obj.logService).append("</td></tr>");
					 						 					 						 				    
		 				
			sb.append("<tr><td class='tablecolor'>数据子服务路径：").append("</td><td  >").append(das.obj.logServicePath).append("</td>");
			
					 						 					 						 				    
		 				
						sb.append("<td  class='tablecolor'>数据子服务名称：</td><td >").append(das.obj.logServiceName).append("</td></tr>");
					 						 					 						 				    
		 				
			sb.append("<tr><td class='tablecolor'>信息：").append("</td><td  >").append(das.obj.logMessage,50).append("</td>");
			
					 						 					 						 				    
		 				
			/* 			sb.append("<td  class='tablecolor'>数据大小：</td><td >").append(das.obj.dataSize).append("</td></tr>");
					 						 					 						 				    
		 				
			sb.append("<tr><td class='tablecolor'>数据条数：").append("</td><td  >").append(das.obj.dataCount).append("</td>");
			 */
					 						 					 						 				    
		 				
						sb.append("<td  class='tablecolor'>日期：</td><td >").append(das.obj.logDate).append("</td></tr>");
					 						 					 						 				    
		 				
			sb.append("<tr><td class='tablecolor'>操作人ID：").append("</td><td  >").append(das.obj.userId).append("</td>");
			
					 						 					 						 				    
		 				
						sb.append("<td  class='tablecolor'>操作人IP：</td><td >").append(das.obj.logIp).append("</td></tr>");
					 						 					 						 				    
		 				
			sb.append("<tr><td class='tablecolor'>部门标识：").append("</td><td  >").append(das.obj.sysCode).append("</td>");
			
					 						 					 						 				    
			if(das.obj.serviceStatus==0){
					sb.append("<td  class='tablecolor'>调用结果状态：</td><td >").append("失败").append("</td></tr>");
				}
				else if(das.obj.serviceStatus==1){
					sb.append("<td  class='tablecolor'>调用结果状态：</td><td >").append("成功").append("</td></tr>");
				}else{
						sb.append("<td  class='tablecolor'>调用结果状态：</td><td >").append(das.obj.serviceStatus).append("</td></tr>");
					}
					 						 					 						 				    
		 				
			sb.append("<tr><td class='tablecolor'>响应时间（单位：毫秒）：").append("</td><td  >").append(das.obj.serviceRuntime).append("</td>");
			
					 						 					 						 				    
		 				
						sb.append("<td  class='tablecolor'>服务标识：</td><td >").append(das.obj.logPService).append("</td></tr>");
					 						 					 						 				    
		 				
			sb.append("<tr><td class='tablecolor'>服务名称：").append("</td><td  >").append(das.obj.logPServiceName).append("</td>");
			
					 						 					 						 				    
		 				
						sb.append("<td  class='tablecolor'>请求ID：</td><td >").append(das.obj.requestId).append("</td></tr>");
					 						 					 						 				    
		 				
			sb.append("<tr><td class='tablecolor'>协议：").append("</td><td  >").append(das.obj.protocol).append("</td>");
			
					 						 					 						 				    
		 				
						sb.append("<td  class='tablecolor'>请求数据大小（单位：Byte）：</td><td >").append(das.obj.requestSize).append("</td></tr>");
					 						 					 						 				    
		 				
			sb.append("<tr><td class='tablecolor'>响应数据大小（单位：Byte）：").append("</td><td  >").append(das.obj.responseSize).append("</td>");
						
					sb.append("<td  class='tablecolor'>错误信息：</td><td >").append(das.obj.errorComment,50).append("</td></tr>");
					 						 					 			$("#tb").html(sb.toString());
		 		}
 			});
		}
		
		
	</script>
</html>
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
<script type="text/javascript" src="js/wdRmpSysErrorLogDetail.js"></script>
<link rel="stylesheet" type="text/css" href="css/wdRmpSysErrorLogDetail.css">
<script type="text/javascript">
     window.onload=function(){window.parent.scrollTo(0,0);}
</script>
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
               <button type="button" onclick="back();">返回</button>
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
		 		url: "<%=basePath%>/wdRmpSysErrorLog/selectByPrimaryKey",
		 		data:{
		 			"id":"<%=id%>"
		 		},
		 		async: true,
		 		dataType: "text",
		 		success: function(data){
		 			var das = JSON.parse(data);
		 			var sb = new StringBuilder();
		 					 						 					sb.append("<tr style='display:none'><td>").append(das.obj.id).append("</td></tr>");
		 						 					 						 				    
		 				
			sb.append("<tr><td class='tablecolor'>日志级别：").append("</td><td  >").append(das.obj.logLevel).append("</td>");
			
					 						 					 						 				    
		 				
						sb.append("<td  class='tablecolor'>被访问类：</td><td >").append(das.obj.logClass).append("</td></tr>");
					 						 					 						 				    
		 				
			sb.append("<tr><td class='tablecolor'>被访问方法：").append("</td><td  >").append(das.obj.logMethod).append("</td>");
			
					 						 					 						 				    
		 				
						sb.append("<td  class='tablecolor'>参数：</td><td >").append(das.obj.logParameter).append("</td></tr>");
					 						 					 						 				    
		 				
			sb.append("<tr><td class='tablecolor'>操作人ID：").append("</td><td  >").append(das.obj.userId).append("</td>");
			
					 						 					 						 				    
		 				
						sb.append("<td  class='tablecolor'>操作人IP：</td><td >").append(das.obj.logIp).append("</td></tr>");
					 						 					 						 				    
		 				
			sb.append("<tr><td class='tablecolor'>信息：").append("</td><td  >").append(das.obj.logMessage).append("</td>");
			
					 						 					 						 				    
		 				
						sb.append("<td  class='tablecolor'>子系统标识：</td><td >").append(das.obj.sysCode).append("</td></tr>");
					 						 					 						 				    
		 				
			sb.append("<tr><td class='tablecolor'>日期：").append("</td><td  >").append(das.obj.logDate).append("</td>");
			
					 						 					 			$("#tb").html(sb.toString());
		 		}
 			});
		}
		
		
		function back() {
			location.href=basePath + "/jsp/zh/wd/rmp/log/wdRmpSysErrorLogList.jsp";
		}
	</script>
</html>
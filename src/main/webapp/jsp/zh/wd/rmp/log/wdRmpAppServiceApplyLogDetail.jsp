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
<!-- <script type="text/javascript" src="js/wdRmpAppServiceApplyLogDetail.js"></script>
<link rel="stylesheet" type="text/css" href="css/wdRmpAppServiceApplyLogDetail.css"> -->
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
		 		url: "<%=basePath%>/wdRmpAppServiceApplyLog/selectByPrimaryKey",
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
			
					 						 					 						 				    
		 				
						sb.append("<td  class='tablecolor'>信息：</td><td >").append(das.obj.logMessage).append("</td></tr>");
					 						 					 						 				    
		 				
			sb.append("<tr><td class='tablecolor'>日期：").append("</td><td  >").append(das.obj.logDate).append("</td>");
			
					 						 					 						 				    
		 				
						sb.append("<td  class='tablecolor'>操作人ID：</td><td >").append(das.obj.userId).append("</td></tr>");
					 						 					 						 				    
		 				
			sb.append("<tr><td class='tablecolor'>操作人IP：").append("</td><td  >").append(das.obj.logIp).append("</td>");
			
					 						 					 						 				    
		 				
						sb.append("<td  class='tablecolor'>部门标识：</td><td >").append(das.obj.sysCode).append("</td></tr>");
					 						 					 						 				    
		 				
			sb.append("<tr><td class='tablecolor'>调用结果状态（0服务审核失败，1服务审核通过，2服务申请）：").append("</td><td  >").append(das.obj.serviceStatus).append("</td>");
			
					 						 					 						 				    
		 				
						sb.append("<td  class='tablecolor'>服务标识：</td><td >").append(das.obj.logPService).append("</td></tr>");
					 						 					 						 				    
		 				
			sb.append("<tr><td class='tablecolor'>服务名称：").append("</td><td  >").append(das.obj.logPServiceName).append("</td>");
			
					 						 					 						 				    
		 				if(das.obj.serviceType==1){
		 					sb.append("<td  class='tablecolor'>服务类型：</td><td >").append("应用服务").append("</td></tr>");
		 				}else if(das.obj.serviceType == 2){
		 					sb.append("<td  class='tablecolor'>服务类型：</td><td >").append("数据服务").append("</td></tr>");
		 				}
						
					 						 					 						 				    
		 				
		/* 	sb.append("<tr><td class='tablecolor'>功能名称：").append("</td><td  >").append(das.obj.serviceFunction).append("</td>"); */
			
					 						 					 			$("#tb").html(sb.toString());
		 		}
 			});
		}
		
		
		function back() {
			location.href=basePath + "/jsp/zh/wd/rmp/log/wdRmpAppServiceApplyLogList.jsp";
		}
	</script>
</html>
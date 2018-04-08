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
<script type="text/javascript" src="js/wdRmpAppDataServiceLogUpdate.js"></script>
<link rel="stylesheet" type="text/css" href="css/wdRmpAppDataServiceLogUpdate.css">

</head>
<body>
	<form id="form1" >
		<div class="user_manage">
			<p class="ri_jczctitle">
	           <span class="ri_jczctitletxt">更新页面</span>
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
               <button type="button" onclick="Submit();">提交</button>&nbsp;&nbsp;&nbsp;&nbsp;<button type="button" onclick="back();">取消</button>
        </div>
	</form>
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
		 					 						 					sb.append("<tr style='display:none'><td><input name='id' type='hidden' value='").append(das.obj.id).append("'></td></tr>");
		 						 					 						 				    
		 				
			sb.append("<tr><td class='tablecolor'>日志级别：").append("</td><td  ><input type='text' name='logLevel'  value='").append(das.obj.logLevel).append("' ></td>");
			
					 						 					 						 				    
		 				
						sb.append("<td  class='tablecolor'>数据服务标示：</td><td ><input type='text' name='logService'  value='").append(das.obj.logService).append("' ></td></tr>");
					 						 					 						 				    
		 				
			sb.append("<tr><td class='tablecolor'>数据服务路径：").append("</td><td  ><input type='text' name='logServicePath'  value='").append(das.obj.logServicePath).append("' ></td>");
			
					 						 					 						 				    
		 				
						sb.append("<td  class='tablecolor'>数据服务名称：</td><td ><input type='text' name='logServiceName'  value='").append(das.obj.logServiceName).append("' ></td></tr>");
					 						 					 						 				    
		 				
			sb.append("<tr><td class='tablecolor'>信息：").append("</td><td  ><input type='text' name='logMessage'  value='").append(das.obj.logMessage).append("' ></td>");
			
					 						 					 						 				    
		 				
						sb.append("<td  class='tablecolor'>数据大小：</td><td ><input type='text' name='dataSize'  value='").append(das.obj.dataSize).append("' ></td></tr>");
					 						 					 						 				    
		 				
			sb.append("<tr><td class='tablecolor'>数据条数：").append("</td><td  ><input type='text' name='dataCount'  value='").append(das.obj.dataCount).append("' ></td>");
			
					 						 					 						 				    
		 				
						sb.append("<td  class='tablecolor'>日期：</td><td ><input type='text' name='logDate'  value='").append(das.obj.logDate).append("' ></td></tr>");
					 						 					 						 				    
		 				
			sb.append("<tr><td class='tablecolor'>操作人ID：").append("</td><td  ><input type='text' name='userId'  value='").append(das.obj.userId).append("' ></td>");
			
					 						 					 						 				    
		 				
						sb.append("<td  class='tablecolor'>操作人IP：</td><td ><input type='text' name='logIp'  value='").append(das.obj.logIp).append("' ></td></tr>");
					 						 					 						 				    
		 				
			sb.append("<tr><td class='tablecolor'>系统标示：").append("</td><td  ><input type='text' name='sysCode'  value='").append(das.obj.sysCode).append("' ></td>");
			
					 						 					 						 				    
		 				
						sb.append("<td  class='tablecolor'>服务状态：</td><td ><input type='text' name='serviceStatus'  value='").append(das.obj.serviceStatus).append("' ></td></tr>");
					 						 					 						 				    
		 				
			sb.append("<tr><td class='tablecolor'>响应时间：").append("</td><td  ><input type='text' name='serviceRuntime'  value='").append(das.obj.serviceRuntime).append("' ></td>");
			
					 						 					 						 				    
		 				
						sb.append("<td  class='tablecolor'>父服务标识：</td><td ><input type='text' name='logPService'  value='").append(das.obj.logPService).append("' ></td></tr>");
					 						 					 						 				    
		 				
			sb.append("<tr><td class='tablecolor'>父服务名称：").append("</td><td  ><input type='text' name='logPServiceName'  value='").append(das.obj.logPServiceName).append("' ></td>");
			
					 						 					 						 				    
		 				
						sb.append("<td  class='tablecolor'>请求ID：</td><td ><input type='text' name='requestId'  value='").append(das.obj.requestId).append("' ></td></tr>");
					 						 					 						 				    
		 				
			sb.append("<tr><td class='tablecolor'>协议：").append("</td><td  ><input type='text' name='protocol'  value='").append(das.obj.protocol).append("' ></td>");
			
					 						 					 						 				    
		 				
						sb.append("<td  class='tablecolor'>请求数据大小：</td><td ><input type='text' name='requestSize'  value='").append(das.obj.requestSize).append("' ></td></tr>");
					 						 					 						 				    
		 				
			sb.append("<tr><td class='tablecolor'>错误信息：").append("</td><td  ><input type='text' name='errorComment'  value='").append(das.obj.errorComment).append("' ></td>");
			
					 						 					 			$("#tb").html(sb.toString());
		 		}
 			});
		}
		
		
		function Submit() {
			var params = $("#form1").serialize();
			$.ajax({
		 		type: "post",
		 		url: "<%=basePath%>/wdRmpAppDataServiceLog/update",
		 		data:params,
		 		async: true,
		 		dataType: "text",
		 		beforeSend: function(){},  
	        	complete: function(){},
		 		success: function(data){
		 			var das = JSON.parse(data);
		 			if(das.success){
		 				location.href=basePath + "/static/commons/massage/success.jsp?url="+basePath+"/jsp/zh/wd/rmp/log/wdRmpAppDataServiceLogList.jsp";
		 			}else{
		 				location.href=basePath + "/static/commons/massage/failure.jsp?url="+basePath+"/jsp/zh/wd/rmp/log/wdRmpAppDataServiceLogList.jsp";
		 			}
		 		}
 			});
		}
	
		function back() {
			location.href=basePath + "/jsp/zh/wd/rmp/log/wdRmpAppDataServiceLogList.jsp";
		}
	</script>
</html>
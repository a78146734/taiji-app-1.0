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
<script type="text/javascript" src="js/wdRmpAppLogUpdate.js"></script>
<link rel="stylesheet" type="text/css" href="css/wdRmpAppLogUpdate.css">

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
		 		url: "<%=basePath%>/wdRmpAppLog/selectByPrimaryKey",
		 		data:{
		 			"id":"<%=id%>"
		 		},
		 		async: true,
		 		dataType: "text",
		 		success: function(data){
		 			var das = JSON.parse(data);
		 			var sb = new StringBuilder();
		 					 						 					sb.append("<tr style='display:none'><td><input name='id' type='hidden' value='").append(das.obj.id).append("'></td></tr>");
		 						 					 						 				    
		 				
			sb.append("<tr><td class='tablecolor'>日志级别：").append("</td><td  ><input type='text' name='logLevel'  value='").append(das.obj.logLevel).append("' ></td>");
			
					 						 					 						 				    
		 				
						sb.append("<td  class='tablecolor'>模块名称：</td><td ><input type='text' name='logModular'  value='").append(das.obj.logModular).append("' ></td></tr>");
					 						 					 						 				    
		 				
			sb.append("<tr><td class='tablecolor'>功能名称：").append("</td><td  ><input type='text' name='logFunction'  value='").append(das.obj.logFunction).append("' ></td>");
			
					 						 					 						 				    
		 				
						sb.append("<td  class='tablecolor'>操作类型：</td><td ><input type='text' name='operatType'  value='").append(das.obj.operatType).append("' ></td></tr>");
					 						 					 						 				    
		 				
			sb.append("<tr><td class='tablecolor'>备注信息：").append("</td><td  ><input type='text' name='logMessage'  value='").append(das.obj.logMessage).append("' ></td>");
			
					 						 					 						 				    
		 				
						sb.append("<td  class='tablecolor'>子系统标示：</td><td ><input type='text' name='sysCode'  value='").append(das.obj.sysCode).append("' ></td></tr>");
					 						 					 						 				    
		 				
			sb.append("<tr><td class='tablecolor'>日期：").append("</td><td  ><input type='text' name='logDate'  value='").append(das.obj.logDate).append("' ></td>");
			
					 						 					 						 				    
		 				
						sb.append("<td  class='tablecolor'>操作人ID：</td><td ><input type='text' name='userId'  value='").append(das.obj.userId).append("' ></td></tr>");
					 						 					 						 				    
		 				
			sb.append("<tr><td class='tablecolor'>操作人IP：").append("</td><td  ><input type='text' name='logIp'  value='").append(das.obj.logIp).append("' ></td>");
			
					 						 					 						 				    
		 				
						sb.append("<td  class='tablecolor'>被访问类：</td><td ><input type='text' name='logClass'  value='").append(das.obj.logClass).append("' ></td></tr>");
					 						 					 						 				    
		 				
			sb.append("<tr><td class='tablecolor'>被访问方法：").append("</td><td  ><input type='text' name='logMethod'  value='").append(das.obj.logMethod).append("' ></td>");
			
					 						 					 						 				    
		 				
						sb.append("<td  class='tablecolor'>父服务标识：</td><td ><input type='text' name='logPService'  value='").append(das.obj.logPService).append("' ></td></tr>");
					 						 					 						 				    
		 				
			sb.append("<tr><td class='tablecolor'>父服务名称：").append("</td><td  ><input type='text' name='logPServiceName'  value='").append(das.obj.logPServiceName).append("' ></td>");
			
					 						 					 			$("#tb").html(sb.toString());
		 		}
 			});
		}
		
		
		function Submit() {
			var params = $("#form1").serialize();
			$.ajax({
		 		type: "post",
		 		url: "<%=basePath%>/wdRmpAppLog/update",
		 		data:params,
		 		async: true,
		 		dataType: "text",
		 		beforeSend: function(){},  
	        	complete: function(){},
		 		success: function(data){
		 			var das = JSON.parse(data);
		 			if(das.success){
		 				location.href=basePath + "/static/commons/massage/success.jsp?url="+basePath+"/jsp/zh/wd/rmp/log/wdRmpAppLogList.jsp";
		 			}else{
		 				location.href=basePath + "/static/commons/massage/failure.jsp?url="+basePath+"/jsp/zh/wd/rmp/log/wdRmpAppLogList.jsp";
		 			}
		 		}
 			});
		}
	
		function back() {
			location.href=basePath + "/jsp/zh/wd/rmp/log/wdRmpAppLogList.jsp";
		}
	</script>
</html>
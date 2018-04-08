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
<script type="text/javascript" src="js/wdRmpSysUsableLogUpdate.js"></script>
<link rel="stylesheet" type="text/css" href="css/wdRmpSysUsableLogUpdate.css">

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
		 		url: "<%=basePath%>/wdRmpSysUsableLog/selectByPrimaryKey",
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
		 						 					 						 				    
		 				
			sb.append("<tr><td class='tablecolor'>日志等级：").append("</td><td  ><input type='text' name='logLevel'  value='").append(das.obj.logLevel).append("' ></td>");
			
					 						 					 						 				    
		 				
						sb.append("<td  class='tablecolor'>系统名称：</td><td ><input type='text' name='sysName'  value='").append(das.obj.sysName).append("' ></td></tr>");
					 						 					 						 				    
		 				
			sb.append("<tr><td class='tablecolor'>系统名称：").append("</td><td  ><input type='text' name='sysUrl'  value='").append(das.obj.sysUrl).append("' ></td>");
			
					 						 					 						 				    
		 				
						sb.append("<td  class='tablecolor'>系统IP：</td><td ><input type='text' name='sysIp'  value='").append(das.obj.sysIp).append("' ></td></tr>");
					 						 					 						 				    
		 				
			sb.append("<tr><td class='tablecolor'>系统Port：").append("</td><td  ><input type='text' name='sysPort'  value='").append(das.obj.sysPort).append("' ></td>");
			
					 						 					 						 				    
		 				
						sb.append("<td  class='tablecolor'>系统状态(0为异常,1正常)：</td><td ><input type='text' name='sysState'  value='").append(das.obj.sysState).append("' ></td></tr>");
					 						 					 						 				    
		 				
			sb.append("<tr><td class='tablecolor'>系统方法：").append("</td><td  ><input type='text' name='sysFunction'  value='").append(das.obj.sysFunction).append("' ></td>");
			
					 						 					 						 				    
		 				
						sb.append("<td  class='tablecolor'>联系电话：</td><td ><input type='text' name='sysPhone'  value='").append(das.obj.sysPhone).append("' ></td></tr>");
					 						 					 						 				    
		 				
			sb.append("<tr><td class='tablecolor'>系统类型：").append("</td><td  ><input type='text' name='usableType'  value='").append(das.obj.usableType).append("' ></td>");
			
					 						 					 						 				    
		 				
						sb.append("<td  class='tablecolor'>错误计数：</td><td ><input type='text' name='errorCount'  value='").append(das.obj.errorCount).append("' ></td></tr>");
					 						 					 						 				    
		 				
			sb.append("<tr><td class='tablecolor'>是否短信通知：").append("</td><td  ><input type='text' name='logNotify'  value='").append(das.obj.logNotify).append("' ></td>");
			
					 						 					 						 				    
		 				
						sb.append("<td  class='tablecolor'>记录时间：</td><td ><input type='text' name='logDate'  value='").append(das.obj.logDate).append("' ></td></tr>");
					 						 					 						 				    
		 				
			sb.append("<tr><td class='tablecolor'>系统id：").append("</td><td  ><input type='text' name='sysId'  value='").append(das.obj.sysId).append("' ></td>");
			
					 						 					 			$("#tb").html(sb.toString());
		 		}
 			});
		}
		
		
		function Submit() {
			var params = $("#form1").serialize();
			$.ajax({
		 		type: "post",
		 		url: "<%=basePath%>/wdRmpSysUsableLog/update",
		 		data:params,
		 		async: true,
		 		dataType: "text",
		 		beforeSend: function(){},  
	        	complete: function(){},
		 		success: function(data){
		 			var das = JSON.parse(data);
		 			if(das.success){
		 				location.href=basePath + "/static/commons/massage/success.jsp?url="+basePath+"/jsp/zh/wd/rmp/usability/wdRmpSysUsableLogList.jsp";
		 			}else{
		 				location.href=basePath + "/static/commons/massage/failure.jsp?url="+basePath+"/jsp/zh/wd/rmp/usability/wdRmpSysUsableLogList.jsp";
		 			}
		 		}
 			});
		}
	
		function back() {
			location.href=basePath + "/jsp/zh/wd/rmp/usability/wdRmpSysUsableLogList.jsp";
		}
	</script>
</html>
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
<script type="text/javascript" src="js/oopUpdate.js"></script>
<link rel="stylesheet" type="text/css" href="css/oopUpdate.css">

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
		 		url: "<%=basePath%>/oop/selectByPrimaryKey",
		 		data:{
		 			"id":"<%=id%>"
		 		},
		 		async: true,
		 		dataType: "text",
		 		success: function(data){
		 			var das = JSON.parse(data);
		 			var sb = new StringBuilder();
		 					 						 					sb.append("<tr style='display:none'><td><input name='id' type='hidden' value='").append(das.obj.id).append("'></td></tr>");
		 						 					 						 				    
		 				
			sb.append("<tr><td class='tablecolor'>名称：").append("</td><td  ><input type='text' name='name'  value='").append(das.obj.name).append("' ></td>");
			
					 						 					 						 				    
		 				
						sb.append("<td  class='tablecolor'>性别：</td><td ><input type='text' name='sex'  value='").append(das.obj.sex).append("' ></td></tr>");
					 						 					 			$("#tb").html(sb.toString());
		 		}
 			});
		}
		
		
		function Submit() {
			var params = $("#form1").serialize();
			$.ajax({
		 		type: "post",
		 		url: "<%=basePath%>/oop/update",
		 		data:params,
		 		async: true,
		 		dataType: "text",
		 		beforeSend: function(){},  
	        	complete: function(){},
		 		success: function(data){
		 			var das = JSON.parse(data);
		 			if(das.success){
		 				location.href=basePath + "/static/commons/massage/success.jsp?url="+basePath+"/jsp/zh/wd/sys/log/oopList.jsp";
		 			}else{
		 				location.href=basePath + "/static/commons/massage/failure.jsp?url="+basePath+"/jsp/zh/wd/sys/log/oopList.jsp";
		 			}
		 		}
 			});
		}
	
		function back() {
			location.href=basePath + "/jsp/zh/wd/sys/log/oopList.jsp";
		}
	</script>
</html>
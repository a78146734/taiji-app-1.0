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
<!-- <script type="text/javascript" src="js/wdRmpSysUsableDetail.js"></script>
<link rel="stylesheet" type="text/css" href="css/wdRmpSysUsableDetail.css"> -->
	<style type="text/css">
	body{
		min-width: 600px !important;
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
		 		url: "<%=basePath%>/wdRmpSysUsable/selectByPrimaryKey",
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
		 						 					 						 				    
		 				
			sb.append("<tr><td class='tablecolor'>系统名称：").append("</td><td  >").append(das.obj.sysName).append("</td>");
			
					 						 					 						 				    
		 				
						sb.append("<td  class='tablecolor'>系统URL：</td><td style='max-width:220px;'>").append(das.obj.sysUrl).append("</td></tr>");
					 						 					 						 				    
		 				
			sb.append("<tr><td class='tablecolor'>系统IP：").append("</td><td  >").append(das.obj.sysIp).append("</td>");
			
					 						 					 						 				    
		 				
						sb.append("<td  class='tablecolor'>系统Port：</td><td >").append(das.obj.sysPort).append("</td></tr>");
					 						 					 						 				    
		 				if(das.obj.sysState =="1"){
		 					sb.append("<tr><td class='tablecolor'>系统状态：").append("</td><td  >").append("正常").append("</td>");
		 				}else if(das.obj.sysState =="0"){
		 					sb.append("<tr><td class='tablecolor'>系统状态：").append("</td><td  >").append("故障").append("</td>");
		 				}
			
					 						 					 						 				    
		 				
						sb.append("<td  class='tablecolor'>创建时间：</td><td >").append(das.obj.createTime).append("</td></tr>");
					 						 					 						 				    
		 				
		//	sb.append("<tr><td class='tablecolor'>系统方法：").append("</td><td  >").append(das.obj.sysFunction).append("</td>");
			
					 						 					 						 				    
		 				
			//			sb.append("<td  class='tablecolor'>系统参数：</td><td >").append(das.obj.sysParameter).append("</td></tr>");
					 						 					 						 				    
		 				
			sb.append("<tr><td class='tablecolor'>类型").append("</td><td  >").append(das.obj.usableType).append("</td>");
			sb.append("<td  class='tablecolor'>负责人手机：</td><td >").append(das.obj.sysPhone).append("</td></tr>");
					 						 					 			$("#tb").html(sb.toString());
		 		}
 			});
		}
		
		
		function back() {
			parent.layer.closeAll('iframe');
		//	window.history.go(-1);
		//	location.href=basePath + "/jsp/zh/wd/rmp/usability/wdRmpSysUsableList.jsp";
		}
	</script>
</html>
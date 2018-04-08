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
<%@ include file="../../commons/global.jsp"%>
<%@ include file="../../commons/xw/basejs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<style type="text/css">
	body{
		min-width: 600px;
		overflow: auto;
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
	$(document).ready(function(){
	 	doQuery();
	});
	//查询执行方法
	function doQuery(){
		$.ajax({
	 		type: "get",
	 		url: "<%=basePath%>/user/selectByPrimaryKey",
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
	 			sb.append("<tr style='display:none'><td>").append(das.obj.userId).append("</td></tr>");
				sb.append("<tr><td class='tablecolor'>姓名：").append("</td><td  >").append(das.obj.username).append("</td>");
				if("20257"==das.obj.sex){
					sb.append("<td  class='tablecolor'>性别：</td><td >男</td></tr>");
				}else if("20258"==das.obj.sex){
					sb.append("<td  class='tablecolor'>性别：</td><td >女</td></tr>");
				}
				sb.append("<tr><td  class='tablecolor'>用户名：</td><td >").append(das.obj.loginName).append("</td>");
				sb.append("<td  class='tablecolor'>创建时间：</td><td >").append(das.obj.createTime).append("</td></tr>");
				if("20253"==das.obj.isXw){
					sb.append("<tr><td class='tablecolor'>是否在徐圩工作</td><td  >徐圩新区工作人员</td>");
				}else if("20252"==das.obj.isXw){
					sb.append("<tr><td class='tablecolor'>是否在徐圩工作</td><td  >外部工作人员</td>");
				}
				sb.append("<td class='tablecolor'>证件号：").append("</td><td  >").append(das.obj.certId).append("</td></tr>");
				sb.append("<tr><td class='tablecolor'>入职时间：").append("</td><td  >").append(das.obj.workDate).append("</td>");
				sb.append("<td class='tablecolor'>座机：").append("</td><td  >").append(das.obj.officePhone).append("</td></tr>");
				sb.append("<tr><td class='tablecolor'>手机：").append("</td><td  >").append(das.obj.phone).append("</td>");
				sb.append("<td class='tablecolor'>邮箱：").append("</td><td  >").append(das.obj.email).append("</td></tr>");
				sb.append("<tr><td class='tablecolor'>人员编码：").append("</td><td  >").append(das.obj.personCode).append("</td>");
				sb.append("<td class='tablecolor'>房间号：").append("</td><td  >").append(das.obj.roomNumber).append("</td></tr>");
				
			 	$("#tb").html(sb.toString());
	 		}
			});
	}
	function cancel(){
		parent.layer.closeAll();
	}
</script>
</html>
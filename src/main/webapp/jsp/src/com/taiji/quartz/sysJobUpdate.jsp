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
<style type="text/css">
	body{
		min-width: 600px;
	}
</style>
</head>
<body>
	<form id="form1" class="forms" action="<%=basePath%>/sysJob/update" method="post">
			<div class="user_list">
				<table class="gridtable04 ">
					<tbody id="tb">

					</tbody>
				</table>
			</div>
		<div class="formmsg">
				<span id="formmsg" ></span>
		</div>
		<div class="butdiv">
			<button class="button" type="submit">提交</button>
			<button onclick="cancel();" class="button" type="button">返回</button>
		</div>
		
	</form>
</body>
<script type="text/javascript">
		//初始加载
		$(function(){
	
	$(".forms").Validform({
		tiptype:function(msg,o,cssctl){
			var objtip=$("#formmsg");
			cssctl(objtip,o.type);
			objtip.text(msg);
		},
		ajaxPost:true,
		callback:function(data){
 			if(data.success){
 				location.href=basePath + "/jsp/utils/massage/success_gen_close.jsp?url="+basePath+"/jsp/src/com/taiji/quartz/sysJobList.jsp";
 			}else{
 				location.href=basePath + "/jsp/utils/massage/failure_gen_close.jsp?url="+basePath+"/jsp/src/com/taiji/quartz/sysJobList.jsp";
 			}
		}
	});
});
		$(document).ready(function(){
		 	doQuery();
		});
	
		//查询执行方法
		function doQuery(){
			$.ajax({
		 		type: "get",
		 		url: "<%=basePath%>/sysJob/selectByPrimaryKey",
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
		 			sb.append("<tr style='display:none'><td><input name='jobId' type='hidden' value='").append(das.obj.jobId).append("'></td></tr>");
		 						 					 						 				    
					sb.append("<td class='tablecolor'>任务名称：").append("</td><td  ><input type='text' datatype='*3-18' errormsg='任务名称至少3位任意字符,最多18位字符！' name='jobName'  value='").append(das.obj.jobName).append("' ></td>");
		 				
					sb.append("<td  class='tablecolor'>表达式：</td><td ><input type='text' onclick='cronMaker();' style='width: 150px' readonly='readonly' placeholder='请输入表达式' datatype='*' errormsg='情输入corn表达式' name='cronExpression' id='cronExpression' value='").append(das.obj.cronExpression).append("' >");
		 			sb.append("</td></tr>");
		 			
					sb.append("<tr><td  class='tablecolor'>执行类：</td><td ><input type='text' name='beanClass' datatype='*' errormsg='请输入执行类'  value='").append(das.obj.beanClass).append("' ></td>");
					 						 					 						 				    
					sb.append("<td  class='tablecolor'>执行方法：</td><td ><input type='text' name='methodName' placeholder='请输入执行方法' datatype='*' errormsg='请输入执行方法'  value='").append(das.obj.methodName).append("' ></td></tr>");
					 						 					 						 				    
					sb.append("<tr><td class='tablecolor'>任务描述：").append("</td><td colspan='3' ><input type='text' name='description' datatype='*0-100' errormsg='请控制在100字以内'  value='").append(das.obj.description).append("' ></td>");
		 				
			
					$("#tb").html(sb.toString());
		 		}
 			});
		}
		
		
		function Submit() {
			var params = $("#form1").serialize();
			$.ajax({
		 		type: "post",
		 		url: "<%=basePath%>/sysJob/update",
		 		data:params,
		 		async: true,
		 		dataType: "text",
		 		beforeSend: function(){},  
	        	complete: function(){},
		 		success: function(data){
		 			var das = JSON.parse(data);
		 			if(das.success){
		 				location.href=basePath + "/static/commons/massage/success_gen_close.jsp?url="+basePath+"/jsp/src/com/taiji/quartz/sysJobList.jsp";
		 			}else{
		 				location.href=basePath + "/static/commons/massage/success_gen_close.jsp?url="+basePath+"/jsp/src/com/taiji/quartz/sysJobList.jsp";
		 			}
		 		}
 			});
		}
		function cronMaker(){
			layer.open({
				  type: 2,
				  title: '表达式生成',
				  shadeClose: true,
				  shade: 0.5,
				  shadeClose: true,
				  maxmin: true, //开启最大化最小化按钮
				  area: ['100%', '100%'],
				  /* btn:['取消'],
				  yes:function(index ,layero){
		 
					  layer.close(index);
				  }, */
			  

			  content: "<%=basePath%>/jsp/src/com/taiji/cronmaker/cronMaker.jsp",
			 
			}); 
		}
		function back() {
			location.href=basePath + "/jsp/src/com/taiji/quartz/sysJobList.jsp";
		}
		function cancel(){
			parent.layer.closeAll();
		}
	</script>
</html>
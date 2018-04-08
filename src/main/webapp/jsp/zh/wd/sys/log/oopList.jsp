<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<%@include file="../../../../../commons/global.jsp"%>
	<%@include file="../../../../../commons/xw/basejs.jsp"%>
		<script type="text/javascript" src="js/oopList.js"></script>
			<link rel="stylesheet" type="text/css" href="css/oopList.css">
		
</head>
<body >
<form id="form1">
	<div class="user_manage">
				<p class="ri_jczctitle">
					<span class="ri_jczctitletxt">标题</span> <span
						class="ri_jczctitlemore"><img src="${base}/static/commons/main/images/more.png" width="16"
						height="16" /></span>
				</p>
			<div class="hj_username">
						<span class="hj_usertxtname">名称：</span> 
		<span><input name="name" type="text"  class="hj_usernameinp"></span>
        <span class="hj_usertxtname">性别：</span> 
		<span><input name="sex" type="text"  class="hj_usernameinp"></span>
		<span><button onclick="Query();" class="button" type="button">确定</button></span>
		<span class='hj_mar20'><button onclick="add();"class="button" type="button">添加</button></span>
		</div>					
				
		<div class="hj_user">
			<table class="gridtable03">
				<tr >
			   <th style="width: 2%;">序号</th>
																			<th  style="width: 10%;">名称</th>
																<th  style="width: 10%;">性别</th>
											<th style="width:200px;">操作</th>
				</tr>

			<tbody id="tb" >
				
			</tbody>
			</table>
			</div>

			</div>

	<div  class="page"><%@include
			file="../../../../../commons/xw/page.jsp"%></div>		
	</form>
</body>
<script type="text/javascript">
		//初始加载
		$(document).ready(function(){
		 	doQuery();
		 	$("#btnQuery").click(function(){
				$("[name=pageNo]").val("0");
				doQuery();
		 	});
		});
		
		//点击查询
		function Query(){
			$("[name=pageNo]").val("1");
			doQuery();
		}
		
		//查询执行方法
		function doQuery(){
			var params = $("#form1").serialize();
			$.ajax({
		 		type: "post",
		 		url: basePath+"/oop/list",
		 		data:params,
		 		async: false,
		 		dataType: "text",
		 		success: function(data){
		 			var das = JSON.parse(data); 
		 			if(pageValue(das.obj)){return;}
		 			var sb = new StringBuilder();
		              $.each(das.obj.rows,function(i,obj){ 
			  			 sb.append("<tr><td>").append(++i).append("</td>");
						 sb.append("<td >").append(obj.name,15).append("</td>");
						 sb.append("<td >").append(obj.sex,15).append("</td>");
						 sb.append("<td ><a class='hj_mar20' onclick='select(\"").append(obj.id).append("\")'><i class='icon icon-search hj_bianji'></i><span class='hj_mar20'>查看</span></a>");
						sb.append("<a class='hj_mar20' onclick='update(\"").append(obj.id).append("\");'><i class='icon icon-pencil hj_bianji'></i><span class='hj_mar20'>编辑</span></a>");
						sb.append("<a class='hj_mar20' onclick='del(\"").append(obj.id).append("\");'><i class='icon icon-remove-sign hj_delete'></i><span class='hj_mar20'>删除</span></a></tr>");
			  			});
		 			 $("#tb").html(sb.toString());	 			 
		 		}
 			});
		}
		
		
		function update(id){
			location.href=basePath+"/jsp/zh/wd/sys/log/oopUpdate.jsp?id="+id;
		}
		
		function select(id){
			location.href=basePath+"/jsp/zh/wd/sys/log/oopDetail.jsp?id="+id;
		}
		
		function add(){
			location.href=basePath+"/jsp/zh/wd/sys/log/oopAdd.jsp";
		}	
		
		function del(id){
			$.ajax({
		 		type: "get",
		 		url: basePath+"/oop/delete",
		 		data:{
		 			"id":id
		 		},
		 		async: true,
		 		dataType: "text",
		 		success: function(data){
		 			var das = JSON.parse(data); 
		 			if(das.success){
		 				doQuery();
		 			}else{
		 				alert("删除失败");
		 			}
		 		}
 			});
		}
		
		
	</script>
</html>
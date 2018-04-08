<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>流程定义列表</title>
<%@include file="../../../../../commons/global.jsp"%>
<%@include file="../../../../../commons/xw/basejs.jsp"%>
<script type="text/javascript" src="js/oopList.js"></script>
<link rel="stylesheet" type="text/css" href="css/oopList.css">

</head>
<body>
	<form id="form1">
		<div class="user_manage">
			<p class="ri_jczctitle">
				<span class="ri_jczctitletxt">标题</span> <span
					class="ri_jczctitlemore"><img
					src="${base}/static/commons/main/images/more.png" width="16"
					height="16" /></span>
			</p>
			<div class="hj_username">
				<span class="hj_usertxtname">名称：</span> <span><input
					name="name" type="text" class="hj_usernameinp"></span> <span
					class="hj_usertxtname">关键词：</span> <span><input name="key"
					type="text" class="hj_usernameinp"></span> <span><button
						onclick="Query();" class="button" type="button">确定</button></span>
						<span
					class='hj_mar20'><button onclick="add();" class="button"
						type="button">新增</button></span> <span
					class='hj_mar20'><button onclick="upload();" class="button"
						type="button">上传</button></span>
						
			</div>

			<div class="hj_user">
				<table class="gridtable03">
					<tr>
						<th style="width: 2%;">序号</th>
						<th style="width: 10%;">流程名称</th>
						<th style="width: 10%;">版本</th>
						<th style="width: 10%;">关键词</th>
						<th style="width: 10%;">源文件</th>
						<th style="width:10%;">描述</th>
						<th style="width:200px;">操作</th>
					</tr>

					<tbody id="tb">

					</tbody>
				</table>
			</div>

		</div>

		<div class="page"><%@include
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
		 		url: basePath+"/activiti/listDef",
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
						 sb.append("<td >").append(obj.version,15).append("</td>");
						 sb.append("<td >").append(obj.key,50).append("</td>");
						 sb.append("<td >").append(obj.resourceName,30).append("</td>");
						 sb.append("<td >").append(obj.description,30).append("</td>");
						 if(obj.suspended){
						  sb.append("<td ><a class='hj_mar20' onclick='update(0,\"").append(obj.id).append("\");'><i class='icon icon-pencil hj_bianji'></i><span class='hj_mar20'>激活</span></a>");}
						  else{sb.append("<td ><a class='hj_mar20' onclick='update(1,\"").append(obj.id).append("\");'><i class='icon icon-pencil hj_bianji'></i><span class='hj_mar20'>挂起</span></a>");}
						 sb.append("<a class='hj_mar20' onclick='start(\"").append(obj.id).append("\");'><i class='icon icon-pencil hj_bianji'></i><span class='hj_mar20'>启动流程</span></a>");
						 sb.append("<a class='hj_mar20' onclick='selectImg(\"").append(obj.id).append("\")'><i class='icon icon-search hj_bianji'></i><span class='hj_mar20'>查看流程图</span></a>");
						 sb.append("<a class='hj_mar20' onclick='change(\"").append(obj.id).append("\")'><i class='icon icon-search hj_bianji'></i><span class='hj_mar20'>转为模型</span></a>");
						sb.append("<a class='hj_mar20' onclick='del(\"").append(obj.deploymentId).append("\");'><i class='icon icon-remove-sign hj_delete'></i><span class='hj_mar20'>删除</span></a></tr>");
			  			}); 
		 			 $("#tb").html(sb.toString());	 			 
		 		}
 			});
		}
		
		
		function selectImg(id){
			layer.open({
			  type: 2,
			  title: '查看流程图',
			  shadeClose: true,
			  shade: 0.5,
			  shadeClose: true,
			  maxmin: true, //开启最大化最小化按钮
			  offset: '5%',
			  area: ['90%', '90%'],
			  content: "${base}/jsp/src/com/activiti/work/activitiImage.jsp?type=re&id="+id,//此处id为流程定义id
			  end: function () {
				}
			}); 
		}
		
		
		/**上传流程定义文件 2017-11-14 author anjl start **/
		function upload(){
			layer.open({
			  type: 2,
			  title: '上传流程',
			  shadeClose: true,
			  shade: 0.5,
			  shadeClose: true,
			  maxmin: true, //开启最大化最小化按钮
			  offset: '100px',
			  area: ['500px', '300px'],
			  content: "${base}/jsp/utils/uploadify/fileUpload_activity.jsp",
			  end: function () {
					doQuery();
				}
			}); 
		}	
		/**上传流程定义文件 2017-11-14 author anjl end **/
		
		/**添加模型流程定义文件 2017-11-14 author anjl end **/
		function add(){
			location.href = "${base}/jsp/src/com/activiti/work/activitiAdd.jsp";
		}	
		
		function del(deploymentId){
			layer.confirm('您是否要删除此流程吗？删除后将一起删除该流程实例！', {
			  btn: ['确定','取消'] //按钮
			}, function(){
				$.ajax({
			 		type: "get",
			 		url: basePath+"/activiti/delete",
			 		data:{
			 			"deploymentId":deploymentId
			 		},
			 		async: true,
			 		dataType: "json",
			 		beforeSend: function () {},  
		        	complete : function() {},
			 		success: function(data){
			 			if(data.success){
			 				layer.msg(data.msg, {time: 2000,icon: 1},function() {
								doQuery();	
							});
			 			}else{
			 				layer.msg(data.msg, {time: 2000,icon: 2});
			 			}
			 		}
	 			});
			}, function(){
		//		layer.msg('取消', {icon: 1});
			});
			
		}
		/**启动流程  2017-11-16 start**/
		function start(id){
			layer.confirm('您是否要启动此流程？', {
			  btn: ['确定','取消'] //按钮
			}, function(){
				$.ajax({
			 		type: "get",
			 		url: basePath+"/activiti/start",
			 		data:{
			 			"id":id
			 		},
			 		async: true,
			 		dataType: "json",
			 		beforeSend: function () {},  
		        	complete : function() {},
			 		success: function(data){
			 			if(data.success){
			 				layer.msg(data.msg, {time: 2000,icon: 1});
			 			}else{
			 				layer.msg(data.msg, {time: 2000,icon: 2});
			 			}
			 		}
	 			});
			}, function(){
		//		layer.msg('取消', {icon: 1});
			});
		}
		
		/**启动流程  2017-11-16 end**/
		
		/**转换流程  2017-11-16 start**/
		function change(processDefinitionId){
			layer.confirm('您是否要转换为流程模型？', {
			  btn: ['确定','取消'] //按钮
			}, function(){
				$.ajax({
			 		type: "get",
			 		url: basePath+"/activiti/convert-to-model",
			 		data:{
			 			"processDefinitionId":processDefinitionId},
			 		async: true,
			 		dataType: "json",
			 		success: function(data){
			 			if(data.success){
			 				layer.msg(data.msg, {time: 2000,icon: 1});
			 				doQuery();
			 			}else{
			 				layer.msg(data.msg, {time: 2000,icon: 2});
			 			}
			 		}
	 			});
			}, function(){
		//		layer.msg('取消', {icon: 1});
			});
		}
		
		
		function update(state,processDefinitionId){
				$.ajax({
			 		type: "get",
			 		url: basePath+"/activiti/update",
			 		data:{
			 			"state":state,
			 			"processDefinitionId":processDefinitionId},
			 		async: true,
			 		dataType: "json",
			 		success: function(data){
			 			if(data.success){
			 				layer.msg(data.msg, {time: 2000,icon: 1});
			 				doQuery();	
			 			}else{
			 				layer.msg(data.msg, {time: 2000,icon: 2});
			 			}
			 		}
	 			});
		
		}
		/**转换流程  2017-11-16 end**/
	</script>
</html>
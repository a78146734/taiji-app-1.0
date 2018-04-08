<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>模型定义列表</title>
<%@include file="../../../../../commons/global.jsp"%>
<%@include file="../../../../../commons/xw/basejs.jsp"%>

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
					name="name" type="text" class="hj_usernameinp"></span><span><button
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
						<th style="width: 2%;">模型id</th>
						<th style="width: 10%;">模型名称</th>
						<th style="width: 10%;">版本</th>
						<th style="width: 10%;">关键词</th>
						<th style="width: 10%;">创建时间</th>
						<th style="width:10%;">最后修改时间</th>
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
		 		url: basePath+"/model/list",
		 		data:params,
		 		async: false,
		 		dataType: "text",
		 		success: function(data){
		 			var das = JSON.parse(data); 
		 			if(pageValue(das.obj)){return;}
		 			var sb = new StringBuilder();
		               $.each(das.obj.rows,function(i,obj){ 
			  			 sb.append("<tr><td>").append(obj.id).append("</td>");
						 sb.append("<td >").append(obj.name,15).append("</td>");
						 sb.append("<td >").append(obj.version,15).append("</td>");
						 sb.append("<td >").append(obj.key,50).append("</td>");
						 sb.append("<td >").append(obj.createTime).append("</td>");
						 sb.append("<td >").append(obj.lastUpdateTime).append("</td>");
						 sb.append("<td ><a class='hj_mar20' onclick='start(\"").append(obj.id).append("\");'><i class='icon icon-pencil hj_bianji'></i><span class='hj_mar20'>编辑</span></a>");
						 sb.append("<a class='hj_mar20' onclick='deploy(\"").append(obj.id).append("\")'><i class='icon icon-wrench hj_bianji'></i><span class='hj_mar20'>部署</span></a>");
						 sb.append("<a class='hj_mar20' onclick='export1(\"").append(obj.id).append("\")'><i class='icon icon-share hj_bianji'></i><span class='hj_mar20'>导出</span></a>");
						sb.append("<a class='hj_mar20' onclick='del(\"").append(obj.id).append("\");'><i class='icon icon-remove-sign hj_delete'></i><span class='hj_mar20'>删除</span></a></tr>");
			  			}); 
		 			 $("#tb").html(sb.toString());	 			 
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
			location.href = "${base}/jsp/src/com/activiti/work/modelAdd.jsp";
		}	
		
		function del(modelId){
			layer.confirm('您是否要删除此模型吗？', {
			  btn: ['确定','取消'] //按钮
			}, function(){
				$.ajax({
			 		type: "get",
			 		url: basePath+"/model/delete",
			 		data:{
			 			"modelId":modelId
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
		location.href = "${base}/jsp/src/com/activiti/designer/modeler.html?modelId="+id;
		target="_blank";	
		}
		
		/**启动流程  2017-11-16 end**/
		
		function export1(modelId){
				$.ajax({
			 		type: "get",
			 		url: basePath+"/model/export",
			 		data:{
			 			"modelId":modelId},
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
		
		function deploy(modelId){
				$.ajax({
			 		type: "get",
			 		url: basePath+"/model/deploy",
			 		data:{
			 			"modelId":modelId},
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
	</script>
</html>
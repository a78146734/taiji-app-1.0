<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@include file="../../../../../commons/global.jsp"%>
<%@include file="../../../../../commons/xw/basejs.jsp"%>
<style type="text/css">
body{
	min-width: 1280px;
}
</style>
</head>
<body>
		<div class="user_manage">
			<!-- <p class="ri_jczctitle">
				<span class="ri_jczctitletxt">定时任务</span><span
					class="ri_jczctitlemore butimg" onclick="sideDiv(this);"></span>
			</p> -->
			<div class="hj_username" id="search">
				<div >
					<span class="hj_usertxtname">任务名称：</span> <span><input
						data-condition="like" name="jobName" type="text" class="hj_usernameinp"></span> 
						 
						<span
						class="hj_usertxtname">是否启动任务：</span> 
						<span>
							<select name="jobStatus" class="hj_usernameinp">
								<option value="">全部</option>
								<option value="1">已启动</option>
								<option value="0">未启动</option>
							</select>
						</span> 
						<span>&nbsp;&nbsp;
							<button onclick="Query();" class="button" type="button">查询</button>
						</span>
					<shiro:hasPermission name='sysJob/save'>
						<span class='hj_mar20'>&nbsp;&nbsp;
							<button onclick="add();" class="button" type="button">新增</button>
						</span>
					</shiro:hasPermission>
				</div>
			</div>

		<!-- 	<div id="hj_username_2" class="hj_username_2">
				<div class="hj_username1">
					<span class="hj_usertxtname">表达式：</span> <span><input
						name="cronExpression" type="text" class="hj_usernameinp"></span>
					<span class="hj_usertxtname">任务描述：</span> <span><input
						name="description" type="text" class="hj_usernameinp"></span> <span
						class="hj_usertxtname">执行类：</span> <span><input
						name="beanClass" type="text" class="hj_usernameinp"></span>
				</div>
			</div> -->

			<div class="hj_user">
				<table class="gridtable03">
					<tr>
						<th style="width: 2%;">序号</th>
						<th style="width: 10%;"><span>任务名称</span></th>
						<th style="width: 10%;"><span>表达式</span></th>
						<th style="width: 10%;"><span>创建时间</span></th>
						<th style="width: 10%;"><span>更新时间</span></th>
						<th style="width: 10%;"><span>任务状态</span></th>
						<th style="width:200px;">操作</th>
					</tr>

					<tbody id="tb">

					</tbody>
				</table>
			</div>

		</div>
	<form id="form1">
		<div class="page"><%@include
				file="../../../../../commons/xw/page.jsp"%></div>
	</form>
</body>
<script type="text/javascript">
		//初始加载
		$(document).ready(function(){
		 	//设置初始化排序字段
		 	doQuery();
		});
		
		//点击查询
		function Query(){
			$("[name=pageNo]").val("1");
			doQuery();
		}
		
		//查询执行方法
		function doQuery(){
			var condition=new Array();
			$('#search').find("input").each(function(i,obj){
				var val=$(obj).val();
				if(val!=null&&val!=''){
					var conditionItem={
						name:$(obj).attr("name"),
						value:"%"+$(obj).val()+"%",
						condition:$(obj).data("condition")
					}
					condition.push(conditionItem);
				}
			});
			
			//转换分页信息到param
			var params = swichPageInfo(condition);
			$.ajax({
		 		type: "post",
		 		url: basePath+"/sysJob/list",
		 		data: JSON.stringify(params),
		 		contentType: "application/json; charset=utf-8",
		 		async: true,
		 		dataType: "json",
		 		success: function(data){
		 		console.log(data);
		 			data=data.obj;
		 			pageValue(data);
		 			var sb = new StringBuilder();
		              $.each(data.rows,function(i,obj){ 
			  			 sb.append("<tr><td>").append(++i).append("</td>");
						 sb.append("<td >").append(obj.jobName,25).append("</td>");
						 sb.append("<td >").append(obj.cronExpression,25).append("</td>");
						 sb.append("<td >").append(obj.createTime,11).append("</td>");
						 sb.append("<td >").append(obj.updatetime,11).append("</td>");
						 if(obj.jobStatus=="1"){
						 	sb.append("<td ><span style='color:#00EC00;'>").append("已启动",15).append("</span></td>");
						 }else{
							sb.append("<td ><span style='color:red;'>").append("未启动",15).append("</span></td>");
						 }
						 sb.append("<td >");
						 sb.append("<shiro:hasPermission name='sysJob/runAJobNow'>");
						 sb.append("<a class='hj_mar20' onclick='runAJobNow(\"").append(obj.jobId).append("\")'><i class='icon icon-search hj_bianji'></i><span class='hj_mar20'>执行一次</span></a>");
						 sb.append("</shiro:hasPermission>");  
						 sb.append("<shiro:hasPermission name='sysJob/startJob'>");  
						 var flag = "";
						 if(obj.jobStatus=="1")
						 	{ flag ="停止";}
						 	else
						 	{ flag ="启动";}
						 sb.append("<a class='hj_mar20' onclick='startJob(\"").append(obj.jobId).append("\")'><i class='icon icon-search hj_bianji'></i><span class='hj_mar20'>"+flag+"</span></a>");
						 sb.append("</shiro:hasPermission>");	 
						 sb.append("<shiro:hasPermission name='sysJob/selectByPrimaryKey'>");  
						 sb.append("<a class='hj_mar20' onclick='select(\"").append(obj.jobId).append("\")'><i class='icon icon-search hj_bianji'></i><span class='hj_mar20'>查看</span></a>");
						 sb.append("</shiro:hasPermission>");	 
						 sb.append("<shiro:hasPermission name='sysJob/update'>"); 						
						 sb.append("<a class='hj_mar20' onclick='update(\"").append(obj.jobId).append("\");'><i class='icon icon-pencil hj_bianji'></i><span class='hj_mar20'>编辑</span></a>");
						 sb.append("</shiro:hasPermission>"); 
						 sb.append("<shiro:hasPermission name='sysJob/delete'>");						
						 sb.append("<a class='hj_mar20' onclick='del(\"").append(obj.jobId).append("\");'><i class='icon icon-remove-sign hj_delete'></i><span class='hj_mar20'>删除</span></a>");
						 sb.append("</shiro:hasPermission>");				  			
						 sb.append("</td></tr>");
			  			
			  			});
		 			 $("#tb").html(sb.toString());	 			 
		 		}
 			});
		}
		
		/*start 启动该该定时任务 anjl 2017-7-11**/
		function startJob(id){
			layer.confirm('是否修改该任务状态？', {
			  btn: ['确定','取消'] //按钮
				}, function(){
					$.ajax({
			 		type: "get",
			 		url: basePath+"/sysJob/startJob",
			 		data:{
			 			"id":id
			 		},
			 		async: true,
			 		dataType: "text",
			 		beforeSend: function () {},  
	        		complete : function() {},
			 		success: function(data){
			 			var das = JSON.parse(data); 
			 			if(das.success){
			 				layer.msg('操作成功！', {time: 1000,icon: 1},function(){
			 					doQuery();
			 				});
			 			}else{
			 				layer.msg('操作失败！', {time: 1000,icon: 2});
			 			}
			 		}
	 			});
			}, function(){
			  
			});
		}
		/*end 启动该定时任务 anjl 2017-7-11**/
		
		
		/*start 运行该任务一次 anjl 2017-7-11**/
		function runAJobNow(id){
			layer.confirm('是否要运行该任务一次？', {
			  btn: ['确定','取消'] //按钮
				}, function(){
					$.ajax({
			 		type: "get",
			 		url: basePath+"/sysJob/runAJobNow",
			 		data:{
			 			"id":id
			 		},
			 		async: true,
			 		dataType: "text",
			 		success: function(data){
			 			var das = JSON.parse(data); 
			 			if(das.success){
			 				layer.msg('运行成功！', {icon: 1});
			 				doQuery();
			 			}else{
			 				layer.msg('运行失败！', {icon: 2});
			 			}
			 		}
	 			});
			}, function(){
			  
			});
		}
		/*end 运行该任务一次 anjl 2017-7-11**/
		
		function update(id){
			layer.open({
				  type: 2,
				  title: '编辑页面',
				  shadeClose: true,
				  shade: 0.5,
				  shadeClose: true,
				  maxmin: true, //开启最大化最小化按钮
				  offset: '50px',
		  	  	  area: ['70%', '420px'],
				  /* btn:['取消'],
				  yes:function(index ,layero){
		 
					  layer.close(index);
				  }, */
			  
	
			  content: "<%=basePath%>/jsp/src/com/taiji/quartz/sysJobUpdate.jsp?id="+id,
			  end: function () {
					Query();
				}
			}); 
		}
		
		function select(id){
			layer.open({
				  type: 2,
				  title: '详情页面',
				  shadeClose: true,
				  shade: 0.5,
				  shadeClose: true,
				  maxmin: true, //开启最大化最小化按钮
				  offset: '50px',
		  	  	  area: ['70%', '420px'],
				  /* btn:['取消'],
				  yes:function(index ,layero){
		 
					  layer.close(index);
				  }, */
			  
	
			  content: "<%=basePath%>/jsp/src/com/taiji/quartz/sysJobDetail.jsp?id="+id,
			  end: function () {
					Query();
				}
			}); 
		}
		
		function add(){
			layer.open({
				  type: 2,
				  title: '新增定时任务',
				  shadeClose: true,
				  shade: 0.5,
				  shadeClose: true,
				  maxmin: true, //开启最大化最小化按钮
				  offset: '50px',
		  	  	  area: ['70%', '420px'],
				  /* btn:['取消'],
				  yes:function(index ,layero){
		 
					  layer.close(index);
				  }, */
			  
	
			  content: "<%=basePath%>/jsp/src/com/taiji/quartz/sysJobAdd.jsp",
			  end: function () {
					Query();
				}
			}); 
		}	
		
		
		/*start 删除该定时任务 anjl 2017-7-11**/
		function del(id){
		
			layer.confirm('是否删除该任务?(如果任务处于启动状态，删除后任务将停止)', {
			  btn: ['确定','取消'] //按钮
				}, function(){
					$.ajax({
				 		type: "get",
				 		url: basePath+"/sysJob/delete",
				 		data:{
				 			"id":id
				 		},
				 		async: true,
				 		beforeSend: function () {},  
	        			complete : function() {},
				 		dataType: "text",
				 		success: function(data){
				 			var das = JSON.parse(data); 
				 			if(das.success){
				 				layer.msg('删除成功！', {icon: 1},function() {
									doQuery();	
								});
				 			}else{
				 				layer.msg('删除失败！', {icon: 2});
				 			}
				 		}
		 			});
				}, function(){
				  
				});
		}
		/*end 删除该定时任务 anjl 2017-7-11**/
		
	</script>
</html>
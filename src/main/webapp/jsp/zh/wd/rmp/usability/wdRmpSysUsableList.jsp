<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<%@include file="../../../../../commons/global.jsp"%>
	<%@include file="../../../../../commons/xw/basejs.jsp"%>
		<script type="text/javascript" src="js/wdRmpSysUsableList.js"></script>
			<link rel="stylesheet" type="text/css" href="css/wdRmpSysUsableList.css">
		
</head>
<body >
<form id="form1">
	<div class="user_manage">
				<p class="ri_jczctitle">
					<span class="ri_jczctitletxt">系统信息</span> <span
					class="ri_jczctitlemore butimg" onclick="sideDiv(this);"></span>
				</p>
			<div class="hj_username">
				<div class="hj_username1">
        
		<span class="hj_usertxtname">系统类型：</span> 
		<select name="usableType"  style="width: 154px; height:24px;">
		<option value="">--请选择--</option>
			<option value="url">url</option>
			<option value="port">port</option>
		</select>
		
		<span class="hj_usertxtname">系统状态：</span> 
		<select name="sysState"  style="width: 154px; height:24px;">
		<option value="">--请选择--</option>
			<option value="0">故障</option>
			<option value="1">可用</option>
		</select>
		
		<span>&nbsp;&nbsp;<button onclick="Query();" class="button" type="button">查询</button></span>
		<span class='hj_mar20'>&nbsp;&nbsp;&nbsp;&nbsp;<button onclick="add();"class="button" type="button">新增</button></span>
		<span class='hj_mar20'>&nbsp;&nbsp;<button onclick="checkAll();"class="button" type="button">检测全部</button></span>
			</div>	
		</div>
			<div id="hj_username_2" class="hj_username_2">
				<div class="hj_username1">
					<span class="hj_usertxtname">系统名称：</span> <span><input
						name="sysName" type="text" class="hj_usernameinp"></span>
						<span class="hj_usertxtname">系统IP：</span> <span><input
						name="sysIp" type="text" class="hj_usernameinp"></span>
				</div>
			</div>

			<div class="hj_user">
			<table class="gridtable03">
				<tr >
			    <th style="width: 2%;">序号</th>
				<th  style="width: 10%;"><a id="SYS_NAME" class="tha" onclick="sort(this);"><span>系统名称</span><i class="thimg" ></i></a></th>
				<th  style="width: 10%;"><a id="USABLE_TYPE" class="tha" onclick="sort(this);"><span>系统类型</span><i class="thimg" ></i></a></th>
				<th  style="width: 15%;"><a id="SYS_URL" class="tha" onclick="sort(this);"><span>系统URL</span><i class="thimg" ></i></a></th>
				<th  style="width: 10%;"><a id="SYS_IP" class="tha" onclick="sort(this);"><span>系统IP</span><i class="thimg" ></i></a></th>
				<th  style="width: 10%;"><a id="SYS_PORT" class="tha" onclick="sort(this);"><span>系统Port</span><i class="thimg" ></i></a></th>
				<th  style="width: 10%;"><a id="SYS_STATE" class="tha" onclick="sort(this);"><span>系统状态</span><i class="thimg" ></i></a></th>
				<th  style="width: 10%;"><a id="CREATE_TIME" class="tha" onclick="sort(this);"><span>创建时间</span><i class="thimg" ></i></a></th>
				<th style="width: 25%;min-width:290px;">操作</th>
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
		 		url: basePath+"/wdRmpSysUsable/list",
		 		data:params,
		 		async: true,
		 		dataType: "text",
		 		success: function(data){
		 		
		 			var das = JSON.parse(data); 
		 			if(!das.success){
		 				alert(das.msg);
		 			}
		 			pageValue(das.obj);
		 			var sb = new StringBuilder();
		              $.each(das.obj.rows,function(i,obj){ 
			  			 sb.append("<tr><td>").append(++i).append("</td>");
						 sb.append("<td >").append(obj.sysName,15).append("</td>");
						 sb.append("<td >").append(obj.usableType,15).append("</td>");
						 sb.append("<td title='"+obj.sysUrl+"'>").append(obj.sysUrl,30).append("</td>");
						 sb.append("<td >").append(obj.sysIp,15).append("</td>");
						 sb.append("<td >").append(obj.sysPort,15).append("</td>");
						 if(obj.sysState == "1"){
							 sb.append("<td ><font color='green'><strong>").append("可用").append("</strong></font></td>");
						 }else if(obj.sysState == "0"){
							 sb.append("<td ><font color='red'><strong>").append("故障").append("</strong></font></td>");
						 }else{
							 sb.append("<td ><font color='gray'><strong>").append("待检测").append("</strong></font></td>");
						 }
						
						 sb.append("<td >").append(obj.createTime,20).append("</td>");
						 sb.append("<td >");
						 sb.append("<a class='hj_mar20' onclick='check(\"").append(obj.id).append("\");'><i class='icon icon-list hj_bianji'></i><span class='hj_mar20'>检测</span></a>");
   					sb.append("<a class='hj_mar20' onclick='select(\"").append(obj.id).append("\")'><i class='icon icon-search hj_bianji'></i><span class='hj_mar20'>查看</span></a>");
 					sb.append("<a class='hj_mar20' onclick='update(\"").append(obj.id).append("\");'><i class='icon icon-pencil hj_bianji'></i><span class='hj_mar20'>编辑</span></a>");
  					sb.append("<a class='hj_mar20' onclick='del(\"").append(obj.id).append("\");'><i class='icon icon-remove-sign hj_delete'></i><span class='hj_mar20'>删除</span></a>");
 				  			sb.append("</td></tr>");
			  			
			  			});
		 			 $("#tb").html(sb.toString());	 			 
		 		}
 			});
		}
		
		
		function update(id){
			layer.open({
				  type: 2,
				  title: '系统信息编辑',
				  shadeClose: true,
				  shade: 0.5,
				  shadeClose: true,
				  maxmin: true, //开启最大化最小化按钮
				  offset: '50px',
				  area: ['80%', '420px'],
				  /* btn:['取消'], */
				  yes:function(index ,layero){

					  layer.close(index);
				  },
				  

				  content: basePath+"/jsp/zh/wd/rmp/usability/wdRmpSysUsableUpdate.jsp?id="+id,
				  end: function () {
					  doQuery();
		          }
				}); 
		//	location.href=basePath+"/jsp/zh/wd/rmp/usability/wdRmpSysUsableUpdate.jsp?id="+id;
		}
		
		function select(id){
			layer.open({
				  type: 2,
				  title: '系统信息查看',
				  shadeClose: true,
				  shade: 0.5,
				  shadeClose: true,
				  maxmin: true, //开启最大化最小化按钮
				  offset: '50px',
				  area: ['80%', '420px'],
				  /* btn:['取消'], */
				  yes:function(index ,layero){

					  layer.close(index);
				  },
				  

				  content: basePath+"/jsp/zh/wd/rmp/usability/wdRmpSysUsableDetail.jsp?id="+id,
				  end: function () {
					  doQuery();
		          }
				}); 
		//	location.href=basePath+"/jsp/zh/wd/rmp/usability/wdRmpSysUsableDetail.jsp?id="+id;
		}
		
		function add(){
			layer.open({
				  type: 2,
				  title: '系统信息新增',
				  shadeClose: true,
				  shade: 0.5,
				  shadeClose: true,
				  maxmin: true, //开启最大化最小化按钮
				  offset: '50px',
				  area: ['80%', '420px'],
				  /* btn:['取消'], */
				  yes:function(index ,layero){

					  layer.close(index);
				  },
				  

				  content: basePath+"/jsp/zh/wd/rmp/usability/wdRmpSysUsableAdd.jsp",
				  end: function () {
					  doQuery();
		          }
				}); 
		//	location.href=basePath+"/jsp/zh/wd/rmp/usability/wdRmpSysUsableAdd.jsp";
		}	
		
		function del(id){
		
		layer.confirm('是否确定要删除该信息？', {
			  btn: ['确定','取消'] //按钮
			}, function(){
				$.ajax({
			 		type: "get",
			 		url: basePath+"/wdRmpSysUsable/delete",
			 		data:{
			 			"id":id
			 		},
			 		async: true,
			 		dataType: "text",
			 		success: function(data){
			 			var das = JSON.parse(data); 
			 			if(das.success){
			 				layer.msg('删除成功！', {icon: 1});
			 				doQuery();
			 			}else{
			 				layer.msg('删除失败！', {icon: 2});
			 			}
			 		}
	 			});
			}, function(){
			  
			});
			
		}
		
		function check(id){
			$.ajax({
		 		type: "get",
		 		url: "<%=basePath%>/wdRmpSysUsable/checkState",
		 		data:{
		 			"id":id
		 		},
		 		async: true,
		 		dataType: "text",
		 		success: function(data){
		 			var das = JSON.parse(data);
					 if(das.success){
						 layer.msg("系统可用",{icon: 1,shade:0.3, time: 2000});
						 doQuery();
					 }else{
						 layer.msg("系统故障",{icon: 2,shade:0.3, time: 2000});
						 doQuery();
					 }
		 			 
		 		 
		 		}
 			});
		}
		

		function checkAll(){
			$.ajax({
		 		type: "get",
		 		url: "<%=basePath%>/wdRmpSysUsable/checkAllState",
		 		data:{ },
		 		async: true,
		 		dataType: "text",
		 		success: function(data){
		 			var das = JSON.parse(data);
					 if(das.success){
						 layer.msg("检测完成",{icon: 1,shade:0.3, time: 2000});
						 doQuery();
					 }else{
						 layer.msg("系统故障",{icon: 2,shade:0.3, time: 2000});
						 doQuery();
					 }
		 			 
		 		 
		 		}
 			});
		}
		
	</script>
</html>
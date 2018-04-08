<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<%@include file="../../../../../commons/global.jsp"%>
		<%@include file="../../../../../commons/xw/basejs.jsp"%>
		<!-- <script type="text/javascript" src="js/wdRmpAppEqpLogList.js"></script>
		<link rel="stylesheet" type="text/css" href="css/wdRmpAppEqpLogList.css"> -->
	<script type="text/javascript">
     	window.onload=function(){window.parent.scrollTo(0,0);}
	</script>	
	</head>
	<style type="text/css">
		.hj_usertxtname{
			width:60px;
		}
	</style>
	<body >
	<form id="form1">
			<div class="user_manage">
				<p class="ri_jczctitle">
					<span class="ri_jczctitletxt">物联设备日志</span>
					<span class="ri_jczctitlemore butimg" onclick="sideDiv(this);"></span>
				</p>
				<div class="hj_username">
					<span class="hj_usertxtname">日志级别：</span> 
					<span>
					<!-- <input name="logLevel" type="text"  class="hj_usernameinp"> -->
						<select class="hj_usernameinp" id="logLevel" name="logLevel">
						  <option value =""></option>
						  <option value ="ERROR">ERROR</option>
						  <option value ="INFO">INFO</option>
						</select>
					</span>
			        <span class="hj_usertxtname">设备标识：</span> 
					<span><input name="logEqpCode" type="text"  class="hj_usernameinp"></span>
					<span class="hj_usertxtname">设备名称：</span> 
					<span><input name="logEqpName" type="text"  class="hj_usernameinp"></span>	
					<span><button onclick="Query();" class="button" type="button">查询</button></span>
				</div>
				<div id="hj_username_2" class="hj_username_2">
					<span class="hj_usertxtname" style ="margin-left:20px">开始日期：</span> 
					<span><input name="logDate" type="text"  class="hj_usernameinp" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" ></span>
					<span class="hj_usertxtname" style ="margin-left:20px">结束日期：</span> 
					<span><input name="logDate1" type="text"  class="hj_usernameinp" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" ></span>		
				</div>					
				<div class="hj_user">
					<table class="gridtable03">
						<tr >
					   		<th style="width: 2%;">序号</th>
							<th  style="width: 8%;">
								<a id="Log_Level" class="tha" onclick="sort(this);"><span>日志级别</span><i class="thimg" ></i></a>
							</th>
							<th  style="width: 10%;">
								<a id="Log_Eqp_Name" class="tha" onclick="sort(this);"><span>设备名称</span><i class="thimg" ></i></a>
							</th>
							<th  style="width: 10%;">
								<a id="Log_Eqp_Type" class="tha" onclick="sort(this);"><span>设备标识</span><i class="thimg" ></i></a>
							</th>
							<th  style="width: 10%;">
								<a id="Operat_Type" class="tha" onclick="sort(this);"><span>执行操作类型</span><i class="thimg" ></i></a>
							</th>
							<th  style="width: 10%;">
								<a id="Log_Date" class="tha" onclick="sort(this);"><span>日期</span><i class="thimg" ></i></a>
							</th>
							<th  style="width: 10%;">
								<a id="User_Id" class="tha" onclick="sort(this);"><span>操作人ID</span><i class="thimg" ></i></a>
							</th>
							<th  style="width: 10%;">
								<a id="Log_Ip" class="tha" onclick="sort(this);"><span>操作人IP</span><i class="thimg" ></i></a>
							</th>
							<th  style="width: 10%;">
								<a id="Operat_Result" class="tha" onclick="sort(this);"><span>操作结果</span><i class="thimg" ></i></a>
							</th>
							<th style="width:10%;">操作</th>
						</tr>
		
						<tbody id="tb" >
							
						</tbody>
					</table>
				</div>
		
			</div>
		
			<div  class="page"><%@include file="../../../../../commons/xw/page.jsp"%></div>		
		</form>
	</body>
<script type="text/javascript">
		//初始加载
		$(document).ready(function(){
		 	//设置初始化排序字段
		 	initSort("Log_Date","desc");
		 	doQuery();
		});
		
		//点击查询
		function Query(){
			$("[name=nowpage]").val("1");
			$("[name=pageNo]").val("1");
			doQuery();
		}
		
		//查询执行方法
		function doQuery(){
		
			var params = $("#form1").serialize();
			$.ajax({
		 		type: "post",
		 		url: basePath+"/wdRmpAppEqpLog/list",
		 		data:params,
		 		async: true,
		 		dataType: "text",
		 		success: function(data){
		 			var das = JSON.parse(data); 
		 			if(pageValue(das.obj)){return;}
		 			var sb = new StringBuilder();
		              $.each(das.obj.rows,function(i,obj){ 
			  			 sb.append("<tr><td>").append(++i).append("</td>");
						 sb.append("<td >").append(obj.logLevel,15).append("</td>");
						 sb.append("<td >").append(obj.logEqpName,15).append("</td>");
						 sb.append("<td >").append(obj.logEqpCode,15).append("</td>");
						 sb.append("<td >").append(obj.operatType,15).append("</td>");
						 sb.append("<td >").append(obj.logDate,20).append("</td>");
						 sb.append("<td >").append(obj.userId,15).append("</td>");
						 sb.append("<td >").append(obj.logIp,15).append("</td>");
						 sb.append("<td >").append(obj.operatResult,15).append("</td>");
						 sb.append("<td ><a class='hj_mar20'  onclick='doOpenSelect(\"").append(obj.id).append("\")'><i class='icon icon-search hj_bianji'></i><span class='hj_mar20'>查看</span></a>");
			  			});
		 			 $("#tb").html(sb.toString());	 			 
		 		}
 			});
		}
		
		function doOpenSelect(id){
			layer.open({
				type : 2,
				title : '查看日志详细内容',
				offset : '15%',
				area : [ '65%', '60%' ],
				content:["${base}/wdRmpAppEqpLog/openDetailPage?id="+id,'yes']
			});
		}
		function update(id){
			location.href=basePath+"/jsp/zh/wd/rmp/log/wdRmpAppEqpLogUpdate.jsp?id="+id;
		}
		
		/* function select(id){
			location.href=basePath+"/jsp/zh/wd/rmp/log/wdRmpAppEqpLogDetail.jsp?id="+id;
		}
		 */
		function add(){
			location.href=basePath+"/jsp/zh/wd/rmp/log/wdRmpAppEqpLogAdd.jsp";
		}	
		
		function del(id){
			$.ajax({
		 		type: "get",
		 		url: basePath+"/wdRmpAppEqpLog/delete",
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
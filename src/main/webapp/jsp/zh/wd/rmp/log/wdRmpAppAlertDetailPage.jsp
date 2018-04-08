<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<%@include file="../../../../../commons/global.jsp"%>
	<%@include file="../../../../../commons/xw/basejs.jsp"%>
		<!-- <script type="text/javascript" src="js/wdRmpAppServiceLogList.js"></script>
			<link rel="stylesheet" type="text/css" href="css/wdRmpAppServiceLogList.css"> -->
<style type="text/css">
body {
	min-width: 1250px;
}
</style>		
</head>
<body >
<form id="form1">
	<div class="user_manage">
			<p class="ri_jczctitle">
				<span class="ri_jczctitletxt">历史调用失败日志</span><span  
				class="ri_jczctitlemore butimg" onclick="sideDiv(this);"></span>
			</p>
		<div class="hj_username">
			<div class="hj_username1">
				<span><input name="logPService" type="hidden" value="${pid}"></span>
				<span class="hj_usertxtname">日志级别：</span> 
				<span><input name="logLevel" type="text"  class="hj_usernameinp"></span>
        		<span class="hj_usertxtname">服务标示：</span> 
				<span><input name="logService" type="text"  class="hj_usernameinp"></span>
				<span class="hj_usertxtname">服务路径：</span> 
				<span><input name="logServicePath" type="text"  class="hj_usernameinp"></span>				   
				
				<span><button onclick="Query();" class="button" type="button">确定</button></span>
				<span>&nbsp;&nbsp;<button onclick="back();" class="button" type="button">返回</button></span>
			</div>					
		</div>	
		<div id="hj_username_2" class="hj_username_2">
		<span class="hj_usertxtname">服务名称：</span> 
		<span><input name="logServiceName" type="text"  class="hj_usernameinp"></span>
        <span class="hj_usertxtname">信息：</span> 
		<span><input name="logMessage" type="text"  class="hj_usernameinp"></span>
 			   				
			</div>	
				
		<div class="hj_user">
			<table class="gridtable03">
				<tr >
			    <th style="width: 2%;">序号</th>
				<th  style="width: 10%;"><a id="Log_P_Service_Name" class="tha" onclick="sort(this);"><span>模块名称</span><i class="thimg" ></i></a></th>
				<th  style="width: 10%;"><a id="Log_Service_Name" class="tha" onclick="sort(this);"><span>服务名称</span><i class="thimg" ></i></a></th>
				<th  style="width: 10%;"><a id="Log_Message" class="tha" onclick="sort(this);"><span>信息</span><i class="thimg" ></i></a></th>
				<th  style="width: 15%;"><a id="Log_Date" class="tha" onclick="sort(this);"><span>日期</span><i class="thimg" ></i></a></th>
				<th  style="width: 8%;"><a id="User_Id" class="tha" onclick="sort(this);"><span>操作人ID</span><i class="thimg" ></i></a></th>
				<th  style="width: 10%;"><a id="Log_Ip" class="tha" onclick="sort(this);"><span>操作人IP</span><i class="thimg" ></i></a></th>
				<th  style="width: 10%;"><a id="SERVICE_RUNTIME" class="tha" onclick="sort(this);"><span>响应时间(ms)</span><i class="thimg" ></i></a></th>
				<th  style="width: 15%;"><a id="ERROR_COMMENT" class="tha" onclick="sort(this);"><span>错误信息</span><i class="thimg" ></i></a></th>
					<th style="width:10%;">操作</th>
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
		 	//设置初始化排序字段
		 	//initSort("数据库字典列名","desc");
		 	doQuery();
		});
		
		//点击查询
		function Query(){
			$("[name=pageNo]").val("1");
			$("[name=nowpage]").val("1");
			doQuery();
		}
		
		//查询执行方法
		function doQuery(){
			var params = $("#form1").serialize();
			$.ajax({
		 		type: "post",
		 		url: basePath+"/wdRmpAppServiceLog/alertList",
		 		data:params,
		 		async: false,
		 		dataType: "text",
		 		success: function(data){
		 			var das = JSON.parse(data); 
		 			if(pageValue(das.obj)){return;}
		 			var sb = new StringBuilder();
		              $.each(das.obj.rows,function(i,obj){ 
			  			 sb.append("<tr><td>").append(++i).append("</td>");
						 sb.append("<td style='color:red'>").append(obj.logPServiceName,15).append("</td>");
						 sb.append("<td style='color:red'>").append(obj.logServiceName,15).append("</td>");
						 sb.append("<td style='color:red'>").append(obj.logMessage,15).append("</td>");
						 sb.append("<td style='color:red'>").append(obj.logDate,20).append("</td>");
						 sb.append("<td style='color:red'>").append(obj.userId,15).append("</td>");
						 sb.append("<td style='color:red'>").append(obj.logIp,15).append("</td>");
						 sb.append("<td style='color:red'>").append(obj.serviceRuntime,15).append("</td>");
						 sb.append("<td style='color:red'>").append(obj.errorComment,50).append("</td>");
						 sb.append("<td ><a class='hj_mar20' onclick='select(\"").append(obj.id).append("\")'><i class='icon icon-search hj_bianji'></i><span class='hj_mar20' style='color:red'>查看</span></a>");
			  			});
		 			 $("#tb").html(sb.toString());	 			 
		 		}
 			});
		}
		
		
		function update(id){
			location.href=basePath+"/jsp/zh/wd/rmp/log/wdRmpAppServiceLogUpdate.jsp?id="+id;
		}
		
		function select(id){
			location.href=basePath+"/jsp/zh/wd/rmp/log/wdRmpAppServiceLogDetail.jsp?id="+id;
		}
		
		function add(){
			location.href=basePath+"/jsp/zh/wd/rmp/log/wdRmpAppServiceLogAdd.jsp";
		}	
		
		function del(id){
			$.ajax({
		 		type: "get",
		 		url: basePath+"/wdRmpAppServiceLog/delete",
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
	 
		function back() {
			history.back(1);
		}
	</script>
</html>
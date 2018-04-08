<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@include file="../../../../../commons/global.jsp"%>
<%@include file="../../../../../commons/xw/basejs.jsp"%>
<!-- <script type="text/javascript" src="js/wdRmpAppServiceApplyLogList.js"></script>
<link rel="stylesheet" type="text/css"
	href="css/wdRmpAppServiceApplyLogList.css"> -->
<script type="text/javascript">
     window.onload=function(){window.parent.scrollTo(0,0);}
</script>
</head>
<body>
	<form id="form1">
		<div class="user_manage">
			<p class="ri_jczctitle">
				<span class="ri_jczctitletxt">服务申请日志</span><span
					class="ri_jczctitlemore butimg" onclick="sideDiv(this);"></span>
			</p>
			<div class="hj_username">
				<div >
					<!-- 	<span class="hj_usertxtname">日志级别：</span> 
		<span><input name="logLevel" type="text"  class="hj_usernameinp"></span> -->
					<span class="hj_usertxtname">信息：</span> <span><input
						name="logMessage" type="text" class="hj_usernameinp"></span> <span
						class="hj_usertxtname">开始日期：</span> <span><input
						name="logDate" type="text" class="Wdate hj_usernameinp"
						onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"
						readonly="readonly"></span> <span class="hj_usertxtname">结束日期：</span>
					<span><input name="logDate1" type="text"
						class="Wdate hj_usernameinp"
						onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"
						readonly="readonly"></span> <span>&nbsp;&nbsp;
						<button onclick="Query();" class="button" type="button">查询</button>
					</span>
				</div>
			</div>

			<div id="hj_username_2" class="hj_username_2">
					<span class="hj_usertxtname">操作人：</span> <span><input
						name="userId" type="text" class="hj_usernameinp"></span> <span
						class="hj_usertxtname">操作人IP：</span> <span><input
						name="logIp" type="text" class="hj_usernameinp"></span> <span
						class="hj_usertxtname">部门标示：</span> <span><input
						name="sysCode" type="text" class="hj_usernameinp"></span>
			</div>

			<div class="hj_user">
				<table class="gridtable03">
					<tr>
						<th style="width: 2%;">序号</th>
<!-- 						<th style="width: 8%;"><a id="LOG_LEVEL" class="tha"
							onclick="sort(this);"><span>日志级别</span><i class="thimg"></i></a></th>
 -->						<th style="width: 10%;"><a id="LOG_MESSAGE" class="tha"
							onclick="sort(this);"><span>信息</span><i class="thimg"></i></a></th>
						<th style="width: 10%;"><a id="LOG_DATE" class="tha"
							onclick="sort(this);"><span>日期</span><i class="thimg"></i></a></th>
						<th style="width: 10%;"><a id="USER_ID" class="tha"
							onclick="sort(this);"><span>操作人ID</span><i class="thimg"></i></a></th>
						<th style="width: 10%;"><a id="LOG_IP" class="tha"
							onclick="sort(this);"><span>操作人IP</span><i class="thimg"></i></a></th>
						<th style="width: 10%;"><a id="SYS_CODE" class="tha"
							onclick="sort(this);"><span>部门标示</span><i class="thimg"></i></a></th>
						<th style="width: 10%;"><a id="SERVICE_STATUS" class="tha"
							onclick="sort(this);"><span>申请结果</span><i class="thimg"></i></a></th>
						<th style="width: 10%;"><a id="LOG_P_SERVICE_NAME"
							class="tha" onclick="sort(this);"><span>服务名称</span><i
								class="thimg"></i></a></th>
						<th style="width: 10%;"><a id="SERVICE_TYPE" class="tha"
							onclick="sort(this);"><span>服务类型</span><i class="thimg"></i></a></th>
						<!-- 	<th  style="width: 10%;"><a id="SERVICE_FUNCTION" class="tha" onclick="sort(this);"><span>接口名称</span><i class="thimg" ></i></a></th> -->
						<th style="width: 10%">操作</th>
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
		 	//设置初始化排序字段
		 	initSort("LOG_DATE","desc");
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
		 		url: basePath+"/wdRmpAppServiceApplyLog/list",
		 		data:params,
		 		async: true,
		 		dataType: "text",
		 		success: function(data){
		 		
		 			var das = JSON.parse(data); 
		 			if(!das.success){
		 				alert(das.msg);
		 			}
		 			if(pageValue(das.obj)){return;}
		 			var sb = new StringBuilder();
		              $.each(das.obj.rows,function(i,obj){ 
			  			 sb.append("<tr><td>").append(++i).append("</td>");
						/*  sb.append("<td >").append(obj.logLevel,15).append("</td>"); */
						 sb.append("<td >").append(obj.logMessage,15).append("</td>");
						 sb.append("<td >").append(obj.logDate,20).append("</td>");
						 sb.append("<td >").append(obj.userId,15).append("</td>");
						 sb.append("<td >").append(obj.logIp,15).append("</td>");
						 sb.append("<td >").append(obj.sysCode,15).append("</td>");
						 if(obj.serviceStatus==0){
							 sb.append("<td >").append("审核未过",15).append("</td>");
						 }else if(obj.serviceStatus==1){
							 sb.append("<td >").append("审核通过",15).append("</td>");
						 }else if(obj.serviceStatus==2){
							 sb.append("<td >").append("申请提交",15).append("</td>");
						 }else{
							 sb.append("<td >").append("其他操作",15).append("</td>");
						 } 
					//	 sb.append("<td >").append(obj.serviceStatus,15).append("</td>");
						 sb.append("<td >").append(obj.logPServiceName,15).append("</td>");
						 if(obj.serviceType==1){
							 sb.append("<td >").append("应用服务",15).append("</td>");
						 }else if(obj.serviceType==2){
							 sb.append("<td >").append("数据服务",15).append("</td>");
						 }else{
							 sb.append("<td >").append("其他服务",15).append("</td>");
						 } 
					//	 sb.append("<td >").append(obj.serviceType,15).append("</td>");
					//	 sb.append("<td >").append(obj.serviceFunction,15).append("</td>");
						 sb.append("<td >");
 						 sb.append("<a class='hj_mar20' onclick='select(\"").append(obj.id).append("\")'><i class='icon icon-search hj_bianji'></i><span class='hj_mar20'>查看</span></a>");
 
			  			});
		 			 $("#tb").html(sb.toString());	 			 
		 		}
 			});
		}
		
		
		function update(id){
			location.href=basePath+"/jsp/zh/wd/rmp/log/wdRmpAppServiceApplyLogUpdate.jsp?id="+id;
		}
		
		function select(id){
			layer.open({
				  type: 2,
				  title: '服务查看',
				  shadeClose: true,
				  maxmin: true, //开启最大化最小化按钮
				  area: ['80%', '70%'],
				content: basePath + "/jsp/zh/wd/rmp/log/wdRmpAppServiceApplyLogDetail.jsp?id=" + id
			});
//			location.href=basePath+"/jsp/zh/wd/rmp/log/wdRmpAppServiceApplyLogDetail.jsp?id="+id;
		}
		
		function add(){
			location.href=basePath+"/jsp/zh/wd/rmp/log/wdRmpAppServiceApplyLogAdd.jsp";
		}	
		
		function del(id){
			$.ajax({
		 		type: "get",
		 		url: basePath+"/wdRmpAppServiceApplyLog/delete",
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
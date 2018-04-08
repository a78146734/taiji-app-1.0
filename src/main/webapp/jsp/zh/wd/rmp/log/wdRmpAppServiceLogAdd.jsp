<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<%@include file="../../../../../commons/global.jsp"%>
	<%@include file="../../../../../commons/xw/basejs.jsp"%>
		<script type="text/javascript" src="js/wdRmpAppServiceLogAdd.js"></script>
		
		<link rel="stylesheet" type="text/css" href="css/wdRmpAppServiceLogAdd.css">
	
</head>
<body >

<form id="form1"  >

	<div class="user_manage">
			<p class="ri_jczctitle">
	           <span class="ri_jczctitletxt">新增页面</span>
	           <span class="ri_jczctitlemore"></span>
	         </p>
	         <div class="user_list">
				<table class="gridtable04 "  >
				
				  				  					  				  						  						    			<tr><td class="tablecolor">日志级别：</td><td  ><input type="text" name="logLevel"   placeholder="请输入日志级别"></td>
					  		
					  							  				  				  						  						  				<td class="tablecolor">服务标示：</td><td  ><input type="text" name="logService"   placeholder="请输入服务标示"></td></tr>
					  		
					  							  				  				  						  						    			<tr><td class="tablecolor">服务路径：</td><td  ><input type="text" name="logServicePath"   placeholder="请输入服务路径"></td>
					  		
					  							  				  				  						  						    			<td class="tablecolor">服务名称：</td><td ><input type="text" name="logServiceName"   placeholder="请输入服务名称"></td></tr>
					  	
					  						  				  				  						  						    			<tr><td class="tablecolor">信息：</td><td  ><input type="text" name="logMessage"   placeholder="请输入信息"></td>
					  		
					  							  				  				  						  						    			<td class="tablecolor">日期：</td><td ><input type="text" name="logDate"   placeholder="请输入日期"></td></tr>
					  	
					  						  				  				  						  						    			<tr><td class="tablecolor">操作人ID：</td><td  ><input type="text" name="userId"   placeholder="请输入操作人ID"></td>
					  		
					  							  				  				  						  						  				<td class="tablecolor">操作人IP：</td><td  ><input type="text" name="logIp"   placeholder="请输入操作人IP"></td></tr>
					  		
					  							  				  				  						  						    			<tr><td class="tablecolor">系统标示：</td><td  ><input type="text" name="sysCode"   placeholder="请输入系统标示"></td>
					  		
					  							  				  				  						  						    			<td class="tablecolor">调用结果状态（0失败,1成功）：</td><td ><input type="text" name="serviceStatus"   placeholder="请输入调用结果状态（0失败,1成功）"></td></tr>
					  	
					  						  				  				  						  						    			<tr><td class="tablecolor">响应时间(单位：毫秒)：</td><td  ><input type="text" name="serviceRuntime"   placeholder="请输入响应时间(单位：毫秒)"></td>
					  		
					  							  				  				  						  						    			<td class="tablecolor">应用主键：</td><td ><input type="text" name="logPService"   placeholder="请输入应用主键"></td></tr>
					  	
					  						  				  				  						  						    			<tr><td class="tablecolor">应用名称：</td><td  ><input type="text" name="logPServiceName"   placeholder="请输入应用名称"></td>
					  		
					  							  				  				  						  						  				<td class="tablecolor">请求ID：</td><td  ><input type="text" name="requestId"   placeholder="请输入请求ID"></td></tr>
					  		
					  							  				  				  						  						    			<tr><td class="tablecolor">协议：</td><td  ><input type="text" name="protocol"   placeholder="请输入协议"></td>
					  		
					  							  				  				  						  						    			<td class="tablecolor">请求数据大小：</td><td ><input type="text" name="requestSize"   placeholder="请输入请求数据大小"></td></tr>
					  	
					  						  				  				  						  						    			<tr><td class="tablecolor">错误信息：</td><td  ><input type="text" name="errorComment"   placeholder="请输入错误信息"></td>
					  		
					  							  				  				</table>
			</div>
		</div>
		
		<div class="tablebut"> 
               <button type="button" onclick="Submit();">提交</button>&nbsp;&nbsp;&nbsp;&nbsp;<button type="button" onclick="back();">取消</button>
        </div>
	</form>
</body>
<script type="text/javascript">
	function Submit() {
			var params = $("#form1").serialize();
			$.ajax({
		 		type: "post",
		 		url: "<%=basePath%>/wdRmpAppServiceLog/save",
		 		data:params,
		 		async: true,
		 		dataType: "text",
		 		beforeSend: function(){},  
	        	complete: function(){},
		 		success: function(data){
		 			var das = JSON.parse(data);
		 			if(das.success){
		 				location.href=basePath + "/static/commons/massage/success.jsp?url="+basePath+"/jsp/zh/wd/rmp/log/wdRmpAppServiceLogList.jsp";
		 			}else{
		 				location.href=basePath + "/static/commons/massage/failure.jsp?url="+basePath+"/jsp/zh/wd/rmp/log/wdRmpAppServiceLogList.jsp";
		 			}
		 		}
 			});
		}
	
		function back() {
			location.href=basePath + "/jsp/zh/wd/rmp/log/wdRmpAppServiceLogList.jsp";
		}
</script>
</html>
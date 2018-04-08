<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<%@include file="../../../../../commons/global.jsp"%>
		<%@include file="../../../../../commons/xw/basejs.jsp"%>
		<script type="text/javascript" src="js/wdRmpAppEqpLogAdd.js"></script>
		<link rel="stylesheet" type="text/css" href="css/wdRmpAppEqpLogAdd.css">
	
	</head>
<body >

	<form id="form1"  >

		<div class="user_manage">
			<p class="ri_jczctitle">
	           <span class="ri_jczctitletxt">新增页面</span>
	           <span class="ri_jczctitlemore"></span>
	         </p>
	         <div class="user_list">
				<table class="gridtable04 ">
		 			<tr>
		 				<td class="tablecolor">日志级别：</td>
		 				<td ><input type="text" name="logLevel"  placeholder="请输入日志级别"></td>
		  				<td class="tablecolor">设备标示：</td>
		  				<td ><input type="text" name="logEqpCode"   placeholder="请输入设备标示"></td>
		  			</tr>
		
		    		<tr>
		    			<td class="tablecolor">设备名称：</td>
		    			<td ><input type="text" name="logEqpName"   placeholder="请输入设备名称"></td>
		    			<td class="tablecolor">执行操作类型：</td>
		    			<td ><input type="text" name="operatType"   placeholder="请输入执行操作类型"></td>
		    		</tr>
		
		   			<tr>
		   				<td class="tablecolor">信息：</td>
		   				<td ><input type="text" name="logMessage"   placeholder="请输入信息"></td>
		    			<td class="tablecolor">日期：</td>
		    			<td ><input type="text" name="logDate"   placeholder="请输入日期"></td>
		    		</tr>
		
		   			<tr>
		   				<td class="tablecolor">操作人ID：</td>
		   				<td ><input type="text" name="userId"   placeholder="请输入操作人ID"></td>
		  				<td class="tablecolor">操作人IP：</td>
		  				<td ><input type="text" name="logIp"   placeholder="请输入操作人IP"></td>
		  			</tr>
		
		   			<tr>
		    			<td class="tablecolor">系统标示：</td>
		    			<td ><input type="text" name="sysCode"   placeholder="请输入系统标示"></td>
		    			<td class="tablecolor">被访问类：</td>
		    			<td ><input type="text" name="logClass"   placeholder="请输入被访问类"></td>
		   			</tr>
		
		   			<tr>
		   				<td class="tablecolor">被访问方法：</td>
		   				<td ><input type="text" name="logMethod"   placeholder="请输入被访问方法"></td>
		    			<td class="tablecolor">设备类型：</td>
		    			<td ><input type="text" name="logEqpType"   placeholder="请输入设备类型"></td>
		    		</tr>
		
		   			<tr>
			   			<td class="tablecolor">操作结果：</td>
			   			<td ><input type="text" name="operatResult"   placeholder="请输入操作结果"></td>
					</tr>		  		
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
		 		url: "<%=basePath%>/wdRmpAppEqpLog/save",
		 		data:params,
		 		async: true,
		 		dataType: "text",
		 		beforeSend: function(){},  
	        	complete: function(){},
		 		success: function(data){
		 			var das = JSON.parse(data);
		 			if(das.success){
		 				location.href=basePath + "/static/commons/massage/success.jsp?url="+basePath+"/jsp/zh/wd/rmp/log/wdRmpAppEqpLogList.jsp";
		 			}else{
		 				location.href=basePath + "/static/commons/massage/failure.jsp?url="+basePath+"/jsp/zh/wd/rmp/log/wdRmpAppEqpLogList.jsp";
		 			}
		 		}
 			});
		}
	
		function back() {
			location.href=basePath + "/jsp/zh/wd/rmp/log/wdRmpAppEqpLogList.jsp";
		}
</script>
</html>
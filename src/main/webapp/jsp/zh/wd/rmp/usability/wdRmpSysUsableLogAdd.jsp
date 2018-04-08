<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<%@include file="../../../../../commons/global.jsp"%>
	<%@include file="../../../../../commons/xw/basejs.jsp"%>
		<script type="text/javascript" src="js/wdRmpSysUsableLogAdd.js"></script>
		
		<link rel="stylesheet" type="text/css" href="css/wdRmpSysUsableLogAdd.css">
	
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
				
				  				  					  				  						  						    			<tr><td class="tablecolor">日志等级：</td><td  ><input type="text" name="logLevel"   placeholder="请输入日志等级"></td>
					  		
					  							  				  				  						  						  				<td class="tablecolor">系统名称：</td><td  ><input type="text" name="sysName"   placeholder="请输入系统名称"></td></tr>
					  		
					  							  				  				  						  						    			<tr><td class="tablecolor">系统名称：</td><td  ><input type="text" name="sysUrl"   placeholder="请输入系统名称"></td>
					  		
					  							  				  				  						  						    			<td class="tablecolor">系统IP：</td><td ><input type="text" name="sysIp"   placeholder="请输入系统IP"></td></tr>
					  	
					  						  				  				  						  						    			<tr><td class="tablecolor">系统Port：</td><td  ><input type="text" name="sysPort"   placeholder="请输入系统Port"></td>
					  		
					  							  				  				  						  						    			<td class="tablecolor">系统状态(0为异常,1正常)：</td><td ><input type="text" name="sysState"   placeholder="请输入系统状态(0为异常,1正常)"></td></tr>
					  	
					  						  				  				  						  						    			<tr><td class="tablecolor">系统方法：</td><td  ><input type="text" name="sysFunction"   placeholder="请输入系统方法"></td>
					  		
					  							  				  				  						  						  				<td class="tablecolor">联系电话：</td><td  ><input type="text" name="sysPhone"   placeholder="请输入联系电话"></td></tr>
					  		
					  							  				  				  						  						    			<tr><td class="tablecolor">系统类型：</td><td  ><input type="text" name="usableType"   placeholder="请输入系统类型"></td>
					  		
					  							  				  				  						  						    			<td class="tablecolor">错误计数：</td><td ><input type="text" name="errorCount"   placeholder="请输入错误计数"></td></tr>
					  	
					  						  				  				  						  						    			<tr><td class="tablecolor">是否短信通知：</td><td  ><input type="text" name="logNotify"   placeholder="请输入是否短信通知"></td>
					  		
					  							  				  				  						  						    			<td class="tablecolor">记录时间：</td><td ><input type="text" name="logDate"   placeholder="请输入记录时间"></td></tr>
					  	
					  						  				  				  						  						    			<tr><td class="tablecolor">系统id：</td><td  ><input type="text" name="sysId"   placeholder="请输入系统id"></td>
					  		
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
		 		url: "<%=basePath%>/wdRmpSysUsableLog/save",
		 		data:params,
		 		async: true,
		 		dataType: "text",
		 		beforeSend: function(){},  
	        	complete: function(){},
		 		success: function(data){
		 			var das = JSON.parse(data);
		 			if(das.success){
		 				location.href=basePath + "/static/commons/massage/success.jsp?url="+basePath+"/jsp/zh/wd/rmp/usability/wdRmpSysUsableLogList.jsp";
		 			}else{
		 				location.href=basePath + "/static/commons/massage/failure.jsp?url="+basePath+"/jsp/zh/wd/rmp/usability/wdRmpSysUsableLogList.jsp";
		 			}
		 		}
 			});
		}
	
		function back() {
			location.href=basePath + "/jsp/zh/wd/rmp/usability/wdRmpSysUsableLogList.jsp";
		}
</script>
</html>
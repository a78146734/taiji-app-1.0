<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%
	String id = "";
	if(request.getParameter("id")!=null&&request.getParameter("id")!=""){
		id = (String)request.getParameter("id");
	}else{
		out.println("没有接受到主键的错误");
	}
%>
<!DOCTYPE html>
<html>
<head>
	<%@include file="../../../../../commons/global.jsp"%>
	<%@include file="../../../../../commons/xw/basejs.jsp"%>
	<!-- <script type="text/javascript" src="js/wdRmpAppEqpLogDetail.js"></script>
	<link rel="stylesheet" type="text/css" href="css/wdRmpAppEqpLogDetail.css"> -->
<script type="text/javascript">
     window.onload=function(){window.parent.scrollTo(0,0);}
</script>
<style type="text/css">
	html,body{
		overflow: auto;
	}	
	body{
		min-width: 600px;
	}
</style>
</head>
<body style='min-width: auto;'>
	<div class="user_manage">
	   <div class="user_list">
           	<table class="gridtable04 ">
           		<!-- <tbody id="tb">
           		
           		</tbody> -->
           			<tr width="100%">
		 				<td width="25%" class="tablecolor">日志级别：</td>
		 				<td width="25%">${wdRmpAppEqpLog.logLevel}</td>
		  				<td width="25%"class="tablecolor">设备标识：</td>
		  				<td width="25%">${wdRmpAppEqpLog.logEqpCode}</td>
		  			</tr>
		
		    		<tr>
		    			<td width="25%"class="tablecolor">设备名称：</td>
		    			<td width="25%">${wdRmpAppEqpLog.logEqpName}</td>
		    			<td width="25%"class="tablecolor">执行操作类型：</td>
		    			<td width="25%">${wdRmpAppEqpLog.operatType}</td>
		    		</tr>
		
		   			<tr>
		   				<td width="25%"class="tablecolor">信息：</td>
		   				<td width="25%">${wdRmpAppEqpLog.logMessage}</td>
		    			<td width="25%"class="tablecolor">日期：</td>
		    			<td width="25%"><fmt:formatDate pattern='yyyy-MM-dd' value='${wdRmpAppEqpLog.logDate}'/></td>
		    		</tr>
		
		   			<tr>
		   				<td width="25%"class="tablecolor">操作人ID：</td>
		   				<td width="25%">${wdRmpAppEqpLog.userId}</td>
		  				<td width="25%"class="tablecolor">操作人IP：</td>
		  				<td width="25%">${wdRmpAppEqpLog.logIp}</td>
		  			</tr>
		
		   			<tr>
		    			<td width="25%"class="tablecolor">系统标示：</td>
		    			<td width="25%">${wdRmpAppEqpLog.sysCode}</td>
		    			<td width="25%"class="tablecolor">被访问类：</td>
		    			<td width="25%">${wdRmpAppEqpLog.logClass}</td>
		   			</tr>
		
		   			<tr>
		   				<td width="25%"class="tablecolor">被访问方法：</td>
		   				<td width="25%">${wdRmpAppEqpLog.logMethod}</td>
			    		<c:if test="${not empty wdRmpAppEqpLog.logEqpType}">
			    			<td width="25%"class="tablecolor">设备类型：</td>
			    			<td width="25%">
				    				${wdRmpAppEqpLog.logEqpType}
			    			</td>
			    		</c:if>
		    		</tr>
		
		   			<tr>
			   			<td width="25%"class="tablecolor">操作结果：</td>
			   			<td width="25%">${wdRmpAppEqpLog.operatResult}</td>
					</tr>		  		
           	</table>
        </div>
	</div>
	<div class="tablebut"> 
         <button type="button" onclick="cancel();">取消</button>
	</div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<%@include file="../../../../../commons/global.jsp"%>
	<%@include file="../../../../../commons/xw/basejs.jsp"%>
		<script type="text/javascript" src="js/oopAdd.js"></script>
		
		<link rel="stylesheet" type="text/css" href="css/oopAdd.css">
	
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
				
				  				  					  				  						  						    			<tr><td class="tablecolor">名称：</td><td  ><input type="text" name="name"   placeholder="请输入名称"></td>
					  		
					  							  				  				  						  						  				<td class="tablecolor">性别：</td><td  ><input type="text" name="sex"   placeholder="请输入性别"></td></tr>
					  		
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
		 		url: "<%=basePath%>/oop/save",
		 		data:params,
		 		async: true,
		 		dataType: "text",
		 		beforeSend: function(){},  
	        	complete: function(){},
		 		success: function(data){
		 			var das = JSON.parse(data);
		 			if(das.success){
		 				location.href=basePath + "/static/commons/massage/success.jsp?url="+basePath+"/jsp/zh/wd/sys/log/oopList.jsp";
		 			}else{
		 				location.href=basePath + "/static/commons/massage/failure.jsp?url="+basePath+"/jsp/zh/wd/sys/log/oopList.jsp";
		 			}
		 		}
 			});
		}
	
		function back() {
			location.href=basePath + "/jsp/zh/wd/sys/log/oopList.jsp";
		}
</script>
</html>
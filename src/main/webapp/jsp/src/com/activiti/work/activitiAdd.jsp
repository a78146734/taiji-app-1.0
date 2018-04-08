<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@include file="../../../../../commons/global.jsp"%>
<%@include file="../../../../../commons/xw/basejs.jsp"%>
<script type="text/javascript" src="js/sysJobAdd.js"></script>

<link rel="stylesheet" type="text/css" href="css/sysJobAdd.css">
<style type="text/css">
	html,body{
		min-width: 500px;
	}
</style>
</head>
<body>
	<form id="deployFile" name="deployFile" class="forms" action="${base}/activiti/designer" method="post" >
		<div style="padding: 3px;">
		<div class="user_manage">
			<div class="user_list">
				<table class="gridtable04 ">
					<tr>
						<td class="tablecolor">流程名称：</td>
						<td><input type="text" name="name"></td>
					</tr>
					<tr>
						<td class="tablecolor">key：</td>
						<td><input type="text" name="key"></td>
					</tr>
					<tr>
						<td class="tablecolor">流程描述：</td>
						<td><input type="text" name="description"></td>
					</tr>
					
				</table>
			</div>
		</div>
		<div class="formmsg" style="margin-top:150px;">
			<span id="formmsg" ></span>
		</div>
		<div class="butdiv">
			<button class="button" type="submit">提交</button>
			<button onclick="cancel();" class="button" type="button">返回</button>
		</div>
		</div>
	</form>
</body>
<script type="text/javascript">

$(function(){
	$(".forms").Validform({
		tiptype:function(msg,o,cssctl){
			var objtip=$("#formmsg");
			cssctl(objtip,o.type);
			objtip.text(msg);
		},
		ajaxPost:true,
		callback:function(data){
 			if(data.success){
 				location.href=basePath + "/jsp/src/com/activiti/designer/modeler.html?modelId="+data.obj.modelId;
 			}else{
 				alert("创建模型出错！");
 			}
		}
	});
});

	
function cancel(){
	history.back(-1);
}
</script>
</html>
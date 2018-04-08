<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@include file="../../../../../commons/global.jsp"%>
<%@include file="../../../../../commons/xw/basejs.jsp"%>
<style type="text/css">
		body{
			min-width: 600px;
		}
	</style>
</head>
<body>

	<form id="form1" class="forms" action="<%=basePath%>/sysJob/save" method="post">
		<div style="padding: 3px;">
		<div class="user_manage">
			<div class="user_list">
				<table class="gridtable04 ">
					<tr>
						<td class="tablecolor">任务名称：</td>
						<td><input type="text" name="jobName" placeholder="请输入任务名称" datatype="*3-18" errormsg="任务名称至少3位任意字符,最多18位字符！"></td>
						<td class="tablecolor">表达式：</td>
						<td><input type="text" id="cronExpression" name="cronExpression"  style="width: 150px" 
							readonly="readonly" onclick="cronMaker();"  placeholder="请生成表达式" datatype="*" errormsg="情输入corn表达式">
							
				
							</td>
					</tr>

					<tr>
						<td class="tablecolor">执行类：</td>
						<td><input type="text" name="beanClass" placeholder="请输入执行类" datatype="*" errormsg="请输入执行类"></td>
						<td class="tablecolor">执行方法：</td>
						<td><input type="text" name="methodName"
							placeholder="请输入执行方法" datatype="*" errormsg="请输入执行方法"></td>
					</tr>
					<tr>
						<td class="tablecolor">任务描述：</td>
						<td colspan="3"><input type="text" name="description"
							placeholder="请输入任务描述" datatype="*0-100" errormsg="请控制在100字以内"></td>
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
 				location.href=basePath + "/jsp/utils/massage/success_gen_close.jsp?url="+basePath+"/jsp/src/com/taiji/quartz/sysJobList.jsp";
 			}else{
 				location.href=basePath + "/jsp/utils/massage/failure_gen_close.jsp?url="+basePath+"/jsp/src/com/taiji/quartz/sysJobList.jsp";
 			}
		}
	});
});
function cronMaker(){
	layer.open({
		  type: 2,
		  title: '表达式生成',
		  shadeClose: true,
		  shade: 0.5,
		  shadeClose: true,
		  maxmin: true, //开启最大化最小化按钮
		  area: ['100%', '100%'],
		  /* btn:['取消'],
		  yes:function(index ,layero){
 
			  layer.close(index);
		  }, */
	  

	  content: "<%=basePath%>/jsp/src/com/taiji/cronmaker/cronMaker.jsp",
	 
	}); 
}
	
function cancel(){
	parent.layer.closeAll();
}
</script>
</html>
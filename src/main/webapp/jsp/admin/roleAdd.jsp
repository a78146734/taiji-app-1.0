<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp"%>
<%@ include file="/commons/xw/basejs.jsp"%>
<style type="text/css">
	body{
		min-width: 600px;
	}
</style>
<body>
	
		<form id="roleAddForm" class="forms" action="<%=basePath%>/role/add" method="post">
		<div style="padding: 3px;">
		<div class="user_manage">
			<div class="user_list">
			<table class="gridtable04" style="width: 100%;">
				<tr>
					<td style="width: 17%" class="tablecolor">角色名称<span class="tdmsg">*</span></td>
					<td style="width: 33%">
						<input name="name"  id="name"   type="text" placeholder="请输入角色名称" datatype="s1-18" errormsg="名称至少1位字符,最多18位字符！" class="input" />
					</td>
					<td style="width: 17%" class="tablecolor">标示<span class="tdmsg">*</span></td>
					<td style="width: 33%">
						<input name="code" type="text"    id="code"  placeholder="请输入角色标示" datatype="s1-18" errormsg="标示至少1位字符,最多18位字符！" class="input" />
					</td>
				</tr>
				<tr>
					<td style="width: 17%" class="tablecolor">排序</td>
					<td style="width: 33%">
						<input name="seq" value="0" class="input"  datatype="/^\s*$/g|n1-6" errormsg="排序至少1位数字,最多6位数字！"/>
					</td>
					<td style="width: 17%" class="tablecolor">描述</td>
					<td style="width: 33%">
						<textarea name="description" style="width: 80%;" class="input" rows="" cols="" datatype="/^\s*$/g|s1-18" errormsg="描述至少1位字符,最多18位字符！"></textarea>
					</td>
				</tr>
			</table>
		</div></div>
	</div>
	<div class="formmsg" style="margin-top:110px;">
		<span id="formmsg" ></span>
	</div>
	<div class="butdiv">
		<button class="button" type="button" onclick="sub123();">提交</button>
		<button onclick="cancel();" class="button" type="button">返回</button>
	</div>
	</form>
</body>
<script type="text/javascript">
$(function(){
	//
	$(".forms").Validform({
		tiptype:function(msg,o,cssctl){
			var objtip=$("#formmsg");
			cssctl(objtip,o.type);
			objtip.text(msg);
		},
		ajaxPost:true,
		callback:function(data){
			if(data.success){
 				location.href=basePath + "/jsp/utils/massage/success_gen_close.jsp";
 			}else{
 				location.href=basePath + "/jsp/utils/massage/failure_gen_close.jsp";
 			} 
		}
	});
});
	var sub1=true;
	var sub2=true;
	//验证角色名称是否已存在
	function judgeRoleName(){
		if($("#name").val()!=""){
		$.ajax({
	 		type: "post",
	 		url: "${base}/role/judgeRoleName",
	 		data:{"roleName":$("#name").val()},
	 		async: true,
	 		dataType: "json",
	 		success: function(data){	 			
	 			if(data.obj){
	 				$("#formmsg").empty();
	 				$("#formmsg").append("角色名称已存在");	
	 				sub1=false;
	 			}else{
	 				sub1=true;
	 			}
	 		}
		});
		}
	}
	
	//验证角色标示是否已存在
	function judgeCode(){
		if($("#code").val()!=""){
		$.ajax({
	 		type: "post",
	 		url: "${base}/role/judgeCode",
	 		data:{"code":$("#code").val()},
	 		async: true,
	 		dataType: "json",
	 		success: function(data){	 			
	 			if(data.obj){
	 				$("#formmsg").empty();
	 				$("#formmsg").append("角色标示已存在");	
	 				sub2=false;
	 			}else{
	 				sub2=true;
	 			}
	 		}
		});
		}
	}
	//表单提交事件
	function sub123(){
		//验证角色名称是否已存在
		$.ajax({
	 		type: "post",
	 		url: "${base}/role/judgeRoleName",
	 		data:{"roleName":$("#name").val()},
	 		async: true,
	 		dataType: "json",
	 		success: function(data){	 			
	 			if(data.obj){
	 				$("#formmsg").empty();
	 				$("#formmsg").append("角色名称已存在");	
	 				
	 			}else{
	 				//验证角色标示是否已存在
	 				$.ajax({
	 			 		type: "post",
	 			 		url: "${base}/role/judgeCode",
	 			 		data:{"code":$("#code").val()},
	 			 		async: true,
	 			 		dataType: "json",
	 			 		success: function(data){	 			
	 			 			if(data.obj){
	 			 				$("#formmsg").empty();
	 			 				$("#formmsg").append("角色标示已存在");	
	 			 				
	 			 			}else{
	 			 				$("#roleAddForm").submit();
	 			 			}
	 			 		}
	 				});
	 				
	 			}
	 		}
		});
	}

	function save() {
		var params = $("#roleAddForm").serialize();
		$.post("${base}/role/add", params, function(result) {
			//msg success or fail
			if (result.success) {
				layer.msg(result.msg,function(){
					parent.doQuery();
				});
			} else {
				layer.msg(result.msg);
			}
		}, 'JSON');
		var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
		parent.layer.close(index); //再执行关闭 
	}
	function cancel() {
		parent.layer.closeAll('iframe');
	}
</script>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp"%>
<%@ include file="/commons/xw/basejs.jsp"%>
<!DOCTYPE html>
<head>
	<style type="text/css">
		body{
			min-width: 600px;
		}
	</style>
</head>
<html>
<body>
	
		<form id="roleEditForm" class="forms" action="<%=basePath%>/role/edit" method="post">
		<div style="padding: 3px;">
		<div class="user_manage">
			<div class="user_list">
			<table class="gridtable04" style="width: 100%;">
				<tr>
					<td style="width: 17%" class="tablecolor">角色名称<span class="tdmsg">*</span></td>
					<td style="width: 33%">
						<input name="id" type="hidden" value="${role.roleId}">
						<input name="name" type="text" placeholder="请输入角色名称" class="input" value="${role.roleName}" datatype="s1-18" errormsg="角色名称至少1位字符,最多18位字符！"/>
					</td>
					<td style="width: 17%" class="tablecolor">标示<span class="tdmsg">*</span></td>
					<td style="width: 33%">
						<input name="code" type="text" placeholder="请输入角色标示" class="input" value="${role.code}" datatype="s1-18" errormsg="标示至少1位字符,最多18位字符！"/>
					</td>
				</tr>
				<tr>
					<td style="width: 17%" class="tablecolor">排序</td>
					<td style="width: 33%">
						<input name="seq"  class="input" value="${role.seq}" datatype="/^\s*$/g|n1-6" errormsg="排序至少1位数字,最多6位数字！"/>
					</td>
					<td style="width: 17%" class="tablecolor">描述</td>
					<td style="width: 33%">
						<textarea id="description" class="input" name="description" rows="" cols="" datatype="/^\s*$/g|s1-18" errormsg="描述至少1位字符,最多18位字符！" style="width: 80%;"></textarea>
					</td>
				</tr>
				<!-- <tr>
					<td colspan="4">
						<button onclick="save();" class="button" type="button">确定</button>
						<button onclick="cancel();" class="button" type="button">返回</button>
					</td>
				</tr> -->
			</table>
			</div></div>
		</div>
		<div class="formmsg" style="margin-top:110px;">
		<span id="formmsg" ></span>
	</div>
	<div class="butdiv">
		<button class="button" type="submit">提交</button>
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
 
</script>
<script type="text/javascript">
	$(function() {
		$("#description").val("${role.describe}");
	});
	function save() {
		var params = $("#roleEditForm").serialize();
		$.post("${base}/role/edit", params, function(result) {
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
</html>
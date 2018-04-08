<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/global.jsp"%>
<%@ include file="../../commons/xw/basejs.jsp"%>
<style type="text/css">
	body{
		min-width: 600px;
	}
</style>
<script type="text/javascript">
	/* $(function() {
		$('#resourceAddForm').form({
			url : '${path }/puriew/add',
			onSubmit : function() {
				progressLoad();
				var isValid = $(this).form('validate');
				if (!isValid) {
					progressClose();
				}
				return isValid;
			},
			success : function(result) {
				progressClose();
				result = $.parseJSON(result);
				if (result.success) {
					parent.$.modalDialog.openner_treeGrid.treegrid('reload');//之所以能在这里调用到parent.$.modalDialog.openner_treeGrid这个对象，是因为resource.jsp页面预定义好了
					//parent.layout_west_tree.tree('reload');
					parent.$.modalDialog.handler.dialog('close');
				}
			}
		});

	}); */
	function save(){
	// validAjaxForm("forms","saveBtn",mypath+"zjExpert/save.action", successError);
	var path="${base}";
	 $("#forms").attr("action", path+"/puriew/add").submit(); 
	/*  var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
                        parent.layer.close(index); */
}	

function cancel(){
	 var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
     parent.layer.close(index);
}	
</script>

	<form id="forms" class="forms" action="<%=basePath%>/puriew/add" method="post">
	<div style="padding: 3px;">
	<div class="user_manage">
			<div class="user_list">
		<table  class="gridtable04" style="width: 100%;">
			<tr>
				<td class="tablecolor" style="width: 17%">排序:<span class="tdmsg">*</span></td>
				<td style="width: 33%"><input name="seq" datatype="n1-6" errormsg="请输入1-6位数字" value="0" type="text" placeholder="输入排序" class="input"/></td>
				<td  class="tablecolor">权限标识符:<span class="tdmsg">*</span></td>
				<td><input name="code" datatype="*1-6" errormsg="请输入1-6位字符"  type="text"  placeholder="请输入权限标识符" class="input"/></td>
			</tr>
			<tr>
				<td class="tablecolor">权限名称:<span class="tdmsg">*</span></td>
				<td><input name="puriewName" datatype="*1-18" errormsg="请输入1-18位字符" type="text" placeholder="请输入资源名称" class="input"/></td>
				<td class="tablecolor">表达式:<span class="tdmsg">*</span></td>
				<td><input name="expression" datatype="*1-18" errormsg="请输入1-18位字符" type="text" placeholder="输入超链接表达式" class="input" /></td>
			<tr>	
				
			<!-- <tr>
				<td>权限标示</td>
				<td> <input name="code" type="text" placeholder="输入权限标示" class="input"/></td>
					</tr> -->
		</table>
		</div></div>
		</div>
<div class="formmsg" style="margin-top:120px;">
		<span id="formmsg" ></span>
	</div>
	<div class="butdiv">
		<button class="button" type="submit">提交</button>
		<button onclick="cancel();" class="button" type="button">返回</button>
	</div>
	</form>
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
 				location.href=basePath + "/static/commons/massage/success_gen_close.jsp";
 			}else{
 				location.href=basePath + "/static/commons/massage/failure_gen_close.jsp";
 			}
		}
	});
});
</script>
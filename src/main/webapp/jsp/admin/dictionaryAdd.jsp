<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/global.jsp"%>
<%@ include file="../../commons/xw/basejs.jsp"%>
<script type="text/javascript">
	function save(){
	var path="${base}";
	 $("#forms").attr("action", path+"/dictionary/add").submit(); 
}	

function cancel(){
	 var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
     parent.layer.close(index);
}	
</script>
<style type="text/css">
	body{
		min-width: 600px;
	}
</style>
<form id="forms" class="forms" action="<%=basePath%>/dictionary/add" method="post">
<div style="padding: 3px;">
<div class="user_manage">
			<div class="user_list">
		<table  class="gridtable04" style="width: 100%;">
			<tr>
				<td class="tablecolor">序号<span class="tdmsg">*</span></td>
				<td><input name="seq" value="0" type="text" placeholder="输入序号" class="input"  datatype="n1-6" errormsg="序号至少1位数字,最多6位数字！"/></td>
				<td style="width:13%" class="tablecolor">所属节点:</td>
				<td>
				<input type="text" placeholder="" class="input"
						value="根节点" readonly="readonly"   datatype='/^\s*$/g|*' nullmsg='请输入根节点！' errormsg='输入根节点格式有误！'>
				</td>
				
				</tr>
			<tr>
				<td class="tablecolor">节点名称<span class="tdmsg">*</span></td>
					<td><input name="nodeNames" type="text" placeholder="输入节点名称" class="input"
						datatype="*3-18" errormsg="节点名称至少3位任意字符,最多18位字符！"></td>
				<td style="width:13%" class="tablecolor">字典标识符<span class="tdmsg">*</span></td>
				<td>
				<input name="nodeId" id="nodeId" type="text" placeholder="请输入字典标识符" class="input" datatype="s3-18" errormsg="字典标识符至少3位字符,最多18位字符！" onchange="existCheck();"/></td>
			</tr> 
				<tr>
					<td class="tablecolor">参数一</td>
					<td><input name="parameter1" type="text" placeholder="请输入参数一" 
						class="input" datatype='/^\s*$/g|*' nullmsg='请输入参数一！' errormsg='输入参数一格式有误！'></td>
					<td class="tablecolor">参数二</td>
					<td><input name="parameter2" type="text" placeholder="请输入参数二"
						class="input" datatype='/^\s*$/g|*' nullmsg='请输入参数二！' errormsg='输入参数二格式有误！'></td>
				</tr>
				<tr>
					<td class="tablecolor">参数三</td>
					<td><input name="parameter3" type="text" placeholder="请输入参数三"
						class="input" datatype='/^\s*$/g|*' nullmsg='请输入参数三！' errormsg='输入参数三格式有误！'></td>
					<td class="tablecolor">参数四</td>
					<td><input name="parameter4" type="text" placeholder="请输入参数四"
						class="input"   datatype='/^\s*$/g|*' nullmsg='请输入参数四！' errormsg='输入参数四格式有误！'></td>
				</tr>
				<tr>
					<td class="tablecolor">参数五</td>
					<td><input name="parameter5" type="text" placeholder="请输入参数五"
						class="input"  datatype='/^\s*$/g|*' nullmsg='请输入参数五！' errormsg='输入参数五格式有误！'></td>
					<td class="tablecolor">参数六</td>
					<td><input name="parameter6" type="text" placeholder="请输入参数六"
						class="input"   datatype='/^\s*$/g|*' nullmsg='请输入参数六！' errormsg='输入参数六格式有误！'></td>
				</tr>
				<!--  <tr>
					<td class="tablecolor">是否公开</td>
					<td>
						<dic:html nodeId="sys_if_open" name="saveType" type="select" value="${dictionary.saveType}" />
					</td>

					<td>是否缓存</td>
					<td><select name="cache" class="input"   datatype='/^\s*$/g|*' nullmsg='请输入是否缓存！' errormsg='输入格式有误！'>
							<option value="0">不缓存</option>
							<option value="1" selected="selected">缓存</option>
					</select></td>
				</tr>-->
		</table>
		</div></div>
</div>
<div class="formmsg" style="margin-top: 300px;">
	<span id="formmsg" ></span>
</div>
<div class="butdiv">
	<button class="button" onclick="sub();" type="button">提交</button>
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
 				location.href=basePath + "/jsp/utils/massage/success_gen_close.jsp";
 			}else{
 				location.href=basePath + "/jsp/utils/massage/failure_gen_close.jsp";
 			} 
		}
	});
	
});

var boo=true;
//校验数据字段标识符时候已存在
function existCheck(){
	$.ajax({
		type: "post",
		url: "<%=basePath%>/dictionary/existCheck",
		data:{"nodeId":$("#nodeId").val()},
		async: true,
		dataType: "json",
		success: function(data){
			if(data==false){
				boo=true;
			}else{		
				$("#formmsg").html("已存在该标识符");
				boo=false;
			}
		} 		
	})
	
}
//提交
function sub(){	
	if(boo==true){
		$("#forms").submit();
	}
}
</script>


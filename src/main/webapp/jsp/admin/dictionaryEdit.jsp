<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/global.jsp"%>
<%@ include file="../../commons/xw/basejs.jsp"%>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" href="${staticPath }/static/ztree/css/demo.css" type="text/css">
	<link rel="stylesheet" href="${staticPath }/static/ztree/css/zTreeStyle/zTreeStyle.css" type="text/css">
<style type="text/css">
	body{
		min-width: 600px;
	}
</style>
<script type="text/javascript">
//在页面保存原始的标识符
var jspNodeId="";
$(function(){
	$("#saveType").val('${dictionary.saveType}');
	$("#cache").val('${dictionary.cache}');
	//在页面保存原始的标识符
	jspNodeId=$("#nodeId").val();
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
	function save(){
	var path="${base}";
	 $("#forms").attr("action", path+"/dictionary/edit").submit(); 
}	

function cancel(){
	 var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
                        parent.layer.close(index);
}	
</script>
<script type="text/javascript">
$(function(){
	//
	
	//alert(323);
	
});

//校验数据字段标识符时候已存在
var boo=true;
function existCheck(){
	if($("#nodeId").val()!=jspNodeId){
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
	}else{
		boo=true;
	}
	
	
}
//提交
function sub(){
	if(boo==true){
		$("#forms").submit();
	}
}
</script>
<form id="forms" class="forms" action="<%=basePath%>/dictionary/edit"
	method="post">
	<div style="padding: 3px;">
	<div class="user_manage">
			<div class="user_list">
		<table class="gridtable04" style="width: 100%;">
			<tr>
			
			<td class="tablecolor">序号<span class="tdmsg">*</span></td>
				<td><input name="seq"  type="text" datatype="n1-6"
					errormsg="序号至少1位数字,最多6位数字！" placeholder="输入排序" class="input"
					value="${dictionary.seq}" /></td>
				<td style="width:13%" class="tablecolor">所属节点:</td>
				<td><input name="dictionaryId" type="hidden"
					value="${dictionary.dictionaryId}"> <input type="text"
					placeholder="请输入根节点" class="input" value="根节点" readonly="readonly"
					datatype='/^\s*$/g|*' nullmsg='请输入根节点！' errormsg='输入根节点格式有误！'>
				</td>
				
			</tr>
			<tr>
				<td class="tablecolor">节点名称 <span class="tdmsg">*</span></td>
				<td><input name="nodeNames" type="text" datatype="*3-18"
					errormsg="节点名称至少3位任意字符,最多18位字符！" placeholder="输入节点名称" class="input"
					value="${dictionary.nodeName}"></td>
				<td class="tablecolor" style="width:13%">字典标识符<span class="tdmsg">*</span></td>
				<td><input name="nodeId"  id="nodeId" type="text" datatype="s3-30"
					errormsg="字典标识符至少3位数字,最多30位数字！" placeholder="输入节点id" class="input"
					value="${dictionary.nodeId}" onchange="existCheck();" /></td>
			</tr>
			<tr>
				<td class="tablecolor">参数1</td>
				<td><input name="parameter1" type="text" placeholder="输入参数1"
					value="${dictionary.parameter1}" class="input"></td>
				<td class="tablecolor">参数2</td>
				<td><input name="parameter2" type="text" placeholder="输入参数2"
					value="${dictionary.parameter2}" class="input"></td>
			</tr>
			<tr>
				<td class="tablecolor">参数3</td>
				<td><input name="parameter3" type="text" placeholder="输入参数3"
					value="${dictionary.parameter3}" class="input"></td>
				<td class="tablecolor">参数4</td>
				<td><input name="parameter4" type="text" placeholder="输入参数4"
					value="${dictionary.parameter4}" class="input"></td>
			</tr>
			<tr>
				<td class="tablecolor">参数5</td>
				<td><input name="parameter5" type="text" placeholder="输入参数5"
					value="${dictionary.parameter5}" class="input"></td>
				<td class="tablecolor">参数6</td>
				<td><input name="parameter6" type="text" placeholder="输入参数6"
					value="${dictionary.parameter6}" class="input"></td>
			</tr>
			<!--<tr>
				<td class="tablecolor">是否公开</td>
				<td>
					<dic:html nodeId="sys_if_open" name="saveType" type="select"/>
				</td>

				 <td>是否缓存</td>
				<td>
					<dic:html nodeId="sys_if_cache" name="cache" type="select"/>
				</td> 
			</tr>-->
			<!-- <tr><td colspan="4">
			     <button onclick="save();" class="button" type="button">提交</button>
			      <button onclick="cancel();" class="button" type="button">返回</button>
			</td>
			</tr> -->
		</table>
		</div></div>
	</div>
	<div class="formmsg" style="margin-top: 300px;">
		<span id="formmsg"></span>
	</div>
	<div class="butdiv">
		<button class="button" onclick="sub();" type="button">提交</button>
		<button onclick="cancel();" class="button" type="button">返回</button>
	</div>
</form>
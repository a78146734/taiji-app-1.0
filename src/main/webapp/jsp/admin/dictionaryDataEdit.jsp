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

$(function(){
	$("#saveType").val('${dictionaryData.saveType}');
});
	function save(){
	var path="${base}";
	 $("#forms").attr("action", path+"/dictionaryData/edit").submit(); 
}	

function cancel(){
	 var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
                        parent.layer.close(index);
}	
</script>
	<form id="forms" class="forms" action="<%=basePath%>/dictionaryData/edit" method="post">
<div style="padding: 3px;">
<div class="user_manage">
			<div class="user_list">
		<table  class="gridtable04" style="width: 100%;">
				<tr>
			<td style="width:13%" class="tablecolor">所属节点:</td>
			<td>
			<c:choose>
							<c:when test="${empty dictionaries}">
								<input type="text" placeholder=""
									class="easyui-validatebox span2 input" data-options="required:true"
									value="${dictionaryName}" readonly="readonly">
									<input type="hidden" name="dictionaryId" value="${dictionaryId}">
							</c:when>
							<c:otherwise>
								<select name="dictionaryId" class="easyui-combobox input"
									data-options="width:140,height:29,editable:false,panelHeight:'auto'">
									<c:forEach var="item" items="${dictionaries}"
										varStatus="status">
										<option value="${item.dictionaryId}">${item.nodeName}</option>
									</c:forEach>
								</select>
							</c:otherwise>
						</c:choose>
						</td>
				<td style="width:13%" class="tablecolor">数据名称</td>
				<td>
				<input name="dictionaryDataId" type="hidden"   value="${dictionaryData.dictionaryDataId}"/>
				<input name="dictionaryDataName" type="text" datatype="*1-18" errormsg="数据名称至少1位任意字符,最多18位字符！" placeholder="输入数据名称" class="input"  value="${dictionaryData.dictionaryDataName}"/></td>
				</tr>
		<tr>
				<td class="tablecolor">排序</td>
				<td><input name="seq"  datatype="n1-6" errormsg="序号至少1位数字,最多6位数字！" type="text" placeholder="输入节点名称" class="input"  value="${dictionaryData.seq}"/></td>
			</tr> 
				<tr>
					<td class="tablecolor">参数1</td>
					<td><input name="parameter1" type="text" placeholder="输入参数1" value="${dictionaryData.parameter1}"
						class="input"></td>
					<td class="tablecolor">参数2</td>
					<td><input name="parameter2" type="text" placeholder="" value="${dictionaryData.parameter2}"
						class="input"></td>
				</tr>
				<tr>
					<td class="tablecolor">参数3</td>
					<td><input name="parameter3" type="text" placeholder="" value="${dictionaryData.parameter3}"
						class="input"></td>
					<td class="tablecolor">参数4</td>
					<td><input name="parameter4" type="text" placeholder="" value="${dictionaryData.parameter4}"
						class="input"></td>
				</tr>
				<tr>
					<td class="tablecolor">参数5</td>
					<td><input name="parameter5" type="text" placeholder="" value="${dictionaryData.parameter5}"
						class="input"></td>
					<td class="tablecolor">参数6</td>
					<td><input name="parameter6" type="text" placeholder="" value="${dictionaryData.parameter6}"
						class="input"></td>
				</tr>
		</table>
		</div></div>
</div>
<div class="formmsg" style="margin-top:230px;">
		<span id="formmsg" ></span>
	</div>
	<div class="butdiv">
		<button class="button" type="submit">提交</button>
		<button onclick="cancel();" class="button" type="button">返回</button>
	</div>
	</form>
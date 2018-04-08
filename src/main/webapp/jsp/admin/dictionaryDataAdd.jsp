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
	function save(){
	var path="${base}";
	 $("#forms").attr("action", path+"/dictionaryData/add").submit(); 
}	

function cancel(){
	 var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
                        parent.layer.close(index);
}	
</script>
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
	<form id="forms" class="forms" action="<%=basePath%>/dictionaryData/add" method="post">
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
				<!-- 
				<td>
				<input type="text" placeholder="请输入角色名称" class="input"
						value="根节点" readonly="readonly">
				</td> -->
				<td style="width:13%" class="tablecolor">数据名称</td>
				<td>
				<input name="dictionaryDataName" type="text" datatype="s1-18" errormsg="序号至少1位字符,最多18位字符！" placeholder="输入数据名称" class="input"/></td>
				</tr>
		<tr>
				<td class="tablecolor">排序</td>
				<td><input name="seq" value="0" type="text" datatype="n1-6" errormsg="序号至少1位数字,最多6位数字！" placeholder="输入节点名称" class="input"/></td>
				<td></td><td></td>
			</tr> 
				<tr>
					<td class="tablecolor">参数1</td>
					<td><input name="parameter1" type="text" placeholder="输入参数1"
						class="input"></td>
					<td class="tablecolor">参数2</td>
					<td><input name="parameter2" type="text" placeholder=""
						class="input"></td>
				</tr>
				<tr>
					<td class="tablecolor">参数3</td>
					<td><input name="parameter3" type="text" placeholder=""
						class="input"></td>
					<td class="tablecolor">参数4</td>
					<td><input name="parameter4" type="text" placeholder=""
						class="input"></td>
				</tr>
				<tr>
					<td class="tablecolor">参数5</td>
					<td><input name="parameter5" type="text" placeholder=""
						class="input"></td>
					<td class="tablecolor">参数6</td>
					<td><input name="parameter6" type="text" placeholder=""
						class="input"></td>
				</tr>
			<!-- <tr><td colspan="4">
			     <button onclick="save();" class="button" type="button">提交</button>
			      <button onclick="cancel();" class="button" type="button">返回</button>
			</td>
			</tr> -->
		</table>
		</div></div>
</div>
<div class="formmsg" style="margin-top: 225px;">
		<span id="formmsg" ></span>
	</div>
	<div class="butdiv">
		<button class="button" type="submit">提交</button>
		<button onclick="cancel();" class="button" type="button">返回</button>
	</div>
	</form>
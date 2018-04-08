<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%
String id = "";
if(request.getParameter("id")!=null&&request.getParameter("id")!=""){
	id = (String)request.getParameter("id");
}else{
	out.println("没有接受到主键的错误");
}
%>
<!DOCTYPE html>
<html>
<head>
<title>用户管理</title>
<meta charset="UTF-8">
<%@ include file="../../commons/global.jsp"%>
<%@ include file="../../commons/basejs.jsp"%>
<link rel="stylesheet"
	href="${base }/static/adminModule/rightPage/css/biaodancss.css">
<style type="text/css">
</style>
</head>
<body>
	
		<div class="hj_username" id="search">
		<input data-condition="eq" name="dictionaryId" type="hidden" value="<%=id%>" class="hj_usernameinp">
			<span class='hj_mar20'>
			<button onclick="addFun();"	class="button" type="button">添加</button>&nbsp;
			<button onclick="back();"	class="button" type="button">返回</button></span>
		</div>

		<div class="hj_user">
			<table class="gridtable03" style="width: 100%;">
				<tr>
					<th style="width: 5%;">序号</th>
					<th style="width: 5%;">排序号</th>
					<th style="width: 10%;">数据名称</th>
					<th style="width: 10%;">参数一</th>
					<th style="width: 25%;">操作</th>
				</tr>
				<tbody id="tb">

				</tbody>
			</table>
		</div>
	<form id="form1">
		<div class="page">
			<%@ include file="../../commons/page.jsp"%>
		</div>
	</form>
	
</body>

<script type="text/javascript">
var saveType = <dic:html nodeId="sys_if_open" name="saveType" type="json" />;
$(function(){
	$("#dictionaryId").val("${id}");
	doQuery();
});

function Query(){
	$("[name=nowpage]").val("1");
	doQuery();
}

//查询执行方法
function doQuery(){
	var condition=new Array();
	$('#search').find("input").each(function(i,obj){
		var val=$(obj).val();
		if(val!=null&&val!=''){
			if($(obj).attr("name")=="dictionaryId"){
				var conditionItem={
						name:$(obj).attr("name"),
						value:$(obj).val(),
						condition:$(obj).data("condition")
					}
			}else{
				var conditionItem={
						name:$(obj).attr("name"),
						value:"%"+$(obj).val()+"%",
						condition:$(obj).data("condition")
					}
			}
			
			condition.push(conditionItem);
		}
	});
	
	//转换分页信息到param
	var params = swichPageInfo(condition);
	$.ajax({
 		type: "post",
 		url: "<%=basePath%>/dictionaryData/dataGrid",
 		data: JSON.stringify(params),
 		contentType: "application/json; charset=utf-8",
 		async: true,
 		dataType: "json",
 		success: function(data){
 			data=data.obj;
 			pageValue(data);
 			var sb = new StringBuilder();
              $.each(data.rows,function(i,obj){ 
	  			 sb.append("<tr id='").append(obj.dictionaryDataId).append("'><td>"+(++i)+"</td>");
	  			 sb.append("<td>").append(obj.seq).append("</td>");
	  			 sb.append("<td>").append(obj.dictionaryDataName).append("</td>");
	  			 sb.append("<td>").append(obj.parameter1).append("</td>");
	  			 sb.append("<td>");
	  			 sb.append("  <i class='icon icon-pencil hj_bianji'></i><span class='hj_mar20'><a  onclick='editFun(\"").append(obj.dictionaryDataId).append("\");'>编辑</a></span> <i class='icon icon-remove-sign hj_delete'></i><span class='hj_mar20'><a  onclick='deleteFun(\"").append(obj.dictionaryDataId).append("\");'>删除</a></span></td>");
	  			 sb.append("</tr>");
	  		 });
 			 $("#tb").html(sb.toString());
 		}
	});
}
//新增
	function addFun() {
	layer.open({
		  type: 2,
		  title: '新增字典',
		  shadeClose: true,
		  shade: 0.5,
		  shadeClose: true,
		  maxmin: true, //开启最大化最小化按钮
		  area: ['80%', '80%'],
		  /* btn:['取消'],
		  yes:function(index ,layero){
 
			  layer.close(index);
		  }, */
		  

		  content: "<%=basePath%>/dictionaryData/addPage?id=<%=id%>",
		  end: function () {
 
				location.reload()
			}
		}); 
}

	//新增
	/* function detailFun(id) {
		window.location.href = '${path }/dictionaryData/manager?id=' + id;
} */

	//编辑
	function editFun(id) {
	layer.open({
		  type: 2,
		  title: '编辑',
		  shadeClose: true,
		  shade: 0.5,
		  shadeClose: true,
		  maxmin: true, //开启最大化最小化按钮
		  area: ['80%', '80%'],
		  /* btn:['取消'],
		  yes:function(index ,layero){
 
			  layer.close(index);
		  }, */
		  

		  content: "<%=basePath%>/dictionaryData/editPage?id="+id,
		  end: function () {
			  
				location.reload()
			}
		}); 
}

//编辑
	<%-- function grantFun(obj) {
	layer.open({
		  type: 2,
		  title: '授权',
		  shadeClose: true,
		  shade: 0.8,
		  shadeClose: true,
		  maxmin: true, //开启最大化最小化按钮
		  area: ['60%', '45%'],
		  /* btn:['取消'],
		  yes:function(index ,layero){
 
			  layer.close(index);
		  }, */
		  

		  content: "<%=basePath%>/user/grantPage?id="+obj.parentNode.parentNode.parentNode.id
		}); 
} --%>

//删除
function deleteFun(id){
  if(confirm("确定要删除此字典数据吗？删除后不可恢复")){
	$.ajax({
 		type: "post",
 		url: "<%=basePath%>/dictionaryData/delete",
 		data:{
 			"id":id
 		},
 		async: false,
 		dataType: "json",
 		success: function(data){
	 			if(data.success){
	 				layer.msg(data.msg, {time: 1000,icon: 1},function() {
	 					doQuery();
					});	
	 			}else{
	 				layer.msg(data.msg, {time: 1000,icon: 2});
	 			}
	 		}
		});
	}
}

//返回
function back(){
	location.href=basePath+"/jsp/admin/dictionary.jsp";
	//window.history.go(-1);
}
</script>
</html>
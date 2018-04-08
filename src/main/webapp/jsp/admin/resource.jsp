<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>资源管理</title>
<meta charset="UTF-8">
<%@ include file="../../commons/global.jsp"%>
<%@ include file="../../commons/xw/basejs.jsp"%>
<link rel="stylesheet"
	href="${base }/static/adminModule/rightPage/css/biaodancss.css">
<style type="text/css">
</style>
</head>
<body>
	
		<div class="hj_username" id="search">
			<span class="hj_usertxtname">资源名称：</span> <span><input
				name="resourceName" data-condition="like" type="text" value=""
				class="hj_usernameinp"> <input id="parentId" data-condition="eq"
				name="parentId" type="text" hidden="hidden" value="0"
				class="hj_usernameinp"> </span> <span><button
					onclick="Query();" class="button" type="button">查询</button></span>
			<shiro:hasPermission name='puriew/add'>
				<span><button onclick="addFun();" class="button"
						type="button">新增</button></span>
			</shiro:hasPermission>
			<span class='hj_mar21'><button onclick="returnMain();"
					class="button" type="button">主菜单</button></span> <span class='hj_mar21'><button
					onclick="back();" class="button" type="button">返回</button></span>
		</div>

		<div class="hj_user">
			<table class="gridtable03" style="width: 100%;">
				<tr>
					<th style="width: 5%;">序号</th>
					<!-- <th style="width: 40px;">排序</th> -->
					<th style="width: 20%;">资源名称</th>
					<th style="width: 35%;">资源路径</th>
					<th style="width: 10%;">图标</th>
					<th style="width: 5%;">资源类型</th>
					<!-- <th style="">上级资源ID</th> -->
					<th style="width: 5%;">状态</th>
					<th style="width: 20%;">操作</th>
				</tr>
				<tbody id="tb">

				</tbody>
			</table>
		</div>
	<form id="form1">
		<div class="page">
			<%@ include file="../../commons/xw/page.jsp"%>
		</div>
	</form>
</body>

<script type="text/javascript">
$(function(){
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
			if($(obj).attr("name")=="parentId"){
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
 		url: "<%=basePath%>/resource/treeGrid",
 		data: JSON.stringify(params),
 		contentType: "application/json; charset=utf-8",
 		async: true,
 		dataType: "json",
 		success: function(data){ 	
 			data=data.obj;
 			pageValue(data);
 			var tb = new StringBuilder();
              $.each(data.rows,function(i,obj){ 
	  			 tb.append("<tr id='").append(obj.resourceId).append("'><td>").append(++i).append("</td>");
	  			/*  tb.append("<td>").append(obj.seq).append("</td>"); */
	  			 if(obj.saveType == 1) {
	  				tb.append("<td>").append(obj.resourceName).append("</td>");
	  			 }else if(obj.saveType == 0){
	  			 tb.append("<td><span class='hj_mar20'><a onclick='childQuery(\""+obj.resourceId+"\");'>").append(obj.resourceName).append("</a></span></td>");
	  			 }
	  			 tb.append("<td>").append(obj.resourceUrl).append("</td>");
	  			 
	  			 tb.append("<td>").append(obj.iconCls).append("</td>");
	  			 tb.append("<td>").append(obj.saveType=='0'?'菜单':'按钮 ').append("</td>");
	  			 //tb += "<td>"+obj.parentId+"</td>";
	  			 tb.append("<td>").append(obj.usingState=='0'?'启用':'停用').append("</td>");
	  			 tb.append("<td>");
	  			 
	  			 tb.append("<shiro:hasPermission name='puriew/checkDetails'>");
	  			 tb.append("<a  onclick='select(\"").append(obj.resourceId).append("\");'><i class='icon icon-search hj_bianji'></i><span class='hj_mar20'>查看详情</span></a>");
	  			 tb.append("</shiro:hasPermission>");
	  			 
	  			 tb.append("<shiro:hasPermission name='puriew/edit'>");
	  			 tb.append("<a  onclick='editFun(\"").append(obj.resourceId).append("\");'><i class='icon icon-pencil hj_bianji'></i><span class='hj_mar20'>编辑</span></a>");
	  			 tb.append("</shiro:hasPermission>");
	  			 
	  			 
	  			 tb.append("<shiro:hasPermission name='puriew/delete'>");
	  			 tb.append("<a  onclick='deleteFun(\"").append(obj.resourceId).append("\");'><i class='icon icon-remove-sign hj_delete'></i><span class='hj_mar20'>删除</span></a>");
	  			 tb.append("</shiro:hasPermission>");
	  			 
	  			 tb.append("</td></tr>");
	  		 });
 			 $("#tb").html(tb.toString());
 		}
	});
} 

//编辑
function childQuery(id) {
	 $("#parentId").val(id);
	 Query();
}
//回到首页		
function returnMain(){
	location.href=basePath+"/jsp/admin/resource.jsp";
}
//返回上一级
function back(){
	if($("#parentId").val()=="0"){
		returnMain();
	}else{
		var condition=new Array();
		$('#search').find("input").each(function(i,obj){
			var val=$(obj).val();
			if(val!=null&&val!=''){
				if($(obj).attr("name")=="parentId"){
					var conditionItem={
							name:"parentId",
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
	//	var params = $("#form1").serialize();
		$.ajax({
	 		type:"post",
	 		url: "<%=basePath%>/resource/back",
	 		data: JSON.stringify(params),
	 		contentType: "application/json; charset=utf-8",
	 		async: true,
	 		dataType: "json",
	 		success: function(data){
	 			data=data.obj;
	 			pageValue(data);
	 			var tb = new StringBuilder();
	              $.each(data.rows,function(i,obj){ 
	            	  $("#parentId").val(obj.parentId);
	 	  			 tb.append("<tr id='").append(obj.resourceId).append("'><td>").append(++i).append("</td>");
	 	  			 //tb.append("<td>").append(obj.seq).append("</td>");
	 	  			 if(obj.saveType == 1) {
	 	  				tb.append("<td>").append(obj.resourceName).append("</td>");
	 	  			 }else if(obj.saveType == 0){
	 	  			 tb.append("<td><span class='hj_mar20'><a onclick='childQuery("+obj.resourceId+");'>").append(obj.resourceName).append("</a></span></td>");
	 	  			 }
	 	  			 tb.append("<td>").append(obj.resourceUrl).append("</td>");
	 	  			 
	 	  			 tb.append("<td>").append(obj.iconCls).append("</td>");
	 	  			 tb.append("<td>").append(obj.saveType=='0'?'菜单':'按钮 ').append("</td>");
	 	  			 //tb += "<td>"+obj.parentId+"</td>";
	 	  			 tb.append("<td>").append(obj.usingState=='0'?'启用':'停用').append("</td>");
	 	  			 tb.append("<td>");
	 	  			 
	 	  			 tb.append("<shiro:hasPermission name='puriew/edit'>");
	 	  			 tb.append("<a  onclick='editFun(").append(obj.resourceId).append(");'><i class='icon icon-pencil hj_bianji'></i><span class='hj_mar20'>编辑</span></a>");
	 	  			 tb.append("</shiro:hasPermission>");
	 	  			 
	 	  			 
	 	  			 tb.append("<shiro:hasPermission name='puriew/delete'>");
	 	  			 tb.append("<a  onclick='deleteFun(").append(obj.resourceId).append(");'><i class='icon icon-remove-sign hj_delete'></i><span class='hj_mar20'>删除</span></a>");
	 	  			 tb.append("</shiro:hasPermission>");
	 	  			 
	 	  			 tb.append("</td></tr>");
	              });
	 			 $("#tb").html(tb.toString());
	 		}
		});
	}
}
//新增
	function addFun() {
	layer.open({
		  type: 2,
		  title: '新增',
		  shadeClose: true,
		  shade: 0.5,
		  shadeClose: true,
		  maxmin: true, //开启最大化最小化按钮
		  offset: '50px',
		  area: ['70%', '420px'],
		  /* btn:['取消'],
		  yes:function(index ,layero){
 
			  layer.close(index);
		  }, */
		  content: "<%=basePath%>/resource/addPage",
		  end: function () {
				doQuery();
			}
		}); 
}
	//编辑
	function editFun(id) {
	layer.open({
		  type: 2,
		  title: '编辑',
		  shadeClose: true,
		  shade: 0.5,
		  shadeClose: true,
		  maxmin: true, //开启最大化最小化按钮
		  area: ['80%', '70%'],
		  /* btn:['取消'],
		  yes:function(index ,layero){
 
			  layer.close(index);
		  }, */
		  content: "<%=basePath%>/resource/editPage?id="+id,
		  end: function () {
				doQuery();
			}
		}); 
}
//删除
function deleteFun(id) {
	layer.confirm('确定要删除此资源吗？删除与之关联的权限都将不能使用！', {
		  btn: ['确定','取消'] //按钮
		}, function(){
			
			$.ajax({
		 		type: "post",
		 		url: "${base}/resource/delete",
		 		data: {"id":id},
		 		async: true,
		 		dataType: "json",
		 		beforeSend: function (){},  
	        	complete : function() {},
		 		success: function(data){
		 			if(data.success)		
		 				layer.msg(data.msg, {time: 1000,icon: 1},function(){
		 					doQuery();
		 				});	 
		 			else{
		 				layer.msg(data.msg, {time: 1000,icon: 2});
		 			}
		 		}
			});
		}, function(){
	//		layer.msg('取消', {icon: 1});
		});
}

function select(id){
	layer.open({
		  type: 2,
		  title: '详情页面',
		  shadeClose: true,
		  shade: 0.5,
		  shadeClose: true,
		  maxmin: true, //开启最大化最小化按钮
		  area: ['80%', '60%'],
	  	  content: "<%=basePath%>/jsp/admin/resourceInfo.jsp?id="+id
	}); 
}
</script>
</html>
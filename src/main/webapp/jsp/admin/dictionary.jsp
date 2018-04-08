<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>用户管理</title>
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
			    <span class="hj_usertxtname">名称：</span> <span><input
				data-condition="like" name="nodeName" type="text" value="" class="hj_usernameinp">
			</span>    
			<span class="hj_usertxtname">字典标识符：</span> <span><input
				data-condition="like" name="nodeId" type="text" value="" class="hj_usernameinp"></span>
			 <span>
			 <button onclick="Query();" class="button" type="button">查询</button></span>
			<shiro:hasPermission name="dictionary/add">
			<span class='hj_mar20'><button onclick="addFun();"
					class="button" type="button">新增</button></span>
			</shiro:hasPermission>
		</div>

		<div class="hj_user">
			<table class="gridtable03" style="width: 100%;">
				<tr>
					<th style="width: 5%;">序号</th>
					<!-- <th style="width: 5%;">排序</th> -->
					<th style="width: 10%;">名称</th>
					<th style="width: 10%;">字典标识符</th>
					<!-- <th style="width: 10%;">公开</th> -->
					<th style="width: 25%;">操作</th>
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
//字典json
var saveType = <dic:html nodeId="sys_if_open" name="saveType" type="json" />;
var cache = <dic:html nodeId="sys_if_cache" name="cache" type="json" />;
$(function(){
	doQuery();
});

function Query(){
	$("[name=nowpage]").val("1");
	doQuery();
}

function QueryNow(nowPage){
	$("[name=nowpage]").val(nowPage);
	doQuery();
}

//查询执行方法
function doQuery(){
	var condition=new Array();
	$('#search').find("input").each(function(i,obj){
		var val=$(obj).val();
		if(val!=null&&val!=''){
			var conditionItem={
					name:$(obj).attr("name"),
					value:"%"+$(obj).val()+"%",
					condition:$(obj).data("condition")
			}
			condition.push(conditionItem);
		}
	});
	
	//转换分页信息到param
	var params = swichPageInfo(condition);
	$.ajax({
 		type: "post",
 		url: "<%=basePath%>/dictionary/dataGrid",
 		data: JSON.stringify(params),
 		contentType: "application/json; charset=utf-8",
 		async: true,
 		dataType: "json",
 		success: function(data){
 			data=data.obj;
 			pageValue(data);
 			var sb = new StringBuilder();
              $.each(data.rows,function(i,obj){ 
	  			 sb.append("<tr id='").append(obj.dictionaryId).append("'><td>").append(++i).append("</td>");
	  			// sb.append("<td>").append(obj.seq).append("</td>");
	  			 sb.append("<td>").append(obj.nodeNames).append("</td>");
	  			 sb.append("<td>").append(obj.nodeId).append("</td>");
	  			/*  sb.append("<td>").append(saveType[obj.saveType]).append("</td>");  */ 
	  			 sb.append("<td>");
	  			
	  			 sb.append("<shiro:hasPermission name='dictionaryData/manager'>");
	  			 sb.append("<a  onclick='select(\"").append(obj.dictionaryId).append("\");'><i class='icon icon-search hj_bianji'></i><span class='hj_mar20'>查看详情</span></a>");
	  			 sb.append("</shiro:hasPermission>");
	  			 
	  			 sb.append("<shiro:hasPermission name='dictionaryData/manager'>");
	  			 sb.append("<a  onclick='detailFun(\"").append(obj.dictionaryId).append("\");'><i class='icon icon-search hj_bianji'></i><span class='hj_mar20'>字典数据管理</span></a>");
	  			 sb.append("</shiro:hasPermission>");
	  			 
	  			 sb.append("<shiro:hasPermission name='dictionary/edit'>");
	  			 sb.append("<a  onclick='editFun(\"").append(obj.dictionaryId).append("\");'><i class='icon icon-pencil hj_bianji'></i><span class='hj_mar20'>编辑</span></a>");
	  			 sb.append("</shiro:hasPermission>");
	  			 
	  			 sb.append("<shiro:hasPermission name='dictionary/edit'>");
	  			 sb.append("<a  onclick='deleteFun(\"").append(obj.dictionaryId+"\");'><i class='icon icon-remove-sign hj_delete'></i><span class='hj_mar20'>删除</span></a>");
	  			 sb.append("</shiro:hasPermission>");
	  			 
	  			 sb.append("</td></tr>");
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
			  offset: '50px',
		  	  area: ['70%', '420px'],
			  /* btn:['取消'],
			  yes:function(index ,layero){
	 
				  layer.close(index);
			  }, */
		  

		  content: "<%=basePath%>/dictionary/addPage",
		  end: function () {
				Query();
			}
		}); 
	}

	//新增
	function detailFun(id) {
		window.location.href = '${path }/dictionaryData/manager?id=' + id;
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
		  offset: '50px',
		  area: ['70%', '420px'],
		  /* btn:['取消'],
		  yes:function(index ,layero){
 
			  layer.close(index);
		  }, */
		  

		  content: "<%=basePath%>/dictionary/editPage?id="+id,
		  end: function () {
			  
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
	layer.confirm("确定要删除此权限吗？删除后不可恢复!", {
		  btn: ['确定','取消'] //按钮
		}, function(){
			isnowpage=$("[name=nowpage]").val();
			$.ajax({
		 		type: "get",
		 		url: "<%=basePath%>/dictionary/delete",
		 		data: {
		 			"id":id,
		 			"isnowpage":isnowpage  
		 		},
		 		async: true,
		 		dataType: "json",
		 		beforeSend: function (){},  
	        	complete : function() {},
		 		success: function(data){
		 			if(data.success){
		 				layer.msg(data.obj.msg, {time: 1000,icon: 1},function() {
							QueryNow(data.obj.isnowpage);
						});	
		 			}else{
		 				layer.msg(data.obj.msg, {time: 1000,icon: 2});
		 			}
		 		}
			});
			
			//setTimeout("location.reload()",2000); 
			
		//  layer.msg('删除成功', {icon: 1});
		}, function(){
	//		layer.msg('取消', {icon: 1});
		});
 <%--  if(confirm("删除后不可恢复，确定要删除吗？")){
		$.ajax({
	 		type: "get",
	 		url: "<%=basePath%>/dictionary/delete",
	 		data:{
	 			"id":id
	 		},
	 		async: false,
	 		dataType: "text",
	 		success: function(data){
	 			var das = JSON.parse(data); 
	 			if(das.success){
	 				doQuery();
	 			}else{
	 				alert("删除失败");
	 			}
		 	}
		});
	} --%>
};
//查看详情
function select(id){
	layer.open({
		  type: 2,
		  title: '详情页面',
		  shadeClose: true,
		  shade: 0.5,
		  shadeClose: true,
		  maxmin: true, //开启最大化最小化按钮
		  offset: '50px',
		  area: ['70%', '420px'],
	  	  content: "<%=basePath%>/jsp/admin/dictionaryInfo.jsp?id="+id
	}); 
}

</script>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>权限管理</title>
<meta charset="UTF-8">
<%@ include file="../../commons/global.jsp"%>
<%@ include file="../../commons/xw/basejs.jsp"%>
<link rel="stylesheet" href="${base }/static/adminModule/rightPage/css/biaodancss.css">
<style type="text/css">

</style>
</head>
<body >
	
	<div  class="hj_username" id="search">
			<input name="saveType" type="hidden" data-condition="eq" value="0" class="hj_usernameinp">
           <span class="hj_usertxtname" >权限名称：</span>
           <span><input name="puriewName" type="text" data-condition="like" value="" class="hj_usernameinp"> </span>
           
           <span class="hj_usertxtname" >表达式：</span>
           <span><input name="expression" type="text" data-condition="like" value="" class="hj_usernameinp"> </span>
           
           <span><button onclick="Query();" class="button" type="button">查询</button></span>
           <!-- <i class='icon icon-plus hj_bianji'></i> -->
           <shiro:hasPermission name='puriew/add'>
           <span class='hj_mar20'><button onclick="addFun();" class="button" type="button"
				>新增</button></span>
		   </shiro:hasPermission>
    </div>
	<!-- <div  class="hj_username">
           <i class='icon icon-plus hj_bianji'></i><span class='hj_mar20'><a onclick="addFun();" href="javascript:void(0);"
				>添加</a></span> 
    </div> -->
	<div class="hj_user">
		<table class="gridtable03" style="width: 100%;">
			 <tr>
               <th style="width: 5%;">序号</th>
               <!-- <th style="width: 10%;">排序</th> -->
               <th style="width: 20%;">权限名称</th>
               <th style="width: 30%;">表达式</th>
               <th style="width: 20%;">权限标识符</th>
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
			if($(obj).attr("name")=="saveType"){
				var conditionItem={
						name:$(obj).attr("name"),
						value:$(obj).val(),
						condition:$(obj).data("condition")
					}
				condition.push(conditionItem);
			}else{
				var conditionItem={
					name:$(obj).attr("name"),
					value:"%"+$(obj).val()+"%",
					condition:$(obj).data("condition")
				}
				condition.push(conditionItem);
			}
		}
	});
	
	//转换分页信息到param
	var params = swichPageInfo(condition);
	$.ajax({
 		type: "post",
 		url : "<%=basePath%>/puriew/treeGrid",
 		data: JSON.stringify(params),
 		contentType: "application/json; charset=utf-8",
 		async: true,
 		dataType: "json",
 		success: function(data){
 			data=data.obj;
 			pageValue(data);
 			var sb = new StringBuilder();
              $.each(data.rows,function(i,obj){ 
	  			 sb.append("<tr id='").append(obj.puriewId).append("'><td>").append(++i).append("</td>");
	  			// sb.append("<td>").append(obj.seq).append("</td>");
	  			 sb.append("<td>").append(obj.puriewName).append("</td>");
	  			 sb.append("<td>").append(obj.expression).append("</td>");
	  			 sb.append("<td>").append(obj.code).append("</td>");
	  			 sb.append("<td>");
	  			 sb.append("<shiro:hasPermission name='puriew/checkDetails'>");
	  			 sb.append("<a onclick='select(\"").append(obj.puriewId).append("\");'><i class='icon icon-search hj_bianji'></i><span class='hj_mar20'>查看详情</span></a> ");
	  			 sb.append("</shiro:hasPermission>");
	  			 
	  			 sb.append("<shiro:hasPermission name='puriew/edit'>");
	  			 sb.append("<a  onclick='editFun(this);'><i class='icon icon-pencil hj_bianji'></i><span class='hj_mar20'>编辑</span></a>");
	  			 sb.append("</shiro:hasPermission>");
	  			 
	  			 sb.append("<shiro:hasPermission name='puriew/delete'>");
	  			 if(obj.saveType == 0) {
	  			 	sb.append("<a  onclick='deleteObj(\""+obj.puriewId+"\");'><i class='icon icon-remove-sign hj_delete'></i><span class='hj_mar20'>删除</span></a>");
	  			 } 
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
			  title: '新增权限',
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
			  content: "<%=basePath%>/puriew/addPage",
			  end: function () {
					doQuery();
				}
			}); 
	}

	//编辑
	function editFun(obj) {
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
		  

		  content: "<%=basePath%>/puriew/editPage?id="+obj.parentNode.parentNode.id,
		  end: function () {
				doQuery();
			}
		}); 
	}
	
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
		  	  content: "<%=basePath%>/jsp/admin/puriewInfo.jsp?id="+id
		}); 
	}

//授权
	function grantFun(obj) {
	layer.open({
		  type: 2,
		  title: '授权',
		  shadeClose: true,
		  shade: 0.5,
		  shadeClose: true,
		  maxmin: true, //开启最大化最小化按钮
		  area: ['60%', '45%'],
		  /* btn:['取消'],
		  yes:function(index ,layero){
 
			  layer.close(index);
		  }, */
		  

		  content: "<%=basePath%>/puriew/grantPage?id="+obj.parentNode.parentNode.id,
		  end: function () {
				doQuery();
			}
		}); 
}

//删除
function deleteObj(id){
	layer.confirm("确定要删除此权限吗？删除后不可恢复!", {
		  btn: ['确定','取消'] //按钮
		}, function(){			
			$.ajax({
		 		type: "post",
		 		url: "<%=basePath%>/puriew/delete",
		 		data: {"id":id},
		 		async: true,
		 		dataType: "json",
		 		beforeSend: function (){},  
	        	complete : function() {},
		 		success: function(data){
		 			if(data.success)		
		 				layer.msg(data.msg, {time: 1000,icon: 1},function(){
		 					Query();
		 				});		 
		 			else{
		 				layer.msg(data.msg, {time: 1000,icon: 2});
		 			}
		 		}
			});
			
			//setTimeout("location.reload()",2000); 
			
		//  layer.msg('删除成功', {icon: 1});
		}, function(){
	//		layer.msg('取消', {icon: 1});
		});
 <%--  if(confirm("确定要删除此权限吗？删除后将删除和此权限关联的所有信息")){
	$.ajax({
 		type: "post",
 		url: "<%=basePath%>/puriew/delete",
 		data:{
 			"id":id
 		},
 		async: false,
 		dataType: "json",
 		success: function(data){
 			if(data.success){
 				doQuery();
 			}else{
 				alert("删除失败");
 			}
 		}
		});
	  } --%>
}
</script>
</html>
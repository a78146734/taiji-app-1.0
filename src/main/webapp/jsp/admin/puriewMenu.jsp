<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>权限管理</title>
<meta charset="UTF-8">
<%@ include file="../../commons/global.jsp"%>
<%@ include file="../../commons/basejs.jsp"%>
<link rel="stylesheet" href="${base }/static/adminModule/rightPage/css/biaodancss.css">
<style type="text/css">

</style>
</head>
<body >
	
	<div  class="hj_username" id="search">
			<input name="saveType" type="hidden" data-condition="eq" value="1" class="hj_usernameinp">
           <span class="hj_usertxtname" >权限名称：</span>
           <span><input name="puriewName" type="text" data-condition="like" value="" class="hj_usernameinp"> </span>
           
           <span class="hj_usertxtname" >表达式：</span>
           <span><input name="expression" type="text" data-condition="like" value="" class="hj_usernameinp"> </span>
           
           <span><button onclick="Query();" class="button" type="button">查询</button></span>
           <!-- <i class='icon icon-plus hj_bianji'></i> -->
    </div>
	<!-- <div  class="hj_username">
           <i class='icon icon-plus hj_bianji'></i><span class='hj_mar20'><a onclick="addFun();" href="javascript:void(0);"
				>添加</a></span> 
    </div> -->
	<div class="hj_user">
		<table class="gridtable03" style="width: 100%;">
			 <tr>
               <th style="width: 5%;">序号</th>
              <!--  <th style="width: 10%;">排序</th> -->
               <th style="width: 30%;">权限名称</th>
               <th style="width: 45%;">表达式</th>
               <th style="width: 20%;">权限标识</th>
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
$(function(){
	doQuery();
});

function Query(){
	$("[name=nowpage]").val("1");
	doQuery();
}

//查询执行方法
function doQuery(){
	var condition = new Array();
		$('#search').find("input").each(function(i, obj) {
			var val = $(obj).val();
			if (val != null && val != '') {
				if ($(obj).attr("name") == "saveType") {
					var conditionItem = {
						name : $(obj).attr("name"),
						value : $(obj).val(),
						condition : $(obj).data("condition")
					}
					condition.push(conditionItem);
				} else {
					var conditionItem = {
						name : $(obj).attr("name"),
						value : "%" + $(obj).val() + "%",
						condition : $(obj).data("condition")
					}
					condition.push(conditionItem);
				}
			}
		});

		//转换分页信息到param
		var params = swichPageInfo(condition);
		$.ajax({
			type : "post",
			url : "<%=basePath%>/puriew/listMenuPurs",
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
	  			 //sb.append("<td>").append(obj.seq).append("</td>");
	  			 sb.append("<td>").append(obj.puriewName).append("</td>");
	  			 sb.append("<td>").append(obj.expression).append("</td>");
	  			 sb.append("<td>").append(obj.code).append("</td>");
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
			  title: '新增权限',
			  shadeClose: true,
			  shade: 0.8,
			  shadeClose: true,
			  maxmin: true, //开启最大化最小化按钮
			  area: ['60%', '80%'],
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
		  shade: 0.8,
		  shadeClose: true,
		  maxmin: true, //开启最大化最小化按钮
		  area: ['60%', '45%'],
		  /* btn:['取消'],
		  yes:function(index ,layero){
 
			  layer.close(index);
		  }, */
		  

		  content: "<%=basePath%>/puriew/editPage?id="+obj.parentNode.parentNode.parentNode.id,
		  end: function () {
				doQuery();
			}
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
		  

		  content: "<%=basePath%>/puriew/grantPage?id="+obj.parentNode.parentNode.parentNode.id,
		  end: function () {
				doQuery();
			}
		}); 
}

//删除
function deleteObj(obj){
  if(confirm("删除权限将关联删除和此权限关联的所有信息，确定要删除吗？")){
	$.ajax({
 		type: "post",
 		url: "<%=basePath%>/puriew/delete",
 		data:{
 			"id":obj.parentNode.parentNode.parentNode.id
 		},
 		async: false,
 		dataType: "json",
 		success: function(data){
 			if(data.success){
 				$(obj).parent().parent().remove();
 				doQuery();
 			}else{
 				alert("删除失败");
 			}
 		}
		});
	  }
}
</script>
</html>
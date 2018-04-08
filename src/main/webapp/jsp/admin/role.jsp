<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>角色管理</title>
<meta charset="UTF-8">
<%@ include file="/commons/global.jsp" %>
<%@ include file="/commons/xw/basejs.jsp" %>
<link rel="stylesheet" href="${base }/static/adminModule/rightPage/css/biaodancss.css">
</head>
<body >
	<form id="form1">
	<div  class="hj_username" id="search">
		<!-- <span class="hj_usertxtname" >id：</span>
		<span><input name="roleId" type="text"  value="" class="hj_usernameinp"> </span>
		 -->
		<span class="hj_usertxtname" >名称：</span>
		<span><input data-condition="like" name="roleName" type="text" value="" class="hj_usernameinp"> </span>
		
		<span class="hj_usertxtname" >标识：</span>
		<span><input  data-condition="like" name="code" class="hj_usernameinp" value="" type="text"  /> </span>
		
		<span class="hj_usertxtname" >描述：</span>
		<span><input data-condition="like" name="describe" class="hj_usernameinp" value="" type="text"  > </span>
		
		<span><button onclick="Query();" class="button" type="button">查询</button></span>
		<!-- <span><button onclick="" class="button" type="reset">重设</button></span> -->
		<shiro:hasPermission name='role/add'>
		<span><button onclick="doAddRole();" class="button" type="button">新增</button></span>
		</shiro:hasPermission>
	</div>
	
	<div class="hj_user">
		<table class="gridtable03" style="width: 100%;">
			<tr>
			<th style="width: 5%;">排序号</th>
		<!-- 	<th style="width: 10%;">id</th> -->
			<th style="width: 15%;">名称</th>
			<th style="width: 15%;">标识</th>
			<th style="width: 20%;">描述</th>
			<th style="width: 35%;">操作</th>
			</tr>
			<tbody id="tb">
			</tbody>
		</table>
	</div>
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
//添加一个角色
function doAddRole(){
	layer.open({
		type: 2,
		title :'添加角色',
		offset: '50px',
		  area: ['70%', '420px'],
		content: ["${base }/role/openAddPage", 'no'],
		end: function () {
			doQuery();
		}
	});
}
function openEditPage(id){
	layer.open({
		type:2,
		offset: '100px',
		area: ['80%', '70%'],
		content:["${base}/role/openEditPage?id="+id,'no'],
		end: function () {
			doQuery();
		}
	});
}
//授权
function openGrantPage(id){
	layer.open({
		type:2,
		title :'角色授权',
		maxmin: true, //开启最大化最小化按钮
		offset: '10px',
		area: ['80%', '520px'],
		content: ["${path }/role/grantPage?id=" + id],
	});
}
//自定义授权点击事件
function grantFunPersonal(id){
	layer.open({
		  type: 2,
		  title: '查看授权状态',
		  shadeClose: true,
		  shade: 0.5,
		  shadeClose: true,
		  maxmin: true, //开启最大化最小化按钮
		  offset: '10px',
		  area: ['80%', '520px'],
		  /* btn:['取消'], */
		  btn1:function(index ,layero){
			  layer.close(index);
		  },
		  content: '<%=basePath%>/role/grantPagePersonal?id='+id
		}); 
}
//删除一个角色，并删除与权限和用户的关联关系
function doDelete(id){
	layer.confirm('确定要删除此角色吗？删除后不可恢复！', {
		time: 0 ,//不自动关闭
		btn: ['确定', '取消'],
		offset: '15%',
		yes: function(index,layero){
			$.post("${base}/role/delete",{id:id},function(result){
				//msg success or fail
				if(result.success){
					layer.msg(result.msg,function(){
						doQuery();
					});
				}else{
					layer.msg(result.msg);
				}
				layer.close(index);
			},'JSON');
		},
		
	});
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
 		url: "${base }/role/dataSelect",
 		data: JSON.stringify(params),
 		contentType: "application/json; charset=utf-8",
 		async: true,
 		dataType: "json",
 		success: function(data){
 			if(pageValue(data)){
 				return;
 			}
 			data=data.obj;
 			pageValue(data);
 			var tb = new StringBuilder();
              $.each(data.rows,function(i,obj){ 
	  			 tb.append("<tr><td>").append(obj.seq).append("</td>");
	  			/*  tb.append("<td>").append(obj.roleId).append("</td>"); */
	  			tb.append("<td>").append(obj.roleName).append("</td>");
	  			tb.append("<td>").append(obj.code).append("</td>");
	  			tb.append("<td>").append(setNull2empty(obj.describe)).append("</td>");
	  			tb.append("<td>");
	  			
	  			tb.append("<shiro:hasPermission name='role/grant'>");
	  			tb.append("<span class='hj_mar20' onclick=\"openGrantPage('").append(obj.roleId).append("')\"><i class='icon icon-leaf hj_bianji'></i>资源授权</span>");
	  			tb.append("<span class='hj_mar20' onclick=\"grantFunPersonal('").append(obj.roleId).append("')\"><i class='icon icon-leaf hj_bianji'></i>自定义权限授权</span>");	  			
	  			tb.append("</shiro:hasPermission>");
	  			
	  			tb.append("<shiro:hasPermission name='role/checkDetails'>");
	  			tb.append("<a href='#' class='hj_mar20' onclick=\"select('").append(obj.roleId).append("')\"><i class='icon icon-search hj_bianji'></i>查看详情</a>");
	  			tb.append("</shiro:hasPermission>");
	  			
	  			tb.append("<shiro:hasPermission name='role/edit'>");
	  			tb.append("<span class='hj_mar20' onclick=\"openEditPage('").append(obj.roleId).append("')\"><i class='icon icon-pencil hj_bianji'></i>编辑</span>");
	  			tb.append("</shiro:hasPermission>");
	  			
	  			tb.append("<shiro:hasPermission name='role/delete'>");
	  			tb.append("<span class='hj_mar20' onclick=\"doDelete('").append(obj.roleId).append("')\"><i class='icon icon-remove-sign hj_delete'></i>删除</span>");
	  			tb.append("</shiro:hasPermission>");
	  			tb.append("</td><tr>");
	  		 });
 			 $("#tb").html(tb.toString());
 		}
	});
}
function setNull2empty(data){
	if(data==null){
		return "";
	}else{
		return data;
	}
}
//查看用户详情
function select(id){
	layer.open({
		  type: 2,
		  title: '详情页面',
		  shadeClose: true,
		  shade: 0.5,
		  shadeClose: true,
		  maxmin: true, //开启最大化最小化按钮
		  area: ['80%', '60%'],
	  	  content: "<%=basePath%>/jsp/admin/roleInfo.jsp?id="+id
	}); 
}

</script>
</html>
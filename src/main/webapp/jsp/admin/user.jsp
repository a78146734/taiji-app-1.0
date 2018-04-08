<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>用户管理</title>
<meta charset="UTF-8">
<%@ include file="../../commons/global.jsp"%>
<%@ include file="../../commons/xw/basejs.jsp"%>
<!--  <link rel="stylesheet" href="${base }/static/adminModule/rightPage/css/biaodancss.css"> -->
<style type="text/css">
</style>
</head>
<body>
	<div class="hj_username" id="search">
		<span class="hj_usertxtname">姓名：</span> <span> <input
			data-condition="like" name="username" type="text" value=""
			class="hj_usernameinp">
		</span> <span class="hj_usertxtname">用户名：</span> <span> <input
			data-condition="like" name="loginName" type="text" value=""
			class="hj_usernameinp">
		</span> <span><button onclick="Query();" class="button" type="button">查询</button></span>
		<shiro:hasPermission name='user/add'>
			<span class='hj_mar20'><button onclick="addFun();"
					class="button" type="button">新增</button></span>
		</shiro:hasPermission>
	</div>
	<div class="hj_user">
		<table class="gridtable03" style="width: 100%;">
			<tr>
				<th style="width: 5%;">序号</th>
				<th style="width: 15%;">姓名</th>
				<th style="width: 10%;">用户名</th>
				<th style="width: 15%;">用户类型</th>
				<th style="width: 10%;">状态</th>
				<th style="width: 20%;"><a id="UPDATETIME" class="tha"
					onclick="sort(this);"><span>创建时间</span><i class="thimg"></i></a></th>
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
	var saveType = <dic:html nodeId="user_type" name="saveType" type="json" />;
	var usingState = <dic:html nodeId="user_state" name="usingState" type="json" />;
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
	 		url: "<%=basePath%>/user/dataGrid",
	 		data: JSON.stringify(params),
	 		contentType: "application/json; charset=utf-8",
	 		async: true,
	 		dataType: "json",
	 		success: function(data){
	 			data=data.obj;
	 			pageValue(data);
	 			var tb = new StringBuilder();
	              $.each(data.rows,function(i,obj){ 
	            	tb.append("<tr id='").append(obj.userId).append("'><td>").append(++i).append("</td>");
		  			tb.append("<td>").append(obj.username).append("</td>");
		  			tb.append("<td>").append(obj.loginName).append("</td>");
		  			tb.append("<td>").append(saveType[obj.saveType]).append("</td>");
		  			tb.append("<td>").append(usingState[obj.usingState]).append("</td>");
	     			tb.append("<td>").append(obj.createTime).append("</td>");
	     			tb.append("<td>");
	     			
	     			tb.append("<shiro:hasPermission name='user/checkDetails'>");
	     			tb.append("<a onclick='select(\"").append(obj.userId).append("\");'><i class='icon icon-search hj_bianji'></i><span class='hj_mar20'>查看详情</span></a> ");
	     			tb.append("</shiro:hasPermission>");
	     			tb.append("<shiro:hasPermission name='user/edit'>");
		  			tb.append("<a  onclick='editFun(\"").append(obj.userId).append("\");'><i class='icon icon-pencil hj_bianji'></i><span class='hj_mar20'>编辑</span></a> ");
		  			tb.append("</shiro:hasPermission>");
		  			tb.append("<shiro:hasPermission name='user/delete'>");
		  			
		  			if(obj.loginName!="admin"){
		  				tb.append("<a  onclick='deleteFun(\"").append(obj.userId).append("\");'><i class='icon icon-remove-sign hj_delete'></i><span class='hj_mar20'>删除</span></a>");
		  			}
		  			tb.append("</shiro:hasPermission>");
		  			tb.append("</td></tr>");
		  		 });
	 			 $("#tb").html(tb.toString());
	 		}
		});
	}
	//新增
	function addFun() {
		layer.open({
			  type: 2,
			  title: '新增用户',
			  shadeClose: true,
			  shade: 0.5,
			  shadeClose: true,
			  maxmin: true, //开启最大化最小化按钮
			  offset: '10px',
			  area: ['90%', '550px'],
			  style:'overflow:auto',
			  content: "<%=basePath%>/user/addPage",
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
			  shade: 0.8,
			  shadeClose: true,
			  maxmin: true, //开启最大化最小化按钮
			  offset: '10px',
			  area: ['90%', '550px'],
			  style:'overflow:auto',
			  content: "<%=basePath%>/user/editPage?id="+id,
			  end: function () {
					doQuery();
				}
			}); 
	}
	//删除
	function deleteFun(id) {
		layer.confirm('您是否要删除此用户吗？删除后不可恢复！', {
			  btn: ['确定','取消'] //按钮
			}, function(){
				
				$.ajax({
			 		type: "post",
			 		url: "${base}/user/delete",
			 		data: {"id":id},
			 		async: true,
			 		dataType: "json",
			 		beforeSend: function () {},  
		        	complete : function() {},
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
			}, function(){
		//		layer.msg('取消', {icon: 1});
			});
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
			  offset: '50px',
			  area: ['70%', '420px'],
		  	  content: "<%=basePath%>/jsp/admin/userInfo.jsp?id="+id
		}); 
	}
</script>
</html>
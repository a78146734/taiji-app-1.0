<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../../commons/global.jsp"%>
<%@ include file="../../commons/xw/basejs.jsp"%>
<meta http-equiv="X-UA-Compatible" content="edge" />
<title>机构管理</title>

</head>
<body >
	<form id="form1">
	<div  class="hj_username" id="search">
           <span class="hj_usertxtname" >部门名称：</span>
           <span><input id="organName" name="organName" data-condition="like" type="text"  value="" class="hj_usernameinp"> </span>
          <!--  <input id="organId" name="organId" type="hidden" value="" data-condition="like" class="hj_usernameinp"> -->
           <input id="parentId" name="parentId" type="hidden" data-condition="eq" value="0"  class="hj_usernameinp">
          <!--  <span class="hj_usertxtname" >开始时间：</span>
           <span><input name="startTime" class="Wdate hj_usernameinp" value="" type="text" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})" readonly="readonly" /> </span>
           
           <span class="hj_usertxtname" >结束时间：</span>
           <span><input name="endTime" class="Wdate hj_usernameinp" value="" type="text" onfocus="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'});"  > </span>
            -->
           <span><button onclick="Query();" class="button" type="button">查询</button></span>
           <shiro:hasPermission name='organization/add'>
            <span><button onclick="addFun();" class="button" type="button">新增</button></span>
            </shiro:hasPermission>
            <span class='hj_mar21'><button onclick="returnMain();" class="button" type="button">主菜单</button></span>
            <span class='hj_mar21'><button onclick="back();" class="button" type="button">返回</button></span>
    </div>
	
	 
	
	<div class="hj_user">
		<table class="gridtable03" style="width: 100%;">
			 <tr>
               <th style="width: 5%;">序号</th>
               <th style="width: 15%;">部门名称</th>
              <!--  <th style="width: 5%;">排序</th> -->
               <th style="width: 15%;">图标</th>
               <th style="width: 15%;">创建时间</th>
               <th style="width: 5%;">地址</th>
               <th style="width: 40%;">操作</th>
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
	Query();
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
 		url: "<%=basePath%>/organization/treeGrid",
 		data: JSON.stringify(params),
 		contentType: "application/json; charset=utf-8",
 		async: true,
 		dataType: "json",
 		success: function(data){
 			data=data.obj;
 			pageValue(data);
 			var tb = new StringBuilder();
              $.each(data.rows,function(i,obj){ 
            	 tb.append("<tr><td>").append(++i).append("</td>");
      //      	 tb.append("<td>").append(obj.organName).append("</td>");
            	 tb.append("<td><span class='hj_mar20'><a  onclick='childQuery(\""+obj.organId+"\");'>").append(obj.organName).append("</a></span></td>");
	  		/* 	tb.append("<td>").append(obj.seq).append("</td>"); */
	  			tb.append("<td>").append(obj.icon).append("</td>");
	  			tb.append("<td>").append(obj.createTime).append("</td>");
	  			tb.append("<td>").append(obj.address).append("</td>");
	  			tb.append("<td>");
	  			
	  			tb.append("<shiro:hasPermission name='organization/grant'>");
	  			tb.append("<a href='#' class='hj_mar20' onclick='grantFun(\"").append(obj.organId).append("\")'><i class='icon icon-search hj_bianji'></i>资源授权</a>");
	  			tb.append("<a href='#' class='hj_mar20' onclick='grantFunPersonal(\"").append(obj.organId).append("\")'><i class='icon icon-search hj_bianji'></i>自定义权限授权</a>");
	  			tb.append("</shiro:hasPermission>");
	  			
	  			tb.append("<shiro:hasPermission name='organization/userPage'>");
	  			tb.append("<a href='#' class='hj_mar20' onclick='personFun(\"").append(obj.organId).append("\")'><i class='icon icon-info-sign hj_bianji'></i>部门人员</a>");
	  			tb.append("</shiro:hasPermission>");
	  			
	  			tb.append("<shiro:hasPermission name='organization/checkDetails'>");
	  			tb.append("<a href='#' class='hj_mar20' onclick='select(\"").append(obj.organId).append("\")'><i class='icon icon-search hj_bianji'></i>查看详情</a> ");
	  			tb.append("</shiro:hasPermission>");
	  			
	  			tb.append("<shiro:hasPermission name='organization/edit'>");
	  			tb.append("<a href='#' class='hj_mar20' onclick='editFun(\"").append(obj.organId).append("\")'><i class='icon icon-pencil hj_bianji'></i>编辑</a> ");
	  			tb.append("</shiro:hasPermission>");
	  			
	  			tb.append("<shiro:hasPermission name='organization/delete'>");
	  			tb.append("<a href='#' class='hj_mar20' onclick='deleteFun(\"").append(obj.organId).append("\")'><i class='icon icon-remove-sign hj_delete'></i>删除</a>");
	  			tb.append("</shiro:hasPermission>");
	  			tb.append("</td><tr>");
	  		 });
 			$("#tb").html(tb.toString());
 		}
	});
}

//返回上一级
function back(){
	if($("#parentId").val()=="0"){
		returnMain();
	}else{ 
		var params = $("#form1").serialize();
		$.ajax({
	 		type: "post",
	 		url: "<%=basePath%>/organization/back",
	 		data:params,
	 		async: true,
	 		dataType: "json",
	 		success: function(data){
	 			data=data.obj;
	 			if(data!=null){
	 				$("#parentId").val(data.parentId);
		 			doQuery()
	 			}else{
	 				/* $("#parentId").val(""); */
	 				Query();
	 			}
	 			//pageValue(data);
	 			//alert(data.parentId)
	 			/* var tb = new StringBuilder();
	              $.each(data.rows,function(i,obj){ 
	            	  $("#organId").val(obj.parentId);
	            	 tb.append("<tr><td>").append(++i).append("</td>");
	      //      	 tb.append("<td>").append(obj.organName).append("</td>");
	            	 tb.append("<td><span class='hj_mar20'><a  onclick='childQuery("+obj.organId+");'>").append(obj.organName).append("</a></span></td>");
		  //			tb.append("<td>").append(obj.seq).append("</td>");
		  			tb.append("<td>").append(obj.icon).append("</td>");
		  			tb.append("<td>").append(obj.createTime).append("</td>");
		  			tb.append("<td>").append(obj.address).append("</td>");
		  			
		  			tb.append("<td>");
		  			tb.append("<shiro:hasPermission name='organization/grant'>");
		  			tb.append("<a href='#' class='hj_mar20' onclick='grantFun(").append(obj.organId).append(")'><i class='icon icon-search hj_bianji'></i>资源授权</a>");
		  			tb.append("<a href='#' class='hj_mar20' onclick='grantFunPersonal(").append(obj.organId).append(")'><i class='icon icon-search hj_bianji'></i>自定义权限授权</a>");
		  			tb.append("</shiro:hasPermission>");
		  			
		  			tb.append("<shiro:hasPermission name='organization/userPage'>");
		  			tb.append("<a href='#' class='hj_mar20' onclick='personFun(").append(obj.organId).append(")'><i class='icon icon-info-sign hj_bianji'></i>部门人员</a>");
		  			tb.append("</shiro:hasPermission>");
		  			
		  			tb.append("<shiro:hasPermission name='organization/edit'>");
		  			tb.append("<a href='#' class='hj_mar20' onclick='editFun(").append(obj.organId).append(")'><i class='icon icon-pencil hj_bianji'></i>编辑</a> ");
		  			tb.append("</shiro:hasPermission>");
		  			
		  			tb.append("<shiro:hasPermission name='organization/delete'>");
		  			tb.append("<a href='#' class='hj_mar20' onclick='deleteFun(").append(obj.organId).append(")'><i class='icon icon-remove-sign hj_delete'></i>删除</a>");
		  			tb.append("</shiro:hasPermission>");
		  			tb.append("</td></tr>");
		  		 });
	             
	 			 $("#tb").html(tb.toString()); */
	 		}
		});
	}	
}

function childQuery(id) {
	 $("#parentId").val(id);
	Query();
}
function returnMain(){
	location.href=basePath+"/organization/manager";
}
<%-- function grantFun(id){
	layer.open({
		  type: 2,
		  title: '查看授权状态',
		  shadeClose: true,
		  shade: 0.8,
		  shadeClose: true,
		  maxmin: true, //开启最大化最小化按钮
		  area: ['60%', '70%'],
		  content: '<%=basePath%>/organization/grantPage?id='+id
		}); 
} --%>
function grantFun(id){
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

		  content: '<%=basePath%>/organization/grantPage?id='+id
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
		  beforeSend : function() {
			},
			complete : function() {
			},
		  maxmin: true, //开启最大化最小化按钮
		  offset: '10px',
		  area: ['80%', '520px'],
		  /* btn:['取消'], */
		  btn1:function(index ,layero){
			  layer.close(index);
		  },

		  content: '<%=basePath%>/organization/grantPagePersonal?id='+id
		}); 
}


function addFun(){
	layer.open({
		  type: 2,
		  title: '添加部门信息',
		  shadeClose: true,
		  shade: 0.5,
		  shadeClose: true,
		  maxmin: true, //开启最大化最小化按钮
		  offset: '50px',
		  area: ['80%', '420px'],
		  /* btn:['取消'], */
		  yes:function(index ,layero){

			  layer.close(index);
		  },
		  

		  content: '<%=basePath%>/organization/addPage',
		  end: function () {
	//		  setTimeout("location.reload()",2000); 
			  location.reload()
          }
		}); 
}
function editFun(id) {
	layer.open({
		  type: 2,
		  title: '编辑部门信息',
		  shadeClose: true,
		  shade: 0.5,
		  shadeClose: true,
		  maxmin: true, //开启最大化最小化按钮
		  offset: '50px',
		  area: ['80%', '420px'],
		  /* btn:['取消'], */
		  yes:function(index ,layero){
 
			  layer.close(index);
			  
		  },
		  content: '<%=basePath%>/organization/editPage?id='+id,
		  end: function () {
		//	  setTimeout("location.reload()",2000); 
			  doQuery();
          }
		}); 
}

function deleteFun(id) {
	layer.confirm('确定删除此部门吗？删除后不可恢复!', {
		  btn: ['确定','取消'] //按钮
		}, function(){			
			$.ajax({
		 		type: "post",
		 		url: "${base}/organization/delete",
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
			
			//setTimeout("location.reload()",2000); 
			
		//  layer.msg('删除成功', {icon: 1});
		}, function(){
	//		layer.msg('取消', {icon: 1});
		});
}

function personFun(id) {
	layer.open({
		  type: 2,
		  title: '部门人员信息',
		  shadeClose: true,
		  shade: 0.5,
		  shadeClose: true,
		  maxmin: true, //开启最大化最小化按钮
		  offset: '50px',
		  area: ['95%', '480px'],
		  /* btn:['取消'], */
		  yes:function(index ,layero){
 
			  layer.close(index);
		  },
		  

		  content: '<%=basePath%>/organization/userPage?id='+id,
		  end: function () {
		//	  setTimeout("location.reload()",2000); 
	//		location.reload()
          }
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
	  	  content: "<%=basePath%>/jsp/admin/organizationInfo.jsp?id="+id
	}); 
}

</script>
</html>
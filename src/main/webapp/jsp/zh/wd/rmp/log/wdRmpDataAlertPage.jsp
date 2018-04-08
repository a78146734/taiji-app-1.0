<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<%@include file="../../../../../commons/global.jsp"%>
	<%@include file="../../../../../commons/xw/basejs.jsp"%>
		<!-- <script type="text/javascript" src="js/wdRmpAppServiceLogList.js"></script>
			<link rel="stylesheet" type="text/css" href="css/wdRmpAppServiceLogList.css"> -->
		<link rel="stylesheet" href="${staticPath }/static/ztree/css/demo.css" type="text/css">
	<link rel="stylesheet" href="${staticPath }/static/ztree/css/zTreeStyle/zTreeStyle.css" type="text/css">
<style type="text/css">
body {
	min-width: 1250px;
}
</style>		
</head>
<body >
	<form id="form1">
			<div class="user_manage">
			<p class="ri_jczctitle">
				<span class="ri_jczctitletxt">服务告警详情</span> <span
					class="ri_jczctitlemore"></span>
			</p>
			<div class="hj_username">
			<div class="hj_username1">
					<span>&nbsp;&nbsp;<button onclick="alertDetail();" class="button" type="button" style="width:150px">历史调用失败日志</button></span>
				<span>&nbsp;&nbsp;<button onclick="back();" class="button" type="button">返回</button></span>
				</div>
				</div>
				</div>
		<div id="content" class="row-fluid">
			<div class="col-md-2 col-sm-2 col-lg-2" style="min-width: 150px;">
				<ul id="treeDemo" class="ztree"></ul>
			</div>
			<div class="col-md-10 col-sm-10 col-lg-10">
				<div class="panel-body">
					<table id="tb_departments" class="gridtable04 " style="display:none">
					<tr>
						<td class="tablecolor">服务ID：</td>
						<td id=servicePublishInfoId></td>
						<td class="tablecolor">服务状态：</td>	
						<td id="status" style='color:red'></td>
					</tr>
					<tr>
						<td class="tablecolor">服务名称：</td>
						<td id="name"></td>
						<td class="tablecolor">服务版本：</td>
						<td id="version"></td>
					</tr>
					<tr>
						<td class="tablecolor">目标服务：</td>
						<td id="url"></td>
						<td class="tablecolor">发布路径：</td>
						<td id="path"></td>
					</tr>
					<tr>
						<td class="tablecolor">服务注册时间：</td>
						<td id="publishDate"></td>
						<td class="tablecolor">服务有效期：</td>
						<td id="offlineDate"></td>
					</tr>
					<tr>
						<td class="tablecolor">服务所属应用：</td>
						<td id="providerApp"></td>
						<td class="tablecolor">服务协议类型：</td>
						<td id="protocol"></td>
					</tr>
					<tr>
						<td class="tablecolor">服务方法：</td>
						<td id="method"></td>
						<td class="tablecolor">服务描述：</td>
						<td id="description"></td>
					</tr>		
					
					</table>
				</div>
			</div>
		</div>
	</form>

</body>
<script type="text/javascript">
		//初始加载
		$(document).ready(function(){
			searchServices();
			
			
		 	//设置初始化排序字段
		 	//initSort("数据库字典列名","desc");
		 	//doQuery();
		});
		
		//点击查询
		function Query(){
			$("[name=pageNo]").val("1");
			$("[name=nowpage]").val("1");
			doQuery();
		}
		
		//查询执行方法
		function doQuery(){
			var params = $("#form1").serialize();
			/* $.ajax({
		 		type: "post",
		 		url: basePath+"/wdRmpAppDataServiceLog/alertList",
		 		data:params,
		 		async: false,
		 		dataType: "text",
		 		success: function(data){
		 			var das = JSON.parse(data); 
		 			if(pageValue(das.obj)){return;}
		 			var sb = new StringBuilder();
		              $.each(das.obj.rows,function(i,obj){ 
		            		 	});
		 			 $("#tb").html(sb.toString());	 			 
		 		}
 			}); */
		}
		
		
		function update(id){
			location.href=basePath+"/jsp/zh/wd/rmp/log/wdRmpAppDataServiceLogUpdate.jsp?id="+id;
		}
		
		function select(id){
			location.href=basePath+"/jsp/zh/wd/rmp/log/wdRmpAppDataServiceLogDetail.jsp?id="+id;
		}
		
		function add(){
			location.href=basePath+"/jsp/zh/wd/rmp/log/wdRmpAppDataServiceLogAdd.jsp";
		}	
		
		function del(id){
			$.ajax({
		 		type: "get",
		 		url: basePath+"/wdRmpAppServiceLog/delete",
		 		data:{
		 			"id":id
		 		},
		 		async: true,
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
		}
	 
		function back() {
			history.back(1);
		}
		
		function alertDetail(){
			location.href = basePath + "/dataAnalysis/alertDetailPage";
		}
		

		var treeObj;
		//var treeObj2;
		var zNodes =[ ];
		var setting = {	
				data: {
					simpleData: {
						enable: true,
						idKey:"id",
						pIdKey:"pid"
					}
				},
				view: {
					selectedMulti:false
				},
				callback:{
					onClick:showServiceInfo
				}
				
		};
		
		function searchServices(){	 
			$.ajax({
		 		type: "post",
		 		url: basePath+"/dataAnalysis/serviceAlert",
		 		data: {"id" : "${pid}"},
		 		async: true,
		 		dataType: "json",
		 		success: function(data){	 
	 				treeObj = $.fn.zTree.init($("#treeDemo"), setting, data);
	 				treeObj.expandAll(true); 				
	 				if(treeObj.getNodes().length<1){
	 					layer.msg('没有告警服务，请继续保持！', {
	 						icon: 6, time: 2000
	 					});
	 				}
		 		}
			});		
		}
		
		function showServiceInfo(){		
			var treeObj1=$.fn.zTree.getZTreeObj("treeDemo");
            var nodes=treeObj1.getSelectedNodes(true);
        	
            if(nodes[0].level != 0){
            	$("#tb_departments").show();
        	$.ajax({
				type : "get",
				url : basePath + "/WdSspAipServiceMange/selectByPrimaryKey",
				data:{
		 			"id":nodes[0].id
		 		},
				async : false,
				dataType : "text",
				success : function(data) {
			//		console.log(data);
					var das = JSON.parse(data);
					if(pageValue(das.obj)){return;}
					$("#servicePublishInfoId").html(das.obj.service.publishes[0].servicePublishInfoId);
					$("#status").html(das.obj.status.label);
					$("#publishDate").html(das.obj.service.publishes[0].publishDate);	
					$("#providerApp").html(das.obj.providerApp.name);
					$("#name").html(das.obj.name);
					if(das.obj.offlineDate =="" || das.obj.offlineDate == null){
						$("#offlineDate").html("永久");
					}else{
						$("#offlineDate").html(das.obj.offlineDate);
					}
					$("#version").html(das.obj.version);
					$("#url").html(das.obj.url);
					$("#path").html(das.obj.service.publishes[0].path);
					$("#method").html(das.obj.method);
					$("#protocol").html(das.obj.protocol);
					$("#description").html(das.obj.description);
					 
				}
			});
		}
		}
		
	</script>
</html>
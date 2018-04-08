<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp"%>
<%@ include file="/commons/basejs.jsp"%>
<!DOCTYPE html>
<HTML>
<HEAD>
	<TITLE>角色授权</TITLE>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" href="${staticPath }/static/ztree/css/demo.css" type="text/css">
	<link rel="stylesheet" href="${staticPath }/static/ztree/css/zTreeStyle/zTreeStyle.css" type="text/css">
	<%-- <script type="text/javascript" src="${staticPath }/static/ztree/js/jquery.ztree.core.js"></script>
	<script type="text/javascript" src="${staticPath }/static/ztree/js/jquery.ztree.excheck.js"></script> --%>
	<SCRIPT type="text/javascript">

	$(document).ready(function(){
		searchOrg();
		//searchPur();
		$().click(function showCheckTree(){
			
		});
	});
	var treeObj;
	//var treeObj2;
	var zNodes =[];	
	//初始化树状图
	function searchOrg(){	 
		$.ajax({
	 		type: "post",
	 		url: "${base}/resource/allTree",
	 		async: true,
	 		dataType: "json",
	 		success: function(data){	 			  
 				treeObj = $.fn.zTree.init($("#treeDemo"), setting, data);
 				treeObj.expandAll(true); 				
 			  	$.ajax({
 			 		type: "post",
 			 		url: "${base}/role/resourceIds",
 			 		data: {"roleId":'${id}'},
 			 		async: true,
 			 		dataType: "json",
 			 		success: function(data2){	 		
 			 			for (var i=0, l=data2.obj.length; i < l; i++) {
 			 				treeObj.checkNode(treeObj.getNodeByParam( "id",data2.obj[i] ), true); 			 				
 			 			}
 			 			showCheckTree();
 			 		}
 				});  
	 		}
		});		
	}

/* 	function searchPur(){		 
		$.ajax({
	 		type: "post",
	 		url: "${base}/puriew/allPurTree",
	 		data: {"organId":'${id}'},
	 		async: true,
	 		dataType: "json",
	 		beforeSend: function(){},
            complete: function(){},
	 		success: function(data){	 			  
	 			treeObj2 = $.fn.zTree.init($("#treeDemo2"), setting, data);
	 			treeObj2.expandAll(true);	 				
	  			  	$.ajax({
	 			 		type: "post",
	 			 		url: "${base}/organization/purIds",
	 			 		data: {"organId":'${id}'},
	 			 		async: true,
	 			 		dataType: "json",
	 			 		success: function(data2){	
	 			 			for (var i=0, l=data2.obj.length; i < l; i++) {
	 			 				treeObj2.checkNode(treeObj2.getNodeByParam( "id",data2.obj[i] ), true);
	 			 			}
	 			 		}
	 				});  	 			 
	 		}
		});
	}  */
	
	var setting = {	
			check: {
				enable: true,
				chkboxType: { "Y": "p", "N": "s" }
			},			
			data: {
				simpleData: {
					enable: true,
					idKey:"id",
					pIdKey:"pid",
					rootPId:null
				}
			},
			callback:{
				onCheck:showCheckTree
			}
			
	};
	
	var setting2 = {	
			
	/* 		callback:{
				onCheck:showCheckTree
			}, */
			data: {
				simpleData: {
					enable: true,
					idKey:"id",
					pIdKey:"pid",
					rootPId:null
				}
			}
			
	};
	//提交		
	function Grant(){
           var nodes=treeObj.getCheckedNodes(true);
           var resourceIds = "";
           
           /* var nodes2=treeObj2.getCheckedNodes(true);
           var purIds = ""; */
           
           for(var i=0;i<nodes.length;i++){           
           //alert(nodes[i].id); //获取选中节点的值
           	resourceIds += nodes[i].id+ ",";
           }
           
           /* for(var i=0;i<nodes2.length;i++){
               	purIds += nodes2[i].id+ ",";
           } */ 
           $.ajax({
	 		type: "post",
	 		url: "${base}/role/grant",
	 		data: {"id":"${id}","resourceIds":resourceIds},
	 		async: true,
	 		dataType: "json",
	 		success: function(data){
	 			if(data.success){
	 				parent.layer.msg(data.msg, {time: 1000,icon: 1});	
	 	           parent.layer.closeAll('iframe');
	 			}
	 			else{
	 				parent.layer.msg(data.msg, {time: 1000,icon: 2});	
	 	           parent.layer.closeAll('iframe');
	 			}
	 		}
		});
     }
	//返回
	function cancel(){
		parent.layer.closeAll('iframe');	
	}
	//全选
	function checkAll(){
		treeObj.checkAllNodes(true);
		//treeObj2.checkAllNodes(true);
		showCheckTree();
	}
	//反选
	function checkInverse(){
    	var nodes = treeObj.getCheckedNodes(true);
		var unNodes = treeObj.getCheckedNodes(false);
		
    	/* var nodes2 = treeObj2.getCheckedNodes(true);
		var unNodes2 = treeObj2.getCheckedNodes(false); */
		
    	for ( var i = 0; i < nodes.length; i++) {
			treeObj.checkNode(nodes[i],false,true);
		}
		for ( var i = 0; i < unNodes.length; i++) {
			treeObj.checkNode(unNodes[i],true,false);
		}
		
     	/* for ( var i = 0; i < nodes2.length; i++) {
			treeObj2.checkNode(nodes2[i],false,true);
		}
		for ( var i = 0; i < unNodes2.length; i++) {
			treeObj2.checkNode(unNodes2[i],true,false);
		}  */
		showCheckTree();
	}	
	
	//右侧显示选中的资源	
	function showCheckTree(){
		$("#treeDemo2").empty();		
		var treeObjShow=treeObj.getCheckedNodes(true);
		var rIds="";
		rIds =treeObjShow[0].id;
        for(var i=1;i<treeObjShow.length;i++){        	
        	rIds += ","+treeObjShow[i].id;
        };
        showAjax(rIds);		
	}
	
	//右侧显示ajax
	function showAjax(obj){
		$.ajax({
	 		type: "post",
	 		url: "${base}/resource/getTreeByResourceIds",
	 		data: {resourceIds:obj},
	 		async: true,
	 		dataType: "json",
	 		success: function(data){	 			  
 				var treeObjDemo2 = $.fn.zTree.init($("#treeDemo2"), setting2, data);
 				treeObjDemo2.expandAll(true); 
 				var treeObjChecked=treeObjDemo2.getCheckedNodes(true);		
 		        for(var i=1;i<treeObjChecked.length;i++){        	
 		        	zTree.getNodeByParam("id",treeObjChecked[i].id);
 		        };
	 		}
		});
	}

	</SCRIPT>

</HEAD>

<BODY>
	<div class="content_wrap" style="width: 100%;">
		<table class="gridtable03" style="width: 100%;">
			<tr>
				<td>资源权限树
					<div class="zTreeDemoBackground left">
						<ul id="treeDemo" class="ztree"></ul>
					</div>
				</td>
				<td>
					<div class="hj_username" style="text-align: center;">
						<button onclick="checkAll();" class="button" type="button">全选</button>
					</div>
					<div class="hj_username" style="text-align: center;">
						<button onclick="checkInverse();" class="button" type="button">反选</button>
					</div>
				</td>
				
				<td>已选权限
					<div class="zTreeDemoBackground left">
						<ul id="treeDemo2" class="ztree"></ul>
					</div>
				</td>


				<!-- <td>自定义权限
					<div class="zTreeDemoBackground right">
						<ul id="treeDemo2" class="ztree"></ul>
					</div>
				</td> -->


			</tr>
		</table>
		<div class="hj_username" style="text-align: center;">
			<button onclick="Grant();" class="button" type="button">提交</button>
			<button onclick="cancel();" class="button" type="button">取消</button>
		</div>
	</div>

</BODY>
</HTML>
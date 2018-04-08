<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/global.jsp"%>
<%@ include file="../../commons/xw/basejs.jsp"%>
<!DOCTYPE html>
<HTML>
<HEAD>
	<TITLE>部门添加</TITLE>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" href="${staticPath }/static/ztree/css/demo.css" type="text/css">
	<link rel="stylesheet" href="${staticPath }/static/ztree/css/zTreeStyle/zTreeStyle.css" type="text/css">
	<style type="text/css">
		body{
			min-width: 600px;
		}
	</style>
<script type="text/javascript">
$(document).ready(function(){
	$("#saveType").val(${organization.saveType});
	searchOrg();
	
	//$.fn.zTree.init($("#treeDemo"), setting, zNodes);
});

var zNodes =[];
var setting = {	
		view: {
			dblClickExpand: false
		},
		data: {
			simpleData: {
				enable: true,
				idKey:"id",
				pIdKey:"pid",
				rootPId:null
			}
		},
		callback: {
			beforeClick: beforeClick,
			onClick: onClick
		}
		
};
		function searchOrg(){
			$.ajax({
		 		type: "post",
		 		url: "${base}/organization/tree",
		 		async: true,
		 		dataType: "json",
		 		success: function(data){
		 			var treeObj = $.fn.zTree.init($("#treeDemo"), setting, data.obj);
		 			treeObj.expandAll(true);
		 			loadTreeNode("${organization.parentId}");
		 		}
			});
			
			
		}
		
		function beforeClick(treeId, treeNode) {
	//		var check = (treeNode && !treeNode.isParent);
	//		if (!check) alert("只能选择根节点...");
			var check = treeNode;
			return check;
		}
		
		function onClick(e, treeId, treeNode) {
/* 			var zTree = $.fn.zTree.getZTreeObj("treeDemo"),
			nodes = zTree.getSelectedNodes(),
			v = "";
			nodes.sort(function compare(a,b){return a.id-b.id;});
			for (var i=0, l=nodes.length; i<l; i++) {
				v += nodes[i].name + ",";
			}
			if (v.length > 0 ) v = v.substring(0, v.length-1);
			var organObj = $("#organSel");
			organObj.attr("value", v); //ctrl多选
*/
			if(treeNode){
				var organObj = $("#organSel");
				var selPidObj = $("#selPid");
				organObj.attr("value", treeNode.name);
				selPidObj.attr("value", treeNode.id);
				hideMenu();
			}
		}

		function showMenu() {
			var organObj = $("#organSel");
			var organOffset = $("#organSel").offset();
			$("#menuContent").css({left:organOffset.left + "px", top:organOffset.top + organObj.outerHeight() + "px"}).slideDown("fast");

			$("body").bind("mousedown", onBodyDown);
		}
		function hideMenu() {
			$("#menuContent").fadeOut("fast");
			$("body").unbind("mousedown", onBodyDown);
		}
		function onBodyDown(event) {
			if (!(event.target.id == "menuBtn" || event.target.id == "menuContent" || $(event.target).parents("#menuContent").length>0)) {
				hideMenu();
			}
		}
	
		function Edit(){
			var params = $("#organizationEditForm").serialize();
              $.ajax({
		 		type: "post",
		 		url: "${base}/organization/edit",
		 		data:  params,
		 		async: true,
		 		dataType: "json",
		 		beforeSend: function (){},  
	        	complete : function() {},
		 		success: function(data){
		 			if(data.success)
		 				parent.layer.msg(data.msg, {time: 1000,icon: 1});	
		 			else{
		 				parent.layer.msg(data.msg, {time: 1000,icon: 2});	
		 			}
		 		}
			});
              setTimeout("parent.layer.closeAll('iframe')",2000);  
       }
		
		
		var nodeName = "";
		var nodeId = "";
		function loadTreeNode(id){
			if(id != null && id !=""){
				var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
				var node = treeObj.getNodeByParam("id", id, null);
				if(node!=null){
				nodeName = node.name;
				}
				nodeId = id;
				var organObj = $("#organSel");
				organObj.attr("value", nodeName);
			}
		}
		
		function resetSel(){
			$("#organSel").attr("value",nodeName);
			$("#selPid").attr("value",nodeId);
		}
</script>
</HEAD>
<BODY>

    <form id="organizationEditForm" class="forms" action="<%=basePath%>/organization/edit" method="post">
    <div style="padding: 3px;">
    <div class="user_manage">
			<div class="user_list">
        <table class="gridtable04" style="width: 100%;">
            <tr>
           		<td class="tablecolor" style="width: 17%" >部门名称<span class="tdmsg">*</span></td>
                <td style="width: 33%"><input name="name" type="text" datatype="s1-18" errormsg="部门名称至少1位字符,最多18位字符！"  value="${organization.organName}" placeholder="请输入部门名称" class="input" data-options="required:true" ></td>
          
                <td class="tablecolor">部门描述<span class="tdmsg">*</span></td>
                <td><input name="id" type="hidden"  value="${organization.organId}"><input name="describe" type="text" class="input" datatype="*1-200" placeholder="请输入部门描述"  errormsg="最多输入200个字符！" value="${organization.describe}"/></td>
                  </tr>
            <tr>
                <td class="tablecolor">排序</td>
                <td><input name="seq"  class="input" datatype="/^\s*$/g|n1-6" errormsg="排序至少1位数字,最多6位数字！" value="${organization.seq}" style="widtd: 140px; height: 29px;" required="required" data-options="editable:false"></td>
                <td class="tablecolor">菜单图标</td>
                <td ><input  name="icon" class="input" value="${organization.icon}" datatype="/^\s*$/g|*" errormsg="菜单图标至少1位字符,最多18位字符！"/></td>
            </tr>
            <tr>
                <td class="tablecolor">地址</td>
                <td ><input datatype="/^\s*$/g|*" errormsg="地址至少1位字符,最多18位字符！" name="address" class="input" value="${organization.address}"/></td>
           		<td class="tablecolor">上级部门</td>
                <td >
                <input id="organSel" class="input"  type="text" readonly value="" onclick="showMenu(); return false;" datatype="/^\s*$/g|s1-18" errormsg="上级资源至少1位字符,最多18位字符！"/>&nbsp;
                <input id="selPid" name="pid" class="input" type="hidden" readonly value="${organization.parentId}" />&nbsp;
               <!--  <button id="menuBtn" class="button"  type="button" onclick="showMenu(); return false;">选择</button>&nbsp;
                <button class="button" type="button"  onclick="resetSel()" >重置</button> -->
				</td>
            </tr>
            <tr>
            <td class="tablecolor">状态</td>
                <td >
                	<select id="saveType" name="saveType"  >
                			<option value="1" >启用</option>
							<option value="0" >停用</option>
							
					</select>
                
                </td>
            	
            </tr>
        </table>
        </div></div>
        <br>

</div>
<br> <br>
<div class="formmsg" style="margin-top:130px;">
		<span id="formmsg" ></span>
	</div>
	<div class="butdiv">
		<button class="button" type="submit">提交</button>
		<button onclick="cancel();" class="button" type="button">返回</button>
	</div>
    </form>
<script type="text/javascript">
$(function(){
	//
	$(".forms").Validform({
		tiptype:function(msg,o,cssctl){
			var objtip=$("#formmsg");
			cssctl(objtip,o.type);
			objtip.text(msg);
		},
		ajaxPost:true,
		callback:function(data){
			if(data.success){
 				location.href=basePath + "/jsp/utils/massage/success_gen_close.jsp";
 			}else{
 				location.href=basePath + "/jsp/utils/massage/failure_gen_close.jsp";
 			} 
		}
	});
});
function cancel() {
	 var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
     parent.layer.close(index);
}
</script>
<div id="menuContent" class="menuContent" style="display:none; position: absolute;height:130px;">
	<ul id="treeDemo" class="ztree" style="margin-top:0; width:300px;height:100%;"></ul>
</div>
</BODY>
</HTML>
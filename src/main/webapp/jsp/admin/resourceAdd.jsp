<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/global.jsp"%>
<%@ include file="../../commons/xw/basejs.jsp"%>
	<link rel="stylesheet" href="${staticPath }/static/ztree/css/demo.css" type="text/css">
	<link rel="stylesheet" href="${staticPath }/static/ztree/css/zTreeStyle/zTreeStyle.css" type="text/css">
	<style type="text/css">
		body{
			min-width: 600px;
		}
	</style>
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
</script>

<script type="text/javascript">
	$(document).ready(function(){
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
		 		url: "${base}/resource/treeByMenu",
		 		async: true,
		 		dataType: "json",
		 		success: function(data){
		 			
		 			var treeObj = $.fn.zTree.init($("#treeDemo"), setting, data);
		 			treeObj.expandAll(true);
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
	
		
		function resetSel(){
			$("#organSel").attr("value","");
			$("#selPid").attr("value","");
		}
	function save(){
	var path="${base}";
	 $("#forms").attr("action", path+"/resource/add").submit(); 
	/*  var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
                        parent.layer.close(index); */
}	
	

function cancel(){
	 var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
                        parent.layer.close(index);
}	



function cleanOrganSel(){
	$("#organSel").attr("value","");
	$("#selPid").attr("value","");
}
</script>

<style>
	.icon-remove{
		cursor: pointer;
	}
</style>

<form id="forms" class="forms" action="<%=basePath%>/resource/add" method="post">
<div style="padding: 3px;">
	<div class="user_manage">
			<div class="user_list">
		<table  class="gridtable04" style="width: 100%;">
			<tr>
				<td style="width:17%" class="tablecolor">资源名称<span class="tdmsg">*</span></td>
				<td><input name="name" type="text" datatype="*1-18"  errormsg="请输入1-18位字符"  placeholder="请输入资源名称" class="input"/>
				</td>
				<td style="width:17%" class="tablecolor">资源类型</td>
				<td> <select id="resourceType" name="resourceType"  placeholder="选择资源类型" class="input">
							<option value="0">菜单</option>
                        <option value="1">按钮</option>
                        
				</select> 
				
				<%-- <dic:html dicId="82" name="resourceType" type="select" value="" /> --%></td>
				</tr>
			<tr>	
				<td class="tablecolor">资源路径<span class="tdmsg">*</span></td>
				<td colspan="3" ><input name="url"  type="text" datatype="*1-100"  errormsg="请输入小于100位字符"  placeholder="请输入资源地址" class="input" style="width:470px"/></td>
				 
				
			</tr>
			<tr>
				<td class="tablecolor">上级资源</td>
                <td><!-- <select id="pid" name="pid" type="text" placeholder="请输入菜单图标" class="input"></select> -->
                 
                 <div>
                 	<input id="organSel" class="input" type="text" readonly value="" onclick="showMenu(); return false;"/>&nbsp;
				 	<i class="icon-remove" onclick="cleanOrganSel();"></i>	                 
                 </div>
                
                <input id="selPid" name="pid" class="input" type="hidden" readonly value="" />&nbsp;
                </td>
				<td class="tablecolor">菜单图标</td>
				<td><input name="icon" type="text"  placeholder="请输入菜单图标" class="input"/></td>
			</tr>
			<tr>
			<td class="tablecolor">状态</td>
				<td><select  name="status"  placeholder="选择状态" class="input">
							 <option value="0">启用</option>
                        <option value="1">停用</option>
				</select></td>
				 <td class="tablecolor">排序</td>
				<td><input  name="seq" value="0" datatype="/^\s*$/g|n1-6" errormsg="序号至少1位数字,最多6位数字！" type="text" placeholder="请输入排序号" class="input"/></td>
				
                <!-- <button id="menuBtn" class="button"  type="button" onclick="showMenu(); return false;">选择</button>&nbsp;
                <button class="button" type="button"  onclick="resetSel()" >清空</button>
                 -->	
                </tr>
			<!-- <tr><td colspan="4">
			     <button onclick="save();" class="button" type="button">提交</button>
			      <button onclick="cancel();" class="button" type="button">返回</button>
			</td>
			</tr> -->
			<tr>
				<td class="tablecolor">菜单图片</td>
				<td>
					<input class="input" name="pic" type="text" placeholder="请输入顶部图片名" />
				</td>
			</tr>
		</table>
	</div></div>
	<div id="menuContent" class="menuContent" style="display:none; position: absolute;height:171px">
	<ul id="treeDemo" class="ztree" style="margin-top:0; width:205px;height:100%"></ul>
</div>
<div class="formmsg" style="margin-top: 260px;">
		<span id="formmsg" ></span>
	</div>
	<div class="butdiv">
		<button class="button" type="submit">提交</button>
		<button onclick="cancel();" class="button" type="button">返回</button>
	</div>
</div>
	</form>
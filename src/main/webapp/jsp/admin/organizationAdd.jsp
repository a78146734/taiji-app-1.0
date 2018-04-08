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
		function Add(){
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
		 		url: "${base}/organization/add",
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
</script>
</HEAD>
<BODY>
<form id="organizationAddForm" class="forms" action="<%=basePath%>/organization/add"  method="post">
<div style="padding: 3px;">
	<div class="user_manage">
			<div class="user_list">
        <table class="gridtable04" style="width: 100%;">
            <tr>
            	<td class="tablecolor" style="width: 17%">部门名称<span class="tdmsg">*</span></td>
                <td style="width: 33%"><input name="organName"  type="text" placeholder="请输入部门名称" class="input" data-options="required:true" datatype="s1-18" errormsg="部门至少1位字符,最多18位字符！"></td>
              
                <td class="tablecolor">部门描述<span class="tdmsg">*</span></td>
                <td><input name="describe"  type="text" placeholder="请输入部门描述" datatype="*1-200" errormsg="最多输入200个字符！" class="input" data-options="required:true" ></td>
                  
            </tr>
            <tr>
                <td class="tablecolor">排序</td>
                <td><input name="seq" class="input" datatype="/^\s*$/g|n1-6" errormsg="排序至少1位数字,最多6位数字！"  required="required" data-options="editable:false" value="0"></td>
                <td class="tablecolor">菜单图标</td>
                <td><input  name="icon" class="input" value="icon-folder"/></td>
            </tr>
            <tr>
                <td class="tablecolor">地址</td>
                <td ><input  name="address" datatype="/^\s*$/g|*1-18" errormsg="地址至少1位字符,最多18位字符！"  class="input"  /></td>
            	<td class="tablecolor">上级部门</td>
                <td >
                <input id="organSel" class="input"  type="text" readonly value=""  onclick="showMenu(); return false;"/>
                <input id="selPid" name="parentId" class="input" type="hidden" readonly value="" />
                <!-- <button id="menuBtn" class="button"  type="button" onclick="showMenu(); return false;">选择</button>&nbsp;
                <button class="button" type="button"  onclick="resetSel()" >清空</button> -->
				</td>
            </tr>
            <tr>
            <td class="tablecolor">状态</td>
                <td >
                	<select  name="saveType"  >
                			<option value="1" selected="selected">启用</option>
							<option value="0">停用</option>
							
					</select>
                
                </td>
            	
            </tr>
        </table>
        </div></div>
          <br>
       <!--  <div style = "text-align:center;">
        <button class="button" type="button"  onclick="Add()" >添加</button>
        </div> -->
    
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
function cancel() {
	parent.layer.closeAll('iframe');
}
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
<div id="menuContent" class="menuContent" style="display:none; position: absolute;height:130px;">
	<ul id="treeDemo" class="ztree" style="margin-top:0; width:300px;height:100%;"></ul>
</div>
</BODY>
</HTML>
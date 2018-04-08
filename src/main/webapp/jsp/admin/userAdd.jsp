<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/global.jsp"%>
<%@include file="../../commons/xw/basejs.jsp"%>
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
			overflow: auto;
		}
		
.tdmsg {
	line-height: 30px;
}
	</style>
<script type="text/javascript">
$(document).ready(function(){
	searchOrg();
	searchRole();
	//Query();
	//$.fn.zTree.init($("#treeDemo"), setting, zNodes);
});

var zNodes =[];
var	treeObj1="";
var	treeObj="";
var setting = {	
		check:{
			enable:true,
			 chkboxType : { "Y" : "", "N" : "" }
		},
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
//			beforeClick: beforeClick,
			onCheck:onOrganCheck,
			onClick: onClick
		}
		
};

var setting1 = {
	check:{
		enable:true
	},
	view: {
		dblClickExpand: false
	},
	data: {
		simpleData: {
			enable: true,
			idKey:"id1",
			pIdKey:"pid1",
			rootPId:null
		}
	},
	callback: {
		onClick:onRoleClick,
		onCheck:onCheck
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
		
		function searchRole(){
		 		$.ajax({
			 		type: "post",
			 		url: "${base}/role/tree",
			 		async: true,
			 		dataType: "json",
			 		success: function(data){
			 		    treeObj1 = $.fn.zTree.init($("#treeDemo1"), setting1, data);
		 				treeObj1.expandAll(true);
		 				//var roleIdsList = ${roleIds};
		 				
			 			//loadRoleTreeNode(roleIdsList);
			 		}
				});
		}
		
		
		function onCheck(e, treeId, treeNode){
			var zTree = $.fn.zTree.getZTreeObj("treeDemo1");
			var roleIdStr = "";
			var roleNameStr = "";
			var nodes=zTree.getCheckedNodes(true);
			for(var i=0;i<nodes.length;i++){
				if(nodes[i].checked==true){
					roleIdStr += nodes[i].id + ",";
					roleNameStr += nodes[i].name + ",";
				}
			};
			$("[name='roleIds']").val(roleIdStr);
			$("[name='roleName']").val(roleNameStr);
		}
		
		function onRoleClick(e, treeId1, treeNode1){
			var zTree = $.fn.zTree.getZTreeObj("treeDemo1");
			var roleIds = "";
			var roleName = "";
			checked(0);
			var nodes=zTree.getCheckedNodes(true);
			for(var i=0;i<nodes.length;i++){
				if(nodes[i].checked==true)
					roleIds += nodes[i].id+ ",";
					roleName += nodes[i].name+ ",";
			};
			$("[name='roleIds']").val(roleIds);
			$("[name='roleName']").val(roleName);
		}
		function checked(i){
			var zTree=$.fn.zTree.getZTreeObj("treeDemo1");
			nodes = zTree.getSelectedNodes(true);
			if(nodes[i].checked==true){
				zTree.checkNode(nodes[i],false,true);
			}else{
				zTree.checkNode(nodes[i],true,false);
			}
		
			/* zTree.checkNode(nodes[i],true,false); */
		}
		
		function showMenu1() { 
			var roleObj = $("#roleSel") ;
			var roleOffset = $("#roleSel").offset();
			$("#menuContent1").css({left:roleOffset.left + "px", top:roleOffset.top + roleObj.outerHeight() + "px"}).slideDown("fast");
			$("body").bind("mousedown", onBodyDown1);
		}
		function onBodyDown1(event) {
			if (!(event.target.id == "menuContent1" || $(event.target).parents("#menuContent1").length>0)) {
				hideMenu1();
			}
		}
		function hideMenu1() {
			$("#menuContent1").fadeOut("fast");
			$("body").unbind("mousedown", onBodyDown);
		}	
		
		
		
		function beforeClick(treeId, treeNode) {
	//		var check = (treeNode && !treeNode.isParent);
	//		if (!check) alert("只能选择根节点...");
			var check = treeNode;
			return check;
		}
		
		function onClick(e, treeId, treeNode) {
	//		if(treeNode){
	//			var organObj = $("#organSel");
	//			var selPidObj = $("#selPid");
	//			organObj.attr("value", treeNode.name);
	//			selPidObj.attr("value", treeNode.id);
	//			hideMenu();
	//		}
			var zTree = $.fn.zTree.getZTreeObj("treeDemo");
			var organIds = "";
			var organName = "";
			organChecked(0);
			var nodes=zTree.getCheckedNodes(true);
			for(var i=0;i<nodes.length;i++){
				if(nodes[i].checked==true)
					organIds += nodes[i].id+ ",";
					organName += nodes[i].name+ ",";
			};
			$("#selPid").val(organIds);
			$("#organSel").val(organName);
		}
		function organChecked(i){
			var zTree=$.fn.zTree.getZTreeObj("treeDemo");
			nodes = zTree.getSelectedNodes(true);
			if(nodes[i].checked==true){
				zTree.checkNode(nodes[i],false,true);
			}else{
				zTree.checkNode(nodes[i],true,false);
			}
		
			/* zTree.checkNode(nodes[i],true,false); */
		}
		function onOrganCheck(e, treeId, treeNode){
			var zTree = $.fn.zTree.getZTreeObj("treeDemo");
			var organIds = "";
			var organName = "";
			var nodes=zTree.getCheckedNodes(true);
			for(var i=0;i<nodes.length;i++){
				if(nodes[i].checked==true)
					organIds += nodes[i].id+ ",";
					organName += nodes[i].name+ ",";
			};
			$("#selPid").val(organIds);
			$("#organSel").val(organName);
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
			var params = $("#userAddForm").serialize();
            $.ajax({
		 		type: "post",
		 		url: "${base}/user/add",
		 		data:  params,
		 		async: true,
		 		dataType: "json",
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
		
		function cancel(){
			parent.layer.closeAll('iframe');
		}
</script>
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
function sub(){
			$.ajax({
		 		type: "post",
		 		url: "${base}/user/check",
		 		data:{"loginName":$("#loginName").val()},
		 		async: true,
		 		dataType: "json",
		 		success: function(data){
		 			if(!data.obj){
		 				$("#formmsg").empty();
		 				$("#formmsg").append("用户名已存在");
		 				$("#loginName").css("background","light-pink");
		 				$("#loginName").select();
		 			}else{
		 				$("#userAddForm").submit();
		 			}
		 		}
			});
		}
</script>
</HEAD>
<BODY>
	<form id="userAddForm" class="forms" action="<%=basePath%>/user/add" method="post">
		<div style="padding: 3px;">
		<div class="user_manage">
		<div class="user_list">
		<table  class="gridtable04" style="width: 100%;">
			<tr>
				<td style="width:17%" class="tablecolor">用户名<span class="tdmsg">*</span></td>
				<td style="width:33%"><input id="loginName" value='' name="loginName" type="text" placeholder="请输入登录名" datatype="/^[a-zA-Z0-9_]{4,16}$/" errormsg="请输入符合规范的用户名，由4-16位字母，数字，下划线组成"/></td>
				<td style="width:17%" class="tablecolor">姓名<span class="tdmsg">*</span></td>
				<td><input name="username" type="text" placeholder="请输入姓名"   datatype="s1-18" errormsg="请输入1-18位字符，不能含有特殊符号"/></td>
				</tr>
			<tr>	
				<td class="tablecolor">密码<span class="tdmsg">*</span></td>
				<td><input name="userpassword" type="password" placeholder="输入密码"   datatype="s4-8" errormsg="密码长度为4-8位字符，不能含有特殊符号"/></td>
				<td class="tablecolor">用户类型</td>
				<td><dic:html nodeId="user_type" name="userType" type="select"/>
				<!-- <select  name="userType" type="text" placeholder="选择用户类型" >
							<option value="0">管理员</option>
							<option value="1" selected="selected">用户</option>
				</select> -->
				</td>
			</tr>
			<tr>
				<td class="tablecolor">部门</td>
				<td > 
				<input id="organSel" name="organName" type="text"  onclick="showMenu(); return false;" placeholder="选择部门" readonly/>
				<input id="selPid" name="organIds"  type="hidden" readonly value="" />&nbsp;
                <!-- <button id="menuBtn" class="button"  type="button" onclick="showMenu(); return false;">选择</button>&nbsp;
                <button class="button" type="button"  onclick="resetSel()" >清空</button> -->
				
				</td>			
		 		<td class="tablecolor">角色</td>
				<td >
					<input id="roleSel" name="roleName" type="text"   onclick="showMenu1(); return false;" readonly placeholder="选择角色" />
					<input name="roleIds" type="hidden"    />&nbsp;
				</td>
			</tr>
			
			<tr>
			 <td class="tablecolor">状态<span class="tdmsg">*</span></td>
				<td >
				<%-- <dic:html nodeId="user_state" name="status" type="select" value="" /> --%>
				<select id="status" name="status" datatype="*"  placeholder="选择用户状态" >
				<option  value=""  >--请选择--</option>
							<option value="20255">启用</option>
							<option value="20256" >停用</option>
				</select>
				</td>
				<td class="tablecolor">排序<span class="tdmsg">*</span></td>
					<td><input name="sort" type="text" placeholder="输入序号"   datatype="n1-6" errormsg="序号长度为1-6位数字"/></td>
			</tr>
			<tr>
				<td class="tablecolor">人员生日</td>
				<td>
					<input name="birthDate" class="Wdate hj_usernameinp" value="" placeholder="出生年月日" type="text"
						onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"
						readonly="readonly" />
				</td>
				<td class="tablecolor">性别</td>
				<td>
				<dic:html nodeId="user_sex" name="sex" type="select"/>
					<!-- <select id="sex" name="sex"  placeholder="选择性别"  >
							<option selected="selected" value="1">男</option>
							<option value="2" >女</option>
					</select> -->
				</td>
			</tr>
			<tr>
				<td class="tablecolor">入职时间</td>
				<td>
					<input name="workDate" class="Wdate hj_usernameinp" value="" placeholder="入职年月日" type="text"
						onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"
						readonly="readonly" /></td>
				<td class="tablecolor">人员隶属</td>
				<td><dic:html nodeId="user_belong" name="isXw" type="select"/>
					<!-- <select id="isXw" name="isXw" type="text" placeholder="选择人员隶属" >
							<option selected="selected" value="1">徐圩新区工作人员</option>
							<option value="2" >外部工作人员</option>
					</select> -->
				</td>
				
			</tr>
			<tr>
				<td class="tablecolor">人员分类</td>
				<td ><dic:html nodeId="user_class" name="publicCode" type="select"/>
					<!-- <select id="publicCode" name="publicCode" type="text" placeholder="选择人员分类" >
							<option selected="selected" value="0001">管委会领导</option>
							<option value="0002" >员工</option>
					</select> -->
				</td>
				<td class="tablecolor">手机</td>
				<td><input name="phone" type="text"  placeholder="输入手机号码" /></td>
			</tr>
			<tr>
				<td class="tablecolor">邮箱</td>
				<td ><input name="email" type="text"  placeholder="输入邮箱" /></td>
				<td class="tablecolor">座机</td>
				<td><input name="officePhone" type="text"  /></td>
			</tr>
			<tr>
				<td class="tablecolor">员工号
				<%-- 	<dic:html dicId="63" name="11" type="select" value="2" /> --%>
				</td>
				<td>
					<input id="certId" name="certId" type="text"  placeholder="请输入员工号"     errormsg="请输入正确的员工号"/>
					<input id="privateCode" name="privateCode" type="hidden" style="width:300px;"   value="${priCode}"/>
				</td>
				
			</tr>
			<!-- <tr><td colspan="4">
					
			     <button onclick="Add();" class="button" type="button" >提交</button>
			      <button onclick="cancel();" class="button" type="button">返回</button>
			</td>
			</tr> -->
		</table>
		</div>
		</div>
		<div class="formmsg" style="margin-top: 400px;">
		<span id="formmsg" ></span>
	</div>
	<div class="butdiv">
		<button class="button" type="button" onclick="sub();">提交</button>
		<button onclick="cancel();" class="button" type="button">返回</button>
	</div>
</div>

	</form>

<div id="menuContent" class="menuContent" style="display:none; position: absolute;height:161px;">
	<ul id="treeDemo" class="ztree" style="margin-top:0; width:300px;height:100%"></ul>
</div>
<div id="menuContent1" class="menuContent" style="display:none; position: absolute;height:120px;">
	<ul id="treeDemo1" class="ztree" style="margin-top:0; width:300px;height:100%;"></ul>
</div>
</BODY>
</HTML>
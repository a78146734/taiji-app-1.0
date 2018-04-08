<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/global.jsp"%>
<%@include file="../../commons/xw/basejs.jsp"%>
<!DOCTYPE html>
<HTML>
<HEAD>
	<TITLE>部门编辑</TITLE>
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
	
	Query();
	searchOrg();
	searchRole();
	//$.fn.zTree.init($("#treeDemo"), setting, zNodes);
	
	function isPlaceholder(){
	    var input = document.createElement('input');
	    return 'placeholder' in input;
	}
	if (!isPlaceholder()) {//不支持placeholder 用jquery来完成
	    $(document).ready(function() {
	        if(!isPlaceholder()){
	            $("input").not("input[type='password']").each(//把input绑定事件 排除password框
	                    function(){
	                        if($(this).val()=="" && $(this).attr("placeholder")!=""){
	                            $(this).val($(this).attr("placeholder"));
	                            $(this).focus(function(){
	                                if($(this).val()==$(this).attr("placeholder")) $(this).val("");
	                            });
	                            $(this).blur(function(){
	                                if($(this).val()=="") $(this).val($(this).attr("placeholder"));
	                            });
	                        }
	                    });
	            //对password框的特殊处理1.创建一个text框 2获取焦点和失去焦点的时候切换
	            $("input[type='password']").each(
	                    function() {
	                        var pwdField    = $(this);
	                        var pwdVal      = pwdField.attr('placeholder');
	                        pwdField.after('<input  class="login-input" type="text" value='+pwdVal+' autocomplete="off" style="margin-left:15px;"/>');
	                        var pwdPlaceholder = $(this).siblings('.login-input');
	                        pwdPlaceholder.show();
	                        pwdField.hide();

	                        pwdPlaceholder.focus(function(){
	                            pwdPlaceholder.hide();
	                            pwdField.show();
	                            pwdField.focus();
	                        });

	                        pwdField.blur(function(){
	                            if(pwdField.val() == '') {
	                                pwdPlaceholder.show();
	                                pwdField.hide();
	                            }
	                        });
	                    })
	        }
	    });
	}
	
	
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
			 			
			 			treeObj = $.fn.zTree.init($("#treeDemo"), setting, data.obj);
			 			treeObj.expandAll(true);
	
						var organIdsList = ${organIds};
			 			loadTreeNode(organIdsList);
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
		 				var roleIdsList = ${roleIds};
			 			loadRoleTreeNode(roleIdsList);
			 		}
				});
		}
		function beforeClick(treeId, treeNode) {
	//		var check = (treeNode && !treeNode.isParent);
	//		if (!check) alert("只能选择根节点...");
			var check = treeNode;
			return check;
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
		function onClick(e, treeId, treeNode) {
//			if(treeNode){
//				var organObj= $("#organSel");  
//				var selPidObj = $("#selPid");
//				organObj.attr("value", treeNode.name);
//				selPidObj.attr("value", treeNode.id);
//				hideMenu();
//			}
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
			var organObj = $("#organSel") ;
			var organOffset = $("#organSel").offset();
			$("#menuContent").css({left:organOffset.left + "px", top:organOffset.top + organObj.outerHeight() + "px"}).slideDown("fast");
			$("body").bind("mousedown", onBodyDown);
		}
		
		function hideMenu() {
			$("#menuContent").fadeOut("fast");
			$("body").unbind("mousedown", onBodyDown);
		}
		function onBodyDown(event) {
			if (!(event.target.id == "menuContent" || $(event.target).parents("#menuContent").length>0)) {
				hideMenu();
			}
		}
	
		function Edit(){
			var params = $("#userEditForm").serialize();
              $.ajax({
		 		type: "post",
		 		url: "${base}/user/edit",
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
		
		
		var nodeName = "";
		var nodeId = "";
		function loadTreeNode(organIds){
			if(organIds != null && organIds !=""){
				var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
				
				for(var i=0;i<organIds.length;i++){
					var node = treeObj.getNodeByParam("id", organIds[i], null);
					treeObj.checkNode(node,true);
					nodeName += node.name+",";
					nodeId += node.id+",";
				}
				$("#organSel").attr("value", nodeName);
				$("#selPid").attr("value", nodeId);
			}
		}
		function resetSel(){
			$("#organSel").attr("value",nodeName);
			$("#selPid").attr("value",nodeId);
		}
		
		function Query(){
			var roleIdsList = ${roleIds};
			$("#userType").val('${user.saveType}');
			$("#status").val('${user.usingState}');
			$("#sex").val('${user.sex}');
			$("#publicCode").val('${user.publicCode}');
			$("#isXw").val('${user.isXw}');
			
			/* $.ajax({
		 		type: "post",
		 		url: "${base}/role/tree",
		 		async: true,
		 		dataType: "json",
		 		success: function(data){
		 			$.each(data,function(i,obj){ 
		 				$("#roleIds").append("<option value='"+obj.roleId+"'>"+obj.roleName+"</option>"); 
		 			});	
		 			$("#roleIds").val(roleIdsList[0]);
		 		}
			}); */
			
			
		}
		//////////////////////////////////////////
		function beforeClick1(treeId1, treeNode1) {
	//		var check = (treeNode && !treeNode.isParent);
	//		if (!check) alert("只能选择根节点...");
			var check = treeNode1;
			return check;
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
		var nodeName1 = "";
		var nodeId1 = "";
		/*给已经保存的角色信息赋值  -- anjl -- 2017-05-19 start*/
		function loadRoleTreeNode(roleIds){
			var treeDemo1 = $.fn.zTree.getZTreeObj("treeDemo1");
			if(roleIds != null && roleIds !=""){
				var roleIdStr = "";
				var roleNameStr = "";
				for(var i=0;i<roleIds.length;i++){
					var treeEntry = treeDemo1.getNodeByParam( "id",roleIds[i]);
					treeDemo1.checkNode(treeEntry,true);
					roleIdStr += treeEntry.id+",";
					roleNameStr += treeEntry.name+",";
				}
				$("[name='roleName']").val(roleNameStr);
				$("[name='roleIds']").val(roleIdStr);
			}
		}
		/*给已经保存的角色信息赋值  -- anjl -- 2017-05-19 end*/
		
		function resetSel(){
			$("#roleSel").attr("value",nodeName);
			$("#selPid").attr("value",nodeId);
		}
		/////////////////////////////////////////
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
 				$("#formmsg").empty();
 				$("#formmsg").append(data.msg);
 				$("#certId").css("background","light-pink");
 				$("#certId").select();
 				//location.href=basePath + "/jsp/utils/massage/failure_gen_close.jsp";
 			}
		}
	});
});
</script>
</HEAD>
<BODY>
<form id="userEditForm" class="forms" action="<%=basePath%>/user/edit" method="post">
<div style="padding: 3px;">
<div class="user_manage">
			<div class="user_list">
	<!-- <span>密码不修改请留空。</span> -->
		<table  class="gridtable04" style="width: 100%;">
			<tr>
				<td style="width:17%" class="tablecolor">用户名<span class="tdmsg">*</span></td>
				<td style="width:33%" ><input name="id" type="hidden" value="${user.userId}"  />
				<input name="loginName" value="${user.loginName}" type="text" placeholder="请输入登录名"  readonly="readonly"/></td>
				<td style="width:17%" class="tablecolor">姓名<span class="tdmsg">*</span></td>
				<td><input name="username" value="${user.username}" errormsg="请输入1-18个字符，不能含有特殊符号" datatype="s1-18" type="text"  autocomplete="off"/></td>
				</tr>
			<tr>	
				<td class="tablecolor">密码<span class="tdmsg">*</span></td>
				<td><input  name="userpassword" type="password" placeholder="密码不修改请留空" datatype="/^\s*$/g|s4-18" errormsg="密码长度为4-18个字符，不能含有特殊符号"  /></td>
				<td class="tablecolor">用户类型</td>
				<td>
				<dic:html nodeId="user_type" name="userType" type="select"/>
				<!-- <select name="userType" id="userType" type="text" placeholder="选择用户类型" >
							<option value="0">管理员</option>
							<option value="1" >用户</option>
				</select> -->
				</td>
			</tr>
			<tr>
				<td class="tablecolor">部门</td>
				<td> 
				<input id="organSel" name="organName" type="text"  onclick="showMenu('organ'); return false;" readonly placeholder="选择部门" />
				<input id="selPid" name="organIds"  type="hidden" readonly value="" />&nbsp;
				<!-- <i class='icon icon-pencil hj_bianji'></i> -->
				</td>			
		 	<td class="tablecolor">状态<span class="tdmsg">*</span></td>
				<td >
				<%-- <dic:html nodeId="user_state" name="status" type="select"/> --%>
				<select id="status" name="status" datatype="*"  >
				<option  value=""  >--请选择--</option>
							<option value="20255">启用</option>
							<option value="20256">停用</option>
				</select>
				</td>
				
			</tr>
			<tr>
				<td class="tablecolor">角色</td>
				<td >
				<!-- <select id="roleIds" name="roleIds"   >
				</select> -->
				<input id="roleSel" name="roleName" type="text"  onclick="showMenu1(); return false;" readonly placeholder="选择角色" />
				<input name="roleIds" type="hidden"    />&nbsp;
				</td>
				
				<td class="tablecolor">排序</td>
				<td><input name="sort" type="text" placeholder="输入序号"   datatype="n1-5" errormsg="密码长度为1-5位数字" value="${user.sort}"/></td>
				
			</tr>
			<tr>
				<td class="tablecolor">人员生日</td>
				<td>
					<input name="birthDate" class="Wdate hj_usernameinp " value="${birthCode}" placeholder="出生年月日" type="text"
						onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"
						readonly="readonly" />
				</td>
				<td class="tablecolor">性别</td>
				<td>
				<dic:html nodeId="user_sex" name="sex" type="select"/>
					<!-- <select id="sex" name="sex" type="text" placeholder="选择性别" >
							<option selected="selected" value="1">男</option>
							<option value="2" >女</option>
					</select> -->
				</td>
			</tr>
			<tr>
				<td class="tablecolor">入职时间</td>
				<td>
					<input name="workDate" class="Wdate hj_usernameinp " value="${workCode}" placeholder="入职年月日" type="text"
						onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"
						readonly="readonly" /></td>
				<td class="tablecolor">人员隶属</td>
				<td>
				<dic:html nodeId="user_belong" name="isXw" type="select"/>
					<!-- <select id="isXw" name="isXw" type="text" placeholder="选择人员隶属" >
							<option selected="selected" value="1">徐圩新区工作人员</option>
							<option value="2" >外部工作人员</option>
					</select> -->
				</td>
			</tr>
			<tr>
				<td class="tablecolor">人员分类</td>
				<td >
					<dic:html nodeId="user_class" name="publicCode"  type="select" />
					<!-- <select id="publicCode" name="publicCode" type="text" placeholder="选择人员分类" >
							<option selected="selected" value="0001">管委会领导</option>
							<option value="0002" >员工</option>
					</select> -->
				</td>
				<td class="tablecolor">手机</td>
				<td><input name="phone" type="text" placeholder="输入手机号码" value="${user.phone }"/></td>
			</tr>
			<tr>
				<td class="tablecolor">邮箱</td>
				<td ><input name="email" type="text"  placeholder="输入邮箱" value="${user.email }"/></td>
				<td class="tablecolor">座机</td>
				<td><input name="officePhone" type="text"  value="${user.officePhone }"/></td>
			</tr>
			<tr>
				<td class="tablecolor">
				员工号
				<%-- 	<dic:html dicId="63" name="11" type="select" value="2" /> --%>
				</td>
				<td>
					<input id="certId" name="certId" type="text" value='${certId}' placeholder="请输入员工号"     errormsg="请输入正确的员工号"/>
					<input id="privateCode" name="privateCode" type="hidden" style="width:300px;"   value="${priCode}"/>
				</td>
			</tr>
			<!-- <tr><td colspan="4">
					
			     <button onclick="Edit();" class="button" type="button">提交</button>
			      <button onclick="cancel();" class="button" type="button">返回</button>
			</td>
			</tr> -->
		</table>
		</div></div>
</div>
<div class="formmsg" style="margin-top: 400px;">
		<span id="formmsg" ></span>
	</div>
	<div class="butdiv">
		<button class="button" type="submit">提交</button>
		<button onclick="cancel();" class="button" type="button">返回</button>
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
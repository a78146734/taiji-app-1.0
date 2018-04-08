<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<%@include file="../../../../../commons/global.jsp"%>
	<%@include file="../../../../../commons/xw/basejs.jsp"%>
		<script type="text/javascript" src="js/wdRmpSysUsableAdd.js"></script>
		
		<link rel="stylesheet" type="text/css" href="css/wdRmpSysUsableAdd.css">
	<style type="text/css">
	body{
		min-width: 600px !important;
	}
</style>
</head>
<body >

<form id="form1"  >

	<div class="user_manage">
			<p class="ri_jczctitle">
	           <span class="ri_jczctitletxt">新增页面</span>
	           <span class="ri_jczctitlemore"></span>
	         </p>
	         <div class="user_list">
				<table class="gridtable04 "  >

					<tr>
						<td class="tablecolor">系统名称：<span class="tdmsg">*</span></td>
						<td><input type="text" name="sysName" placeholder="请输入系统名称" datatype="s1-20" errormsg="请输入1-20位字符"></td>

						<td class="tablecolor">类型<span class="tdmsg">*</span></td>
						<td><select id="usableType" name="usableType" onchange="typeChange(this);">
								<option value="url">url</option>
								<option value="port">port</option>
						</select></td>

					</tr>
					<tr>
						<td class="tablecolor">系统URL：<span class="tdmsg">*</span></td>
						<td  colspan="3"><input id="sys_url" type="text" name="sysUrl" placeholder="请输入系统URL"  ></td>
					</tr>
					<tr>
						<td class="tablecolor">系统IP：<span class="tdmsg">*</span></td>
						<td><input id="sys_ip" type="text" name="sysIp" placeholder="请输入系统IP"></td>

						<td class="tablecolor">系统Port：<span class="tdmsg">*</span></td>
						<td><input id="sys_port" type="text" name="sysPort" placeholder="请输入系统Port" ></td>
					</tr>
					<tr>
						<td class="tablecolor">负责人手机：<span class="tdmsg">*</span></td>
						<td><input id="sys_phone" type="text" name="sysPhone" placeholder="请输入手机号码" datatype="m" errormsg="请输入正确的手机号码"></td>
					</tr>


				</table>
			</div>
		</div>
		
		<div class="tablebut"> 
               <button type="button" onclick="Submit();">提交</button>&nbsp;&nbsp;&nbsp;&nbsp;<button type="button" onclick="back();">取消</button>
        </div>
	</form>
</body>
<script type="text/javascript">
//初始加载
$(document).ready(function() {
	typeChange($("#usableType"));
	validAllFormDefault("form1"); 
});

	function Submit() {
			var params = $("#form1").serialize();
			console.log(params);
			validAjaxFormList(basePath+"/wdRmpSysUsable/save");
			$("#form1").submit();
			<%-- $.ajax({
		 		type: "post",
		 		url: "<%=basePath%>/wdRmpSysUsable/save",
		 		data:params,
		 		async: true,
		 		dataType: "text",
		 		beforeSend: function(){},  
	        	complete: function(){},
		 		success: function(data){
		 			var das = JSON.parse(data);
		 			if(das.success){
		 				location.href=basePath + "/static/commons/massage/success.jsp?url="+basePath+"/jsp/zh/wd/rmp/usability/wdRmpSysUsableList.jsp";
		 			}else{
		 				location.href=basePath + "/static/commons/massage/failure.jsp?url="+basePath+"/jsp/zh/wd/rmp/usability/wdRmpSysUsableList.jsp";
		 			}
		 		}
 			}); --%>
		}
	
		function back() {
			parent.layer.closeAll('iframe');
		//	location.href=basePath + "/jsp/zh/wd/rmp/usability/wdRmpSysUsableList.jsp";
		}
		function typeChange(obj){
			var typeName = $(obj).val();
			if(typeName == "url"){
				$("#sys_url").removeAttr("disabled");
				$("#sys_url").attr("datatype", "/^(http).*/");
				$("#sys_url").attr("errormsg", "请输入http开头的url地址");
				
				$("#sys_ip").attr("disabled", true);
				$("#sys_ip").removeAttr("datatype");
				$("#sys_ip").removeAttr("errormsg");
				$("#sys_ip").val(null);
				
				$("#sys_port").attr("disabled", true);
				$("#sys_port").removeAttr("datatype");
				$("#sys_port").removeAttr("errormsg");
				$("#sys_port").val(null);
			}else if(typeName == "port"){
				$("#sys_url").attr("disabled", true);
				$("#sys_url").removeAttr("datatype");
				$("#sys_url").removeAttr("errormsg");
				$("#sys_url").val(null);
				
				$("#sys_ip").removeAttr("disabled");
				$("#sys_ip").attr("datatype", "s1-20");
				$("#sys_ip").attr("errormsg", "请输入ip地址");
				
				$("#sys_port").removeAttr("disabled");
				$("#sys_port").attr("datatype", "n1-8");
				$("#sys_port").attr("errormsg", "请输入port");
			}
		}
		
		
		var validVar = ""; // 不能删除
		function validAllFormDefault(formId){
			validVar = $("#" +formId).Validform({
				tiptype:function(msg,o,cssctl){
					//msg：提示信息;
					//o:{obj:*,type:*,curform:*}, obj指向的是当前验证的表单元素（或表单对象），type指示提示的状态，值为1、2、3、4， 1：正在检测/提交数据，2：通过验证，3：验证失败，4：提示ignore状态, curform为当前form对象;
					//cssctl:内置的提示信息样式控制函数，该函数需传入两个参数：显示提示信息的对象 和 当前提示的状态（既形参o中的type）;
					if(!o.obj.is("form")){  //验证表单元素时o.obj为该表单元素，全部验证通过提交表单时o.obj为该表单对象;
						if(o.type==2){
							layer.closeAll();
						}
						else if(o.type==4){
							layer.closeAll();
						}
						else{
							layer.tips(msg, "[name='"+$(o.obj).attr("name")+"']", {
							  	tips: [2, '#D15B47'], 
						 	 	time: 0
							});
						}
					}	
				}
			});
		}
		
		//自定义ajax方法urlPath为ajax的actions
		function validAjaxFormList(urlPath){
			validVar.config({
		    	url:urlPath,
		    	ajaxPost:true,
		    	postonce: true,
				ajaxpost:{
		        success:function(data,obj){
					 if(data.success){
						 layer.msg("系统添加成功",{icon: 1,shade:0.3, time: 1000});
						 parent.layer.closeAll('iframe');
					 }else{
						 layer.msg("系统添加失败",{icon: 2,shade:0.3, time: 1000});
					 }
		        },
		        error:function(data,obj){
		        	
		            //data是{ status:**, statusText:**, readyState:**, responseText:** };
		            //obj是当前表单的jquery对象;
		        }
		    }
			});
		 
		}
</script>
</html>
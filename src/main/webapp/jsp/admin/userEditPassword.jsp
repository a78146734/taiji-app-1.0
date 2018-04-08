<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@include file="../../commons/global.jsp"%>
<%@include file="../../commons/xw/basejs.jsp"%>
<body>
	<form id="form1">
		<div class="user_manage">
			<p class="ri_jczctitle">
				<span class="ri_jczctitletxt">密码修改</span> <span
					class="ri_jczctitlemore"></span>
			</p>
			<div class="user_list">
				<table class="gridtable04">
					<tr>
						<td class="tablecolor">原密码：</td>
						<td>
							<input type="password" name="passWord" id="passWord" placeholder="请输入原密码" datatype="s4-16" errormsg="请输入符合规范的用户名，由4-16位字母，数字，下划线组成">
						</td>
						
					</tr>
					<tr>
						<td class="tablecolor">新密码：</td>
						<td>
							<input type="password" name="newPassWord" id="newPassWord" placeholder="请输入符合规范的用户名，由4-16位字母，数字，下划线组成" datatype="s4-16" errormsg="请输入符合规范的用户名，由4-16位字母，数字，下划线组成">
						</td>
						
					</tr>
					<tr>
						<td class="tablecolor">确认密码：</td>
						<td>
							<input type="password" name="validatePassWord" id="validatePassWord" placeholder="请再次输入密码" datatype="s4-16" errormsg="请输入符合规范的用户名，由4-16位字母，数字，下划线组成">
						</td>
						
					</tr>
				</table>
			</div>
		</div>

		<div class="butdiv">
			<button class="button" type="button" onclick="Submit()">确定</button>
		</div>
	
	</form>
	 
</body>
<script type="text/javascript">
	//初始加载
	$(document).ready(function() {
		
		validAllFormDefault("form1"); 
	//	selectServiceList();
		
	//  selectProviderApp();
		
	});

	function tcancel(){
		layer.closeAll();	
	}


	function Submit() {
		if($("#validatePassWord").val()!=$("#newPassWord").val()){
			layer.msg("两次输入的密码不一致",{icon:2,time:1500});
		}else{
			 $.ajax({
			 		type: "post",
			 		url: basePath+"/user/checkPassword",
					data:[],	 
			 		async: false,
			 		dataType: "text",  //text  json
			 		beforeSend: function(){},
		            complete: function(){},
			 		success: function(data){
			 			var das = JSON.parse(data);
			 			if(das.loginPassword!=$("#passWord").val()){
			 				layer.msg("密码输入错误",{icon:2,time:1500});
			 			}else{
			 				validAjaxFormList(basePath+"/user/editPassword");
			 				$("#form1").submit();
			 			}
			 		}
				});
			
		}

	}
 
	function selectServiceList(){
		var params = $("#form1").serializeArray();
 		var str = JSON.stringify(params); 
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
	        	if(data.msg==1){
	        		 layer.msg('用户密码不能为空',{icon: 2,shade:0.3, time: 1000});
	        	}else if(data.msg==2){
	        		 layer.msg('请确认新用户密码',{icon: 2,shade:0.3, time: 1000});
	        	}else if(data.msg==3){
	        		layer.msg('两次输入的密码不符',{icon: 2,shade:0.3, time: 1000});
	        	}else{
					 layer.msg('密码修改成功,请重新登录',{
		        			icon: 1,
		        			shade:0.3,
							  time: 1000, //不自动关闭
							  },function(){
								  parent.logout(1);
							  }); 
					/*  alert("子服务注册成功");
	        		location.href=basePath + "/wdSspAipServiceRequestion/approve"; */
	        	}
	        },
	        error:function(data,obj){
	        	layer.msg("密码修改失败",{icon: 2,shade:0.3, time: 1000});
	            //data是{ status:**, statusText:**, readyState:**, responseText:** };
	            //obj是当前表单的jquery对象;
	        }
	    }
		});
	 
	}
</script>
</html>
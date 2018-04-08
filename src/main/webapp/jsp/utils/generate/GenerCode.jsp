<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<%@ include file="../../../commons/global.jsp"%>
<%@ include file="../../../commons/basejs.jsp"%>
<style type="text/css">
body{
width: 99%;
}
.bt{
	height: 60px;
	width: 99%;
	background: red;
}
.lr{
	width: 200px;
	height: 35px;
}

.gridtable02 tr{
	height: 55px;
}
</style>
</head>
  
  <body>
  	<form action="">
	  	<div >
		    <table class="gridtable02" style="width: 100%;" >
		    	<tr class="bt">
		    		<td colspan="3"  >生成代码</td>
		    	</tr>
		    	<tr class="bt">
		    		<td colspan="3" style="color: red;font-size: 15px;" >注意事项：<br>由于使用了jpa，所以代码生成器不再创建entity类，生成步骤改为
		    		<br>（1）创建自己的业务实体类entity,请继承BaseDomain，
		    		<br>	BaseDomain作用为：自动携带主键和创建时间以及更新时间
		    		<br>（在创建或修改对象时会自动更新这俩字段，不必设置）
		    		<br> 可查看示例代码com.stu.info.entity.Student.java
		    		<br>（2）运行项目jpa会根据实体类信息，生成数据库表
		    		<br>（3）打开数据库，对数据库表字段进行注释
		    		<br>（4）访问此页面，进行生成，由于使用maven，无法获取到工作空间路径，所以需要手动粘贴项目路径
		    		<br>（5）填写数据库表名，填写模块名，填写功能名，填写创建人，点击生成
		    		<br>（6）现在的代码第一级包都在com下，模块和功能两级包可以自定义</td>
		    	</tr>
		    	<tr>
		    		<td style="width:30%">工程路径：</td>
		    		<td style="width:40%"><input  name="projectPath" class="lr" type="text" value=""></td>
		    		<td  style="width:30%;color: red;" class="tr2" >例如：E:\work\taijiapp\taiji-app-support-1.0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
		    	</tr>
		    	<tr style="display: none;">
		    		<td>项目名称：</td>
		    		<td><input class="lr" name=sysname type="text" value="src/main/java"></td>
		    		<td class="tr2">例如：zh</td>
		    	</tr>
		    	<!-- 隐藏 暂时不用 程序不受影响start -->
		    	<tr style="display:none;">
		    		<td>表空间名：</td>
		    		<td><input name="schema" class="lr" type="text" value="aky"></td>
		    		<td class="tr2">例如：aky</td>
		    	</tr>
		    	<!-- 隐藏 暂时不用 程序不受影响end -->
		    	<tr>
		    		<td>数据库表名：</td>
		    		<td><input name="tableName" class="lr" type="text" value=""></td>
		    		<td class="tr2">例如：EAP_SYS_USER_BASEPROFILE</td>
		    	</tr>
		    	<tr style="display: none;">
		    		<td >系统名称：</td>
		    		<td><input name="basePackage" class="lr" type="text" value="/com/"></td>
		    		<td class="tr2">例如：/com/</td>
		    	</tr>
		    	<tr>
		    		<td>模块名称：</td>
		    		<td><input name="module" class="lr" type="text" value=""></td>
		    		<td class="tr2">例如：user</td>
		    	</tr>
		    	<tr>
		    		<td>功能名称：</td>
		    		<td><input name="function" class="lr" type="text" value=""></td>
		    		<td class="tr2">例如：form</td>
		    	</tr>
		    	<tr>
		    		<td>创建人：</td>
		    		<td><input name="author" class="lr" type="text" value="admin"></td>
		    		<td class="tr2">例如：admin</td>
		    	</tr>
		    	<tr>
		    		<td>选择生成文件：</td>
		    		<td colspan="2" >
		    			<input onclick="checkAll(this);"  type="checkbox" value="全选">全选&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		    			<input onclick="checkOne(this);"  type="checkbox" value="dao">dao&nbsp;&nbsp;&nbsp;&nbsp;
		    			<input onclick="checkOne(this);"  type="checkbox" value="service">service&nbsp;&nbsp;&nbsp;&nbsp;
		    			<input onclick="checkOne(this);"  type="checkbox" value="action">action&nbsp;&nbsp;&nbsp;&nbsp;
		    			<input onclick="checkOne(this);"  type="checkbox" value="list">List.jsp&nbsp;&nbsp;&nbsp;&nbsp;
		    			<input onclick="checkOne(this);"  type="checkbox" value="add">Add.jsp&nbsp;&nbsp;&nbsp;&nbsp;
		    			<input onclick="checkOne(this);"  type="checkbox" value="update">Update.jsp&nbsp;&nbsp;&nbsp;&nbsp;
		    			<input onclick="checkOne(this);"  type="checkbox" value="detail">Detail.jsp&nbsp;&nbsp;&nbsp;&nbsp;
		    			<input onclick="checkOne(this);"  type="checkbox"  value="js">js&nbsp;&nbsp;&nbsp;&nbsp;
		    			<input onclick="checkOne(this);"  type="checkbox" value="css">css&nbsp;&nbsp;&nbsp;&nbsp;
		    		</td>
		    	</tr>
		    	<tr>
		    		<td>是否绑定权限</td><td>是否绑定权限&nbsp;<input type="checkbox" name="genPur"  value="true"/></td>
		    	</tr>
		    	
		    	<tr>
		    		<td colspan="3">
		    			<input class='btn btn-primary btn-sm' style="width:100px;" type="button" onclick="SubmitData();" value="提&nbsp;交"></td>
		    		<td class="tr2"></td>
		    	</tr>
		    </table>
		    <div id="msg"></div>
		 </div>
    </form>
  </body>
  <script type="text/javascript">
  		//初始加载
  		$(document).ready(function(){
  			$("input:checkbox").each(function(){
  				$(this).attr("checked","true");
  			});
  			//获取项目路径
  			//ObtainPath();
  		});
  		
  		//全选
		function checkAll(obj){
			if($(obj).attr("checked")){
				$(obj).parent().find("input").each(function(i){
					if(i>0){
						$(this).attr("checked","true");
					}
				 });
			}else{
				$(obj).parent().find("input").each(function(i){
					if(i>0){
						$(this).removeAttr("checked");
					}
				 });
			}
		}
		
		
		
		//checkbox单选
		function checkOne(obj){
			var temp = true;
			$(obj).parent().find("input").each(function(i){
				if(i>0){
					if(!$(this).attr("checked")){
						temp = false;
						return false;
					}
					
				}
			 });
			 if(temp){
			 	$(obj).parent().find("input").eq(0).attr("checked","true");
			 }else{
			 	$(obj).parent().find("input").eq(0).removeAttr("checked");
			 }
		}
		
		//提交方法
		function SubmitData(){
			var Genfile = "";
			$("input:checkbox").each(function(i){
				if(i>0){
					if($(this).attr("checked")){
						Genfile += $(this).val();
						Genfile += ",";
					}
				}
			 });
			 
			 if(Genfile==null||Genfile==""){
			 	alert("没有选择生成文件！");
			 	return;
			 }
			 
			 if(!CheckForm()){
			 	return;
			 }
			$.ajax({
		 		type: "post",
		 		url: "${base}/generCode",
		 		data:'genPur='+$("[name=genPur]").val()+'&projectPath='+$("[name=projectPath]").val()+'&sysname='+$("[name=sysname]").val()+'&schema='+$("[name=schema]").val()+'&tableName='+$("[name=tableName]").val()+'&basePackage='+$("[name=basePackage]").val()+'&module='+$("[name=module]").val()+'&function='+$("[name=function]").val()+'&author='+$("[name=author]").val()+'&Genfile='+Genfile,
		 		async: true,
		 		dataType: "json",
		 		success: function(data){
		 			alert(data.msg);
		 			$("#msg").html(data.msg);
		 		}
 			});
		}
		
		//获取项目路径
		function ObtainPath(){
		
			$.ajax({
		 		type: "get",
		 		url: "${base}/obtainPath",
		 		data:'',
		 		async: true,
		 		dataType: "text",
		 		success: function(data){
		 			$("[name=projectPath]").val(data.split('WebRoot')[0]);
		 		}
 			});
		}
		
		
		//判断是否为空
		function CheckNull(str){
			if(str!=null&&str!=""){
				return true;
			}else{
				return false;
			}
		}
		
		
		//判断form表单是否为空
		function CheckForm(){
			temp = true;
			if(!CheckNull($("[name=projectPath]").val())){
			 	alert("项目路径不能为空");
			 	temp = false;
			 	return;
			 }
			 
			 if(!CheckNull($("[name=sysname]").val())){
			 	alert("项目名称不能为空");
			 	temp = false;
			 	return;
			 }
			 
			 if(!CheckNull($("[name=schema]").val())){
			 	alert("表空间不能为空");
			 	temp = false;
			 	return;
			 }
			 
			 if(!CheckNull($("[name=tableName]").val())){
			 	alert("表名称不能为空");
			 	temp = false;
			 	return;
			 }
			 
			 if(!CheckNull($("[name=basePackage]").val())){
			 	alert("java包路径不能为空");
			 	temp = false;
			 	return;
			 }
			 
			 if(!CheckNull($("[name=module]").val())){
			 	alert("模块名不能为空");
			 	temp = false;
			 	return;
			 }
			 
			 if(!CheckNull($("[name=function]").val())){
			 	alert("功能名不能为空");
			 	temp = false;
			 	return;
			 }
			 
			 if(!CheckNull($("[name=author]").val())){
			 	alert("创建者名称不能为空");
			 	temp = false;
			 	return;
			 }
			 return temp;
		}
  </script>
</html>

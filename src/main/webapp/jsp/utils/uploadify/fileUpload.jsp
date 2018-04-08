<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path;
	String key = "";
	String part = "";
	String divid = "";
	String type = "";
	if(request.getParameter("key")!=null&&request.getParameter("key")!=""){
		 key = request.getParameter("key");
	}
	
	if(request.getParameter("part")!=null&&request.getParameter("part")!=""){
		 part = request.getParameter("part");
	}
	if(request.getParameter("divid")!=null&&request.getParameter("divid")!=""){
		 divid = request.getParameter("divid");
	}
	if(request.getParameter("type")!=null&&request.getParameter("type")!=""){
		 type = request.getParameter("type");
	}
%>
<!DOCTYPE html>
<html lang="en">
<head>
<base href="<%=basePath%>">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta charset="utf-8" />
<title>上传文件</title>
<meta name="description" content="" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
<link rel="stylesheet" type="text/css" href="<%=basePath%>/static/uploadify/uploadify.css" />
<script type="text/javascript" src="<%=basePath%>/static/jquery/jquery.min.js"></script>
<script type="text/javascript" src="<%=basePath%>/static/layui/layui.js" charset="utf-8"></script>
<script type="text/javascript" src="<%=basePath%>/static/layui/lay/dest/layui.all.js" charset="utf-8"></script>
<script type="text/javascript" src="<%=basePath%>/static/uploadify/jquery.uploadify.js"></script>
<style type="text/css">
	.placeholder{
		height:20px;
	}
	body {
		overflow: hidden;
	}
</style>

</head>
<body class="no-skin">
<div style="text-align: center;width: 100%;">
			<input id="key" type="hidden" value="<%=key%>">
			<input id="part" type="hidden" value="<%=part%>">
			<input id="divid" type="hidden" value="<%=divid%>">
			<input id="type" type="hidden" value="<%=type%>">
			<div id="fileQueue"></div>
		    <input type="file" name="uploadify" id="uploadify" />
		    <div class="uploadify-button " onclick="javascript:$('#uploadify').uploadify('cancel');closeWindow()" style="height: 24px; line-height: 24px; width: 75px;">
		    	<span class="uploadify-button-text">取消上传</span>
		    </div>
</div>
		
</body>
<script type="text/javascript">
		<%-- $(document).ready(function()
	        {
	            $("#uploadify").uploadify({
	                'uploader': ,
	                'script': 'UploadHandler.ashx',
	                'cancelImg': '<%=basePath%>resources/scripts/uploadify/uploadify-cancel.png',
	                'folder': 'UploadFile',
	                'queueID': 'fileQueue',
	                'auto': false,
	                'multi': true
	            });
	        }); --%>
	        
	        function closeWindow(){
	        	//layer.close(layer.index);
	        	var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
				parent.layer.close(index); //再执行关闭   
	        } 
	        
	        $(function () {
	            $("#uploadify").uploadify({
	            	uploader:'<%=basePath%>/sysToolFile/upload;jsessionid=${pageContext.session.id}',
	                //指定swf文件
	                swf:'<%=basePath%>/static/uploadify/uploadify.swf',
	                fileObjName:'fileArr',
	                //后台处理的页面
	                fileSizeLimit:1024*500,
	                //按钮显示的文字
	                buttonText: '上传文件',
	                method:'post',
	                debug:false,
	                queueID:'fileQueue',
	                //显示的高度和宽度，默认 height 30；width 120
	                width:'75',  //按钮宽度  
        			height:'24',  //按钮高度  
	                //上传文件的类型  默认为所有文件    'All Files'  ;  '*.*'
	                //在浏览窗口底部的文件类型下拉菜单中显示的文本
	                //'fileTypeDesc': 'Image Files',
	                //允许上传的文件后缀
	                //'fileTypeExts': '*.gif; *.jpg; *.png',
	                //发送给后台的其他参数通过formData指定
	                formData: { 'key': '<%=key%>', 'part': '<%=part%>' },
	                //上传文件页面中，你想要用来作为文件队列的元素的id, 默认为false  自动生成,  不带#
	                //'queueID': 'fileQueue',
	                //选择文件后自动上传
	                auto: true,
	                //设置为true将允许多文件上传
	                multi: true,
	                 //返回一个错误，选择文件的时候触发    
			        onSelectError:function(file, errorCode, errorMsg){ 
			            switch(errorCode) { 
			                case -100:    
			                    alert("上传的文件数量已经超出系统限制的"+$('#uploadify').uploadify('settings','queueSizeLimit')+"个文件！");    
			                    break;    
			                case -110:    
			                    alert("文件 ["+file.name+"] 大小超出系统限制的"+$('#uploadify').uploadify('settings','fileSizeLimit')+"大小！");    
			                    break;    
			                case -120:    
			                    alert("文件 ["+file.name+"] 大小异常！");    
			                    break;    
			                case -130:    
			                    alert("文件 ["+file.name+"] 类型不正确！");    
			                    break;    
			            }    
			        },    
			        //检测FLASH失败调用    
			        onFallback:function(){    
			            alert("您未安装FLASH控件，无法上传图片！请安装FLASH控件后再试。");    
			        },    
			        onSelect: function(file){  
			            $("#alertDiv").text("正在上传...");  
			            $("#alertDiv").show();  
			        },  
			        //上传到服务器，服务器返回相应信息到data里    
			        onUploadSuccess:function(file, data, response){
			            //var json = eval("(" + data + ")");  
			            //alert("上传成功！");
			        },  
			        onQueueComplete: function(queueData){ //队列里所有的文件处理完成后调用  
		            	var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
		            	window.parent.getFile($("#key").val(),$("#divid").val(),"edit",$("#type").val());
                    	parent.layer.close(index); //再执行关闭   
			        }
	            });
	        });
    
</script>

</html>	
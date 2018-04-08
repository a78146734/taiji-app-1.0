<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ include file="../../../commons/global.jsp"%>
<%@include file="../../../commons/basejs.jsp"%>

<%
	
	String msg = "";
	if(request.getAttribute("msg")!=""&&request.getAttribute("msg")!=null){
		msg = request.getAttribute("msg").toString();
	}
	
	String url = "";
	if(request.getAttribute("url")!=""&&request.getAttribute("url")!=null){
		msg = request.getAttribute("url").toString();
	}
	
%>
<!DOCTYPE html>
<html>
<head>
    <title>操作成功</title>
    <style type="text/css">
    	.msg{
    		width: 100%;
    		font-size: 40px;
    		text-align: center;
    		padding-top: 10%;
    		font-family: inherit;
    	}
    	.url{
    		width: 100%;
    		font-size: 28px;
    		text-align: center;
    		padding-top: 5%;
    	}
    </style>
  </head>
  <body><input id="path" type="hidden" value="<%=url%>">
   		<%
   			if(msg!=""){
   				%>
   					<div class="msg"><img src="${base}/static/adminModule/frame/images/success.png">&nbsp;&nbsp;&nbsp;<%=msg%></div>
   				<% 
   			}else{
   				%>
   					<div class="msg"><img src="${base}/static/adminModule/frame/images/success.png">&nbsp;&nbsp;&nbsp;操作成功！</div>
   				<% 
   			}
   		 %>
   					<div class="url"><a id="endtime" class="btn btn-sm btn-success" onclick="goTo();">关闭</a></div>
  </body>
  <script type="text/javascript">
	function goTo(){
			var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
                        parent.layer.close(index);
		}
		var k = setTimeout("goTo()",1000);  
		var i = 3; 
		remainTime(); 
		function remainTime(){  
		    if(i==0){  
		        goTo();  
		        clearTimeout(k);
		    }  
		    document.getElementById('endtime').innerHTML=(i--)+"秒后关闭";  
		}  
		remainTime(); 
  </script>
</html>

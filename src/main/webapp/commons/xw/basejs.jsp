<%--标签 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script type="text/javascript">
var basePath = "${staticPath }";
var _LoadingHtml = "<div id='loading' class='load'><img src='${base}/static/commons/page/images/ajax-loader.gif'/></div>";
document.write(_LoadingHtml);
	
</script>
<%-- [jQuery] --%>
<script type="text/javascript" src="${staticPath }/static/jquery/jquery.min.js" charset="utf-8"></script>
<script type="text/javascript" src="${staticPath }/static/jquery/jquery.serializejson.min.js" charset="utf-8"></script>
<script type="text/javascript" src="${staticPath }/static/My97DatePicker/WdatePicker.js" charset="utf-8"></script>
<script type="text/javascript" src="${staticPath }/static/layui/lay/dest/layui.all.js" charset="utf-8"></script>
<script type="text/javascript" src="${staticPath }/static/ztree/js/jquery.ztree.all.js" charset="utf-8"></script>
<script type="text/javascript" src="${staticPath }/static/echart/echarts-all-2.2.7.js" charset="utf-8"></script>
<script type="text/javascript" src="${staticPath }/static/commons/main/js/basejs.js" charset="utf-8"></script>
<script type="text/javascript" src="${staticPath }/static/validform/Validform_v5.3.2_min.js "  charset="utf-8"></script>
<script type="text/javascript" src="${staticPath }/static/layui/layui.js" charset="utf-8"></script> 
<script type="text/javascript" src="${staticPath }/static/uploadify/uploadTool.js" charset="utf-8"></script>
<link rel="stylesheet" href="${staticPath }/static/layui/css/layui.css">
<link rel="stylesheet" href="${staticPath }/static/commons/main/css/xw_main.css">
<link rel="stylesheet" href="${staticPath }/static/adminModule/frame/zui/css/zui.min.css">
<link rel="stylesheet" href="${staticPath }/static/adminModule/frame/css/base.css">
<style>
html,body{
	overflow: hidden;
}
.layui-layer-tips .layui-layer-content{
	line-height:14px;
}
.load{
	position: fixed;
	top: -70%;
	left: -50%;
	width: 200%;
	height: 200%;
	background: #fff;
	z-index: 100;
	overflow: hidden;
	filter: alpha(opacity=50); opacity: 0.5;
	display: none;
}
.load img{
	position: absolute;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	margin: auto;
}
/* validform */
.formmsg {
	text-align: center;
	height: 20px;
	color: red;
}

.formmsg span {
	line-height: 10px;
}

.butdiv {
	text-align: center;
}

.tdmsg {
	display: inline-block;
	color: red;
	line-height: 40px;
	width: 10px;
}

.Validform_error {
	background-color: #ffe7e7;
}

select.input {
    	margin-left: 0px;
	}
</style>
    
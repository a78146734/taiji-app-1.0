<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@include file="../../../../../commons/global.jsp"%>
<%@include file="../../../../../commons/xw/basejs.jsp"%>
<!-- <script type="text/javascript" src="js/wdRmpAppServiceLogList.js"></script>
<link rel="stylesheet" type="text/css"
	href="css/wdRmpAppServiceLogList.css"> -->
<script type="text/javascript">
	window.onload = function() {
		window.parent.scrollTo(0, 0);
	}
</script>
<style type="text/css">
	.hj_username2 {
		    background-color: #f9f9f9;
    		padding: 9px 19px;
	}
</style>
</head>
<body>
	<form id="form1">
		<div class="user_manage">
			<p class="ri_jczctitle">
				<span class="ri_jczctitletxt">应用服务日志</span><span
					class="ri_jczctitlemore butimg" onclick="sideDiv(this);"></span>
			</p>
			<div class="hj_username2">
				<div>
					<span class="hj_usertxtname">日志级别：</span> 
					<span><select name="logLevel" class="hj_usernameinp">
							<option value="">--请选择--</option>
							<option value="off">OFF</option>
							<option value="fatal">FATAL</option>
							<option value="error">ERROR</option>
							<option value="warn">WARN</option>
							<option value="info">INFO</option>
							<option value="debug">DEBUG</option>
							<option value="all">ALL</option>
					</select></span> 
					<span class="hj_usertxtname">服务标识：</span> 
					<span>
						<select id="logPService" name="logPService" class="hj_usernameinp">
							<option value="">全部</option>
						</select>
					</span> 
					<span><button onclick="Query();" class="button" type="button">查询</button></span>
				</div>
				
			</div>
			<div id="hj_username_2" class="hj_username_2">
				<span class="hj_usertxtname">开始日期：</span> 
				<span><input name="logDate" type="text" class="Wdate hj_usernameinp" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})" readonly="readonly"></span>
				<span class="hj_usertxtname">结束日期：</span> 
				<span><input name="logDate1" type="text" class="Wdate hj_usernameinp" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})" readonly="readonly"></span>
			</div>
			<!--  <div id="hj_username_2" class="hj_username_2">
						<span class="hj_usertxtname">服务名称：</span> 
		<span><input name="logServiceName" type="text"  class="hj_usernameinp"></span>
        <span class="hj_usertxtname">信息：</span> 
		<span><input name="logMessage" type="text"  class="hj_usernameinp"></span>
		<span class="hj_usertxtname">日期：</span> 
		<span><input name="logDate" type="text"  class="hj_usernameinp"></span>				   				
			</div>	-->
			<div class="hj_user">
				<table class="gridtable03">
					<tr>
						<th style="width: 2%;">序号</th>
						<th style="width: 8%;"><a id="Log_Level" class="tha"
							onclick="sort(this);"><span>日志级别</span><i class="thimg"></i></a></th>
						<th style="width: 10%;"><a id="Log_Service_Name" class="tha"
							onclick="sort(this);"><span>子服务名称</span><i class="thimg"></i></a></th>
						<th style="width: 10%;"><a id="Log_Message" class="tha"
							onclick="sort(this);"><span>信息</span><i class="thimg"></i></a></th>
						<th style="width: 15%;"><a id="Log_Date" class="tha"
							onclick="sort(this);"><span>日期</span><i class="thimg"></i></a></th>
						<th style="width: 10%;"><a id="Protocol" class="tha"
							onclick="sort(this);"><span>协议</span><i class="thimg"></i></a></th>
						<th style="width: 10%;"><a id="Log_Ip" class="tha"
							onclick="sort(this);"><span>操作人IP</span><i class="thimg"></i></a></th>
						<th style="width: 10%;"><a id="SERVICE_RUNTIME" class="tha"
							onclick="sort(this);"><span>响应时间(ms)</span><i class="thimg"></i></a></th>
						<th style="width: 15%;"><a id="Log_P_Service_Name"
							class="tha" onclick="sort(this);"><span>服务名称</span><i
								class="thimg"></i></a></th>
						<th style="width: 10%;">操作</th>
					</tr>

					<tbody id="tb">

					</tbody>
				</table>
			</div>

		</div>

		<div class="page"><%@include
				file="../../../../../commons/xw/page.jsp"%></div>
	</form>
</body>
<script type="text/javascript">
	//初始加载
	$(document).ready(function() {
		doQuery();
		initializeName();
		$("#btnQuery").click(function() {
			$("[name=pageNo]").val("0");
			doQuery();
		});
		validAllFormDefault("form1");
	});

	//点击查询
	function Query() {
		$("[name=pageNo]").val("1");
		$("[name=nowpage]").val("1");
		validAjaxFormList(basePath + "/wdRmpAppServiceLog/list");
		$("#form1").submit();
		//			doQuery();
	}
	
	
	function initializeName(){
		
		$.post(basePath + "/wdRmpAppServiceLog/listSelect",null,function(data){
			var sb = new StringBuilder();
			 sb.append("<option value=''>全部</option>");
			 for(var i=0;i<data.length;i++){      
				 sb.append("<option value='"+data[i].SERVER_NUMBER+"' >"+data[i].SERVER_NAME+"</option>");     
		        }  
			$("#logPService").html(sb.toString());
		});
		
	}
	
	
	//查询执行方法
	function doQuery() {
		var params = $("#form1").serialize();
			$.ajax({
					type : "post",
					url : basePath + "/wdRmpAppServiceLog/list",
					data : params,
					async : true,
					dataType : "text",
					success : function(data) {
						var das = JSON.parse(data);
						if (pageValue(das.obj)) {
							return;
						}
						var sb = new StringBuilder();
						$
								.each(
										das.obj.rows,
										function(i, obj) {
											sb.append("<tr><td>").append(++i)
													.append("</td>");
											sb.append("<td >").append(
													obj.logLevel, 15).append(
													"</td>");
											sb.append("<td >").append(
													obj.logServiceName, 15)
													.append("</td>");
											sb.append("<td >").append(
													obj.logMessage, 15).append(
													"</td>");
											sb.append("<td >").append(
													obj.logDate, 20).append(
													"</td>");
											sb.append("<td >").append(
													obj.protocol, 15).append(
													"</td>");
											sb.append("<td >").append(
													obj.logIp, 15).append(
													"</td>");
											sb.append("<td >").append(
													obj.serviceRuntime, 15)
													.append("</td>");
											sb.append("<td >").append(
													obj.logPServiceName, 15)
													.append("</td>");
											sb
													.append(
															"<td ><a class='hj_mar20' onclick='select(\"")
													.append(obj.id)
													.append(
															"\")'><i class='icon icon-search hj_bianji'></i><span class='hj_mar20'>查看</span></a>");
										});
						$("#tb").html(sb.toString());
					}
				});
	}

	function update(id) {
		location.href = basePath
				+ "/jsp/zh/wd/rmp/log/wdRmpAppServiceLogUpdate.jsp?id=" + id;
	}

	function select(id) {
		layer.open({
			  type: 2,
			  title: '服务查看',
			  shadeClose: true,
			  maxmin: true, //开启最大化最小化按钮
			  area: ['80%', '70%'],
			content: basePath + "/jsp/zh/wd/rmp/log/wdRmpAppServiceLogDetail.jsp?id=" + id
		});
		/* location.href = basePath
				+ "/jsp/zh/wd/rmp/log/wdRmpAppServiceLogDetail.jsp?id=" + id; */
	}

	function add() {
		location.href = basePath
				+ "/jsp/zh/wd/rmp/log/wdRmpAppServiceLogAdd.jsp";
	}

	function del(id) {
		$.ajax({
			type : "get",
			url : basePath + "/wdRmpAppServiceLog/delete",
			data : {
				"id" : id
			},
			async : true,
			dataType : "text",
			success : function(data) {
				var das = JSON.parse(data);
				if (das.success) {
					doQuery();
				} else {
					alert("删除失败");
				}
			}
		});
	}

	var validVar = ""; // 不能删除
	function validAllFormDefault(formId) {
		validVar = $("#" + formId).Validform(
				{
					//ajaxPost:true,
					//postonce: true,
					tiptype : function(msg, o, cssctl) {
						//msg：提示信息;
						//o:{obj:*,type:*,curform:*}, obj指向的是当前验证的表单元素（或表单对象），type指示提示的状态，值为1、2、3、4， 1：正在检测/提交数据，2：通过验证，3：验证失败，4：提示ignore状态, curform为当前form对象;
						//cssctl:内置的提示信息样式控制函数，该函数需传入两个参数：显示提示信息的对象 和 当前提示的状态（既形参o中的type）;
						if (!o.obj.is("form")) { //验证表单元素时o.obj为该表单元素，全部验证通过提交表单时o.obj为该表单对象;
							if (o.type == 2) {
								layer.closeAll();
							} else {
								layer.tips(msg, "[name='"
										+ $(o.obj).attr("name") + "']", {
									tips : [ 2, '#D15B47' ],
									time : 0
								});
							}
						}
					}
				});
	}
	//自定义ajax方法urlPath为ajax的actions
	function validAjaxFormList(urlPath) {
		validVar
				.config({
					url : urlPath,
					ajaxPost : true,
					postonce : true,
					ajaxpost : {
						success : function(data, obj) {
							pageValue(data.obj);
							var sb = new StringBuilder();
							$
									.each(
											data.obj.rows,
											function(i, obj) {
												sb.append("<tr><td>").append(
														++i).append("</td>");
												sb.append("<td >").append(
														obj.logLevel, 15)
														.append("</td>");
												sb.append("<td >").append(
														obj.logServiceName, 15)
														.append("</td>");
												sb.append("<td >").append(
														obj.logMessage, 15)
														.append("</td>");
												sb.append("<td >").append(
														obj.logDate, 15)
														.append("</td>");
												sb.append("<td >").append(
														obj.userId, 15).append(
														"</td>");
												sb.append("<td >").append(
														obj.logIp, 15).append(
														"</td>");
												sb.append("<td >").append(
														obj.serviceRuntime, 15)
														.append("</td>");
												sb
														.append("<td >")
														.append(
																obj.logPServiceName,
																15).append(
																"</td>");
												sb
														.append(
																"<td ><a class='hj_mar20' onclick='select(\"")
														.append(obj.id)
														.append(
																"\")'><i class='icon icon-search hj_bianji'></i><span class='hj_mar20'>查看</span></a>");

											});
							$("#tb").html(sb.toString());
						},
						error : function(data, obj) {
							//data是{ status:**, statusText:**, readyState:**, responseText:** };
							//obj是当前表单的jquery对象;
						}
					}
				});

	}
</script>
</html>
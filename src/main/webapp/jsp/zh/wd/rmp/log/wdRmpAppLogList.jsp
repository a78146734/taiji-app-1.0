<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@include file="../../../../../commons/global.jsp"%>
<%@include file="../../../../../commons/xw/basejs.jsp"%>
<!-- <script type="text/javascript" src="js/wdRmpAppLogList.js"></script>
<link rel="stylesheet" type="text/css" href="css/wdRmpAppLogList.css"> -->
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
#logModular{
	width: 154px;
    height: 24px;
    border: 1px solid #d9d9d9;
    color: #b8b8b8;
    font: 12px;
    text-indent: 8px;
}
</style>
</head>
<body>
	<form id="form1">
		<div class="user_manage">
			<p class="ri_jczctitle">
				<span class="ri_jczctitletxt">应用操作日志</span><span
					class="ri_jczctitlemore butimg" onclick="sideDiv(this);"></span>
			</p>
			<div class="hj_username2">
				<div>
					<span class="hj_usertxtname">日志级别：</span> <span><select
						name="logLevel" class="hj_usernameinp">
							<option value="">--请选择--</option>
							<option value="off">OFF</option>
							<option value="fatal">FATAL</option>
							<option value="error">ERROR</option>
							<option value="warn">WARN</option>
							<option value="info">INFO</option>
							<option value="debug">DEBUG</option>
							<option value="all">ALL</option>
					</select></span> <span class="hj_usertxtname">模块名称：</span> <span>
					<dic:html nodeId="system" name="logModular" type="selectByParam1" />
					</span>
					<span class="hj_usertxtname">操作人：</span> <span> <input
						name="userId" type="text" class="hj_usernameinp"></span>
					<span><button
							onclick="Query();" class="button" type="button">查询</button></span>
				</div>
			</div>

			<div id="hj_username_2" class="hj_username_2">
				<span class="hj_usertxtname">开始日期：</span> <span> <input
						name="logDate" type="text" class="hj_usernameinp"
						onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"
						readonly="readonly"></span> <span class="hj_usertxtname">结束日期：</span>
					<span> <input name="logDate1" type="text"
						class="hj_usernameinp"
						onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"
						readonly="readonly"></span> 
				 <span
					class="hj_usertxtname">日志信息：</span> <span><input
					name="logMessage" type="text" class="hj_usernameinp"></span> 
			</div>

			<div class="hj_user">
				<table class="gridtable03">
					<tr>
						<th style="width: 2%;">序号</th>
						<th style="width: 8%;"><a id="Log_Level" class="tha"
							onclick="sort(this);"><span>日志级别</span><i class="thimg"></i></a></th>
						<th style="width: 10%;"><a id="Log_Modular" class="tha"
							onclick="sort(this);"><span>模块名称</span><i class="thimg"></i></a></th>
						<th style="width: 20%;"><a id="Log_Message" class="tha"
							onclick="sort(this);"><span>日志信息</span><i class="thimg"></i></a></th>
						<th style="width: 10%;"><a id="Log_Date" class="tha"
							onclick="sort(this);"><span>日期</span><i class="thimg"></i></a></th>
						<th style="width: 10%;"><a id="User_Id" class="tha"
							onclick="sort(this);"><span>操作人</span><i class="thimg"></i></a></th>
						<th style="width: 10%;"><a id="Log_Ip" class="tha"
							onclick="sort(this);"><span>操作人IP地址</span><i class="thimg"></i></a></th>
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
	var Modular = <dic:html nodeId="system" name="Modular" type="jsonByParam1" />;
	//初始加载
	$(document).ready(function() {
		//设置初始化排序字段
		initSort("Log_Date", "desc");
		doQuery();
	});

	//点击查询
	function Query() {
		$("[name=nowpage]").val("1");
		$("[name=pageNo]").val("1");
		doQuery();
	}

	//查询执行方法
	function doQuery() {
		var params = $("#form1").serialize();
		$
				.ajax({
					type : "post",
					url : basePath + "/wdRmpAppLog/list",
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
													Modular[obj.logModular], 15).append(
													"</td>");
											sb.append("<td >").append(
													obj.logMessage, 30).append(
													"</td>");
											sb.append("<td >").append(
													obj.logDate, 20).append(
													"</td>");
											sb.append("<td >").append(
													obj.userId, 15).append(
													"</td>");
											sb.append("<td >").append(
													obj.logIp, 15).append(
													"</td>");
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
				+ "/jsp/zh/wd/rmp/log/wdRmpAppLogUpdate.jsp?id=" + id;
	}

	function select(id) {
		layer.open({
			  type: 2,
			  title: '服务查看',
			  shadeClose: true,
			  maxmin: true, //开启最大化最小化按钮
			  area: ['80%', '70%'],
			content: basePath + "/jsp/zh/wd/rmp/log/wdRmpAppLogDetail.jsp?id=" + id
		});
	/* 	location.href = basePath
				+ "/jsp/zh/wd/rmp/log/wdRmpAppLogDetail.jsp?id=" + id; */
	}

	function add() {
		location.href = basePath + "/jsp/zh/wd/rmp/log/wdRmpAppLogAdd.jsp";
	}

	function del(id) {
		$.ajax({
			type : "get",
			url : basePath + "/wdRmpAppLog/delete",
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
</script>
</html>
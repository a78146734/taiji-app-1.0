<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>用户管理</title>
<meta charset="UTF-8">
<%@ include file="../../commons/global.jsp"%>
<%@ include file="../../commons/basejs.jsp"%>
<link rel="stylesheet" href="${base }/static/adminModule/rightPage/css/biaodancss.css">
<style type="text/css">
</style>
</head>
<body>
	
		<div class="hj_username" id="search" style="height: 50px;" >
			<span>
				<%-- <input name="userIds" data-condition="like" type="hidden" value="${userIds}" class="hj_usernameinp"> --%>
				<input name="organIds" data-condition="eq" type="hidden" value="${organId}" class="hj_usernameinp">
			</span>
			<span class="hj_usertxtname">姓名：</span>
			<span>
				<input name="username" data-condition="like"  type="text" value="" class="hj_usernameinp">
			</span>
			<span class="hj_usertxtname">用户名：</span>
			<span>
				<input name="loginName" data-condition="like"  type="text" value="" class="hj_usernameinp">
			</span>
			<span>
				&nbsp;&nbsp;&nbsp;&nbsp;<button onclick="Query();" class="button" type="button">查询</button>
			</span>
		</div>
		<div class="hj_user">
			<table class="gridtable03" style="width: 100%;">
				<tr>
					<th style="width: 5%;">序号</th>
					<th style="width: 15%;">姓名</th>
					<th style="width: 15%;">用户名</th>
					<th style="width: 35%;">创建时间</th>
					<th style="width: 15%;">用户类型</th>
					<th style="width: 15%;">状态</th>
				</tr>
				<tbody id="tb">
				</tbody>
			</table>
		</div>
		<form id="form1">
		<div class="page">
			<%@ include file="../../commons/page.jsp"%>
		</div>
	</form>
</body>

<script type="text/javascript">
$(function(){
	doQuery();
});

function Query(){
	$("[name=nowpage]").val("1");
	doQuery();
}

//查询执行方法
function doQuery(){
	var condition=new Array();
	$('#search').find("input").each(function(i,obj){
		var val=$(obj).val();
		if(val!=null&&val!=''){
			if($(obj).attr("name")=="organIds"){
				var conditionItem={
						name:$(obj).attr("name"),
						value:$(obj).val(),
						condition:$(obj).data("condition")
					}
			}else{
				var conditionItem={
					name:$(obj).attr("name"),
					value:"%"+$(obj).val()+"%",
					condition:$(obj).data("condition")
				}
			}
			condition.push(conditionItem);
		}
	});
	//转换分页信息到param
	var params = swichPageInfo(condition);
	$.ajax({
 		type: "post",
 		url: "<%=basePath%>/user/dataOrganGrid",
 		data: JSON.stringify(params),
 		contentType: "application/json; charset=utf-8",
 		async: true,
 		dataType: "json",
			success : function(data) {
				data=data.obj;
	 			pageValue(data);
				var tb = new StringBuilder();
				$.each(data.rows, function(i, obj) {
					tb.append("<tr id='").append(obj.userId).append("'><td>").append(++i).append("</td>");
					tb.append("<td>").append(obj.username).append("</td>");
					tb.append("<td>").append(obj.loginName).append("</td>");
					tb.append("<td>")+tb.append(obj.createTime).append("</td>");
					if (obj.saveType == "20250") {
						tb.append("<td>管理员</td>");
					} else if (obj.saveType == "20251") {
						tb.append("<td>用户</td>");
					} else {
						tb.append("<td>未知类型</td>");
					}

					if (obj.usingState == "20255") {
						tb.append("<td>启用</td>");
					} else if (obj.usingState == "20256") {
						tb.append("<td>停用</td>");
					}

				});
				$("#tb").html(tb.toString());
			}
		});
	}
</script>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<%@include file="../../../../../commons/global.jsp"%>
	<%@include file="../../../../../commons/xw/basejs.jsp"%>
		<script type="text/javascript" src="js/wdRmpAppLogList.js"></script>
			<link rel="stylesheet" type="text/css" href="css/wdRmpAppLogList.css">
<style type="text/css">
body {
	min-width: 1250px;
}
</style>		
</head>
<body >
<table class="gridtable03">
<tr>
	<td style="width:45%">
		<div id="mainGraph" style="width:100%;height:350px;"></div>
	</td>
	<td style="width:45%">
		<div id="mainGraph2" style="width:100%;height:350px;"></div>
	</td>

</tr>

</table>

<form id="form1">
	<div class="user_manage">
				<p class="ri_jczctitle">
					<span class="ri_jczctitletxt">功能统计</span> 
						<span class="ri_jczctitlemore butimg" onclick="sideDiv(this);"></span>
				</p>
			<div class="hj_username">
				<div class="hj_username1">
			<span><input name="logPService" type="hidden"  value="${pid}"></span>
		<span class="hj_usertxtname">日志级别：</span> 
		<span><input name="logLevel" type="text"  class="hj_usernameinp"></span>
	   
		<span class="hj_usertxtname">系统标识：</span> 
		<span><input name="sysCode" type="text"  class="hj_usernameinp"></span>					
		<span>&nbsp;&nbsp;<button onclick="Query();" class="button" type="button">确定</button></span>
		<span>&nbsp;&nbsp;<button onclick="back();" class="button" type="button">返回</button></span>
		 
		</div>	
		</div>					
				
		<div id="hj_username_2" class="hj_username_2">
				<div class="hj_username1">
        <span class="hj_usertxtname">模块名称：</span> 
		<span><input name="logPServiceName" type="text"  class="hj_usernameinp"></span>
		<span class="hj_usertxtname">功能名称：</span> 
		<span><input name="serviceFunction" type="text"  class="hj_usernameinp"></span>			

				</div>
			</div>
			
		<div class="hj_user">
			<table class="gridtable03">
			
				<tr >
			   	<th style="width: 2%;">序号</th>
				<th  style="width: 8%;"><a id="LOG_LEVEL" class="tha" onclick="sort(this);"><span>日志级别</span><i class="thimg" ></i></a></th>
				<th  style="width: 10%;"><a id="LOG_MESSAGE" class="tha" onclick="sort(this);"><span>信息</span><i class="thimg" ></i></a></th>
				<th  style="width: 10%;"><a id="LOG_DATE" class="tha" onclick="sort(this);"><span>日期</span><i class="thimg" ></i></a></th>
				<th  style="width: 10%;"><a id="USER_ID" class="tha" onclick="sort(this);"><span>操作人ID</span><i class="thimg" ></i></a></th>
				<th  style="width: 10%;"><a id="LOG_IP" class="tha" onclick="sort(this);"><span>操作人IP</span><i class="thimg" ></i></a></th>
				<th  style="width: 10%;"><a id="SYS_CODE" class="tha" onclick="sort(this);"><span>系统标示</span><i class="thimg" ></i></a></th>
				<th  style="width: 5%;"><a id="SERVICE_STATUS" class="tha" onclick="sort(this);"><span>申请结果</span><i class="thimg" ></i></a></th>
				<th  style="width: 10%;"><a id="LOG_P_SERVICE_NAME" class="tha" onclick="sort(this);"><span>应用名称</span><i class="thimg" ></i></a></th>
				<th  style="width: 5%;"><a id="SERVICE_TYPE" class="tha" onclick="sort(this);"><span>服务类型</span><i class="thimg" ></i></a></th>
				<th  style="width: 10%;"><a id="SERVICE_FUNCTION" class="tha" onclick="sort(this);"><span>功能名称</span><i class="thimg" ></i></a></th>
				<th style="width:10%">操作</th>
				</tr>
				 
		<!-- 	   <th style="width: 2%;">序号</th>
																			<th  style="width: 8%;">日志级别</th>
																<th  style="width: 10%;">模块名称</th>
																<th  style="width: 10%;">功能名称</th>
																<th  style="width: 10%;">操作类型</th>
																<th  style="width: 10%;">备注信息</th>
																 
																<th  style="width: 15%;">日期</th>
																<th  style="width: 10%;">操作人ID</th>
																<th  style="width: 10%;">操作人IP</th>
 
											<th style="width:15%;">操作</th>
				</tr> -->

			<tbody id="tb" >
				
			</tbody>
			</table>
			</div>

			</div>

	<div  class="page"><%@include
			file="../../../../../commons/xw/page.jsp"%></div>		
	</form>
</body>
<script type="text/javascript">
		var pName = [];
		//初始加载
		$(document).ready(function(){
			doQuery();
			graphQuery();
		 	$("#btnQuery").click(function(){
				$("[name=pageNo]").val("0");
				doQuery();
		 	});
		});
		
		//点击查询
		function Query(){
			$("[name=pageNo]").val("1");
			doQuery();
		}
		
		//查询执行方法
		function doQuery(){
			var params = $("#form1").serialize();
			$.ajax({
		 		type: "post",
		 		url: basePath+"/wdRmpAppServiceApplyLog/list",
		 		data:params,
		 		async: false,
		 		dataType: "text",
		 		success: function(data){
		 			var das = JSON.parse(data); 
		 			if(pageValue(das.obj)){return;}
		 			if(das.obj.rows.length!=0)
		 			{
		 				pName.push(das.obj.rows[0].logPServiceName);
		 			}
		 			var sb = new StringBuilder();
		 			$.each(das.obj.rows,function(i,obj){ 
			  			 sb.append("<tr><td>").append(++i).append("</td>");
						 sb.append("<td >").append(obj.logLevel,15).append("</td>");
						 sb.append("<td >").append(obj.logMessage,15).append("</td>");
						 sb.append("<td >").append(obj.logDate,20).append("</td>");
						 sb.append("<td >").append(obj.userId,15).append("</td>");
						 sb.append("<td >").append(obj.logIp,15).append("</td>");
						 sb.append("<td >").append(obj.sysCode,15).append("</td>");
						 if(obj.serviceStatus == "0"){
							 sb.append("<td >").append("审核失败",15).append("</td>");
						 }
						 else if(obj.serviceStatus == "1"){
							 sb.append("<td >").append("审核通过",15).append("</td>");
						 }
						 else if(obj.serviceStatus == "2"){
							 sb.append("<td >").append("提交",15).append("</td>");
						 }
						 sb.append("<td >").append(obj.logPServiceName,15).append("</td>");
						 if(obj.serviceType=="1"){
							 sb.append("<td >").append("应用服务",15).append("</td>");
						 }
						 else if(obj.serviceType=="2"){
							 sb.append("<td >").append("数据服务",15).append("</td>");
						 }
						 sb.append("<td >").append(obj.serviceFunction,15).append("</td>");
						 sb.append("<td >");
						 sb.append("<a class='hj_mar20' onclick='select(\"").append(obj.id).append("\")'><i class='icon icon-search hj_bianji'></i><span class='hj_mar20'>查看</span></a>");

			  			});
		 			 $("#tb").html(sb.toString());	 			 
		 		}
 			});
		}
		
		
		function update(id){
			location.href=basePath+"/jsp/zh/wd/rmp/log/wdRmpAppLogUpdate.jsp?id="+id;
		}
		
		function select(id){
			location.href=basePath+"/jsp/zh/wd/rmp/log/wdRmpAppLogDetail.jsp?id="+id;
		}
		
		function add(){
			location.href=basePath+"/jsp/zh/wd/rmp/log/wdRmpAppLogAdd.jsp";
		}	
		
		function del(id){
			$.ajax({
		 		type: "get",
		 		url: basePath+"/wdRmpAppLog/delete",
		 		data:{
		 			"id":id
		 		},
		 		async: true,
		 		dataType: "text",
		 		success: function(data){
		 			var das = JSON.parse(data); 
		 			if(das.success){
		 				doQuery();
		 			}else{
		 				alert("删除失败");
		 			}
		 		}
 			});
		}
		function back() {
			history.back(1);
		//	location.href=basePath + "/jsp/zh/wd/rmp/log/wdRmpAppServiceLogList.jsp";
		}
		
		var myChart = echarts.init(document.getElementById('mainGraph'),'macarons');
		var pieData= [];
		var pieSeriesData = [];

		var myChart2 = echarts.init(document.getElementById('mainGraph2'),'macarons');
		var xData2= [];
		var ySeriesData2 = [];
		
		function graphQuery(){
			 var option = {
					    title : {
					        text: pName[0]+'功能申请数',
					        x : 'center'
					    },
					    tooltip : {
					        trigger: 'item',
					        formatter: "{a} <br> {b} : {c} ({d}%)"
					    },
					    legend: {
					        orient : 'vertical',
					        x : 'left',
					        data:pieData
					    },
					    toolbox: {
					        show : true,
					        feature : {
					            mark : {show: true},
					            dataView : {show: true, readOnly: false},
					            magicType : {
					                show: true, 
					                type: ['pie', 'funnel'],
					                option: {
					                    funnel: {
					                        x: '25%',
					                        width: '50%',
					                        funnelAlign: 'left' 
					                    }
					                }
					            },
					            restore : {show: true},
					            saveAsImage : {show: true}
					        }
					    },
					    /* grid:{
				            x:'20px',
				            x2:'20px'
				     //       y:'40px',
				     //       y2:'40px'
				        }, */
					    calculable : true,
					    series : [
					        {
					            name:'申请数',
					            type:'pie',
					            radius : '55%',
					            center: ['50%', '60%'],
					            itemStyle:{ 
					                normal:{ 
					                      label:{ 
					                        show: true, 
					                        formatter: '{b} : {c} ({d}%)' 
					                      }, 
					                      labelLine :{show:true} 
					                    } 
					                },
					            data: pieSeriesData
					        }
					    ]
					};
	 
			 $.ajax({
		 		type: "post",
		 		url: basePath+"/dataAnalysis/totalApplyFunc",
				data:{"pid":"${pid}"},	 
		 		async: false,
		 		dataType: "json",  //text
		 		beforeSend: function(){},
	            complete: function(){},
		 		success: function(data){
		 			if(data.obj.length>0){

		 	 		$.each(data.obj,function(i,map){ 
		 	 			pieSeriesData.push({value:parseInt(map["COUNTS"]),name:map["FUNCTIONS"]});
		 	 			pieData.push(map["FUNCTIONS"]);
		 	 			
		 	 		});
		 			}
		 		}
			}); 
			
			
			myChart.setOption(option);
			
			 var option2 = {
					    title : {
					        text: pName[0]+'功能通过率' 
					         
					    },
					    tooltip : {
					        trigger: 'item',  //axis
					        	formatter: "{a} <br> {b} : {c} ({d}%)"
		//			        ,axisPointer: {
		//			            type: 'none'
		//			            }
					    },
					    legend: {
					        data:[]
					    },
					    toolbox: {
					        show : true,
					        feature : {
					            mark : {show: true},
					            dataView : {show: true, readOnly: false},
					            magicType : {show: true, type: ['line', 'bar']},
					            restore : {show: true},
					            saveAsImage : {show: true}
					        }
					    },
					    grid:{
				            x:'40px',
				            x2:'40px',
				            y:'70px',
				            y2:'10px'
				        },
					    calculable : true,
					    xAxis : [
					        {
					            type : 'category',
					            data : xData2
					        }
					    ],
					    yAxis : [
					        {
					            type : 'value',
					            name : '%',
					            min: 0,
			                    max: 100
					        }
					    ],
					    series : [
					        {
					            name:"通过率",
					            type:'bar',
					            data:ySeriesData2,
					            itemStyle: {
				                    normal: {
				                        color: function(params) {
				                            var colorList = [
				                            	 '#C1232B','#B5C334','#FCCE10','#E87C25','#27727B',
				                                 '#FE8463','#9BCA63','#FAD860','#F3A43B','#60C0DD',
				                                 '#D7504B','#C6E579','#F4E001','#F0805A','#26C0C0'
				                            ];
				                            return colorList[params.dataIndex]
				                        },
				                        label: {
				                            show: true,
				                            position: 'top',
				                            formatter: '{b}\n{c}%'
				                        }
				                    }
				                }/* ,
					            markPoint : {
					                data : [
					                    {type : 'max', name: '最大值'},
					                    {type : 'min', name: '最小值'}
					                ]
					            } */
					        }
					    ]
					};
			  
			 $.ajax({
			 		type: "post",
			 		url: basePath+"/dataAnalysis/applyFuncPassRate",
					data:{"pid":"${pid}"},	 
			 		async: false,
			 		dataType: "json",  //text
			 		beforeSend: function(){},
		            complete: function(){},
			 		success: function(data){
			 			if(data.obj.length>0){

			 	 		$.each(data.obj,function(i,map){ 
			 	 			ySeriesData2.push(map["PASSRATE"]);
			 	 			xData2.push(map["FUNCTIONS"]);
			 	 			
			 	 		});
			 			}
			 		}
	 			}); 
			
			myChart2.setOption(option2); 

		 	window.onresize = function () {
	 
			 	myChart.resize();
			 	myChart2.resize();
			 	myChart.resize();
			}
		}
		
	</script>
</html>
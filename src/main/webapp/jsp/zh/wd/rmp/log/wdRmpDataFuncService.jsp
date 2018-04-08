<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<%@include file="../../../../../commons/global.jsp"%>
	<%@include file="../../../../../commons/xw/basejs.jsp"%>
	<!-- 	<script type="text/javascript" src="js/wdRmpAppServiceLogList.js"></script>
			<link rel="stylesheet" type="text/css" href="css/wdRmpAppServiceLogList.css"> -->
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
				<span class="ri_jczctitletxt">服务调用日志</span> <span
					class="ri_jczctitlemore butimg" onclick="sideDiv(this);"></span>
			</p>
			<div class="hj_username">
				<div class="hj_username1">
					<span><input name="logPService" type="hidden" value="${pid}"></span>
					 <span class="hj_usertxtname">服务名称：</span> <span><input
						name="logServiceName" type="text" class="hj_usernameinp"></span>   
					 <span class="hj_usertxtname">操作人IP：</span> <span><input
						name="logIp" type="text" class="hj_usernameinp"></span>
					<span>&nbsp;&nbsp;
						<button onclick="Query();" class="button" type="button">查询</button>
					</span>  
					<span>&nbsp;&nbsp;<button onclick="back();" class="button" type="button">返回</button></span>
					 
				</div>
			</div>

			<div id="hj_username_2" class="hj_username_2">
				<div class="hj_username1">
					<span class="hj_usertxtname">操作人ID：</span> <span><input
						name="userId" type="text" class="hj_usernameinp"></span>
				</div>
			</div>

			<div class="hj_user">
				<table class="gridtable03">
					<tr>
						<th style="width: 2%;" >序号</th>
						<th style="width: 8%;" ><a id="LOG_LEVEL" class="tha"
							onclick="sort(this);"><span>日志级别</span><i class="thimg"></i></a></th>
						<!-- <th style="width: 10%;" ><a id="LOG_P_SERVICE_NAME" class="tha"
							onclick="sort(this);"><span>模块名称</span><i class="thimg"></i></a></th>		 -->			
						<th style="width: 15%;"><a id="LOG_SERVICE_NAME" class="tha"
							onclick="sort(this);"><span>服务名称</span><i class="thimg"></i></a></th>	
						<th style="width: 10%;"><a id="LOG_SERVICE_PATH" class="tha"
							onclick="sort(this);"><span>服务路径</span><i class="thimg"></i></a></th>	
						<th style="width: 15%;"><a id="LOG_MESSAGE" class="tha"
							onclick="sort(this);"><span>信息</span><i class="thimg"></i></a></th>	
						<th style="width: 15%;"><a id="LOG_DATE" class="tha"
							onclick="sort(this);"><span>日期</span><i class="thimg"></i></a></th>	
					<!-- 	<th style="width: 10%;"><a id="USER_ID" class="tha"
							onclick="sort(this);"><span>操作人ID</span><i class="thimg"></i></a></th>	 -->
						<th style="width: 10%;"><a id="LOG_IP" class="tha"
							onclick="sort(this);"><span>操作人IP</span><i class="thimg"></i></a></th>	
						<th style="width: 15%">操作</th>
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
			$("[name=nowpage]").val("1");
			doQuery();
		}
 
		//查询执行方法
		function doQuery(){
			var params = $("#form1").serialize();
			$.ajax({
		 		type: "post",
		 		url: basePath+"/wdRmpAppDataServiceLog/list",
		 		data:params,
		 		async: false,
		 		dataType: "text",
		 		success: function(data){
		 			var das = JSON.parse(data); 
		 			
		 			/* if(das.obj.rows.length!=0)
		 			{
		 				pName.push(das.obj.rows[0].logPServiceName);
		 			}else{
		 				pName.push("");
		 			} */
		 			pName.push("${pname}");
		 			if(pageValue(das.obj)){return;}
		 			var sb = new StringBuilder();
		              $.each(das.obj.rows,function(i,obj){ 
				  			 sb.append("<tr><td>").append(++i).append("</td>");
							 sb.append("<td >").append(obj.logLevel,15).append("</td>");
				//			 sb.append("<td >").append(obj.logPServiceName,20).append("</td>");
							 sb.append("<td >").append(obj.logServiceName,20).append("</td>");
							 sb.append("<td >").append(obj.logServicePath,50).append("</td>");
							 sb.append("<td >").append(obj.logMessage,15).append("</td>");
							 sb.append("<td >").append(obj.logDate,20).append("</td>");
				//			 sb.append("<td >").append(obj.userId,15).append("</td>");
							 sb.append("<td >").append(obj.logIp,15).append("</td>");

						 sb.append("<td ><i class='icon icon-search hj_bianji'></i><span class='hj_mar20'><a class='hj_mar20' onclick='select(\"").append(obj.id).append("\")'>查看</a></span>"); 
			  			});
		 			 $("#tb").html(sb.toString());	 			 
		 		}
				});
		}
		
		
		function update(id){
			location.href=basePath+"/jsp/zh/wd/rmp/log/wdRmpAppDataServiceLogUpdate.jsp?id="+id;
		}
		
		function select(id){
			location.href=basePath+"/jsp/zh/wd/rmp/log/wdRmpAppDataServiceLogDetail.jsp?id="+id;
		}
		
		function add(){
			location.href=basePath+"/jsp/zh/wd/rmp/log/wdRmpAppDataServiceLogAdd.jsp";
		}	
		
		function del(id){
			$.ajax({
		 		type: "get",
		 		url: basePath+"/wdRmpAppDataServiceLog/delete",
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
		}
 
		var myChart = echarts.init(document.getElementById('mainGraph'),'macarons');
		var xData= [];
		var ySeriesData = [];
		
		var myChart2 = echarts.init(document.getElementById('mainGraph2'),'macarons');
		var xData2= [];
		var ySeriesData2 = [];
		
		function graphQuery(){
			 var option = {
					    title : {
					        text: '近7天使用功能数量图--'+pName[0] 
					         
					    },
					    tooltip : {
					        trigger: 'axis'
					    },
					    legend: {
					        data:[]
					    },
					    toolbox: {
					        show : false,
					        feature : {
					            mark : {show: true},
					            dataView : {show: true, readOnly: false},
					            magicType : {show: true, type: ['line', 'bar']},
					            restore : {show: true},
					            saveAsImage : {show: true}
					        }
					    },
					    grid:{
				            x:'30px',
				            x2:'30px',
				           y:'60px'
				     //       y2:'40px'
				        },
					    calculable : true,
					    xAxis : [
					        {
					            type : 'category',
					            data : xData
					        }
					    ],
					    yAxis : [
					        {
					            type : 'value',
					            name : '个'
					        }
					    ],
					    series : [
					        {
					            name:pName[0],
					            type:'bar',
					            data:ySeriesData,
					            itemStyle: {
				                    normal: {
				                        color: function(params) {
				                            var colorList = [
				                            		'#C1232B','#B5C334','#FCCE10','#E87C25','#27727B',
				                                '#FE8463','#9BCA63','#FAD860','#F3A43B','#60C0DD',
				                                '#D7504B','#C6E579','#F4E001','#F0805A','#26C0C0'
				                                /* '#FF0000','#FF7F00','#FFFF00','#00FF00','#00FFFF',
					                               '#0000FF','#8B00FF' */
				                            ];
				                            return colorList[params.dataIndex]
				                        } ,
				                        label: {
				                            show: true,
				                            position: 'top',
				                            formatter: '{c}'
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
		 		url: basePath+"/dataAnalysis/graphData",
				data:{"pid":"${pid}"},	 
		 		async: false,
		 		dataType: "json",  //text
		 		beforeSend: function(){},
	            complete: function(){},
		 		success: function(data){
		 			if(data.obj.length>0){
		 			var hours;
		 	 		$.each(data.obj,function(i,map){ 
		 	 			for (var key in map) {  
		 	 				if(key=="STATUS"){
		 	 					ySeriesData.push(parseInt(map[key]));
		 	 				}
		 	 				else if(key=="DTIME"){
		 	 					xData.push(map[key]);
		 	 				}		
		 		        } 
		 	 		});
		 			}
		 		}
 			}); 
			
			
			myChart.setOption(option);
 			
			var option2 = {
				    title : {
				        text: '近7天平均响应时间--'+pName[0] 
				         
				    },
				    tooltip : {
				        trigger: 'axis'
				    },
				    legend: {
				    	show:false,
				    	data:pName
				    },
				    toolbox: {
				        show : false,
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
			            x2:'40px'
			     //       y:'40px',
			     //       y2:'40px'
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
				            name : 'ms'
				        }
				    ],
				    series : [
				        {
				            name:pName[0],
				            type:'line',
				            data:ySeriesData2,
				            markPoint : {
				                data : [
				                    {type : 'max', name: '最大值'},
				                    {type : 'min', name: '最小值'}
				                ]
				            },
				            markLine : {
				                data : [
				                    {type : 'average', name: '平均值'}
				                ]
				            }
				        }
				    ]
				};
			
			$.ajax({
		 		type: "post",
		 		url: basePath+"/dataAnalysis/rTimeGraphData",
				data:{"pid":"${pid}"},	 
		 		async: false,
		 		dataType: "json",  //text
		 		beforeSend: function(){},
	            complete: function(){},
		 		success: function(data){
		 			if(data.obj.length>0){
		 			var hours;
		 	 		$.each(data.obj,function(i,map){ 
		 	 			for (var key in map) {  
		 	 				if(key=="RTIME"){
		 	 					ySeriesData2.push(parseInt(map[key]));
		 	 				}
		 	 				else if(key=="DTIME"){
		 	 					xData2.push(map[key]);
		 	 				}		
		 		        } 
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
		
		function back() {
			history.back(1);
		}
	</script>
</html>
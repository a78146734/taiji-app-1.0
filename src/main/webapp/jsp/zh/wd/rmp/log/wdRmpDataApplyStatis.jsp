<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@include file="../../../../../commons/global.jsp"%>
<%@include file="../../../../../commons/xw/basejs.jsp"%>
<!-- <script type="text/javascript" src="js/wdRmpAppLogList.js"></script>
<link rel="stylesheet" type="text/css" href="css/wdRmpAppLogList.css"> -->
</head>
<body>
	<table class="gridtable03">
		<tr>
			<td style="width:45%">
				<div id="mainGraph" style="width:100%;height:350px;"></div>
			</td>
			<td style="width:45%">
				<div id="mainGraph3" style="width:100%;height:350px;"></div>
			</td>

		</tr>

	</table>
	<table class="gridtable03">
		<tr>
			<td style="width:100%">
				<div id="mainGraph2" style="width:100%;height:400px;"></div>
			</td>
		</tr>

	</table>
	<table class="gridtable03">
		<tr>
			<td style="width:100%">
				<div id="mainGraph4" style="width:100%;height:400px;"></div>
			</td>

		</tr>

	</table>
	<form id="form1">
		<div class="user_manage">
			<p class="ri_jczctitle">
				<span class="ri_jczctitletxt">服务信息</span> <span
					class="ri_jczctitlemore butimg" onclick="sideDiv(this);"></span>
			</p>
			<div class="hj_username">
				<div class="hj_username1">
				<input name="serverStatus" type="hidden" class="hj_usernameinp" value="2">
					<span class="hj_usertxtname">服务名称：</span> <span><input
						name="serverName" type="text" class="hj_usernameinp"></span> 
						<span class="hj_usertxtname">服务编号：</span> <span><input
						name="serverNumber" type="text" class="hj_usernameinp"></span> 
						 <span>&nbsp;&nbsp;
						<button onclick="Query();" class="button" type="button">查询</button>
					</span>  
				</div>
			</div>

			<div id="hj_username_2" class="hj_username_2">
				<div class="hj_username1">
					<span class="hj_usertxtname">服务概述：</span> <span><input
						name="serverSummary" type="text" class="hj_usernameinp"></span>
				</div>
			</div>

			<div class="hj_user">
				<table class="gridtable03">
					<tr>
						<th style="width: 5%;">序号</th>
						<th style="width: 15%;"><a id="SERVER_TYPE" class="tha"
							onclick="sort(this);"><span>服务类型</span><i class="thimg"></i></a></th>
						<th style="width: 20%;"><a id="SERVER_NAME" class="tha"
							onclick="sort(this);"><span>服务名称</span><i class="thimg"></i></a></th>
						<th style="width: 35%;"><a id="SERVER_SUMMARY" class="tha"
							onclick="sort(this);"><span>服务概述</span><i class="thimg"></i></a></th>
						<th style="width: 25%;"><a id="SERVER_DATE" class="tha"
							onclick="sort(this);"><span>注册时间</span><i class="thimg"></i></a></th>
						<!-- <th style="width:20%;">操作</th> -->
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
		$(document).ready(function(){
			loadOrgan();
			graphQuery();
		 	doQuery();
		 	$("#btnQuery").click(function(){
				$("[name=pageNo]").val("0");
				doQuery();
		 	});
		});
		
		var organList=[];
		function loadOrgan(){
			$.ajax({
		 		type: "post", 
		 		url: basePath+"/wdSspApply/selectOrgan",
		 		data:"",
		 		async: false,
		 		dataType: "text",
		 		beforeSend: function(){},
	            complete: function(){},
		 		success: function(data){
		 			var das = JSON.parse(data); 
		              $.each(das.obj,function(i,obj){ 
		            	  organList.push({name:obj.organName,code:obj.organCode});
		              });
		 		}
				});
		}
		
		//点击查询
		function Query(){
			$("[name=nowpage]").val("1");
			$("[name=pageNo]").val("1");
			doQuery();
		}
		
		//查询执行方法
		function doQuery(){
			var params = $("#form1").serialize();
			$.ajax({
		 		type: "post",
		 		url: basePath+"/wdSspServer/list",
		 		data:params,
		 		async: false,
		 		dataType: "text",
		 		success: function(data){
		 			var das = JSON.parse(data); 
		 			if(pageValue(das.obj)){return;}
		 			var sb = new StringBuilder();
		              $.each(das.obj.rows,function(i,obj){ 
		            	  sb.append("<tr><td>").append(++i).append("</td>");
		            	/*   if(obj.serverStatus == 1){
		            		  sb.append("<td >").append("应用服务",15).append("</td>");
		            	  }else if(obj.serverStatus == 2){
		            		  sb.append("<td >").append("数据服务",15).append("</td>");
		            	  }else if(obj.serverStatus == 3){
		            		  sb.append("<td >").append("安全服务",15).append("</td>");
		            	  } */
		 				 
		            	 sb.append("<td >").append(obj.serverType,15).append("</td>");
		 				 sb.append("<td >").append(obj.serverName,15).append("</td>");
		 				 sb.append("<td >").append(obj.serverSummary,15).append("</td>");
		 				 sb.append("<td >").append(obj.serverDate,25).append("</td>");
		 				 
		 	//			 sb.append("<td >");
		 	//			 sb.append("<i class='icon icon-search hj_bianji'></i><span class='hj_mar20'><a class='hj_mar20' onclick='selectchild(\"").append(obj.serverId).append("\")'>功能详情</a></span>");
		 				   
		              });
		 			 $("#tb").html(sb.toString());	 			 
		 		}
 			});
		}
		
	  	function selectchild(pid){
			location.href=basePath+"/dataAnalysis/applyFuncStatis?pid="+pid;
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
		
		
		var myChart = echarts.init(document.getElementById('mainGraph') ,'macarons');
		var pieData= [];
		var pieSeriesData = [];

		var myChart2 = echarts.init(document.getElementById('mainGraph2') ,'macarons');
		var xData2= [];
		var ySeriesData2 = [];
		
		var myChart3 = echarts.init(document.getElementById('mainGraph3'),'macarons');
		var pieData2= [];
		var pieSeriesData2 = [];
		
		var myChart4 = echarts.init(document.getElementById('mainGraph4'),'macarons');
		var xData3= [];
		var ySeriesData3 = [];
		
		function graphQuery(){
			 var option = {
					    title : {
					    	textStyle : {
					    		 fontSize: 18,
					    		 fontFamily:'Microsoft YaHei',
					    		    fontWeight: 'bolder',
					    		    color: '#333'
					    	 },
					    	text: '各数据服务申请数',
					        x : 'center'
					    },
					    tooltip : {
					        trigger: 'item',
					        formatter: "{a} <br> {b} : {c} ({d}%)"
					    },
					    legend: {
					    	show:false,
					    	orient : 'vertical',
					        x : 'left',
					        data:pieData
					    },
					    toolbox: {
					        show : false,
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
		 		url: basePath+"/dataAnalysis/totalApply",
				data:{"modular":"2"},
		 		async: false,
		 		dataType: "json",  //text
		 		beforeSend: function(){},
	            complete: function(){},
		 		success: function(data){
		 			if(data.obj.length>0){

		 	 		$.each(data.obj,function(i,map){ 
		 	 			pieSeriesData.push({value:parseInt(map["COUNTS"]),name:map["SERVICES"]});
		 	 			pieData.push(map["SERVICES"]);
		 	 			
		 	 		});
		 			}
		 		}
 			}); 
			
			
			myChart.setOption(option);
 			
			 var option2 = {
					    title : {
					    	textStyle : {
					    		 fontSize: 18,
					    		 fontFamily:'Microsoft YaHei',
					    		    fontWeight: 'bolder',
					    		    color: '#333'
					    	 },
					    	text: '各数据服务申请通过率' 
					         
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
				    //         x:'40px',
				    //        x2:'40px',
					//            y:'70px',
					            y2:'80px' 
				        },
					    calculable : true,
					    xAxis : [
					        {
					            type : 'category',
					     //       axisLabel:{  
					     //       	interval: 0,
					     //       	rotate: -30
					     //       },
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
					            barMaxWidth: '100',
					            data:ySeriesData2,
					            itemStyle: {
				                    normal: {
				                        color: function(params) {
				                            var colorList = [
				                            	 '#2ec7c9','#b6a2de','#5ab1ef','#ffb980','#d87a80',
				                                 '#8d98b3','#e5cf0d','#97b552','#95706d','#dc69aa',
				                                 '#07a2a4','#9a7fd1','#588dd5','#f5994e','#c05050',
				                                 '#59678c','#c9ab00','#7eb00a','#6f5553','#c14089',
				                                 
				                                 '#ed9678','#e7dac9','#cb8e85','#f3f39d','#c8e49c',
				                                 '#f16d7a','#f3d999','#d3758f','#dcc392','#2e4783',
				                                 '#82b6e9','#ff6347','#a092f1','#0a915d','#eaf889',
				                                 '#6699FF','#ff6666','#3cb371','#d5b158','#38b6b6'
				                                 
				                                 
				                            ];
				                            return colorList[params.dataIndex]
				                        },
				                        label: {
				               //             show: true,
				              //              position: 'top',
				               //             formatter: '{b}\n{c}%'
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
			 		url: basePath+"/dataAnalysis/applyPassRate",
					data:{"modular":"2"},	 
			 		async: false,
			 		dataType: "json",  //text
			 		beforeSend: function(){},
		            complete: function(){},
			 		success: function(data){
			 			if(data.obj.length>0){

			 	 		$.each(data.obj,function(i,map){ 
			 	 			ySeriesData2.push(map["PASSRATE"]);
			 	 			xData2.push(map["SERVICES"]);
			 	 			
			 	 		});
			 			}
			 		}
	 			}); 
			
			myChart2.setOption(option2);
 
			 var option3 = {
					    title : {
					    	textStyle : {
					    		 fontSize: 18,
					    		    fontWeight: 'bolder',
					    		    color: '#333'
					    	 },
					    	text: '各部门服务申请数',
					        x : 'center'
					    },
					    tooltip : {
					        trigger: 'item',
					        formatter: "{a} <br> {b} : {c} ({d}%)"
					    },
					    legend: {
					    	show:false,
					    	orient : 'vertical',
					        x : 'left',
					        data:pieData2
					    },
					    toolbox: {
					        show : false,
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
					            data: pieSeriesData2
					        }
					    ]
					};
	 
	//		 pieData2.push("其他");
	//		 pieSeriesData2.push({value:0,name:"其他"});
			 $.ajax({
		 		type: "post",
		 		url: basePath+"/dataAnalysis/systemApply",
				data:{"modular":"2"},
		 		async: false,
		 		dataType: "json",  //text
		 		beforeSend: function(){},
	            complete: function(){},
		 		success: function(data){
		 			if(data.obj.length>0){

		 	 		$.each(data.obj,function(t,map){ 
		 	 			if(t < 10){
		 	 				var inList=0;
			 	 			for(var i =0;i<organList.length;i++){ 
			            		  if(map["SYSTEMS"] == organList[i]["code"]){
			            			  var inList=1;
			            			  pieSeriesData2.push({value:parseInt(map["COUNTS"]),name:organList[i]["name"]});
			            			  pieData2.push(organList[i]["name"]);
			            		  }
			            	  } 
			 	 			if(inList==0){
			 	 				if(pieData2.indexOf("其他") > -1){
			 	 					pieSeriesData2[pieData2.indexOf("其他")]["value"] += parseInt(map["COUNTS"]);
			 	 				}else{
			 	 					pieData2.push("其他");
				 	 				pieSeriesData2.push({value:parseInt(map["COUNTS"]),name:"其他"});
			 	 				}
			 	 			}
		 	 			}else{
		 	 				if(pieData2.indexOf("其他") > -1){
		 	 					pieSeriesData2[pieData2.indexOf("其他")]["value"] += parseInt(map["COUNTS"]);
		 	 				}else{
		 	 					pieData2.push("其他");
			 	 				pieSeriesData2.push({value:parseInt(map["COUNTS"]),name:"其他"});
		 	 				}
		 	 			}
		 	 		});
		 			}
		 		}
			}); 
			
			myChart3.setOption(option3);
			
			var option4 = {
				    title : {
				    	textStyle : {
				    		 fontSize: 18,
				    		 fontFamily:'Microsoft YaHei',
				    		    fontWeight: 'bolder',
				    		    color: '#333'
				    	 },
				    	text: '各部门服务申请通过率' 
				         
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
			//             x:'40px',
			//            x2:'40px',
			//	            y:'70px',
				            y2:'80px' 
			        },
				    calculable : true,
				    xAxis : [
				        {
				            type : 'category',
				            axisLabel:{  
				            	interval: 0,
				            	rotate: -30
				            },
				            data : xData3
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
				            barMaxWidth: '100',
				            data:ySeriesData3,
				            itemStyle: {
			                    normal: {
			                        color: function(params) {
			                            var colorList = [
			                            	 '#2ec7c9','#b6a2de','#5ab1ef','#ffb980','#d87a80',
			                                 '#8d98b3','#e5cf0d','#97b552','#95706d','#dc69aa',
			                                 '#07a2a4','#9a7fd1','#588dd5','#f5994e','#c05050',
			                                 '#59678c','#c9ab00','#7eb00a','#6f5553','#c14089',
			                                 
			                                 '#ed9678','#e7dac9','#cb8e85','#f3f39d','#c8e49c',
			                                 '#f16d7a','#f3d999','#d3758f','#dcc392','#2e4783',
			                                 '#82b6e9','#ff6347','#a092f1','#0a915d','#eaf889',
			                                 '#6699FF','#ff6666','#3cb371','#d5b158','#38b6b6',
			                                 
			                                 '#44B7D3','#E42B6D','#F4E24E','#FE9616','#8AED35',
			                                 '#ff69b4','#ba55d3','#cd5c5c','#ffa500','#40e0d0',
			                                 '#E95569','#ff6347','#7b68ee','#00fa9a','#ffd700',
			                                 '#6699FF','#ff6666','#3cb371','#b8860b','#30e0e0'
			                            ];
			                            return colorList[params.dataIndex]
			                        },
			                        label: {
			               //             show: true,
			               //             position: 'top',
			               //             formatter: '{b}\n{c}%'
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
		 		url: basePath+"/dataAnalysis/systemPassRate",
				data:{"modular":"2"},	 
		 		async: false,
		 		dataType: "json",  //text
		 		beforeSend: function(){},
	            complete: function(){},
		 		success: function(data){
		 			if(data.obj.length>0){

		 	 		$.each(data.obj,function(i,map){ 
		 	 			ySeriesData3.push(map["PASSRATE"]);
		 	 			var inList=0;
		 	 			for(var i =0;i<organList.length;i++){ 
		            		  if(map["SYSTEMS"] == organList[i]["code"]){
		            			  inList=1;
		            			  xData3.push(organList[i]["name"]);
		            		  }
		            	  }
		 	 			if(inList==0){
		 	 				xData3.push(map["SYSTEMS"]);
		 	 			}
		 	 	//		xData3.push(map["SYSTEMS"]);
		 	 			
		 	 		});
		 			}
		 		}
 			}); 
		
		myChart4.setOption(option4);
			
	 	window.onresize = function () {
	 		 
		 	myChart.resize();
		 	myChart2.resize();
		 	myChart3.resize();
		 	myChart4.resize();
		 	myChart.resize();
		 	myChart3.resize();
		}
	}

	</script>
</html>
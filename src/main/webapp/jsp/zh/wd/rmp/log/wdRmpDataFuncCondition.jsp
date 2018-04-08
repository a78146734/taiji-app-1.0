<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<%@include file="../../../../../commons/global.jsp"%>
	<%@include file="../../../../../commons/xw/basejs.jsp"%>
	<!-- 	<script type="text/javascript" src="js/wdRmpAppServiceLogList.js"></script>
			<link rel="stylesheet" type="text/css" href="css/wdRmpAppServiceLogList.css"> -->
<style type="text/css">

#left{width:50%;  float:left}
#right{width:50%; float:right}
</style>		
</head>
<body >
<form id="form1">
	<div class="user_manage">
				<!-- <p class="ri_jczctitle">
					<span class="ri_jczctitletxt">运行情况</span> <span
						class="ri_jczctitlemore butimg" onclick="sideDiv(this);"></span>
				</p> -->
			<span><input name="pid" type="hidden" value="${pid}"></span>
		 	<div class="hj_username">
			 
					<span class="hj_usertxtname">服务名称：</span> 
					<span><input name="logServiceName" type="text" class="hj_usernameinp"></span>
 
					<span>&nbsp;&nbsp;&nbsp;<button onclick="Query();" class="button"
							type="button">查询</button></span>
					 <span>&nbsp;&nbsp;&nbsp;<button onclick="back();"
							class="button" type="button">返回</button></span>
		 
			</div>
			 
			<div class="hj_user">
				<table class="gridtable03">
					<tr>
						<th style="width: 5%;" >序号</th>
					 
						<th style="width: 25%;" ><a id="LOG_P_SERVICE_NAME" class="tha"
							onclick="sort(this);"><span>服务名称</span><i class="thimg"></i></a></th>	
											
						<th style="width: 30%;"><a id="LOG_SERVICE_NAME" class="tha"
							onclick="sort(this);"><span>子服务名称</span><i class="thimg"></i></a></th>	
						
						 
							
						<th style="width: 10%;"><a id="COUNTS" class="tha"
							onclick="sort(this);"><span>调用次数(次)</span><i class="thimg"></i></a></th>	
							
						<th style="width: 10%;"><a id="RTIME" class="tha"
							onclick="sort(this);"><span>平均响应时间(ms)</span><i class="thimg"></i></a></th>	
					 
						<th style="width: 10%;"><a id="DSIZE" class="tha"
							onclick="sort(this);"><span>平均数据大小(Byte)</span><i class="thimg"></i></a></th>	
					 
						<th style="width: 10%;"><a id="TOTALSIZE" class="tha"
							onclick="sort(this);"><span>大小总计(GB)</span><i class="thimg"></i></a></th>	
					</tr>
					<tbody id="tb">

					</tbody>
				</table>
				<div  class="page"><%@include
						file="page.jsp"%></div>	
			</div>
		</div>
	</form>
<table class="gridtable03">
<tr>
	<td style="width:50%">
		<div id="mainGraph" style="width:100%;height:350px;"></div>
	</td>
	<td style="width:50%">
	<div id="mainGraph3" style="width:100%;height:350px;"></div>
		
	</td>

</tr>

</table>
 
 
	
	<table class="gridtable03">
<tr>
	<td style="width:50%">
		<div id="mainGraph2" style="width:100%;height:400px;"></div>
	</td>
	<td style="width:50%">
	<div id="mainGraph4" style="width:100%;height:400px;"></div>
		
	</td>

</tr>

</table>

	<table class="gridtable03">
<tr>
	<td style="width:100%">
		<div id="mainGraph5" style="width:100%;height:400px;"></div>
	</td>

</tr>

</table>


<!-- <div class="user_manage">
  <div id="left">
  		<div id="mainGraph2" style="width:100%;height:350px;"></div>
  </div>
    <div id="right">
		 <div id="mainGraph4" style="width:100%;height:350px;"></div>  
 	</div>
 </div> -->
	 
</body>
<script type="text/javascript">
		var pName = [];
		//初始加载
		$(document).ready(function(){
			loadOrgan();
			doQuery();
			graphQuery();
	//		graphQuery2();
	//		graphQuery3();
	//		graphQuery4();
	//		graphQuery5();
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
			$("[name=pageNo]").val("1");
			$("[name=nowpage]").val("1");
			doQuery();
		}
 
		//查询执行方法
		function doQuery(){
			var params = $("#form1").serialize();
			$.ajax({
		 		type: "post",
		 		url: basePath+"/wdRmpAppDataServiceLog/serviceFuncInfo",
		 		data:params,
		 		async: false,
		 		dataType: "text",
		 		success: function(data){
		 			var das = JSON.parse(data); 
		 			if(pageValue(das.obj)){return;}
		 			var sb = new StringBuilder();
		              $.each(das.obj.rows,function(i,map){ 
		            	  pName.push(map["LOG_P_SERVICE_NAME"]);
		            	  
			  			 sb.append("<tr><td>").append(++i).append("</td>");
						 sb.append("<td >").append(map["LOG_P_SERVICE_NAME"],15).append("</td>");
						 sb.append("<td >").append(map["LOG_SERVICE_NAME"],20).append("</td>");
						 sb.append("<td >").append(map["COUNTS"],20).append("</td>");
						 sb.append("<td >").append(map["RTIME"],15).append("</td>");
						 sb.append("<td >").append(map["DSIZE"],15).append("</td>");
						 if((parseFloat(map["TOTALSIZE"])/(1024*1024*1024)).toFixed(2) <= 0){
			 					sb.append("<td >").append("< 0.01 GB").append("</td>");
			 				 }else{
			 					sb.append("<td >").append( (parseFloat(map["TOTALSIZE"])/(1024*1024*1024)).toFixed(2) +" GB",15).append("</td>");
			 				 }
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
		var ySeriesData2 = [];
		
		var myChart2 = echarts.init(document.getElementById('mainGraph2'),'macarons');
		var xData2= [];
		var ySeriesData3 = [];
		
		var myChart3 = echarts.init(document.getElementById('mainGraph3'),'macarons');
		var pieData= [];
		var pieSeriesData = [];
	 	
		var myChart4 = echarts.init(document.getElementById('mainGraph4'),'macarons');
		var xData3= [];
		var ySeriesData4 = [];
		var ySeriesData5 = [];
		
		var myChart5 = echarts.init(document.getElementById('mainGraph5'),'macarons');
		var xData55= [];
		var ySeriesData55 = [];
		
		var zrColor =  zrender.tool.color;
		
		function graphQuery(){
			 var option = {
					    title : {
					    	textStyle : {
					    		 fontSize: 18,
					    		    fontWeight: 'bolder',
					    		    color: '#333'
					    	 },
					        text: '近7天数据平均使用量--'+pName[0]
					         
					    },
					    tooltip : {
					        trigger: 'axis'
					    },
					    legend: {
					        data:[]//pName
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
				            x:'50px',
				            x2:'50px'
				     //       y:'40px',
				     //       y2:'40px'
				        },
					    calculable : true,
					    xAxis : [
					        {
					            type : 'category',
					            name : '日期',
					            data : xData
					        }
					    ],
					    yAxis : [
					   //     {
					   //         type : 'value',
					   //         name : '条数'
					  //      },
					        {
					            type : 'value',
					            name : 'KB'
					        }
					    ],
					    series : [
					 /*        {
					            name:"条数",
					            type:'bar',
					            data:ySeriesData,
					            itemStyle: {
				                    normal: {
				                        color: function(params) {
				                            var colorList = [
				                            		'#C1232B','#B5C334','#FCCE10','#E87C25','#27727B',
				                                '#FE8463','#9BCA63','#FAD860','#F3A43B','#60C0DD',
				                                '#D7504B','#C6E579','#F4E001','#F0805A','#26C0C0'
				                                
				                            ];
				                            return colorList[params.dataIndex]
				                        } 
				                    }
				                } 
					        }, 
					        {
					            name:"大小",
					            type:'line',
					            data:ySeriesData2,
					            yAxisIndex: 1,
					            markPoint : {
									data : [ {
										type : 'max',
										name : '最大值'
									}, {
										type : 'min',
										name : '最小值'
									} ]
								}
					            
					        }*/
					        {
					            name:"数据量",
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
				                            formatter: '{c}'
				                        }
				                    }
				                } 
					            
					        }
					    ]
					};
 
			 $.ajax({
		 		type: "post",
		 		url: basePath+"/dataAnalysis/graphDataCount",
				data:{"pid":"${pid}"},	 
		 		async: false,
		 		dataType: "json",  //text
		 		beforeSend: function(){},
	            complete: function(){},
		 		success: function(data){
		 			if(data.obj.length>0){
		 	 		$.each(data.obj,function(i,map){ 
		 	 	//		ySeriesData.push(parseInt(map["STATUS"]));
		 	 			xData.push(map["DTIME"]);
		 	 			ySeriesData2.push(parseFloat(map["RTIME"]/1024).toFixed(2));
		 	 			 
		 	 		});
		 			}
		 		}
 			}); 
				myChart.setOption(option);
 
			
 			
			 var option2 = {
					    title : {
					    	 textStyle : {
					    		 fontSize: 18,
					    		    fontWeight: 'bolder',
					    		    color: '#333'
					    	 },
					        text: '各子服务平均响应时间--'+pName[0] 
					         
					    },
				//	    color:['#333'],
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
				    //        x:'40px',
				     //       x2:'40px',
				              y2:'130px'
				     //       y:'40px',
				     //       y2:'40px'
				        },
					    calculable : true,
					    xAxis : [
					        {
					            type : 'category',
					            axisLabel:{  
					            	interval: 0,
					            	rotate: -30
					            },
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
					            type:'bar',
					            barMaxWidth: '100',
					            data:ySeriesData3,
					            markLine : {
					                itemStyle:{
					                    normal:{
					                        lineStyle:{
					                            type: 'dashed'
					                        }
					                    }
					                },
					                data : [
					                    [{type : 'min'}, {type : 'max'}]
					                ]
					            },
					             itemStyle: {
				                     normal: {
				                        color: function(params) {
				                        	return zrColor.getLinearGradient(
				                                    0, 0, 1000, 0,
				                                    [[0, 'rgba(30,144,255,0.5)'],[1, 'rgba(141, 0, 141,0.9)']]
				                                )
				                        } 
				                    } 
				                } 
					        }
					    ]
					};
	 
			 $.ajax({
		 		type: "post",
		 		url: basePath+"/dataAnalysis/serviceRunTime",
				data:{"pid":"${pid}"},	 
		 		async: false,
		 		dataType: "json",  //text
		 		beforeSend: function(){},
	            complete: function(){},
		 		success: function(data){
		 			if(data.obj.length>0){
		 	 		$.each(data.obj,function(i,map){ 
		 	 				xData2.push(map["SERVICES"]);
		 	 				ySeriesData3.push(parseInt(map["RTIME"]));
		 	 				 		
		 	 		});
		 			}
		 		}
			}); 
		
				myChart2.setOption(option2);
		 
			 var option3 = {
					    title : {
					    	textStyle : {
					    		 fontSize: 18,
					    		 fontFamily:'Microsoft YaHei',
					    		    fontWeight: 'bolder',
					    		    color: '#333'
					    	 },
					    	text: '子服务调用占比--'+pName[0],
					        x : 'center'
					    },
					    tooltip : {
					        trigger: 'item',
					        formatter: "{a} <br> {b} : {c} ({d}%)"
					    },
					    legend: {
					        orient : 'vertical',
					        x : 'left',
					        data:pieData,
					        selected:{}
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
					            name:'调用次数',
					            type:'pie',
					            radius : '55%',
					            center: ['55%', '55%'],
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
			 		url: basePath+"/dataAnalysis/funcUseTime",
					data:{"pid":"${pid}"},	 
			 		async: false,
			 		dataType: "json",  //text
			 		beforeSend: function(){},
		            complete: function(){},
			 		success: function(data){
			 			if(data.obj.length>0){
			 				$.each(data.obj,function(i,map){ 
				 	 			pieSeriesData.push({value:parseInt(map["COUNTS"]),name:map["SERVICES"]});
				 	 			pieData.push(map["SERVICES"]);
				 	 			 
				 	 	//		option2.legend.selected[map["SERVICES"]]=false;
				 	 			
				 	 		});
			 			}
			 		}
	 			}); 

			myChart3.setOption(option3);
			
	 
			
 			
			 var option4 = {
					    title : {
					    	 textStyle : {
					    		 fontSize: 18,
					    		    fontWeight: 'bolder',
					    		    color: '#333'
					    	 },
					        text: '各子服务数据使用量排名--'+pName[0]
					         
					    },
				//	    color:['#333'],
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
				            x:'100px',
				     //       x2:'40px',
				              y2:'130px'
				     //       y:'40px',
				     //       y2:'40px'
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
					            name : 'GB'
					        }
					    ],
					    series : [
					        {
					            name:pName[0],
					            type:'bar',
					            barMaxWidth: '100',
					            data:ySeriesData5,
					            markLine : {
					                itemStyle:{
					                    normal:{
					                        lineStyle:{
					                            type: 'dashed'
					                        }
					                    }
					                },
					                data : [
					                    [{type : 'max'},{type : 'min'} ]
					                ]
					            },
					             itemStyle: {
				                     normal: {
				                        color: function(params) {
				                        	return zrColor.getLinearGradient(
				                                    0, 0, 200, 0,
				                                    [[0, 'rgba(255, 230, 0,0.5)'],[1, 'rgba(255, 180, 0, 0.9)']]
				                                )
				                             
				                        } 
				                    } 
				                } 
					        }
					        
					    ]
					};
	 
			 $.ajax({
		 		type: "post",
		 		url: basePath+"/dataAnalysis/serviceTotalData",
				data:{"pid":"${pid}"},	 
		 		async: false,
		 		dataType: "json",  //text
		 		beforeSend: function(){},
	            complete: function(){},
		 		success: function(data){
		 			if(data.obj.length>0){
		 	 		$.each(data.obj,function(i,map){ 
		 	 				xData3.push(map["SERVICES"]);
		 	 		//		ySeriesData4.push(parseInt(map["TCOUNT"]));
		 	 		
		 	 		//		ySeriesData5.push(parseInt(map["TSIZE"]));
		 	 			if((parseFloat(map["TSIZE"])/(1024*1024*1024)).toFixed(2) <= 0){
		 	 				ySeriesData5.push(0.01);
		 	 			}else{
		 	 				ySeriesData5.push((parseFloat(map["TSIZE"])/(1024*1024*1024)).toFixed(2));
		 	 			}
		 	 				 		
		 	 		});
		 			}
		 		}
			}); 
		
				myChart4.setOption(option4);
	 

				var option5 = {
					    title : {
					    	 textStyle : {
					    		 fontSize: 18,
					    		    fontWeight: 'bolder',
					    		    color: '#333'
					    	 },
					        text: '各部门调用数量--'+pName[0]
					         
					    },
				//	    color:['#333'],
					    tooltip : {
					        trigger: 'axis'
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
				    //        x:'40px',
				     //       x2:'40px',
				              y2:'80px'
				     //       y:'40px',
				     //       y2:'40px'
				        },
					    calculable : true,
					    xAxis : [
					        {
					            type : 'category',
					            axisLabel:{  
					            	interval: 0//,
					      //      	rotate: -30
					            },
					            data : xData55
					        }
					    ],
					    yAxis : [
					        {
					            type : 'value',
					            name : '次数'
					        }
					    ],
					    series : [
					        {
					            name:pName[0],
					            type:'bar',
					            barMaxWidth: '100',
					            data:ySeriesData55,
					            markLine : {
					                itemStyle:{
					                    normal:{
					                        lineStyle:{
					                            type: 'dashed'
					                        }
					                    }
					                },
					                data : [
					                    [{type : 'max'}, {type : 'min'}]
					                ]
					            },
					             itemStyle: {
				                     normal: {
				                        color: function(params) {
				                        	return zrColor.getLinearGradient(
				                                    0, 0, 1000, 0,
				                                    [[0, 'rgba(30,144,255,0.5)'],[1, 'rgba(141, 0, 141,0.9)']]
				                                )
				                            /* var colorList = [
				                            	 
				                            	'#C1232B','#B5C334','#FCCE10','#E87C25','#27727B',
				                                '#FE8463','#9BCA63','#FAD860','#F3A43B','#60C0DD',
				                                '#D7504B','#C6E579','#F4E001','#F0805A','#26C0C0'
				                                
				                            ];
				                            return colorList[params.dataIndex] */
				                        } 
				                    } 
				                } 
					        }
					    ]
					};
	 
			 $.ajax({
		 		type: "post",
		 		url: basePath+"/dataAnalysis/organUseTime",
				data:{"pid":"${pid}"},	 
		 		async: false,
		 		dataType: "json",  //text
		 		beforeSend: function(){},
	            complete: function(){},
		 		success: function(data){
		 			if(data.obj.length>0){
		 	 		$.each(data.obj,function(i,map){ 
		 	 			var inList=0;
		 	 			for(var i =0;i<organList.length;i++){ 
		            		  if(map["SYSTEMS"] == organList[i]["code"]){
		            			  var inList=1;
		            			  xData55.push(organList[i]["name"]);
		            			  ySeriesData55.push(parseInt(map["COUNTS"]));
		            		  }
		            	  } 
		 	 			if(inList==0){
		 	 				xData55.push(map["SYSTEMS"]);
	           			  ySeriesData55.push(parseInt(map["COUNTS"]));
		 	 			}
		 	 		//		xData3.push(map["SERVICES"]);
		 	 		//		ySeriesData3.push(parseInt(map["RTIME"]));
		 	 				 		
		 	 		});
		 			}
		 		}
				}); 
			
			
			myChart5.setOption(option5);
		
	 	window.onresize = function () {
	 		 
		 	myChart.resize();
		 	myChart2.resize();
		 	myChart3.resize();
		 	myChart4.resize();
		 	myChart5.resize();
		 	myChart.resize();
		 	myChart2.resize();
		}
		 }
		function back() {
			history.back(1);
		}
	</script>
</html>
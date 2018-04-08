<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@include file="../../../../../commons/global.jsp"%>
<%@include file="../../../../../commons/xw/basejs.jsp"%>
<!-- <script type="text/javascript" src="js/wdRmpAppLogList.js"></script>
<link rel="stylesheet" type="text/css" href="css/wdRmpAppLogList.css"> -->
<style type="text/css">
#left{width:50%;float:left}
#right{width:50%; float:right}
</style>
</head>
<body>
<div class="user_manage">
<div id="left">
	<div id="mainGraph" style="width:100%;height:355px;"></div>
</div>
<div id="right">
 <form id="form1">
		<div class="user_manage">
			<div class="hj_user">
				 <table class="gridtable03">
					<tr>
						<th style="width: 4%;">序号</th>
						 
						<th style="width: 30%;"><a id="SERVER_NAME" class="tha"
							onclick="sort(this);"><span>服务名称</span><i class="thimg"></i></a></th>
						
						<th style="width: 16%;"><a id="COUNTS" class="tha"
							onclick="sort(this);"><span>调用次数</span><i class="thimg"></i></a></th>
						 
						<th style="width: 30%;"><a id="RSIZE" class="tha"
							onclick="sort(this);"><span>数据流量</span><i class="thimg"></i></a></th>
						
						<!-- <th style="width: 20%;"><a id="SERVER_DATE" class="tha"
							onclick="sort(this);"><span>注册时间</span><i class="thimg"></i></a></th>
						 -->
						  <th style="width:20%;">操作</th> 
					</tr>

					<tbody id="tb">

					</tbody>
				</table>
					<div class="page"><%@include
				file="page.jsp"%></div>
			</div>
		</div>

	
				
	</form>
</div>
</div>

	<table class="gridtable03">
		<!-- <tr>
			<td style="width:45%">
				<div id="mainGraph" style="width:100%;height:350px;"></div>
			</td>
			<td style="width:45%">
				
			</td> 

		</tr> -->
		<tr>
			<th>
			统计范围
			<select id="range" name="range" onchange="switchRange();">
  				<option value ="30d" selected = "selected">30天内</option>
  				<option value ="12m">12月内</option>
			</select>
			
			</th>
		</tr>
		<tr>
			<td style="width:100%">
				<div id="mainGraph2" style="width:100%;height:360px;"></div>
			</td>
		</tr>
		  
	</table>
 
 
	 <table class="gridtable03">
	 <tr>
			 <td style="width:50%">
				<div id="mainGraph4" style="width:100%;height:360px;"></div>
			</td>
		 
			<td style="width:50%">
				<div id="mainGraph5" style="width:100%;height:360px;"></div>
			</td>
		</tr>
	 </table>
	 
	 <table class="gridtable03">
	 <tr>
			<th>
			统计范围
			<select id="range2" name="range2" onchange="switchRange2();">
  				<option value ="30d" >30天内</option>
  				<option value ="12m" selected = "selected">12月内</option>
			</select>
			
			</th>
		</tr>
		<tr>
			<td style="width:100%">
				<div id="mainGraph3" style="width:100%;height:360px;"></div>
			</td>
		</tr>
	 </table>
	 
	
</body>
<script type="text/javascript">

		//初始加载
		$(document).ready(function(){
			loadOrgan();
			selectSysDic();
			selectPService();
			doQuery();
			graphQuery();
			graphQuery6();
			graphQuery7();
			if($("select[name='range']").val()=="12m"){
				graphQuery3();
			}else if($("select[name='range']").val()=="30d"){
				graphQuery2();
			}
			
			if($("select[name='range2']").val()=="12m"){
				graphQuery5();
			}else if($("select[name='range2']").val()=="30d"){
				graphQuery4();
			}
			
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
		
		//查询执行方法2
		function doQuery(){
			var params = $("#form1").serialize();
			$.ajax({
		 		type: "post",
		 		url: basePath+"/wdRmpAppDataServiceLog/serviceInfo",
		 		data:params,
		 		async: false,
		 		dataType: "text",
		 		success: function(data){
		 			var das = JSON.parse(data); 
		 			if(pageValue(das.obj)){return;}
		 			var sb = new StringBuilder();
		              $.each(das.obj.rows,function(i,map){ 
		             	 sb.append("<tr><td>").append(++i).append("</td>");
		 				 sb.append("<td >").append(map["SERVER_NAME"],15).append("</td>");
		 				 sb.append("<td >").append(map["COUNTS"],15).append("</td>");
		 				 if((parseFloat(map["RSIZE"])/(1024*1024*1024)).toFixed(2) <= 0){
		 					sb.append("<td >").append("< 0.01 GB").append("</td>");
		 				 }else{
		 					sb.append("<td >").append( (parseFloat(map["RSIZE"])/(1024*1024*1024)).toFixed(2) +" GB",25).append("</td>");
		 				 }
		 		 //		 sb.append("<td >").append(map["SERVER_DATE"],25).append("</td>");
		 		 		 sb.append("<td >");
		 		 		 sb.append("<i class='icon icon-search hj_bianji'></i><span class='hj_mar20'><a class='hj_mar20' onclick='selectchild(\"").append(map["SERVER_NUMBER"]).append("\")'>使用详情</a></span>");
		 				     
		              });
		 			 $("#tb").html(sb.toString());	 			 
		 		}
 			});
		}
		
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
		
		var sysIpMap={};
		var sysIPName=[];
		var sysIPs="";
		function selectSysDic(){
			$.ajax({
		 		type: "post",
		 		url: basePath+"/dictionaryData/selectDicByNodeId",
		 		data:{
		 			"nodeId":"sys_ip_address"
		 		},
		 		async: false,
		 		dataType: "json",
		 		beforeSend: function(){},
	            complete: function(){},
		 		success: function(data){
		 			for (var key in data)
		 		    {
		 				sysIPs += key + ",";
		 		//		if(sysIPName.length % 5 == 0 && sysIPName.length > 0){
		 		//			sysIPName.push('');
		 		//		}
		 		//		sysIPName.push(data[key]);
		 				sysIpMap[key] = data[key];
		 		    }
		 		}
 			});
		}
		
		function selectchild(pid){
			location.href=basePath+"/dataAnalysis/dataFuncCondition?pid="+pid;
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
		 
		
		function switchRange(){
			var range = $("select[name='range']").val();
			if(range =="12m"){
				myChart2.clear();
				xData2=[];
				graphQuery3();
			}else if(range="30d"){
				myChart2.clear();
				xData2=[];
				graphQuery2();
			}
		//	alert(range);
		}
		
		function switchRange2(){
			var range = $("select[name='range2']").val();
			if(range =="12m"){
				myChart3.clear();
				xData3=[];
				sysIPName=[];
				graphQuery5();
			}else if(range="30d"){
				myChart3.clear();
				xData3=[];
				sysIPName=[];
				graphQuery4();
			}
		//	alert(range);
		}
		
		function selectPService(){
			 $.ajax({
			 		type: "post",
			 		url: basePath+"/dataAnalysis/selectPService",
					data:[],	 
			 		async: false,
			 		dataType: "json",  //text
			 		beforeSend: function(){},
		            complete: function(){},
			 		success: function(data){
			 			if(data.obj.length>0){
			 				
			 	 		$.each(data.obj,function(i,map){ 
			 	 			 pIds = pIds +map["LOG_P_SERVICE"]+",";
			 	 			 if(pNames.length %5 == 0 && pNames.length > 0){
			 	 				pNames.push('');
			 	 			 }
			            	  pNames.push(map["LOG_P_SERVICE_NAME"]);
			            	  pMap[map["LOG_P_SERVICE"]]=map["LOG_P_SERVICE_NAME"];
			 	 			
			 	 		});
			 			}
			 			
			 		}
	 			}); 
		}
		Array.prototype.remove = function(val) {
			var index = this.indexOf(val);
			if (index > -1) {
			this.splice(index, 1);
			}
			};
			
		var pIds="";
		var pNames=[];
		var pMap={};
		
		var myChart = echarts.init(document.getElementById('mainGraph'),'macarons');
		var pieData= [];
		var pieSeriesData = [];

		var myChart2 = echarts.init(document.getElementById('mainGraph2'),'macarons');
		var xData2= [];
		var ySeriesData2 = [];
		
		var myChart3 = echarts.init(document.getElementById('mainGraph3'),'macarons');
		var xData3= [];
		var ySeriesData3 = [];
		
		var myChart4 = echarts.init(document.getElementById('mainGraph4'),'macarons');
		var pieData4= [];
		var pieSeriesData4 = [];
		
		var myChart5 = echarts.init(document.getElementById('mainGraph5'),'macarons');
		var pieData5= [];
		var pieSeriesData5 = [];
		
		function graphQuery(){
			 var option = {
					    title : {
					    	textStyle : {
					    		 fontSize: 18,
					    		 fontFamily:'Microsoft YaHei',
					    		    fontWeight: 'bolder',
					    		    color: '#333'
					    	 },
					    	text: '各数据服务使用率',
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
					            name:'调用次数',
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
			 		url: basePath+"/dataAnalysis/invokeTime",
					data:[],	 
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
			
 		 	/* 
			 var option2 = {
					    title : {
					        text: '各数据服务使用次数' 
					         
					    },
					    tooltip : {
					        trigger: 'item',  //axis
					        	formatter: "{a} <br> {b} : {c} ({d})"
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
					            name : '次'
					        }
					    ],
					    series : [
					        {
					            name:"使用次数",
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
				                            formatter: '{b}\n{c}'
				                        }
				                    }
				                }
					        }
					    ]
					}; 
			 
			 $.ajax({
			 		type: "post",
			 		url: basePath+"/dataAnalysis/invokeTime",
					data:[],	 
			 		async: false,
			 		dataType: "json",  //text
			 		beforeSend: function(){},
		            complete: function(){},
			 		success: function(data){
			 			if(data.obj.length>0){

			 	 		$.each(data.obj,function(i,map){ 
			 	 			pieSeriesData.push({value:parseInt(map["COUNTS"]),name:map["SERVICES"]});
			 	 			pieData.push(map["SERVICES"]);
			 	 			ySeriesData2.push(map["COUNTS"]);
			 	 			xData2.push(map["SERVICES"]);
			 	 			
			 	 		});
			 			}
			 		}
	 			}); */
			
			myChart.setOption(option);
		}
		function graphQuery2(){
			
			 var option2 = {
					    title : {
					    	textStyle : {
					    		 fontSize: 18,
					    		    fontWeight: 'bolder',
					    		    color: '#333'
					    	 },
					        text: '各服务近30天调用次数' 
					         
					    },
					    tooltip : {
					        trigger: 'axis' 
					    },
					    legend: {
					    	 x: 'center', //left right center
					         y: 'top',
					        data:pNames
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
					            name : '日期',
					            data : xData2
					        }
					    ],
					    yAxis : [
					        {
					            type : 'value',
					            name : '次'
					        }
					    ],
					    series : [
		  			    //    {
					     //       name:"法人库",
					     //       type:'line',
					     //       data:ySeriesData2,
					     //   }  
					    ]
					};
			 
				var markPoint = {
						data : [ {
							type : 'max',
							name : '最大值'
						} ]
					};
				
				 $.ajax({
				 		type: "post",
				 		url: basePath+"/dataAnalysis/serviceInvokeTime",
						data:{"pid":pIds},	 
				 		async: false,
				 		dataType: "json",  //text
				 		beforeSend: function(){},
			            complete: function(){},
				 		success: function(data){
				 			if( data.obj != null){
				 			 	for (var key in data.obj) {  
				 			 		if(key in pMap){
				 			 			var tempData=[] ;
				 						$.each(data.obj[key],function(i,map){ 
				 							tempData.push(parseInt(map["COUNTS"]));
					 	 				});
				 						option2.series.push({name:pMap[key],type:'line',data:tempData,markPoint:markPoint });
				 			 		}
			 		        	}  
				 		 	 	 for (var key in data.obj) {  
				 			 		$.each(data.obj[key],function(i,map){ 
					 	 				for (var key in map) {  
					 	 					if(key=="DTIME"  ){
					 	 						xData2.push(map[key]);
					 	 					}		
					 		        	} 
					 	 			});
				 			 		break;
				 			 	}  
				 			}
				 		}
		 			}); 
				 
				myChart2.setOption(option2); 
		}
		 
		function graphQuery3(){
			 var option2 = {
					    title : {
					    	textStyle : {
					    		 fontSize: 18,
					    		    fontWeight: 'bolder',
					    		    color: '#333'
					    	 },
					        text: '各服务近12月调用次数' 
					         
					    },
					    tooltip : {
					        trigger: 'axis' 
					    },
					    legend: {
					    	 x: 'center', 
					         y: 'top',
					        data:pNames
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
					            name : '日期',
					            data : xData2
					        }
					    ],
					    yAxis : [
					        {
					            type : 'value',
					            name : '次'
					        }
					    ],
					    series : [
		  			    //    {
					     //       name:"法人库",
					     //       type:'line',
					     //       data:ySeriesData2,
					     //   }  
					    ]
					};
			 
				var markPoint = {
						data : [ {
							type : 'max',
							name : '最大值'
						} ]
					};
				
				 $.ajax({
				 		type: "post",
				 		url: basePath+"/dataAnalysis/serviceInvokeTimeMonthly", 
						data:{"pid":pIds},	 
				 		async: false,
				 		dataType: "json",  //text
				 		beforeSend: function(){},
			            complete: function(){},
				 		success: function(data){
				 			if( data.obj != null){
				 			 	for (var key in data.obj) {  
				 			 		if(key in pMap){
				 			 			var tempData=[] ;
				 						$.each(data.obj[key],function(i,map){ 
					 	 					for (var key in map) {  
					 	 						if(key=="COUNTS"){
					 	 							tempData.push(parseInt(map[key]));
					 	 						}
					 	 					//	else if(key=="DTIME" && xData2==null){
					 	 					//		xData2.push(map[key]);
					 	 					//	}		
					 		        		} 
					 	 				});
				 						option2.series.push({name:pMap[key],type:'line',data:tempData,markPoint:markPoint });
				 			 		}
			 		        	}  
				 		 	 	for (var key in data.obj) {  
				 			 		$.each(data.obj[key],function(i,map){ 
					 	 				for (var key in map) {  
					 	 					if(key=="DTIME"  ){
					 	 						xData2.push(map[key]);
					 	 					}		
					 		        	} 
					 	 			});
				 			 		break;
				 			 	} 
				 			}
				 			 	/*
				 	 		$.each(data.obj,function(i,map){ 
				 	 			for (var key in map) {  
				 	 				if(key=="COUNTS"){
				 	 					ySeriesData2.push(parseInt(map[key]));
				 	 				}
				 	 				else if(key=="DTIME"){
				 	 					xData2.push(map[key]);
				 	 				}		
				 		        } 
				 	 		}); */
				 			
				 		}
		 			}); 
				 
				myChart2.setOption(option2);  

		}
		
		function graphQuery4(){
			
			 var option3 = {
/* 					 noDataLoadingOption: {
	                        text: '暂无数据',
	                        effect: 'bubble',
	                        effectOption: {
	                            effect: {
	                                n: 0
	                            }
	                        }
	 					}, */
			 
					    title : {
					    	textStyle : {
					    		 fontSize: 18,
					    		    fontWeight: 'bolder',
					    		    color: '#333'
					    	 },
					        text: '各系统近30天调用次数' 
					         
					    },
					    tooltip : {
					        trigger: 'axis' 
					    },
					    legend: {
					    	/* formatter: function (name) {
					    	    return (name.length > 8 ? (name.slice(0,8)+"...") : name ); 
					    	}, */
					    	 x: 'center', 
					         y: 'top',
					        data:sysIPName
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
				            x2:'40px',
				            y:'80px',
				            y2:'30px'
				        },
					    calculable : true,
					    xAxis : [
					        {
					            type : 'category',
					            name : '日期',
					            data : xData3
					        }
					    ],
					    yAxis : [
					        {
					            type : 'value',
					            name : '次'
					        }
					    ],
					    series : [
		  			    //    {
					     //       name:"法人库",
					     //       type:'line',
					     //       data:ySeriesData2,
					     //   }  
					    ]
					};
			 
				var markPoint = {
						data : [ {
							type : 'max',
							name : '最大值'
						} ]
					};
				
				 $.ajax({
				 		type: "post",
				 		url: basePath+"/dataAnalysis/systemInvokeTime",
						data:{"sysIP":sysIPs},	 
				 		async: false,
				 		dataType: "json",  //text
				 		beforeSend: function(){},
			            complete: function(){},
				 		success: function(data){
				 			if( data.obj != null){
				 			 	for (var key in data.obj) {  
				 			 		if(key in sysIpMap){
				 			 			var tempData=[] ;
				 			 			var tempBool = false;
				 						$.each(data.obj[key],function(i,map){ 
				 							if(parseInt(map["COUNTS"]) != 0){
				 								tempBool = true;
				 							}
				 							tempData.push(parseInt(map["COUNTS"]));
					 	 				});
				 						if(tempBool){
				 							if(sysIPName.length % 5 == 0 && sysIPName.length > 0){
				 					 			sysIPName.push('');
				 					 		}
				 							sysIPName.push(sysIpMap[key]);
				 							option3.series.push({name:sysIpMap[key],type:'line',data:tempData,markPoint:markPoint });
							 			 	
				 						}
				 						
				 					}
			 		        	}  
				 		 	 	 for (var key in data.obj) {  
				 			 		$.each(data.obj[key],function(i,map){ 
					 	 				for (var key in map) {  
					 	 					if(key=="DTIME"  ){
					 	 						xData3.push(map[key]);
					 	 					}		
					 		        	} 
					 	 			});
				 			 		break;
				 			 	}  
				 			}
				 		}
		 			}); 
				 
				myChart3.setOption(option3); 
		}
		
		function graphQuery5(){
			
			 var option3 = {
					    title : {
					    	textStyle : {
					    		 fontSize: 18,
					    		    fontWeight: 'bolder',
					    		    color: '#333'
					    	 },
					        text: '各系统近12月调用次数' 
					         
					    },
					    tooltip : {
					        trigger: 'axis' 
					    },
					    legend: {
					    	 x: 'center', 
					         y: 'top',
					        data:sysIPName
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
					            name : '日期',
					            data : xData3
					        }
					    ],
					    yAxis : [
					        {
					            type : 'value',
					            name : '次'
					        }
					    ],
					    series : [
		  			    //    {
					     //       name:"法人库",
					     //       type:'line',
					     //       data:ySeriesData2,
					     //   }  
					    ]
					};
			 
				var markPoint = {
						data : [ {
							type : 'max',
							name : '最大值'
						} ]
					};
				
				 $.ajax({
				 		type: "post",
				 		url: basePath+"/dataAnalysis/systemInvokeTimeMonthly",
						data:{"sysIP":sysIPs},	 
				 		async: false,
				 		dataType: "json",  //text
				 		beforeSend: function(){},
			            complete: function(){},
				 		success: function(data){
				 			if( data.obj != null){
				 			 	for (var key in data.obj) {  
				 			 		if(key in sysIpMap){
				 			 			var tempData=[] ;
				 			 			var tempBool = false;
				 						$.each(data.obj[key],function(i,map){ 
				 							if(parseInt(map["COUNTS"]) != 0){
				 								tempBool = true;
				 							}
				 							tempData.push(parseInt(map["COUNTS"]));
					 	 				});
				 						if(tempBool){
				 							if(sysIPName.length % 5 == 0 && sysIPName.length > 0){
				 					 			sysIPName.push('');
				 					 		}
				 							sysIPName.push(sysIpMap[key]);
				 							option3.series.push({name:sysIpMap[key],type:'line',data:tempData,markPoint:markPoint });
							 			 	
				 						}
				 			 		}
			 		        	}  
				 		 	 	 for (var key in data.obj) {  
				 			 		$.each(data.obj[key],function(i,map){ 
					 	 				for (var key in map) {  
					 	 					if(key=="DTIME"  ){
					 	 						xData3.push(map[key]);
					 	 					}		
					 		        	} 
					 	 			});
				 			 		break;
				 			 	}  
				 			}
				 		}
		 			}); 
				 
				myChart3.setOption(option3); 
		}
		
		function graphQuery6(){
			 var option4 = {
					    title : {
					    	textStyle : {
					    		 fontSize: 18,
					    		 fontFamily:'Microsoft YaHei',
					    		    fontWeight: 'bolder',
					    		    color: '#333'
					    	 },
					    	text: '各部门使用服务情况',
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
					        data:pieData4
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
					            center: ['50%', '60%'],
					            itemStyle:{ 
					                normal:{ 
					                      label:{ 
					                        show: true, 
					                        formatter: '{b} : {c} 次 ({d}%)' 
					                      }, 
					                      labelLine :{show:true} 
					                    } 
					                },
					            data: pieSeriesData4
					        }
					    ]
					};
			 
			 $.ajax({
			 		type: "post",
			 		url: basePath+"/dataAnalysis/organUseTime",
					data:[],	 
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
			            			  pieSeriesData4.push({value:parseInt(map["COUNTS"]),name:organList[i]["name"]});
						 	 			pieData4.push(organList[i]["name"]);
			            		  }
			            	  } 
			 	 			if(inList==0){
			 	 				pieSeriesData4.push({value:parseInt(map["COUNTS"]),name:map["SYSTEMS"]});
				 	 			pieData4.push(map["SYSTEMS"]);
			 	 			}
			 	 			
			 	 		});
			 			}
			 		}
	 			});
			
			myChart4.setOption(option4);
		}
		function graphQuery7(){
			 var option5 = {
					    title : {
					    	textStyle : {
					    		 fontSize: 18,
					    		 fontFamily:'Microsoft YaHei',
					    		    fontWeight: 'bolder',
					    		    color: '#333'
					    	 },
					    	text: '各部门使用流量情况',
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
					        data:pieData5
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
					            name:'数据流量',
					            type:'pie',
					            radius : '55%',
					            center: ['50%', '60%'],
					            itemStyle:{ 
					                normal:{ 
					                      label:{ 
					                        show: true, 
					                        formatter: '{b} : {c} MB ({d}%)' 
					                      }, 
					                      labelLine :{show:true} 
					                    } 
					                },
					            data: pieSeriesData5
					        }
					    ]
					};
			 
			 $.ajax({
			 		type: "post",
			 		url: basePath+"/dataAnalysis/organUseSize",
					data:[],	 
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
			            			  pieSeriesData5.push({value:(parseFloat(map["RPSIZE"])/(1024*1024)).toFixed(2),name:organList[i]["name"]});
						 	 			pieData5.push(organList[i]["name"]);
			            		  }
			            	  }
			 	 			if(inList==0){
			 	 				pieSeriesData5.push({value:(parseFloat(map["RPSIZE"])/(1024*1024)).toFixed(2),name:map["SYSTEMS"]});
				 	 			pieData5.push(map["SYSTEMS"]);
			 	 			}
			 	 			
			 	 		});
			 			}
			 		}
	 			});
			
			myChart5.setOption(option5);
		}
	 	window.onresize = function () {
 
		 	myChart.resize();
		 	myChart2.resize();
		 	myChart3.resize();
		 	myChart4.resize();
		 	myChart5.resize();
		}
		
	</script>
</html>
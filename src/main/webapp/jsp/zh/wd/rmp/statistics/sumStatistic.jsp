<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@include file="../../../../../commons/global.jsp"%>
<%@include file="../../../../../commons/xw/basejs.jsp"%>
<link rel="stylesheet" href="css/style.css">
</head>
<body>
<table class="gridtable03">
		<tr>
			<td style="width:45%">
				 <div id="chartsum" style="width:600px; height: 400px;"></div> 
			</td>
			<td style="width:45%"  valign="top">
				 <div id="chartmain" style="width:600px; height: 400px;"></div> 
			</td>

		</tr>
		<tr >
			<td style="width:45%" colspan='2'>
			<ul class="mainmenu">
			<div class="col-lg-1 col-sm-1 col1">
			  <button type="button" class="btn btn-sm btn-primary" onclick="doEchart(11)"> 一年</button>
		    </div>
			<div class="col-lg-2 col-sm-2 col2">
			  <button type="button" class="btn btn-sm btn-primary" onclick="selectToday()"> 今日</button>
			</div>
				<li class='btn btn-sm btn-primary'>
				<span class='more'>更多</span>
					<img src="images/off.png" alt="User icon" class="icon" id='icon'/>
				</li>
					<ul class="submenu" id='submenu'>
						<br />
						<span><div class="col-lg-3 col-sm-4">
								<div class="input-daterange input-group" id="datepicker">
									<input type="text" class="input-sm form-control data1"
										id="start" placeholder="开始时间" name="start"
										onclick="WdatePicker({isShowClear:false,readOnly:true,dateFmt:'yyyy-MM-dd',maxDate:'%y-%M-{%d-1}'})"
										readonly="readonly" /> <span class="input-group-addon">到</span>
									<input type="text" class="input-sm form-control data1" id="end"
										name="end" placeholder="结束时间"
										onclick="WdatePicker({isShowClear:false,readOnly:true,dateFmt:'yyyy-MM-dd',maxDate:'%y-%M-{%d}'})"
										readonly="readonly" />
								</div>
							</div>
							<div class="col-lg-1 col-sm-2">
								<button type="button" class="btn btn-sm btn-primary" id='btn'>
									查找</button>
							</div></span>
					</ul>
				</ul>	
				<div id="chartmiddle" style="width:100%; height: 400px;"></div> 
			</td>
		</tr>
	</table>
    <script type="text/javascript">
	var Modular = <dic:html nodeId="system" name="Modular" type="jsonByParam1" />;
	var d = new Date();
	var endDate = d.getFullYear() + "-" + (d.getMonth() + 1) + "-"
			+ d.getDate();
	var startDate = d.getFullYear() + "-" + (d.getMonth() - 11) + "-"
			+ d.getDate();
	//更多的隐藏与显示
    $(document).ready(function(){
		doQuery();
		var $submenu = $('.submenu');
		var $mainmenu = $('.mainmenu');
		$submenu.hide();
		var src='images/open.png';
		$mainmenu.on('click', 'li', function() {
			$(this).next('.submenu').slideToggle().siblings('.submenu').slideUp();
			$('#icon').attr('src',src);
			if(src=='images/off.png'){
				src='images/open.png';
			}else{
				src='images/off.png';
			}
		});
	});
	//查询执行方法
	var ssp,eqm,rmp,taiji;
	function doQuery() {
		$("#start").val(startDate);
		$("#end").val(endDate);
		echartsRight();
		selectDate();
		doEchart(11);
	}
	//平台总访问量
	var sum=0;
	function echartLeft(sum){
		var str="平台总访问量为："+sum;
		$("#chartsum").html(str);
	}
	/* 右侧平台统计饼图 */
	function echartsRight(){
		var myChart = echarts.init(document.getElementById("chartmain"),'macarons');
		$.ajax({
			type : "post",
			url : basePath + "/wdRmpAppLog/findAll",
			beforeSend: function(){},
	        complete: function(){},
			async : true,
			dataType : "text",
			success : function(data) {
				var das = JSON.parse(data);	
				var date=[];
				var sum=0;
				var countSum=0;
				$.each(das.obj,function(i,map){
					if(map["LOG_MODULAR"]!="eqm" && map["LOG_MODULAR"]!="snetm"){
						date.push({
								name:Modular[map["LOG_MODULAR"]],
								value:map["COUNTS"]
							});
						countSum+=map["COUNTS"];
					}else{
						sum+=map["COUNTS"];	
						countSum+=map["COUNTS"];	
					}
				});
				date.push({
					name:Modular["eqm"],
					value:sum
				});
				//平台总访问量
				echartLeft(countSum);
				//指定图标的配置和数据
				 var option = {
				    title : {
				        text: '平台统计图',
				       /*  subtext: '各平台访问次数统计图', */
				        x:'center'
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
				    tooltip : {
				        trigger: 'item',
				        formatter: "{a} <br/>{b} : {c} ({d}%)"
				    },
				    /* toolbox: {
				        show : true,
				        feature : {
				            mark : {show:true},
				            dataView : {show:true, readOnly: false},
				            magicType : {show:true, type: ['line', 'bar', 'stack', 'tiled']},
				            restore : {show:true},
				            saveAsImage :{show: true}
				        }
				    }, */
				    legend: {
				        orient: 'vertical',
				        x: "15%",
				        data: [Modular['ssp'],Modular['eqm'],Modular['rmp'],Modular['taiji']]
				    },
				    series : [
				        {
				        	name:"平台访问次数",
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
				            data:date,
				           
				        }
				    ]
				};
				//使用制定的配置项和数据显示图表
				  myChart.setOption(option);
			}
		
		});
	}
//  下方折线图===================================
	function doEchart(month){
		var d = new Date();
		var endDate = d.getFullYear()+"-"+(d.getMonth()+1)+"-"+d.getDate();
		var startDate = d.getFullYear()+"-"+(d.getMonth()-month)+"-"+d.getDate();
		echartsMiddle(startDate,endDate);
	}
	/* function dayEchart(){
		var d = new Date();
		var endDate = d.getFullYear()+"-"+(d.getMonth()+1)+"-"+d.getDate();
		var startDate = d.getFullYear()+"-"+(d.getMonth()-month)+"-"+d.getDate();
		echartsMiddle(startDate,endDate);
	} */
	function echartsMiddle(startDate,endDate){
		var myChart = echarts.init(document.getElementById("chartmiddle"),'macarons');
		var xDate=[]; 
		var sspData=[];
		var rmpData=[];
		var taijiData=[];
		var eqmData=[];
		var modular=["ssp","rmp","eqm","taiji"];
			$.ajax({
				type : "post",
				url : basePath + "/wdRmpAppLog/countDate",
				data: {"Modular":modular,"logDate":startDate,"logDate1":endDate}, 
				traditional: true,
				beforeSend: function(){},
		        complete: function(){},
				async : true,
				dataType : "text",
				success : function(data) {
					var das = JSON.parse(data);	
					$.each(das.obj,function(i,map){
						$.each(map,function(key,val){
 	 							if(i=="ssp"){
 	 								sspData.push(val["COUNTS"]);
 	 								xDate.push(val["DTIME"]);
 	 							}else if(i=="rmp"){
 	 								rmpData.push(val["COUNTS"]);
 	 							}else if(i=="eqm"){
 	 								eqmData.push(val["COUNTS"]);
 	 							}else if(i=="taiji"){
 	 								taijiData.push(val["COUNTS"]);
 	 							}
 	 							/* tempData.push(); */
					});
						//alert(map["COUNTS"])
						/* sspData.push(map["COUNTS"]);
						xDate.push(map["DTIME"]); */
						});	
					/* option = {						
						    title: {
						        text: '统计总览图'
						    },
						    tooltip : {
						        trigger: 'axis',
						        axisPointer: {
						            type: 'cross',
						            label: {
						                backgroundColor: '#6a7985'
						            }
						        }
						    },
						    legend: {
						    	data: [Modular['ssp'],Modular['eqm'],Modular['rmp'],Modular['taiji']]
						    },
						    toolbox: {
						        show : true,
						        feature : {
						            dataView : {show:true, readOnly: false},
						            magicType : {show:true, type: ['line', 'bar', 'stack', 'tiled']},
						            restore : {show:true},
						            saveAsImage :{show: true}
						        }
						    },
						    grid: {
						        left: '3%',
						        right: '4%',
						        bottom: '3%',
						        containLabel: true
						    },
						    calculable : true,
						    xAxis : [
								        {
								            type : 'category',
								            boundaryGap : false,
								            name : '日期',
								            data : xDate,
								            axisLabel:{
								            	  interval:"auto"
								            }
								        }
								    ],
						    yAxis : [
						        {
						            type : 'value',
						            name:"访问量"
						        }
						    ],
						    series : [
						        {
						            name:Modular['ssp'],
						            type:'line',
						            showAllSymbol:false,
						            smooth:true,
						            data:sspData
						            
						        },
						        {
						            name:Modular['eqm'],
						            type:'line',
						            showAllSymbol:false,
						            smooth:true,
						            data:eqmData
						        },
						        {
						            name:Modular['taiji'],
						            type:'line',
						            showAllSymbol:false,
						            smooth:true,
						            data:taijiData
						        },
						        {
						            name:Modular['rmp'],
						            type:'line',
						            showAllSymbol:false,
						            smooth:true,
						            data:rmpData
						        }
						    ]
					}; */
					option = {						
							 title: {
							        text: '统计总览图'
							    },
							    tooltip : {
							        trigger: 'axis',
							        axisPointer: {
							            type: 'cross',
							            label: {
							                backgroundColor: '#6a7985'
							            }
							        }
							    },
						    legend: {
						    	data: [Modular['ssp'],Modular['eqm'],Modular['rmp'],Modular['taiji']]
						    },
						    toolbox: {
						        show : true,
						        feature : {
						            dataView : {show:true, readOnly: false},
						            magicType : {show:true, type: ['line', 'bar', 'stack', 'tiled']},
						            restore : {show:true},
						            saveAsImage :{show: true}
						        }
						    },
						    grid: {
						        left: '3%',
						        right: '4%',
						        bottom: '3%',
						        containLabel: true
						    },
						    
						    xAxis : [
						        {
						            type : 'category',
						            boundaryGap : false,
						            name : '日期',
						            data : xDate,
						            axisLabel:{
						            	  interval:"auto"
						            }
						        }
						    ],
						    yAxis : [
						        {
						            type : 'value',
						            name:"访问量"
						        }
						    ],
						    series : [
								        {
								            name:Modular['ssp'],
								            type:'line',
								            showAllSymbol:false,
								            smooth:true,
								            data:sspData
								            
								        },
								        {
								            name:Modular['eqm'],
								            type:'line',
								            showAllSymbol:false,
								            smooth:true,
								            data:eqmData
								        },
								        {
								            name:Modular['taiji'],
								            type:'line',
								            showAllSymbol:false,
								            smooth:true,
								            data:taijiData
								        },
								        {
								            name:Modular['rmp'],
								            type:'line',
								            showAllSymbol:false,
								            smooth:true,
								            data:rmpData
								        }
								    ]
						
					};
					myChart.setOption(option);
				}
			});
	}
	
	function selectDate(){
		 $("#btn").click(function(e){
			 var startDate = $("#start").val();
			 var endDate = $("#end").val();
			 echartsMiddle(startDate,endDate);
         });
	}
	function selectToday(){
		var myChart = echarts.init(document.getElementById("chartmiddle"),'macarons');
		var xDate=[]; 
		var sspData=[];
		var rmpData=[];
		var taijiData=[];
		var eqmData=[];
		var modular=["ssp","rmp","eqm","taiji"];
			$.ajax({
				type : "post",
				url : basePath + "/wdRmpAppLog/selectToday",
				data: {"Modular":modular}, 
				traditional: true,
				beforeSend: function(){},
		        complete: function(){},
				async : true,
				dataType : "text",
				success : function(data) {
					var das = JSON.parse(data);	
					$.each(das.obj,function(i,map){
						var num=0;
						$.each(map,function(key,val){
							
 	 							if(i=="ssp"){
 	 								sspData.push(val["COUNTS"]);
 	 								xDate.push(num+++"点");
 	 							}else if(i=="rmp"){
 	 								rmpData.push(val["COUNTS"]);
 	 							}else if(i=="eqm"){
 	 								eqmData.push(val["COUNTS"]);
 	 							}else if(i=="taiji"){
 	 								taijiData.push(val["COUNTS"]);
 	 							}
 	 							/* tempData.push(); */
					});
						//alert(map["COUNTS"])
						/* sspData.push(map["COUNTS"]);
						xDate.push(map["DTIME"]); */
				});	
					option = {						
						    title: {
						        text: '统计总览图'
						    },
						    tooltip : {
						        trigger: 'axis'
						        /* axisPointer: {
						            type: 'cross',
						            label: {
						                backgroundColor: '#6a7985'
						            }
						        } */
						    },
						    legend: {
						    	data: [Modular['ssp'],Modular['eqm'],Modular['rmp'],Modular['taiji']]
						    },
						    toolbox: {
						        show : true,
						        feature : {
						            dataView : {show: true, readOnly: false},
						            magicType : {show: true, type: ['line', 'bar']},
						            restore : {show: true},
						            saveAsImage : {show: true}
						        }
						    },
						    grid: {
						        left: '3%',
						        right: '4%',
						        bottom: '3%',
						        containLabel: true
						    },
						    calculable : true,
						    xAxis : [
						        {
						            type : 'category',
						            boundaryGap : false,
						            name : '日期',
						            data : xDate,
						           /*  axisLabel:{  
					                    rotate : 45
					                } */
						        }
						    ],
						    
						    yAxis : [
						        {
						            type : 'value',
						            name:"次"
						        }
						    ],
						    series : [
						        {
						            name:Modular['ssp'],
						            type:'line',
						            smooth:true,
						            data:sspData
						            
						        },
						        {
						            name:Modular['eqm'],
						            type:'line',
						            smooth:true,
						            data:eqmData
						        },
						        {
						            name:Modular['taiji'],
						            type:'line',
						            smooth:true,
						            data:taijiData
						        },
						        {
						            name:Modular['rmp'],
						            type:'line',
						            smooth:true,
						            data:rmpData
						        }
						    ]
					};
					myChart.setOption(option);
				}
			});
	}
</script> 
</body>
</html>
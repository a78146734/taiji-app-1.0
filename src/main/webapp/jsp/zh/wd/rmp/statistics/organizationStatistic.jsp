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
				   <div data-toggle="buttons" class="btn-group nav-tabs " style="position:relative;">
                                    <label class="btn btn-sm btn-primary btn-white  active" data-target="0" id="ssp"  > <input type="radio" id="option1" name="options">  </label>
                                    <label class="btn btn-sm btn-primary btn-white" data-target="1" id="rmp" > <input type="radio" id="option2" name="options"></label>
                                    <label class="btn btn-sm btn-primary btn-white" data-target="2" id="eqm" > <input type="radio" id="option3" name="options"></label>
                                    <label class="btn btn-sm btn-primary btn-white" data-target="3" id="taiji" > <input type="radio" id="option4" name="options"></label>
                                </div> <br/><br/>
                               <div id="chartmain" style="width:600px; height: 400px;"></div> 
			</td>
			<td style="width:45%">
			    <div id="chartColumn" style="width:700px; height: 400px;">
			    </div>   
			</td>

		</tr>
		<tr >
			<td style="width:45%" colspan='2'>
			 <div data-toggle="buttons" class="btn-group nav-tab" style="position:relative;">
                                    <label class="btn btn-sm btn-primary btn-white active" data-target="0" id="_ssp" onClick='selectRoof("ssp");' > <input type="radio" class="elegant-aero" id="option1" name="options">  </label>
                                    <label class="btn btn-sm btn-primary btn-white" data-target="1" id="_rmp" onClick='selectRoof("rmp");'> <input type="radio" id="option2" name="options"></label>
                                    <label class="btn btn-sm btn-primary btn-white" data-target="2" id="_eqm" onClick='selectRoof("eqm");'> <input type="radio" id="option3" name="options"></label>
                                    <label class="btn btn-sm btn-primary btn-white" data-target="3" id="_taiji" onClick='selectRoof("taiji");'> <input type="radio" id="option4" name="options"></label>
                                </div>
				<ul class="mainmenu">
					<div class="col-lg-1 col-sm-1 col1">
						<button type="button" class="btn btn-sm btn-primary"
							onclick="selectYear()">一年</button>
					</div>
					<div class="col-lg-2 col-sm-2 col2">
						<button type="button" class="btn btn-sm btn-primary"
							onclick="selectToday()">今日</button>
					</div>
					<li class='btn btn-sm btn-primary'><span class='more'>更多</span>
						<img src="images/off.png" alt="User icon" class="icon" id='icon' />
					</li>
					<ul class="submenu" id='submenu'>
						<span><div class="col-lg-3 col-sm-4">
									<div class="input-daterange input-group" id="datepicker">
										<input type="text" class="input-sm form-control data1"
											id="start" placeholder="开始时间" name="start"
											onclick="WdatePicker({isShowClear:false,readOnly:true,dateFmt:'yyyy-MM-dd',maxDate:'%y-%M-{%d-1}'})"
											readonly="readonly" /> <span class="input-group-addon">到</span>
										<input type="text" class="input-sm form-control data1"
											id="end" name="end" placeholder="结束时间"
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
	var cname="ssp";
	var d = new Date();
	var endDate = d.getFullYear()+"-"+(d.getMonth()+1)+"-"+d.getDate();
	var startDate = d.getFullYear()+"-"+(d.getMonth()-11)+"-"+d.getDate();
    $(document).ready(function(){
		doQuery();
		var $submenu = $('.submenu');
		var $mainmenu = $('.mainmenu');
		$submenu.hide();
		//$submenu.first().delay(400).slideDown(700);
		/* $submenu.on('click','li', function() {
			$submenu.siblings().find('li').removeClass('chosen');
			$(this).addClass('chosen');
		}); */
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
	function doQuery() {
		//var params = $("#form1").serialize();
		//chartColumn();
		$("#start").val(startDate);
		$("#end").val(endDate);
		chartOrganUser();
		echartsTop("ssp");
		echartsMiddle("ssp",startDate,endDate);
		selectOptions();
		selectDate();
		$("#ssp").text(Modular["ssp"]);
		$("#rmp").text(Modular["rmp"]);
		$("#eqm").text(Modular["eqm"]);
		$("#taiji").text(Modular["taiji"]);
		$("#_ssp").text(Modular["ssp"]);
		$("#_rmp").text(Modular["rmp"]);
		$("#_eqm").text(Modular["eqm"]);
		$("#_taiji").text(Modular["taiji"]);
	}
	
	function echartsTop(name){
		var myChart = echarts.init(document.getElementById("chartmain"),'macarons');
		var tittle=Modular[name];
		$.ajax({
			type : "post",
			url : basePath + "/wdRmpAppLog/organDate",
			data:{LogModular:name},
			async : true,
			dataType : "text",
			success : function(data) {
				var das = JSON.parse(data);	
				//var data=[];
				var legendData = [];
			    var seriesData = [];
				$.each(das.obj,function(i,list){
					if(list["ORGAN_NAME"]!=""&&list["ORGAN_NAME"]!=null){
						legendData.push(list["ORGAN_NAME"]);
						seriesData.push({
				            name: list["ORGAN_NAME"],
				            value: list["COUNTS"]
				        });
					}else{
						legendData.push("其他部门");
						 seriesData.push({
					            name: "其他部门",
					            value: list["COUNTS"]
					        });
					}
					});	
				//data.push("legendData",legendData);
				//data.push("seriesData",seriesData);
				option = {
				    title : {
				        text: '部门统计',
				        subtext: tittle,
				        x:'left'
				    },
				    tooltip : {
				        trigger: 'item',
				        formatter: "{a} <br/>{b} : {c} ({d}%)"
				    },
				    legend: {
				        type: 'scroll',
				        orient: 'vertical',
				        right: 10,
				        top: 20,
				        bottom: 20,
				        data: legendData,
				        x:'right'
				    },
				    series : [
				        {
				           name: Modular[name]+"平台访问次数",
				            type: 'pie',
				            radius : '55%',
				            center: ['40%', '50%'],
				            data: seriesData,
				            itemStyle: {
				                emphasis: {
				                    shadowBlur: 10,
				                    shadowOffsetX: 0,
				                    shadowColor: 'rgba(0, 0, 0, 0.5)'
				                }
				            }
				        }
				    ]
				};

				  myChart.setOption(option);
				
			}
		
		});
		
		//return 	data;	 
	}
//折线图===================================
	function echartsMiddle(name,startDate,endDate){
		var myChart = echarts.init(document.getElementById("chartmiddle"),'macarons');
		var xDate=[]; 
		var modular=["ssp","rmp","eqm","taiji"];
			$.ajax({
				type : "post",
				url : basePath + "/wdRmpAppLog/organDate",
				data: {Modular:modular}, 
				traditional: true,
				async : true,
				dataType : "text",
				success : function(data) {
					var das = JSON.parse(data);	
					var date=[];
					var legendData = [];
				    var seriesData = [];
					$.each(das.obj,function(i,list){
						if(list["ORGAN_NAME"]!=""&&list["ORGAN_NAME"]!=null){
							legendData.push(list["ORGAN_NAME"]);
							seriesData.push({
					            name: list["ORGAN_NAME"],
					            value: list["COUNTS"]
					        });
						}else{
							legendData.push("其他部门");
							seriesData.push({
						            name: "其他部门",
						            value: list["COUNTS"]
						        });
						}
						});
					$.ajax({
						type : "post",
						url : basePath + "/wdRmpAppLog/organChart",
						data: {logModular:name,legendData:legendData,"logDate":startDate,"logDate1":endDate}, 
						traditional: true,
						async : true,
						dataType : "text",
						success : function(data) {
							 var Item = function(){  
					                return {  
					                    name:'',  
					                    type:'line',  
					                    smooth:true,
					                    data:[]  
					                    };  
					                };  
							var das = JSON.parse(data);	
							//alert(das.obj)
							 var legends = [];// 准备存放图例数据  
						     var Series = []; // 准备存放图表数据 
							$.each(das.obj,function(i,list){
								var value=[];
								$.each(list["list"],function(key,map){
									if(i==0){
									xDate.push(map["DTIME"]);
									}
		 	 						value.push(map["COUNTS"]);
								});
								date=xDate;
								legends.push(list["organName"]);
								 var it = new Item();  
						            it.name = list["organName"];// 先将每一项填充数据  
						            it.data = value;
						            Series.push(it);// 将item放在series中 
							
						  });
							option = {						
								    title: {
								        text: Modular[cname]+'部门访问量'
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
								    	data: legendData
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
								            data : date
								            
								        }
								    ],
								    yAxis : [
								        {
								            type : 'value',
								            name:"访问量"
								        }
								    ],
								    series : Series
								
							};
							myChart.setOption(option);
						}
					});  
						
					
				}
			});
			
	}
	//查询当天
	function organToday(name){
		var myChart = echarts.init(document.getElementById("chartmiddle"),'macarons');
		var xDate=[]; 
		var modular=["ssp","rmp","eqm","taiji"];
			$.ajax({
				type : "post",
				url : basePath + "/wdRmpAppLog/organDate",
				data: {Modular:modular}, 
				traditional: true,
				async : true,
				dataType : "text",
				success : function(data) {
					var das = JSON.parse(data);	
					var date=[];
					var legendData = [];
				    var seriesData = [];
					$.each(das.obj,function(i,list){
						if(list["ORGAN_NAME"]!=""&&list["ORGAN_NAME"]!=null){
							legendData.push(list["ORGAN_NAME"]);
							seriesData.push({
					            name: list["ORGAN_NAME"],
					            value: list["COUNTS"]
					        });
						}else{
							legendData.push("其他部门");
							seriesData.push({
						            name: "其他部门",
						            value: list["COUNTS"]
						        });
						}
						});
					$.ajax({
						type : "post",
						url : basePath + "/wdRmpAppLog/organToday",
						data: {logModular:name,legendData:legendData}, 
						traditional: true,
						async : true,
						dataType : "text",
						success : function(data) {
							 var Item = function(){  
					                return {  
					                    name:'',  
					                    type:'line',  
					                    smooth:true,
					                    data:[]  
					                    };  
					                };  
							var das = JSON.parse(data);	
							//alert(das.obj)
							 var legends = [];// 准备存放图例数据  
						     var Series = []; // 准备存放图表数据 
							$.each(das.obj,function(i,list){
								var value=[];
								var num=0;
								$.each(list["list"],function(key,map){
									if(i==0){
									xDate.push(num+++"点");
									}
		 	 						value.push(map["COUNTS"]);
								});
								date=xDate;
								legends.push(list["organName"]);
								 var it = new Item();  
						            it.name = list["organName"];// 先将每一项填充数据  
						            it.data = value;
						            Series.push(it);// 将item放在series中 
							
						  });
							option = {						
								    title: {
								        text: '今日'+Modular[cname]+'访问量'
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
								    	data: legendData
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
								            data : date
								            
								        }
								    ],
								    yAxis : [
								        {
								            type : 'value',
								            name:"访问量"
								        }
								    ],
								    series : Series
								
							};
							myChart.setOption(option);
						}
					});  
						
					
				}
			});
			
	}
	
	function selectToday(){
		organToday(cname);
	}
	function selectOptions(){
		 $(".cbody>.content:gt(0)").hide();
         $(".nav-tabs ").delegate('label','click',function(e){
        	 $(this).addClass('active').siblings('label').removeClass("active");
             if($(this).hasClass("active")){
            	 var docName = $(this).context.id;
            	 echartsTop(docName);
                 return;
             }
            
           
         });
     
	}
	function selectRoof(name){
		 $(".body>.content:gt(0)").hide();
         $(".nav-tab ").delegate('label','click',function(e){
        	 $(this).addClass('active').siblings('label').removeClass("active");
             if($(this).hasClass("active")){
            	 //var docName = $(this).context.id;
            	 cname=name;
            	// alert(cname);
            	 echartsMiddle(name,startDate,endDate);
                 return;
             }
            
           
         });
	}
	function selectYear(cname){
		 echartsMiddle(cname,startDate,endDate);
	}
	function chartOrganUser(){
		var myChart = echarts.init(document.getElementById("chartColumn"),'macarons');
		var tittle=Modular[name];
		$.ajax({
			type : "post",
			url : basePath + "/organization/selectOrganUser",
			//data:{LogModular:name},
			async : true,
			dataType : "text",
			success : function(data) {
				var das = JSON.parse(data);	
				//var data=[];
				//alert(das.obj)
				var legendData = [];
			    var seriesData = [];
				$.each(das.obj,function(i,list){
					if(list["ORGAN_NAME"]!=""&&list["ORGAN_NAME"]!=null){
						//legendData.push(list["ORGAN_NAME"]);
						seriesData.push({
				            name: list["ORGAN_NAME"],
				            value: list["COUNTS"]
				        });
					}else{
						//legendData.push("其他部门人数");
						 seriesData.push({
					            name: "其他部门",
					            value: list["COUNTS"]
					        });
					}
					});	
				//data.push("legendData",legendData);
				//data.push("seriesData",seriesData);
				option = {
				    title : {
				        text: '部门人数统计',
				        subtext: tittle,
				        x:'left'
				    },
				    tooltip : {
				        trigger: 'item',
				        formatter: "{a} <br/>{b} : {c} ({d}%)"
				    },
				   /*  legend: {
				        type: 'scroll',
				        orient: 'vertical',
				        right: 10,
				        top: 20,
				        bottom: 20,
				        data: legendData,
				        x:'right'
				    }, */
				    series : [
				        {
				            name:"部门人数",
				            type: 'pie',
				            radius : '55%',
				            center: ['40%', '50%'],
				            data: seriesData,
				        }
				    ]
				};

				  myChart.setOption(option);
				
			}
		
		});
	}
	///////柱状图
/* 					
					function chartColumn(){
						var myChart = echarts.init(document.getElementById("chartColumn"),'macarons');
						$.ajax({
							type : "post",
							url : basePath + "/wdRmpAppLog/findAll",
						
							async : true,
							dataType : "text",
							success : function(data) {
								
								var das = JSON.parse(data);
								if (pageValue(das.obj)) {
									return;
								}
								//指定图标的配置和数据
					 var option={
								color: ['#3398DB'],
						        title:{
						            text:"各平台总访问量"
						        },
						        tooltip : {
						            trigger: 'axis',
						            axisPointer : {            // 坐标轴指示器，坐标轴触发有效
						                type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
						            }
						        },
						       
						        //x轴的文本
								xAxis : [ {
										type : 'category',
										data: [Modular['ssp'],Modular['eqm'],Modular['rmp'],Modular['taiji']],
										axisTick : {
											alignWithLabel : true
										}
										} ],
								//y轴的文本
							    yAxis : [
									        {
									            type : 'value'
									        }
									    ],
								series : [ {
									name : "总访问量",
									type : "bar",
									data : [das.obj["ssp"],das.obj["eqm"],das.obj["rmp"],das.obj["taiji"]]
								} ]
						};
						myChart.setOption(option);
					}
						
				});
						 
						myChart.on('click', function (params) {
							//debugger;
							var logModular="";
							if(params.name==Modular['ssp']){
								logModular="ssp";
							}else if(params.name==Modular['eqm']){
								logModular="eqm";
							}else if(params.name==Modular['rmp']){
								logModular="rmp";
							}else if(params.name==Modular['taiji']){
								logModular="taiji";
							}else{
								chartColumn();
							}
							$.ajax({
								type : "post",
								url : basePath + "/wdRmpAppLog/organDate",
								data:{LogModular:logModular},
								async : true,
								dataType : "text",
								success : function(data) {
									var das = JSON.parse(data);	
									var legendData = [];
								    var seriesData = [];
									$.each(das.obj,function(i,list){
										//alert(其他部门)
										if(list["ORGAN_NAME"]==""||list["ORGAN_NAME"]==null){
											//list["ORGAN_NAME"]="其他部门";
											//alert(seriesData)
											legendData.push("其他部门");
											seriesData.push({
									            name: "其他部门",
									            value: list["COUNTS"]
									        });
										}else{
											legendData.push(list["ORGAN_NAME"]);
											seriesData.push({
									            name: list["ORGAN_NAME"],
									            value: list["COUNTS"]
									        });
										}
									});	
									//alert(legendData)
									  //alert(params.name);
					                var  chartsOption={
					                		color: ['#3398DB'],
									        title:{
									            text:params.name+"访问量"
									        },
									        tooltip : {
									            trigger: 'axis',
									            axisPointer : {            // 坐标轴指示器，坐标轴触发有效
									                type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
									            }
									        },
									      
									        //x轴的文本
											xAxis : [ {
													type : 'category',
													data: legendData,
													axisTick : {
														alignWithLabel : true
													},
													axisLabel:{  
									                    rotate : 45
									                }
													} ],
													 dataZoom : {
											        	   show : true, 
											        	   realtime : true,
											        	   start : 0,
											        	   end : 40  
											        },
										    yAxis : [
												        {
												            type : 'value'
												        }
												    ],
											series : [ {
												name : "部门访问量",
												type : "bar",
												data : seriesData
											} ]
					                };
					                myChart.clear();
					                myChart.setOption(chartsOption);
								}
							
							});
			              
			               
			            });	
						 
			} */
					function selectDate(){
						 $("#btn").click(function(e){
							 var startDate = $("#start").val();
							 var endDate = $("#end").val();
							// alert(cname)
							 echartsMiddle(cname,startDate,endDate);
				         });
					}
</script> 
  </body>
</html>
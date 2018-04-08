<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@include file="../../../../../commons/global.jsp"%>
<%@include file="../../../../../commons/xw/basejs.jsp"%>
<link rel="stylesheet" href="css/style.css">
<style type="text/css">
#left{width:50%;float:left}
#right{width:50%; float:right}
</style>
  </head>
  <body>
	<div class="user_manage">
		<div class="hj_user" id="left">
			<div id="chartmain" style="width:600px; height: 400px;"></div>
		</div>
		<form id="form1">
			<div id="right">
				<table class="gridtable03">
					<tr>
						<th style="width: 20%;">序号</th>
						<th style="width: 40%;"><span>用户名称</span></th>
						<th style="width: 40%;"><span>历史访问次数</span></th>
					</tr>
					<tbody id="tbody">
					</tbody>
					<tfoot>
					</tfoot>
				</table>
				<div class="page"><%@include
						file="../../../../../commons/xw/page.jsp"%>
				</div>
			</div>
		</form>
	</div>
	<div class="user_manage">
	<table class="gridtable03">
		<tr>
			<td style="width:45%" colspan='2'>
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
				<br />
				<span><div class="col-lg-3 col-sm-4">
						<div class="input-daterange input-group" id="datepicker">
							<input type="text" class="input-sm form-control data1" id="start"
								placeholder="开始时间" name="start"
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
		<div id="chartColumn" style="width:100%; height: 400px;"></div>
	 </td></tr>
	 </table>
	</div>
	<script type="text/javascript">
		var Modular = <dic:html nodeId="system" name="Modular" type="jsonByParam1" />;
		var doFirst;
		var doLoginName;
		var d = new Date();
		var endDate = d.getFullYear() + "-" + (d.getMonth() + 1) + "-"
				+ d.getDate();
		var startDate = d.getFullYear() + "-" + (d.getMonth() - 11) + "-"
				+ d.getDate();
		$(document).ready(
				function() {
					doQuery();
					var $submenu = $('.submenu');
					var $mainmenu = $('.mainmenu');
					$submenu.hide();
					//$submenu.first().delay(400).slideDown(700);
					/* $submenu.on('click','li', function() {
						$submenu.siblings().find('li').removeClass('chosen');
						$(this).addClass('chosen');
					}); */
					var src = 'images/open.png';
					$mainmenu.on('click', 'li', function() {
						$(this).next('.submenu').slideToggle().siblings(
								'.submenu').slideUp();
						$('#icon').attr('src', src);
						if (src == 'images/off.png') {
							src = 'images/open.png';
						} else {
							src = 'images/off.png';
						}
					});
				});
		$(document).ready(function() {
			doQuery();
		});
		//查询执行方法
		function doQuery() {
			$("#start").val(startDate);
			$("#end").val(endDate);
			//var params = $("#form1").serialize();
			/* echartsMiddle("ssp"); */
			selectUser();
			selectDate();
			$("#_ssp").text(Modular["ssp"]);
			$("#_rmp").text(Modular["rmp"]);
			$("#_eqm").text(Modular["eqm"]);
			$("#_taiji").text(Modular["taiji"]);
		}
		//饼图
		function echartsTop(name) {
			var myChart = echarts.init(document.getElementById("chartmain"),
					'macarons');
			//var tittle=Modular[name];
			$.ajax({
				type : "post",
				url : basePath + "/wdRmpAppLog/listUser",
				async : true,
				beforeSend : function() {
				},
				complete : function() {
				},
				data : {
					"name" : name
				},
				dataType : "text",
				success : function(data) {
					if (name == null) {
						name = "其他用户";
					}
					var das = JSON.parse(data);
					//var data=[];
					var legendData = [];
					var seriesData = [];
					var eqm = 0;
					$.each(das.obj, function(i, list) {
						if (list["LOG_MODULAR"] != ""
								&& list["LOG_MODULAR"] != null) {
							if (list["LOG_MODULAR"] == "ssp") {
								legendData.push(Modular[list["LOG_MODULAR"]]);
								seriesData.push({
									name : Modular[list["LOG_MODULAR"]],
									value : list["COUNTS"]
								});
							} else if (list["LOG_MODULAR"] == "rmp") {
								legendData.push(Modular[list["LOG_MODULAR"]]);
								seriesData.push({
									name : Modular[list["LOG_MODULAR"]],
									value : list["COUNTS"]
								});
							} else if (list["LOG_MODULAR"] == "eqm"
									|| list["LOG_MODULAR"] == "snetm") {
								eqm += list["COUNTS"];
							} else if (list["LOG_MODULAR"] == "taiji") {
								legendData.push(Modular[list["LOG_MODULAR"]]);
								seriesData.push({
									name : Modular[list["LOG_MODULAR"]],
									value : list["COUNTS"]
								});
							}
						}
						/* if(list["LOG_MODULAR"]!=""&&list["LOG_MODULAR"]!=null){
							legendData.push(list["LOG_MODULAR"]);
							seriesData.push({
						        name: list["LOG_MODULAR"],
						        value: list["COUNTS"]
						    });
						} */
					});
					if (eqm > 0) {
						legendData.push(Modular["eqm"]);
						seriesData.push({
							name : Modular["eqm"],
							value : eqm
						});
					}
					option = {
						title : {
							text : doFirst + '操作统计',
							subtext : '',
							x : 'left'
						},
						tooltip : {
							trigger : 'item',
							formatter : "{a} <br/>{b} : {c} ({d}%)"
						},
						legend : {
							type : 'scroll',
							orient : 'vertical',
							right : 10,
							top : 20,
							bottom : 20,
							data : legendData,
							x : 'right'
						},
						series : [ {
							type : 'pie',
							radius : '55%',
							center : [ '40%', '50%' ],
							data : seriesData,
							itemStyle : {
								emphasis : {
									shadowBlur : 10,
									shadowOffsetX : 0,
									shadowColor : 'rgba(0, 0, 0, 0.5)'
								}
							}
						} ]
					};

					myChart.setOption(option);
				}

			});

		}
		/* 统计用户访问次数的表格 */
		function selectUser() {
			var params = $("#form1").serialize();
			$
					.ajax({
						type : "post",
						url : basePath + "/wdRmpAppLog/selectUser",
						async : true,
						data : params,
						beforeSend : function() {
						},
						complete : function() {
						},
						dataType : "text",
						success : function(data) {
							var das = JSON.parse(data);
							pageValue(das.obj);
							var sb = new StringBuilder();
							var i = 0;
							//pageValue(data);
							//alert(das.obj.rows)
							//alert(data)
							doFirst=das.obj.rows[0]["USER_NAME"];
							findLoginName(doFirst);
							$
									.each(
											das.obj.rows,
											function(i, list) {
												if (list["USER_NAME"] != ""
														&& list["USER_NAME"] != null) {
													sb
															.append("<tr><td>")
															.append(++i)
															.append("</td>")
															.append(
																	"<td ><a href=\"javascript:doCharts('"
																			+ list["USER_NAME"]
																			+ "')\">")
															.append(
																	list["USER_NAME"])
															.append("</a></td>")
															.append("<td >")
															.append(
																	list["COUNTS"])
															.append(
																	"</td></tr>");
												} else {
													sb
															.append("<tr><td>")
															.append(++i)
															.append("</td>")
															.append(
																	"<td ><a href=\"javascript:doCharts()\">")
															.append("其他用户")
															.append("</a></td>")
															.append("<td >")
															.append(
																	list["COUNTS"])
															.append(
																	"</td></tr>");
												}
											});
							$("#tbody").html(sb.toString());
						}
					});
		}
		function doCharts(userName) {
			doFirst = userName;
			findLoginName(userName);
		}
		/* function tab(name,count){	
			sb.append("<tr><td>").append(++i).append("</td>");
			sb.append("<td >").append(name).append("</td>");
			sb.append("<td >").append(count).append("</td></tr>");	
		} */
		//折线图(天)===================================
		function echartsColumn(name) {
			var myChart = echarts.init(document.getElementById("chartColumn"),
					'macarons');
			var date = [];
			//var tittle=Modular[name];
			$.ajax({
				type : "post",
				url : basePath + "/wdRmpAppLog/userDayChart",
				async : true,
				beforeSend : function() {
				},
				complete : function() {
				},
				data : {
					"logMethod" : name
				},
				dataType : "text",
				success : function(data) {
					if (name == null) {
						name = "其他用户";
					}
					var Item = function() {
						return {
							name : '',
							type : 'line',
							smooth : true,
							data : []
						};
					};
					var das = JSON.parse(data);
					//alert(das.obj)
					var legends = [];// 准备存放图例数据  
					var Series = []; // 准备存放图表数据 
					$.each(das.obj, function(i, list) {
						var value = [];
						var num = 0;
						$.each(list["list"], function(key, map) {
							value.push(map["COUNTS"]);
							if (list["platName"] == "ssp") {
								date.push(num++ + "点");
							}
						});
						legends.push(Modular[list["platName"]]);
						var it = new Item();
						it.name = Modular[list["platName"]];// 先将每一项填充数据  
						it.data = value;
						Series.push(it);// 将item放在series中 

					});
					option = {
						title : {
							text : doFirst + '访问量'
						},
						tooltip : {
							trigger : 'axis',
							axisPointer : {
								type : 'cross',
								label : {
									backgroundColor : '#6a7985'
								}
							}
						},
						legend : {
							data : legends
						},
						toolbox : {
							show : true,
							feature : {
								dataView : {
									show : true,
									readOnly : false
								},
								magicType : {
									show : true,
									type : [ 'line', 'bar', 'stack', 'tiled' ]
								},
								restore : {
									show : true
								},
								saveAsImage : {
									show : true
								}
							}
						},
						grid : {
							left : '3%',
							right : '4%',
							bottom : '3%',
							containLabel : true
						},

						xAxis : [ {
							type : 'category',
							boundaryGap : false,
							name : '日期',
							data : date

						} ],
						yAxis : [ {
							type : 'value',
							name : "访问量"
						} ],
						series : Series

					};
					myChart.setOption(option);
				}

			});

		}
		//折线图(年)===================================
		function userYearChart(name, startDate, endDate) {
			var myChart = echarts.init(document.getElementById("chartColumn"),
					'macarons');
			var date = [];
			//var tittle=Modular[name];
			$.ajax({
				type : "post",
				url : basePath + "/wdRmpAppLog/userYearChart",
				async : true,
				data : {
					"logMethod" : name,
					"logDate" : startDate,
					"logDate1" : endDate
				},
				dataType : "text",
				beforeSend : function() {
				},
				complete : function() {
				},
				success : function(data) {
					if (name == null) {
						name = "其他用户";
					}
					var Item = function() {
						return {
							name : '',
							type : 'line',
							smooth : true,
							data : []
						};
					};
					var das = JSON.parse(data);
					//alert(das.obj)
					var legends = [];// 准备存放图例数据  
					var Series = []; // 准备存放图表数据 
					$.each(das.obj, function(i, list) {
						var value = [];
						$.each(list["list"], function(key, map) {
							value.push(map["COUNTS"]);
							if (list["platName"] == "ssp") {
								date.push(map["DTIME"]);
							}
						});
						legends.push(Modular[list["platName"]]);
						var it = new Item();
						it.name = Modular[list["platName"]];// 先将每一项填充数据  
						it.data = value;
						Series.push(it);// 将item放在series中 

					});
					option = {
						title : {
							text : doFirst + '访问量'
						},
						tooltip : {
							trigger : 'axis',
							axisPointer : {
								type : 'cross',
								label : {
									backgroundColor : '#6a7985'
								}
							}
						},
						legend : {
							data : legends
						},
						toolbox : {
							show : true,
							feature : {
								dataView : {
									show : true,
									readOnly : false
								},
								magicType : {
									show : true,
									type : [ 'line', 'bar', 'stack', 'tiled' ]
								},
								restore : {
									show : true
								},
								saveAsImage : {
									show : true
								}
							}
						},
						grid : {
							left : '3%',
							right : '4%',
							bottom : '3%',
							containLabel : true
						},

						xAxis : [ {
							type : 'category',
							boundaryGap : false,
							name : '日期',
							data : date,
							axisLabel : {
								interval : "auto"
							}
						} ],
						yAxis : [ {
							type : 'value',
							name : "访问量"
						} ],
						series : Series

					};
					myChart.setOption(option);
				}

			});

		}
		function selectDate() {
			$("#btn").click(function(e) {
				var startDate = $("#start").val();
				var endDate = $("#end").val();
				// alert(cname)
				userYearChart(doLoginName, startDate, endDate);
			});
		}
		function selectToday() {
			echartsColumn(doLoginName);
		}
		function selectYear() {
			userYearChart(doLoginName, startDate, endDate);
		}
		function findLoginName(name){
			$.ajax({
				type : "post",
				url : basePath + "/wdRmpAppLog/findLoginName",
				async : true,
				data : {
					"logMethod" : name
				},
				dataType : "text",
				beforeSend : function() {
				},
				complete : function() {
				},
				success : function(data){
					var das = JSON.parse(data);
					doLoginName=das.obj["LOGIN_NAME"];
					echartsTop(doLoginName);
					userYearChart(doLoginName, startDate, endDate);
				}
			});
		}
		///////柱状图

		/* function chartColumn(){
			var myChart = echarts.init(document.getElementById("chartColumn"));
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
										}
										} ],
								//y轴的文本
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
	</script> 
  </body>
</html>
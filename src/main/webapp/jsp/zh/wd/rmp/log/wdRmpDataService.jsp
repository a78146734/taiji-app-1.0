<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="../../../../../commons/global.jsp"%>
<%@include file="../../../../../commons/xw/basejs.jsp"%>

<meta http-equiv="refresh" content="60">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>数据服务监控</title>
<style type="text/css">
#left{width:30%;float:left}
#right{width:70%; float:right}
</style>
</head>
<body>

<!-- <div id="left">left</div>
<div id="right">right</div>
 -->
	<table class="gridtable03" style="width: 100%;">
		<tr>
			<td style="width:30%">
			<span id='healthRate'></span>
			<div id="mainGraph2" style="height:270px;"></div>
				
				 
					<p style="height: 25px;">
						 <font  size="3" face="Microsoft YaHei"> 
						<span id="status_label">检测中...请稍后</span>
						 </font>
					</p>
					<p style="height: 25px;">
						<font  size="3"> 
						当前告警数：<a onclick='alertDetails();'><span id='alertSum' style="color:#ff0000"></span></a>条
						 </font>
					</p>

				
			</td>

			<td style="width:70%">

				<div id="mainGraph" style="height:300px;"></div>
			</td>
		</tr>
	</table>
	<form id="form1">
		<div class="user_manage">
			<p class="ri_jczctitle">
				<span class="ri_jczctitletxt">实时监控</span> 
			</p>
			<div class="hj_username">
				<div class="hj_username1">
				<input name="serverStatus" type="hidden" class="hj_usernameinp" value="2">
					<span class="hj_usertxtname">服务编号：</span> <span><input
						name="serverNumber" type="text" class="hj_usernameinp"></span> <span
						class="hj_usertxtname">服务名称：</span> <span><input
						name="serverName" type="text" class="hj_usernameinp"></span>   <span>&nbsp;&nbsp;
						<button onclick="Query();" class="button" type="button">查询</button>
					</span>  
				</div>
			</div>

	<!-- 		<div id="hj_username_2" class="hj_username_2">
				<div class="hj_username1">
					<span class="hj_usertxtname">服务概述：</span> <span><input
						name="serverSummary" type="text" class="hj_usernameinp"></span>
				</div>
			</div> -->

			<div class="hj_user">
				<table class="gridtable03">
					<tr>
						<th style="width: 2%;">序号</th>
						<th style="width: 15%;"><a id="SERVER_NAME" class="tha"
							onclick="sort(this);"><span>服务名称</span><i class="thimg"></i></a></th>
						<th style="width: 15%;"><a id="SERVER_TYPE" class="tha"
							onclick="sort(this);"><span>服务类型</span><i class="thimg"></i></a></th>
						<th style="width: 30%;"><a id="SERVER_SUMMARY" class="tha"
							onclick="sort(this);"><span>服务概述</span><i class="thimg"></i></a></th>
						<th style="width: 20%;"><a id="SERVER_DATE" class="tha"
							onclick="sort(this);"><span>注册时间</span><i class="thimg"></i></a></th>
						<th style="width:18%;">操作</th>
					</tr>
					<tbody id="tbAlert">

					</tbody>
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
	doQuery();
	graphQuery();
	graphQuery2();

	
 	$("#btnQuery").click(function(){
 		$("[name=nowpage]").val("1");
		$("[name=pageNo]").val("1");
		doQuery();
 	});
// 	validAllFormDefault("form1"); 
});

//点击查询
function Query(){
	$("[name=pageNo]").val("1");
//	validAjaxFormList(basePath+"/wdSspServer/list");
 // 	$("#form1").submit();
	doQuery();
}
var validVar = ""; // 不能删除
function validAllFormDefault(formId){
	validVar = $("#" +formId).Validform({
		tiptype:function(msg,o,cssctl){
			//msg：提示信息;
			//o:{obj:*,type:*,curform:*}, obj指向的是当前验证的表单元素（或表单对象），type指示提示的状态，值为1、2、3、4， 1：正在检测/提交数据，2：通过验证，3：验证失败，4：提示ignore状态, curform为当前form对象;
			//cssctl:内置的提示信息样式控制函数，该函数需传入两个参数：显示提示信息的对象 和 当前提示的状态（既形参o中的type）;
			if(!o.obj.is("form")){  //验证表单元素时o.obj为该表单元素，全部验证通过提交表单时o.obj为该表单对象;
				if(o.type==2){
					layer.closeAll();
				}else{
					layer.tips(msg, "[name='"+$(o.obj).attr("name")+"']", {
					  tips: [2, '#D15B47'], 
					  time: 0
					});
				}
			}	
		}
	});
}
//自定义ajax方法urlPath为ajax的actions
function validAjaxFormList(urlPath){
	validVar.config({
    	url:urlPath,
    	ajaxPost:true,
    	postonce: true,
		ajaxpost:{
        success:function(data,obj){
 			pageValue(data.obj);
 			var sb = new StringBuilder();
              $.each(data.obj.rows,function(i,obj){ 
            	 sb.append("<tr><td>").append(++i).append("</td>");
 				 sb.append("<td >").append(obj.serverName,15).append("</td>");
 				 sb.append("<td >").append(obj.serverType,15).append("</td>");
 				 sb.append("<td title='"+obj.serverSummary+"'>").append(obj.serverSummary,15).append("</td>");
 				 sb.append("<td >").append(obj.serverDate,25).append("</td>");
 				 sb.append("<td >");
 				 sb.append("<i class='icon icon-search hj_bianji'></i><span class='hj_mar20'><a class='hj_mar20' onclick='selectchild(\"").append(obj.serverNumber).append("\")'>服务详情</a></span>");
 				   
              });
 			 $("#tb").html(sb.toString());	 
        },
        error:function(data,obj){
            //data是{ status:**, statusText:**, readyState:**, responseText:** };
            //obj是当前表单的jquery对象;
        }
    }
	});
 
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
           // 	  if(alertServiceIdList.indexOf(obj.serverId)<0){
            	  sb.append("<tr>");
            	  sb.append("<td>").append(++i).append("</td>");
 				 sb.append("<td >").append(obj.serverName,15).append("</td>");
 				 sb.append("<td >").append(obj.serverType,15).append("</td>");
 				 sb.append("<td title='"+obj.serverSummary+"'>").append(obj.serverSummary,15).append("</td>");
 				 sb.append("<td >").append(obj.serverDate,25).append("</td>");
 				 sb.append("<td >");
 				 sb.append("<i class='icon icon-search hj_bianji'></i><span class='hj_mar20'><a class='hj_mar20' onclick='selectchild(\"").append(obj.serverNumber).append("\",\"").append(obj.serverName).append("\")'>服务详情</a></span>");
          //  	  }
              });
 			 $("#tb").html(sb.toString());	 			 
 		}
		});
}
 
function selectchild(pid,pname){
	location.href=basePath+"/dataAnalysis/dataFuncService?pid="+pid+"&pname="+pname;
}  
//查看告警信息
function selectAlertChild(pid) {
	location.href = basePath + "/dataAnalysis/alertPage?pid=" + pid;
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
function alertDetails(){
	location.href = basePath + "/dataAnalysis/alertPage";
	/* if(parseInt($("#alertSum").text())>0){
		
	}else{
		layer.msg('服务很健康，请继续保持！', {
			icon: 6, time: 2000
		});
	} */
}
//var height = window.screen.height*0.95;
//var width = window.screen.width*0.95;
//var barDiv = document.getElementById("main");
//barDiv.style.height = height*0.5+"px";
//barDiv.style.width = width*0.70+"px";
var myChart = echarts.init(document.getElementById('mainGraph'),'macarons');

var xData= [];
var ySeriesData = [];
var ySeriesDataLast = [];

var legendData=[];

var seriesName1;
var seriesName2;


var myChart2 = echarts.init(document.getElementById('mainGraph2'),'macarons');
var zrColor =  zrender.tool.color;
var shadowColorGreen = zrColor.getLinearGradient(
        0, 0, 400, 0,
        [[0, 'rgba(34, 111, 34,0.8)'],[1, 'rgba(0,200,0,0.9)']]
    );
var shadowColorYellow = zrColor.getLinearGradient(
        0, 0, 200, 0,
        [[0, 'rgba(255, 230, 0,0.5)'],[1, 'rgba(255, 180, 0, 0.9)']]
    );

var alertServiceIds = "";
var alertServiceIdList = [];


function graphQuery(){
	 var option = {
			    title : {
			    	textStyle : {
			    		 fontSize: 18,
			    		    fontWeight: 'bolder',
			    		    color: '#333'
			    	 },
			        text: '数据服务使用数量' 
			         
			    },
			    tooltip : {
			        trigger: 'axis'
			    },
   				grid:{
		      //      x:'20px',
		      //      x2:'20px'
		      //     y:'50px',
		      //      y2:'50px'
		        },       
			    legend: {
			        data:legendData
			    },
/* 			    toolbox: {
			        show : true,
			        feature : {
			            mark : {show: true},
			            dataView : {show: true, readOnly: false},
			            magicType : {show: true, type: ['line', 'bar']},
			            restore : {show: true},
			            saveAsImage : {show: true}
			        }
			    }, */
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
			            name:" ",
			            type:'line',
			            data:ySeriesData,
			            markPoint : {
			                data : [
			                    {type : 'max', name: '最大值'},
			                    {type : 'min', name: '最小值'}
			                ]
			            }/* ,
			            markLine : {
			                data : [
			                    {type : 'average', name: '平均值'}
			                ]
			            } */
			        },
			        {
			            name:" ",
			            type:'line',
			            data:ySeriesDataLast,
			            markPoint : {
			                data : [
			                    {type : 'max', name: '最大值'},
			                    {type : 'min', name: '最小值'}
			                ]
			            }/* ,
			            markLine : {
			                data : [
			                    {type : 'average', name: '平均值'}
			                ]
			            } */
			        }
			    ]
			};
	 
	$.ajax({
 		type: "post",
 		url: basePath+"/dataAnalysis/recGraph",
		data:[],	 
 		async: false,
 		dataType: "json",  //text
 		beforeSend: function(){},
        complete: function(){},
 		success: function(data){
 			var hours;
 	 		$.each(data.obj,function(i,map){ 
 	 			for (var key in map) {  
 	 				if(key=="STATUS"){
 	 					ySeriesData.push(parseInt(map[key]));
 	 				}
 	 				else if(key=="DTIME"){
 	 					hours=map[key].split(" ");
 	 					xData.push(hours[1]);
 	 					if(seriesName1==null)
 	 						seriesName1 = hours[0];
 	 				}		
 		        } 
 	 		});
 	 		legendData.push(seriesName1);
 	 		option.series[0].name = seriesName1;
 		}
		});
	
	$.ajax({
 		type: "post",
 		url: basePath+"/dataAnalysis/histGraph",
		data:[],	 
 		async: false,
 		dataType: "json",  //text
 		beforeSend: function(){},
        complete: function(){},
 		success: function(data){
	 	var hours;
 	 		$.each(data.obj,function(i,map){ 
 	 			for (var key in map) {  
 	 				if(key=="STATUS"){
 	 					ySeriesDataLast.push(parseInt(map[key]));
 	 				}
 	 				else if(key=="DTIME"){
 	 					hours=map[key].split(" ");
 	 					if(seriesName2==null)
 	 						seriesName2 = hours[0];

 	 				}		
 		        } 
 	 		});
 	 		legendData.push(seriesName2);
 	 		option.series[1].name = seriesName2;
 		}
		});

	myChart.setOption(option);
}
function graphQuery2(){
	option2 = {
			title : {
				textStyle : {
		    		 fontSize: 18,
		    		    fontWeight: 'bolder',
		    		    color: '#333'
		    	 },
				text : '数据服务健康度'

			},
		    tooltip : {
		        formatter: "{a} <br/>{b} : {c}"
		    },
		    toolbox: {
		        show : true,
		        feature : {
		            mark : {show: true},
		            restore : {show: true},
		            saveAsImage : {show: true}
		        }
		    },
		    series : [
		        {
		            name:'数据服务',
		            type:'gauge',
		            startAngle: 180,
		            endAngle: 0,
		            center : ['50%', '90%'],    // 默认全局居中
		            radius : 150,
		            axisLine: {            // 坐标轴线
		                lineStyle: {       // 属性lineStyle控制线条样式
		                   /*  color: [[0.2, 'rgba(255, 0, 0, 0.9)'],[0.8, 'rgba(255, 214, 0, 0.9)'],[1, '#efefef']],  */
			                    color: [[0.2, 'rgba(255, 0, 0, 0.9)'],[0.8, 'rgba(255, 214, 0, 0.9)'],[1, 'rgba(34, 139, 34, 0.9)']],  
		                    width: 80
		                }
		            },
		            axisTick: {            // 坐标轴小标记
		                splitNumber: 2,   // 每份split细分多少段
		                length :8,        // 属性length控制线长
		                lineStyle: { // 属性lineStyle控制线条样式
                            color: '#fff',
                            shadowColor: '#fff', //默认透明
                            shadowBlur: 10
                        }
		            },
		            axisLabel: {           // 坐标轴文本标签，详见axis.axisLabel
		                formatter: function(v){
		                    switch (v+''){
		             //           case '10': return '差';
		            //            case '50': return '良';
		            //            case '90': return '优';
		                        default: return '';
		                    }
		                },
		                textStyle: {       // 其余属性默认使用全局文本样式，详见TEXTSTYLE
		                    color: '#fff',
		                    fontSize: 15,
		                    fontWeight: 'bolder'
		                }
		            },
		            splitLine: { // 分隔线
                        length: 12, // 属性length控制线长
                        lineStyle: { // 属性lineStyle（详见lineStyle）控制线条样式
                            width: 1,
                            color: '#fff',
                            shadowColor: '#fff', //默认透明
                            shadowBlur: 2
                        }
                    },
		            pointer: {
		                width:25,
		                length: '90%',
		                color: 'rgba(211, 211, 211, 0.7)'
		            },
		            title : {
		                show : true,
		                offsetCenter: [0, '-30%'],       // x, y，单位px
		                textStyle: {       // 其余属性默认使用全局文本样式，详见TEXTSTYLE
		                    color: '#000',
		                    fontSize: 25
		                }
		            },
		            detail : {
		            	formatter:'{value}',
		            	offsetCenter: [0, -20],
		            	
		            	textStyle: {       // 其余属性默认使用全局文本样式，详见TEXTSTYLE
		                    color: 'auto',
		                    fontSize : 40,
		                    fontWeight: 'bolder'
		                }
		            	},
		            data:[{value: 50, name: '健康度'}]
		        }
		    ]
		};
	$.ajax({
		type : "post",
		url : basePath + "/dataAnalysis/healthyRate",
		data : [],
		async : false,
		dataType : "json", //text
		beforeSend : function() {
		},
		complete : function() {
		},
		success : function(data) {
			$.each(data.obj, function(i, map) {
				for ( var key in map) {
					option2.series[0].data[0].value =map["STATUS"]; 
					$("#alertSum").text(map["ALERT"]);
					
					if(option2.series[0].data[0].value>=80){
						$("#status_label").html("数据服务状态很好，请继续保持！");
						option2.series[0].axisLine.lineStyle.color= [[0.0, 'red'],
							[ option2.series[0].data[0].value/100, shadowColorGreen], 
							[1, '#efefef']]; 
					}
					else if(option2.series[0].data[0].value<80 && option2.series[0].data[0].value>=25){
						$("#status_label").html("数据服务出了些问题，快去解决！");
						option2.series[0].axisLine.lineStyle.color= [[0.0, 'red'], 
							[ option2.series[0].data[0].value/100, shadowColorYellow], 
							[1, '#efefef']]; 
					}
					else if(option2.series[0].data[0].value<25){
						$("#status_label").html("数据服务宕机了！！！");
						option2.series[0].axisLine.lineStyle.color= [[0.0, 'red'], 
							[ option2.series[0].data[0].value/100, 'rgba(255, 0, 0, 0.9)'], 
							[1, '#efefef']]; 
					}		
						
				}
			});
		}
	});
	
	myChart2.setOption(option2);

	
	
	if(parseInt($("#alertSum").text())>0){ //如果出现告警情况，高亮显示所在服务
		$.ajax({
			type : "post",
			url : basePath + "/dataAnalysis/alertDetail",
			data : [],
			async : false,
			dataType : "json", //text
			beforeSend : function() {
			},
			complete : function() {
			},
			success : function(data) {
				$.each(data.obj, function(i, map) {
					alertServiceIds += alertServiceIds+map["SERVICEID"]+",";
					alertServiceIdList.push(map["SERVICEID"]);
				});
			}
		});
		$.ajax({
			type : "post",
			url : basePath + "/wdSspServer/selectByServerNumbers",
			data : {"ids":alertServiceIds},
			async : false,
			dataType : "json", //text
			beforeSend : function() {
			},
			complete : function() {
			},
			success : function(data) {
				var sb = new StringBuilder();
				$.each(data.obj,function(i,map){ 
	            	 sb.append("<tr  id='").append(map["serverId"]).append("'>");
	            	 sb.append("<td style='color:red'>").append("*").append("</td>");
	 				 sb.append("<td style='color:red'>").append(map["serverName"],15).append("</td>");
	 				 sb.append("<td style='color:red'>").append(map["serverType"],15).append("</td>");
	 				 sb.append("<td style='color:red' title='"+map["serverSummary"]+"'>").append(map["serverSummary"],15).append("</td>");
	 				 sb.append("<td style='color:red'>").append(map["serverDate"],25).append("</td>");
	 				 sb.append("<td >");
	 				 sb.append("<i class='icon icon-search hj_bianji'></i><span class='hj_mar20'><a class='hj_mar20' style='color:red' onclick='selectAlertChild(\"").append(map["serverNumber"]).append("\")'>告警详情</a></span>");
	 				  
	              });
				 sb.append("<tr><td style='color:red' colspan='8'><strong>↑↑↑ 告警信息 ↑↑↑</strong> </td></tr>");
				$("#tbAlert").html(sb.toString());
			}
		});

	}
}
window.onresize = function () {
 	myChart.resize();
 	myChart2.resize();
}

</script>
</html>
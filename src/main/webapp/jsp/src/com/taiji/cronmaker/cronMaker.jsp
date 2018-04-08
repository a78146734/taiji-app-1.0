<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<%@include file="../../../../../commons/global.jsp"%>
	<%@include file="../../../../../commons/xw/basejs.jsp"%>
<script type="text/javascript" src="${staticPath }/static/quartz/cronMaker.js" charset="utf-8"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>应用服务监控</title>
</head>
<body >
<div style="margin-left: 10%;margin-right: 10%;">

		<div class="layui-tab layui-tab-brief">
			<ul class="layui-tab-title">
				<li onclick="resetMsg();">分钟</li>
				<li onclick="resetMsg();">小时</li>
				<li class="layui-this" onclick="resetMsg();">每日</li>
				<li onclick="resetMsg();">每周</li>
				<li onclick="resetMsg();">每月</li>
				<li onclick="resetMsg();">每年</li>
			</ul>
			<div class="layui-tab-content" style="height: 180px; border: 1px solid #CCCCCC">
				<div class="layui-tab-item ">
					<label> 每隔 <input type="text" id="minutes" name="minutes"
						value="1" style="width: 50px;" placeholder="分钟">分钟运行一次 <br>
					<br>
					<button class="button" style="width: 100px;" onclick="minGen()">
							确定</button>
					</label>
				</div>
				
				<div class="layui-tab-item">
					<label><input id="hour_1" name="hour_r" type="radio" style="width: 15px; height: 12px;" value="1" checked="checked" />
						每隔 <input type="text" id="hours" name="hours" value="1" style="width: 50px;" placeholder="小时">小时运行一次 
						</label> 
						<br> 
					<label><input id="hour_2" name="hour_r" type="radio" style="width: 15px; height: 12px;" value="2" /> 
						每天 <select id="hour_s"></select> 时
						<select id="minute_s"></select> 分，运行一次 </label> <br>
					<br>
					<button class="button" style="width: 100px;" onclick="hourGen()">
						确定</button>
				</div>
				
				<div class="layui-tab-item layui-show">
					<label>
					<input id="day_1" name="day_r" type="radio" style="width: 15px; height: 12px;" value="1" checked="checked" />
						每 <input type="text" id="days" name="days" value="1" style="width: 50px;" placeholder="日"> 日，
					 </label> <br>
					 <label><input id="day_2" name="day_r" type="radio" style="width: 15px; height: 12px;" value="2" />
						每个工作日（周一 至 周五）
					 </label> <br>
					<br>
					<select id="hour_s_d"></select> 时 
						  <select id="minute_s_d"></select> 分，运行一次
						  <br>  <br>
					<button class="button" style="width: 100px;" onclick="dayGen()">
						确定</button>

				</div>
				<div class="layui-tab-item">
				  
				<label><input  name="weekly" type="checkbox" style="width: 15px; height: 12px;" value="MON" />周一 &nbsp;</label>
				<label><input  name="weekly" type="checkbox" style="width: 15px; height: 12px;" value="TUE" />周二 &nbsp;</label>
				<label><input  name="weekly" type="checkbox" style="width: 15px; height: 12px;" value="WED" />周三 &nbsp;</label>
				<label><input  name="weekly" type="checkbox" style="width: 15px; height: 12px;" value="THU" />周四  &nbsp;</label>
				<label><input  name="weekly" type="checkbox" style="width: 15px; height: 12px;" value="FRI" />周五  &nbsp;</label>
				<label><input  name="weekly" type="checkbox" style="width: 15px; height: 12px;" value="SAT" />周六 &nbsp;</label>
				<label><input  name="weekly" type="checkbox" style="width: 15px; height: 12px;" value="SUN" />周日 &nbsp;</label><br>
				  <br>
					<select id="hour_s_w"></select> 时 
						  <select id="minute_s_w"></select> 分，运行一次
						  <br>  <br>
					<button class="button" style="width: 100px;" onclick="weekGen()">
						确定</button>
				</div>
				<div class="layui-tab-item">
					<label><input id="month_1" name="month_r" type="radio" style="width: 15px; height: 12px;" value="1" checked="checked" />
						每 <input type="text" id="month_m" name="month_m" style="width: 50px;" value="1"> 个月，
						 第 <input type="text" id="day_m" name="day_m" style="width: 50px;" value="1" > 日
						</label> 
						<br> 
					<label><input id="month_2" name="month_r" type="radio" style="width: 15px; height: 12px;" value="2" /> 
						每 <input type="text" id="month_s_m" name="month_s_m" style="width: 50px;" value="1" > 个月，
						
						第
						<select id="month_s_1">
						<option value="1">一</option>
						<option value="2">二</option>
						<option value="3">三</option>
						<option value="4">四</option>
						</select>
						个
						星期
						<select id="month_s_2">
							<option value="MON">一  </option>
							<option value="TUE">二 </option>
							<option value="WED">三 </option>
							<option value="THU">四  </option>
							<option value="FRI">五 </option>
							<option value="SAT">六 </option>
							<option value="SUN">日 </option>
						</select>
						
					</label> <br>  <br>
					<select id="hour_s_m"></select> 时 
						  <select id="minute_s_m"></select> 分，运行一次
						  <br>  <br>
					<button class="button" style="width: 100px;" onclick="monthGen()">
						确定</button>
				</div>
				<div class="layui-tab-item">
					<label><input id="year_1" name="year_r" type="radio" style="width: 15px; height: 12px;" value="1" checked="checked" />
						每年 
						<select id="month_s_y_1">
						<option value="1">一</option>
						<option value="2">二</option>
						<option value="3">三</option>
						<option value="4">四</option>
						<option value="5">五</option>
						<option value="6">六</option>
						<option value="7">七</option>
						<option value="8">八</option>
						<option value="9">九</option>
						<option value="10">十</option>
						<option value="11">十一</option>
						<option value="12">十二</option>
						</select>
						 月，
						<input type="text" id="day_y" name="day_y" style="width: 50px;" value="1" > 日
						</label> 
						<br> 
						
					<label><input id="year_2" name="year_r" type="radio" style="width: 15px; height: 12px;" value="2" /> 
						每年 
						<select id="month_s_y_2">
						<option value="1">一</option>
						<option value="2">二</option>
						<option value="3">三</option>
						<option value="4">四</option>
						<option value="5">五</option>
						<option value="6">六</option>
						<option value="7">七</option>
						<option value="8">八</option>
						<option value="9">九</option>
						<option value="10">十</option>
						<option value="11">十一</option>
						<option value="12">十二</option>
						</select>
						 月，
						第
						<select id="year_s_1">
						<option value="1">一</option>
						<option value="2">二</option>
						<option value="3">三</option>
						<option value="4">四</option>
						</select>
						个
						星期
						<select id="year_s_2">
							<option value="MON">一  </option>
							<option value="TUE">二 </option>
							<option value="WED">三 </option>
							<option value="THU">四  </option>
							<option value="FRI">五 </option>
							<option value="SAT">六 </option>
							<option value="SUN">日 </option>
						</select>
						
					</label> <br>					
					<br>
					<select id="hour_s_y"></select> 时 
						  <select id="minute_s_y"></select> 分，运行一次
						  <br>  <br>
					<button class="button" style="width: 100px;" onclick="yearGen()">
						确定</button>
				</div>

				<div>
					<span id="formmsg" class="formmsg"></span>
				</div>
			</div>
		</div>
	<!-- 	<button class=" button" style="width:80px;" onclick="btnFan()"> 表达式解析 </button> -->

		<table id="resolve" class="gridtable03" style="visibility:hidden"><!--  display hidden -->
			<tbody>
				<tr>
					<td>秒</td>
					<td>分钟</td>
					<td>小时</td>
					<td>日</td>
					<td>月</td>
					<td>星期</td>
					<td>年</td>
				</tr>
				<tr>
					<td><input type="text" name="v_second" value="*"
						readonly="readonly" style="width: 80px" /></td>
					<td><input type="text" name="v_min" value="*"
						readonly="readonly" style="width: 80px" /></td>
					<td><input type="text" name="v_hour" value="*"
						readonly="readonly" style="width: 80px" /></td>
					<td><input type="text" name="v_day" value="*"
						readonly="readonly" style="width: 80px" /></td>
					<td><input type="text" name="v_mouth" value="*"
						readonly="readonly" style="width: 80px" /></td>
					<td><input type="text" name="v_week" value="?"
						readonly="readonly" style="width: 80px" /></td>
					<td><input type="text" name="v_year" readonly="readonly"
						style="width: 80px" /></td>
				</tr>
				<tr>
				 <td>Cron 表达式:</td>
					  <td colspan="6"><input type="text" name="cron" style="width: 100%;" value="* * * * * ?" id="cron" /></td>
						 
				 </tr>
				 <tr>
					  <td colspan="8"  >最近5次运行时间:</td>
							     
						    </tr>
						   <tr>
							    <td colspan="8" >
							       <ul id="recentTime">
							       	 
							       </ul>
							    </td>
							     
						    </tr>
			</tbody>
		</table>

	</div>
	 
</body>
<script type="text/javascript">
$(function(){
	 var hour_s = $("#hour_s");
     var min_s = $("#minute_s");
     
	 var hour_s_d = $("#hour_s_d");
     var min_s_d = $("#minute_s_d");
     
	 var hour_s_w = $("#hour_s_w");
     var min_s_w = $("#minute_s_w");
     
	 var hour_s_m = $("#hour_s_m");
     var min_s_m = $("#minute_s_m");
     
	 var hour_s_y = $("#hour_s_y");
     var min_s_y = $("#minute_s_y");
      
     for ( var i = 0; i < 24; i++)
     {
    	 hour_s.append("<option value="+i+">"+i+"</option>");
    	 hour_s_d.append("<option value="+i+">"+i+"</option>");
    	 hour_s_w.append("<option value="+i+">"+i+"</option>");
    	 hour_s_m.append("<option value="+i+">"+i+"</option>");
    	 hour_s_y.append("<option value="+i+">"+i+"</option>");
          
     }
      
     for ( var i = 0; i < 60; i++)
     {
    	 min_s.append("<option value="+i+">"+i+"</option>");
    	 min_s_d.append("<option value="+i+">"+i+"</option>");
    	 min_s_w.append("<option value="+i+">"+i+"</option>");
    	 min_s_m.append("<option value="+i+">"+i+"</option>");
    	 min_s_y.append("<option value="+i+">"+i+"</option>");
   
     }
});


</script>
</html>
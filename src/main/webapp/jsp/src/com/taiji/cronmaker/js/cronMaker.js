var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
         
function resetMsg(){
	$("#formmsg").html("");
}
function btnFan() {
    //获取参数中表达式的值
    var txt = $("#cron").val();
    var dateArr=[];
    $.ajax({
 		type: "get",
 		url: "<%=basePath %>/sysJob/caclulateDate",
 		data:{
 			"cron":txt
 		},
 		async: true,
 		dataType: "text",
 		success: function(data){
 			
 			var das = JSON.parse(data); 
 			$("#recentTime").empty();
 			dateArr = das.msg.split(",");
 			console.log(dateArr);
 			$.each(dateArr,function(i,obj){ 
 	 		 	$("#recentTime").append(" <li>"+obj+"</li>"); 
 	 		});
 			if(das.success){
 		//		$("#recent").html(das.msg);
 				
 			}else{
 				alert(das.msg);
 			}
 		}
		});
      if (txt) {
        var regs = txt.split(' ');
        $("input[name=v_second]").val(regs[0]);
        $("input[name=v_min]").val(regs[1]);
        $("input[name=v_hour]").val(regs[2]);
        $("input[name=v_day]").val(regs[3]);
        $("input[name=v_mouth]").val(regs[4]);
        $("input[name=v_week]").val(regs[5]);
 

        if (regs.length > 6) {
            $("input[name=v_year]").val(regs[6]);
 
        }
    }  
}

var item = [];
function pushItem(){
	item.push($("input[name=v_second]").val());
	item.push($("input[name=v_min]").val());
	item.push($("input[name=v_hour]").val());
	item.push($("input[name=v_day]").val());
	item.push($("input[name=v_mouth]").val());
	item.push($("input[name=v_week]").val());
	item.push($("input[name=v_year]").val());
}
function minGen(){
	var cron = $("#cron");
	cron.val("");
	item = [];
	
	var min = $("#minutes").val();
	if(/^\d+$/.test(min))  {
		if(parseInt(min)>0 && parseInt(min)<=60){
			$("input[name=v_second]").val(0);
			$("input[name=v_min]").val("0/"+min);
	        $("input[name=v_hour]").val("*");
	        $("input[name=v_day]").val("1/1");
	        $("input[name=v_mouth]").val("*");
	        $("input[name=v_week]").val("?");
	        $("input[name=v_year]").val("*");
	        
	        pushItem();
	        cron.val(item.join(" "));
			$("#cronExpression", parent.document).val(cron.val());
			parent.layer.close(index);
			$("#formmsg").html("");
		}else{
			$("#formmsg").html("请输入1-60整数");
		}
	}else{
		$("#formmsg").html("请输入1-60整数");
		 
	}
}


	function hourGen() {
		var cron = $("#cron");
		cron.val("");
		item = [];
		if ($("input[name='hour_r']:checked").val() == 1) {

			var hours = $("#hours").val();
			if (/^\d+$/.test(hours)) {
				if (parseInt(hours) > 0 && parseInt(hours) <= 12) {
					$("input[name=v_second]").val(0);
					$("input[name=v_min]").val("0");
					$("input[name=v_hour]").val("0/" + hours);
					$("input[name=v_day]").val("1/1");
					$("input[name=v_mouth]").val("*");
					$("input[name=v_week]").val("?");
					$("input[name=v_year]").val("*");

					pushItem();
					cron.val(item.join(" "));
					$("#cronExpression", parent.document).val(cron.val());
					parent.layer.close(index);
					$("#formmsg").html("");
				} else {
					$("#formmsg").html("请输入1-12整数");
				}
			} else {
				$("#formmsg").html("请输入1-12整数");

			}
		} else if ($("input[name='hour_r']:checked").val() == 2) {
			var hours = $("#hour_s").val();
			var mins = $("#minute_s").val();
			
			$("input[name=v_second]").val(0);
			$("input[name=v_min]").val(mins);
			$("input[name=v_hour]").val(hours);
			$("input[name=v_day]").val("1/1");
			$("input[name=v_mouth]").val("*");
			$("input[name=v_week]").val("?");
			$("input[name=v_year]").val("*");

			pushItem();
			cron.val(item.join(" "));
			$("#cronExpression", parent.document).val(cron.val());
			parent.layer.close(index);
			$("#formmsg").html("");
		}
	}
	
	function dayGen() {
		var cron = $("#cron");
		cron.val("");
		item = [];
		if ($("input[name='day_r']:checked").val() == 1) {
			var hours = $("#hour_s_d").val();
			var mins = $("#minute_s_d").val();
			var days = $("#days").val();
			if (/^\d+$/.test(days)) {
				if (parseInt(days) > 0 && parseInt(days) <= 31) {
					$("input[name=v_second]").val(0);
					$("input[name=v_min]").val(mins);
					$("input[name=v_hour]").val(hours);
					$("input[name=v_day]").val("1/"+days);
					$("input[name=v_mouth]").val("*");
					$("input[name=v_week]").val("?");
					$("input[name=v_year]").val("*");

					pushItem();
					cron.val(item.join(" "));
					$("#cronExpression", parent.document).val(cron.val());
					parent.layer.close(index);
					$("#formmsg").html("");
				} else {
					$("#formmsg").html("请输入1-31整数");
				}
			} else {
				$("#formmsg").html("请输入1-31整数");

			}
		} else if ($("input[name='day_r']:checked").val() == 2) {
			var hours = $("#hour_s_d").val();
			var mins = $("#minute_s_d").val();
			
			$("input[name=v_second]").val(0);
			$("input[name=v_min]").val(mins);
			$("input[name=v_hour]").val(hours);
			$("input[name=v_day]").val("?");
			$("input[name=v_mouth]").val("*");
			$("input[name=v_week]").val("MON-FRI");
			$("input[name=v_year]").val("*");

			pushItem();
			cron.val(item.join(" "));
			$("#cronExpression", parent.document).val(cron.val());
			parent.layer.close(index);
			$("#formmsg").html("");
		}
	}
	
	function weekGen() {
		var cron = $("#cron");
		cron.val("");
		item = [];
		
		if($('input:checkbox[name=weekly]').is(':checked')) {
			var week = "";
		      $('input:checkbox[name=weekly]:checked').each(function(i){
		       if(0==i){
		    	   week = $(this).val();
		       }else{
		    	   week += (","+$(this).val());
		       }
		      });
		      
		      
		      var hours = $("#hour_s_w").val();
				var mins = $("#minute_s_w").val();
				
				$("input[name=v_second]").val(0);
				$("input[name=v_min]").val(mins);
				$("input[name=v_hour]").val(hours);
				$("input[name=v_day]").val("?");
				$("input[name=v_mouth]").val("*");
				$("input[name=v_week]").val(week);
				$("input[name=v_year]").val("*");

				pushItem();
				cron.val(item.join(" "));
				$("#cronExpression", parent.document).val(cron.val());
				parent.layer.close(index);
				$("#formmsg").html("");
		}else{
			$("#formmsg").html("请勾选");
		}
		  
	}
	
	function monthGen() {
		var cron = $("#cron");
		cron.val("");
		item = [];
		if ($("input[name='month_r']:checked").val() == 1) {
			var hours = $("#hour_s_m").val();
			var mins = $("#minute_s_m").val();
			var month_m = $("#month_m").val();
			var day_m = $("#day_m").val();
			
			if (/^\d+$/.test(day_m) && /^\d+$/.test(month_m)) {
				if ( (parseInt(day_m) > 0 && parseInt(day_m) <= 31) && (parseInt(month_m) > 0 && parseInt(month_m) <= 12)) {
					$("input[name=v_second]").val(0);
					$("input[name=v_min]").val(mins);
					$("input[name=v_hour]").val(hours);
					$("input[name=v_day]").val(day_m);
					$("input[name=v_mouth]").val("1/"+month_m);
					$("input[name=v_week]").val("?");
					$("input[name=v_year]").val("*");

					pushItem();
					cron.val(item.join(" "));
					$("#cronExpression", parent.document).val(cron.val());
					parent.layer.close(index);
					$("#formmsg").html("");
				} else {
					$("#formmsg").html("请输入整数，月份（1-12），日期（1-31）");
				}
			} else {
				$("#formmsg").html("请输入整数，月份（1-12），日期（1-31）");

			}
		} else if ($("input[name='month_r']:checked").val() == 2) {
			var hours = $("#hour_s_m").val();
			var mins = $("#minute_s_m").val();
			var month_s_m = $("#month_s_m").val();
			var month_s_1 = $("#month_s_1").val();
			var month_s_2 = $("#month_s_2").val();
			
			if (/^\d+$/.test(month_s_m)) {
				if (  parseInt(month_s_m) > 0 && parseInt(month_s_m) <= 12) {
					$("input[name=v_second]").val(0);
					$("input[name=v_min]").val(mins);
					$("input[name=v_hour]").val(hours);
					$("input[name=v_day]").val("?");
					$("input[name=v_mouth]").val("1/"+month_s_m);
					$("input[name=v_week]").val(month_s_2+"#"+month_s_1);
					$("input[name=v_year]").val("*");

					pushItem();
					cron.val(item.join(" "));
					$("#cronExpression", parent.document).val(cron.val());
					parent.layer.close(index);
					$("#formmsg").html("");
				}else {
					$("#formmsg").html("请输入整数月份（1-12） ");
				}
			}else{
				$("#formmsg").html("请输入整数月份（1-12） ");
			}
			
		}
	}
	
	function yearGen() {
		var cron = $("#cron");
		cron.val("");
		item = [];
		if ($("input[name='year_r']:checked").val() == 1) {
			var hours = $("#hour_s_y").val();
			var mins = $("#minute_s_y").val();
			var month_s_y_1 = $("#month_s_y_1").val();
			var day_y = $("#day_y").val();
			
			if (/^\d+$/.test(day_y) ) {
				if ( parseInt(day_y) > 0 && parseInt(day_y) <= 31 ) {
					
					if(judgeDate(month_s_y_1,day_y)){
						$("input[name=v_second]").val(0);
						$("input[name=v_min]").val(mins);
						$("input[name=v_hour]").val(hours);
						$("input[name=v_day]").val(day_y);
						$("input[name=v_mouth]").val(month_s_y_1);
						$("input[name=v_week]").val("?");
						$("input[name=v_year]").val("*");

						pushItem();
						cron.val(item.join(" "));
						$("#cronExpression", parent.document).val(cron.val());
						parent.layer.close(index);
						$("#formmsg").html("");
					}else{
						$("#formmsg").html("请输入该月份存在的日期");
					}
					
				} else {
					$("#formmsg").html("请输入整数，日期（1-31）");
				}
			} else {
				$("#formmsg").html("请输入整数，日期（1-31）");

			}
		} else if ($("input[name='year_r']:checked").val() == 2) {
			var hours = $("#hour_s_y").val();
			var mins = $("#minute_s_y").val();
			var month_s_y_2 = $("#month_s_y_2").val();
			var year_s_1 = $("#year_s_1").val();
			var year_s_2 = $("#year_s_2").val();
			
			$("input[name=v_second]").val(0);
			$("input[name=v_min]").val(mins);
			$("input[name=v_hour]").val(hours);
			$("input[name=v_day]").val("?");
			$("input[name=v_mouth]").val(month_s_y_2);
			$("input[name=v_week]").val(year_s_2+"#"+year_s_1);
			$("input[name=v_year]").val("*");

			pushItem();
			cron.val(item.join(" "));
			$("#cronExpression", parent.document).val(cron.val());
			parent.layer.close(index);
			$("#formmsg").html("");
		}
	}
	
	function judgeDate(m,d){
		var monthArray1 = ["1","3","5","7","8","10","12"];//31天
		var monthArray2 = ["4","6","9","11"];//30天
	//	var monthArray3 = ["2"];//29天
		
		if(monthArray1.indexOf(m) > -1){
			if(d<=31){
				return true;
			}
		}else if(monthArray2.indexOf(m) > -1){
			if(d<=30){
				return true;
			}else{
				return false;
			}
		}else{
			if(d<=29){
				return true;
			}else{
				return false;
			}
		}
	}
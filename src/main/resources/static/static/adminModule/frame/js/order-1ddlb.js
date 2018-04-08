$(function(){
// #order-1ddlb
// 插件初始化
	// 模态框设置
	$('#order-1ddlb .modal').modal({
		keyboard:false,
		backdrop:'static',
		show:false,
		position:'90px'
	})
	// datetimepicker日期选择
		$("#order-1ddlb .form-datetime").datetimepicker({
			language:  "zh-CN",
			format:"yyyy-mm-dd hh:ii",
			weekStart: 1,
		  	autoclose:true,
	   		todayBtn:  1,
	   		pickerPosition:"bottom-right"
		});
// 结束

// json模拟数据
Mock.mock("dd_json", {
    'list|10': [{
        "dd_name":'@csentence(3, 5)',
		"dd_color":"@hex",
		"dd_size":'@integer(60, 100)',
		"dd_money":'@character("symbol")@integer(100, 200)',
		"dd_kh":"@cname",
		"dd_time":"@datetime",
		"dd_status|1":["已发货","未发货","停止发货"]
    }]
});

// 数据载入，数据表格
	function order_1ddlb_main_data(data,len){
		$("#order-1ddlb .main-content tbody").empty();
		for(i in data){
			$("#order-1ddlb .main-content tbody").append(function(){
				return '<tr><td class="dd-name">'+ data[len-i-1].dd_name +'</td><td>'+ data[len-i-1].dd_color +'</td><td>'+ data[len-i-1].dd_size +'</td><td>'+ data[len-i-1].dd_money +'</td><td>'+ data[len-i-1].dd_kh +'</td><td>'+ data[len-i-1].dd_time +'</td><td>'+ data[len-i-1].dd_status +'</td><td><button class="btn btn-sm btn-info dd-info" data-toggle="modal" data-target=".order-1ddlb-ddxq">详情</button>  <button class="btn btn-sm btn-danger dd-delete">取消订单</button></td></tr>'
			});
		};
	};
	function order_1ddlb_tabAjax(){
		$.ajax({
			url: "dd_json",
			type: 'get',
			dataType: 'json',
			success:function(data){
				console.log(data);
				var len = data.list.length;
				var data = data.list;
				order_1ddlb_main_data(data,len);
			},
			complete:function(){
				$('#order-1ddlb .main-content tbody tr').each(function(index, el) {
					var td_text = $(this).find('td').eq(6).text();
					console.log(td_text)
					if(td_text == "已发货"){
						console.log('已发货')
						$(this).find('td').eq(7).find('.dd-info').after(' <button class="btn btn-sm btn-success dd-gzdingdan" data-toggle="modal" data-target=".order-1ddlb-ddgz">跟踪单</button>')
					}else if(td_text == "未发货"){
						console.log('未发货')
						$(this).find('td').eq(7).find('.dd-info').after(' <button class="btn btn-sm btn-success dd-fahuo" data-toggle="modal" data-target=".order-1ddlb-ddfh">发货</button>')
					}else if(td_text == "停止发货"){
						console.log('停止发货')
						$(this).find('td').eq(7).find('.dd-info').after(' <button class="btn btn-sm btn-success dd-jxfahuo">继续发货</button>')
					}
				});
			}
		})
	}
	order_1ddlb_tabAjax();
	$("body").on("click","#order-1ddlb .break",function(){
		order_1ddlb_tabAjax();
	})
// 结束

// 取消订单
$('body').on('click','.dd-delete',function(){
	var name = $(this).parent().siblings('td').eq(0).text();
	bootbox.confirm(
		'您确定要取消订单 <span class="text-danger">' + name + '</span> 吗？',
		function(result){
			if(result){
				// 确认

			}else{
				// 取消

			}
		}
	);

});




});
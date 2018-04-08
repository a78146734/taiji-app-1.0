$(function(){
// #goods-1cplb
// 产品列表

// 插件初始化----------------------------------------------
	// 模态框
	$('#goods-1cplb .modal').modal({
		keyboard:false,
		backdrop:'static',
		show:false,
		position:'90px'
	})
	// datetimepicker日期选择
	$("#goods-1cplb .form-datetime").datetimepicker({
		language:  "zh-CN",
		format:"yyyy-mm-dd hh:ii",
		weekStart: 1,
	  	autoclose:true,
   		todayBtn:  1,
   		pickerPosition:"bottom-right"
	});
	// 数据表格插件
	$('#goods-1cplb table.datatable').datatable({
		//sortable: true,		//排序
		//checkable: true   //高亮选中行
	});
	// kindeditor富文本
	var editor  = KindEditor.create(
		'#goods-1cplb .goods-1cplb-tjsp textarea.kindeditor',{
			basePath : '/dist/lib/kindeditor/',
			bodyClass : 'article-content',
			resizeType : 1,
			allowPreviewEmoticons : false,
			allowImageUpload : false,
			items : [
			  	'fontname', 'fontsize', '|', 'forecolor', 
			  	'hilitecolor', 'bold', 'italic', 'underline',
			 	'removeformat', '|', 'justifyleft', 'justifycenter', 
			 	'justifyright', 'insertorderedlist',
				'insertunorderedlist', '|', 'emoticons', 'link'
			]
		}
	);
	// $('#goods-1cplb .ke-container').css('width','100%')
	
	// $('#goods-1cplb .getEditorHtml').click(function(){
	// 	alert(editor.html());		//取得html
	// })
	// $('#goods-1cplb .isEditorEmpty').click(function(e) {
	// 	alert(editor.isEmpty());	//判断是否为空
	// });
	// $('#goods-1cplb .clearEditor').click(function(e) {
	// 	editor.html('');	//清空内容
	// });
// 结束----------------------------------------------------

// 顶部搜素栏
	$("body").on("click","#goods-1cplb-formsearch .dropdown-menu li",function(){
		$("#goods-1cplb-formsearch input[name='screen']").val($(this).text())
	})
// 结束

// json模拟数据
Mock.mock("my.json", {
    'list|10': [{
        "sp_name":'@csentence(3, 5)',
		"sp_code":"@guid",
		"sp_img":"@img(70x30)",
		"sp_liebie":"商品类别"
    }]
});
// 数据载入，数据表格
	function goods_1cplb_main_data(data,len){
		$("#goods-1cplb .main-content tbody").empty();
		for(i in data){
			$("#goods-1cplb .main-content tbody").append(function(){
				return '<tr><td class="sp-name">'+ data[len-i-1].sp_name +'</td><td>'+data[len-i-1].sp_code+'</td><td><img src="'+data[len-i-1].sp_img+'" alt=""></td><td>'+data[len-i-1].sp_liebie+'</td><td><button class="btn btn-sm btn-info sp-info" data-toggle="modal" data-target=".goods-1cplb-spxq">详情</button> <button class="btn btn-sm btn-success sp-xiugai">修改</button> <button class="btn btn-sm btn-danger sp-delete">删除</button></td></tr>'
			});
		};
	};
	function goods_1cplb_tabAjax(){
		$.ajax({
			url: "my.json",
			type: 'get',
			dataType: 'json',
			success:function(data){
				console.log(data);
				var len = data.list.length;
				var data = data.list;
				goods_1cplb_main_data(data,len);
			}
		})
	}
	goods_1cplb_tabAjax();
	$("body").on("click","#goods-1cplb .break",function(){
		goods_1cplb_tabAjax();
	})
// 结束

// 添加规格
	// $('.goods-1cplb-tjsp').modal({
	// 	keyboard:false,
	// 	backdrop:'static',
	// })
	$('#goods-1cplb .goods-1cplb-tjgg .ok').on('click',function(){
		
	})
// 结束

// 上架下架判断
	$('body').on('change','#goods-1cplb .goods-1cplb-tjgg .sh-or-xj',function(){
		if($(this).val() == 1){
			$('#goods-1cplb .shangjiatime').html('上架时间');
		}else if($(this).val() == 2){
			$('#goods-1cplb .shangjiatime').html('下架时间');
		}
	});
// 结束

// 删除摁扭
	$('#goods-1cplb .sp-delete').on('click',function(){
		var name = $(this).parent().siblings('td.sp-name').text();
		bootbox.confirm(
			'您确定要删除 <span class="text-danger">' + name + '</span> 吗？',
			function(result){
				if(result){
					// 确认

				}else{
					// 取消

				}
			}
		);
	});
// 结束

// 搜索栏ajax
	
// 结束

// 添加商品ajax提交
	$("body").on("click",".goods-1cplb-tjsp .xiayibu",function(){

		$('.goods-1cplb-tjgg').modal('show')
		$('.goods-1cplb-tjsp').modal('hide')
		// 获取图片
		var imgAry = [];
		var imgObj = {};
		var sp_imgUrl = $(".goods-1cplb-tjsp .spval-img input")[0].files;
		console.log(sp_imgUrl)
		console.log($(".goods-1cplb-tjsp .spval-img input")[0])
		var len = sp_imgUrl.length;
		for(var j = 0;j < len;j++){
			var jUrl = sp_imgUrl[j];
			imgAry[j] = {
				lastModified:jUrl.lastModified,
				lastModifiedDate:jUrl.lastModifiedDate,
				name:jUrl.name,
				size:jUrl.size,
				type:jUrl.type,
				webkitRelativePath:jUrl.webkitRelativePath
			};
		};
		for(k in imgAry){
			imgObj["sp_img"+k] = imgAry[k]
		};
		// console.log(imgObj);

		// 获取表单
		var fText = $("#goods-1cplb-tjsp-form").serializeArray();
		var spObj = {};
		for(i in fText){
			spObj[fText[i].name] =  fText[i].value;
		};

		var spJson = JSON.stringify($.extend(imgObj,spObj));
		console.log(spJson)

	});
// 结束

});
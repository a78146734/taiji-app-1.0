$(function(){
// #goods-1cplb
// 初始化js
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
		'#goods-1cplb .goods-1cplb-tjsp textarea.kindeditor', 
			{
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

// 结束



});
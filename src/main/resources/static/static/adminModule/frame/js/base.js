$(function(){
// 开始

// 全局变量
		//tab-nav的宽度	
	var tnW = $('.tab-nav').width();
// 结束

// ajax加载动画关闭
	$('.ajax-start').ajaxStart(function(){
		$(this).show();
	});
	$('.ajax-start').ajaxStop(function(){
		$(this).hide();
	});
	$('.ajax-start .close').click(function(){
		$('.ajax-start').hide();
	});
// 结束

// 样式控制
	// 侧栏图标样式
	$('#sidenav .show .icon-chevron-right').addClass('icon-rotate-90');
	// 内容区高度样式
	$('#main').css('min-height',$(window).height()-30);
	$('#content').css('min-height',$(window).height()-170);
// 结束

// 网页全屏
	// 全屏摁扭添加提示
	$('.FullScreen').tooltip('show');
	setInterval("$('.FullScreen').tooltip('hide')",3000);

	// 创建方法
	function requestFullScreen(element) {
	    // 判断各种浏览器，找到正确的方法
	    var requestMethod = element.requestFullScreen || //W3C
	        element.webkitRequestFullScreen || //Chrome等
	        element.mozRequestFullScreen || //FireFox
	        element.msRequestFullScreen; //IE11
	    if (requestMethod) {
	        requestMethod.call(element);
	    } else if (typeof window.ActiveXObject !== "undefined") { //for Internet Explorer
	        var wscript = new ActiveXObject("WScript.Shell");
	        if (wscript !== null) {
	            wscript.SendKeys("{F11}");
	        }
	    }
	};

	//退出全屏 判断浏览器种类
	function exitFull() {
	    // 判断各种浏览器，找到正确的方法
	    var exitMethod = document.exitFullscreen || //W3C
	        document.mozCancelFullScreen || //Chrome等
	        document.webkitExitFullscreen || //FireFox
	        document.webkitExitFullscreen; //IE11
	    if (exitMethod) {
	        exitMethod.call(document);
	    } else if (typeof window.ActiveXObject !== "undefined") { //for Internet Explorer
	        var wscript = new ActiveXObject("WScript.Shell");
	        if (wscript !== null) {
	            wscript.SendKeys("{F11}");
	        }
	    }
	};

	// 摁扭点击网页全屏
	$('#header .FullScreen').click(function(event) {
		requestFullScreen(document.documentElement);
		$(this).hide();
		$('#header .ExitFull').show();
		$('.ExitFull').tooltip('show');
	});
	$('#header .ExitFull').click(function(event) {
		exitFull();
		$(this).hide();
		$('#header .FullScreen').show();
	});
	// 点击ESC
	$(document).keyup(function(event){
	 	switch(event.keyCode) {
		 	case 27:
		 	$('#header .ExitFull').hide();
		 	$('#header .FullScreen').show();
		 	case 96:
		 	$('#header .ExitFull').hide();
		 	$('#header .FullScreen').show();
		 }
	});
// 结束
     
	 $('.on').click(function(){
		 $('.on').css('color','#1a80e5');
		 });




// 侧边栏
	// 侧边栏显示隐藏
	$('#header .side-click').click(function(){
		if($('#sidenav').width() == 220){
			$('#sidenav .user,#sidenav nav').fadeOut();
			$('#sidenav').animate({'width':'0px'});
			$('#header').animate({'padding-left':'0'});
			$('#main').animate({'padding-left':'0'});
			$('#footed').animate({'padding-left':'0'});
			$('#tab-title').animate({'padding-left':'0'});
		}else{
			$('#sidenav .user,#sidenav nav').fadeIn();
			$('#sidenav').animate({'width':'220px'});
			$('#header').animate({'padding-left':'220px'});
			$('#main').animate({'padding-left':'220px'});
			$('#footed').animate({'padding-left':'220px'});
			$('#tab-title').animate({'padding-left':'220px'});
		}
	});

	// 侧边栏滚动条
	function navScrool(){
		$('#sidenav nav').height($('#sidenav').height()-$('#sidenav .user').height()-20);
	};
	navScrool();

	//点击侧栏菜单并在tab-nav中添加此菜单对应的标签名，并在内容区域添加对应此标签的内容块 
	/*$('#sidenav .menu a').on('click', function(event) {
		alert(event);
		$(this).parents('.nav').find('li').removeClass('on');
		$(this).parents('.nav').find('.nav-parent').removeClass('active');
		$(this).parents('.nav-parent').addClass('active');
		$(this).parent('li').addClass('on').siblings('li').removeClass('on');

		// 添加的li距离左边的距离
		var tnSet = Math.abs(parseFloat($('.tab-nav li').last().offset().left));
		var onPl = Math.abs(parseFloat($('.tab-nav li').last().position().left) - 120); 
		// 获取a中的内容
		var navListName = $(this).text();
		// 获取a的data-class值
		var thisTitle = $(this).attr('data-class');
		
		// 判断是否含有子选项，是添加tab选项卡，否展开;
		if($(this).siblings().length == 0){
			// console.log('不含nav，增加tab')
			// 判断tab-nav中是否存在此选项卡，是不添加，否在添加
			if($('.tab-nav li.' + thisTitle).length > 0){
				// console.log('已添加');
				var name = '.main-body .'+thisTitle;
				
				// 顶部tab 切换
				$('.tab-nav li.' + thisTitle).addClass('on').siblings('li').removeClass('on');
				// main内容显示
				$('.main-body .tab-content').hide();
				$(name).show();
				
			}else{
				// 添加选项卡头部
				$('.tab-nav ul').append('<li class="'+thisTitle +'" data-class="'+ thisTitle +'">'+ navListName +'<i class="ion-android-cancel"></i></li>');
				$('.tab-nav ul li.'+thisTitle+'').addClass('on').siblings('li').removeClass('on');
				// 判断添加的li距离左边的距离 > ul 的宽度，是 偏移
				if(tnSet > tnW){
					$('.tab-nav ul').css('margin-left','-' + onPl + 'px');
				}
				// 添加对应选项卡内容
				$('.main-body').append('<div class="tab-content '+thisTitle+'" id="'+thisTitle+'"></div>');
				$('.main-body .tab-content').hide();
				$('.main-body .'+ thisTitle).show();
				nextPd();
				
			// ajax加载，关键部分
				// 获取 ajax 的 url  
				var ajaxUrl =  $(this).attr('data-url') + '?' + Math.random();
				var ajaxClass = '.main-body .' + thisTitle;
				// 加载动画
				// $('.ajax-start').show();
				// $.ajaxSetup ({
				// 	cache: false //关闭AJAX相应的缓存
				// });
				
				$(ajaxClass).load(ajaxUrl,function(responseTxt,statusTxt,xhr){
				    if(statusTxt == "success")
				    	// 加载动画隐藏
				    	// $('.ajax-start').hide();
				      	// console.log(responseTxt);
				      	// if($('script[src="js/'+ thisTitle +'.js"]').length == 0){
				      	// 	$("#dtjs").after('<script src="js/'+ thisTitle +'.js"></script>')
				      	// }
				      	// $.getScript('js/'+ thisTitle +'.default.js');
				      	$.getScript('js/'+ thisTitle +'.js');
				    if(statusTxt=="error")
				      	console.log("Error: "+xhr.status+": "+xhr.statusText);
			    });
			// 结束
			}

		}else if($(this).siblings().length > 0){
			console.log('含有nav,展开');
		}
 
	});*/
// 结束

// 顶部tab导航
	// 点击选项卡摁扭对应选项卡内容展示
	$('body').on('click','.tab-nav li',function(e){
		
		var thisClass = $(this).attr('data-class');
		var name = '.main-body .'+thisClass;
		// 添加样式
		$(this).addClass('on').siblings().removeClass('on');
		$('.main-body .tab-content').hide();
		$(name).show();
		// 侧栏样式设置，可以去掉，以提高性能
		$('.nav').find('li').removeClass('on');
		$('.nav').find('.nav-parent').removeClass('active');
		$('#sidenav a[data-class="'+thisClass+'"]').parents('.nav-parent').addClass('active');
		$('#sidenav a[data-class="'+thisClass+'"]').parent('li').addClass('on').siblings('li').removeClass('on');
		// 结束
	});

	// 点击首页选项卡摁扭
	$('body').on('click','.tab-nav ul li.first',function(){
		$('.main-body .tab-content').hide();
		$('.first-content').show();
	});

	// 关闭导航栏和导航栏关联内容	
	$('body').on('click','.tab-nav i', function(){
		var thisPrev = $(this).parent().prev();				//这元素父元素的上一个元素
		var thisTit = $(this).parent().attr('data-class');		//这个元素父元素的title值
		var thisTit1 = thisPrev.attr('data-class');				//父元素title值
		console.log(thisTit1);
		var name = '.main-body .'+thisTit;
		var name1 = '.main-body .'+thisTit1;
		console.log(name1);
		// 删除此标签和它对应的内容
		$(this).parent().remove();
		$(name).remove();
		// $("script[src='js/"+thisTit+".js']").remove();
		// 判断摁扭
		nextPd();
		// // console.log(thisTit);
		// 判断是否存在on类名，存在父元素的上一元素添加on并将父元素的上一元素对应内容显示
		if($(this).parent().hasClass('on')){
			// 判断父元素的上一个同级元素是否为首页的tab-tit
			if(thisPrev.hasClass('first')){
				$('.first-content').show();
				// 侧栏样式设置，可以去掉，以提高性能
				$('.tab-nav ul>li.first').addClass('on');
				$('.nav').find('li').removeClass('on');
				$('.nav').find('.nav-parent').removeClass('active');
				// 结束
			}else{
				thisPrev.addClass('on');
				$(name1).show();
				// 侧栏样式设置，可以去掉，以提高性能
				var preTit = thisPrev.attr('data-class');
				$('.nav').find('li').removeClass('on');
				$('.nav').find('.nav-parent').removeClass('active');
				$('#sidenav a[data-class="'+preTit+'"]').parents('.nav-parent').addClass('active');
				$('#sidenav a[data-class="'+preTit+'"]').parent('li').addClass('on').siblings('li').removeClass('on');
				// 结束
			}
		}
		if($('.tab-nav ul>li').length == 1){
			$('.tab-nav ul>li.first').addClass('on');
			// 侧栏样式设置，可以去掉，以提高性能
			$('.nav').find('li').removeClass('on');
			$('.nav').find('.nav-parent').removeClass('active');
			// 结束
		}
		// 阻止冒泡
		return false;
	});

	// tab控制摁扭选项
	// 判断ul的高度，内容超出会导致ul的高度增加
	// function prevShow(){
	// 	if($('.tab-nav ul').height()>45){
	// 		$('.tab-prev').removeClass('disabled');
	// 	}else{
	// 		$('.tab-prev').addClass('disabled');
	// 	}
	// };
	// prevShow();
	function nextPd(){
		var firstLeft = Math.abs(parseFloat($('.tab-nav ul li').last().position().left));
		if(firstLeft < (tnW - 120)){
			$('.tab-next').addClass('disabled');
		}else{
			$('.tab-next').removeClass('disabled');
		}
	};
	nextPd();

	// 上一页
	$('.tab-prev').click(function(){
		var mLeft = Math.abs(parseFloat($('.tab-nav ul').css('margin-left')));
		var a = $('.tab-nav').width() - 120;
		$('.tab-nav ul').css('margin-left',- (mLeft - a) + 'px');
		if(parseFloat($('.tab-nav ul').css('margin-left')) > 0){
			$('.tab-nav ul').css('margin-left',0);
			// $('.tab-next').addClass('disabled')
		}else{

		}
		nextPd();
	});
	// 下一页
	$('.tab-next').click(function(){
		var onal = parseFloat($('.tab-nav ul li').last().offset().left);
		var mLeft = Math.abs(parseFloat($('.tab-nav ul').css('margin-left')));
		var a = $('.tab-nav').width() - 120;
		// console.log($('.tab-nav ul li').last().offset().left)
		// console.log(mLeft - a)
		var onPl = Math.abs(parseFloat($('.tab-nav ul li').last().position().left) - 120);
		if(onal > mLeft){
			$('.tab-nav ul').css('margin-left',- (mLeft + a) + 'px');
		}else{
			$('.tab-nav ul').css('margin-left','-' + onPl + 'px');
		} 
		// nextPd();
	});
		
	//  关闭第一个li的所有兄弟元素并为第一个元素添加on类名;
	$('.close-full').click(function(){
		$('.tab-nav li').eq(0).addClass('on').siblings().remove();
		$('.first-content').show().siblings().remove();
		
	});
	//  关闭第一个li 的兄弟元素 中 不含有on类名的元素;
	$('body').on('click','.close-on',function(){
		var tit = $('.tab-nav .on').attr('data-class');
		$('.tab-nav li.first').siblings().each(function(index, el) {
			var this_on = $(this).hasClass('on');
			if(!this_on){
				$(this).remove();
			}
		});
		$('.main-body .first-content').siblings().each(function(index, el) {
			var this_tit = $(this).hasClass(tit); 
			if(!this_tit){
				$(this).remove();
			}
		});
	});
	// 定位当前选项卡
	$('.pos-tab').click(function(){
		var onl = Math.abs(parseFloat($('.tab-nav li.on').position().left) - 200);
		if(onl > tnW){
			$('.tab-nav ul').css('margin-left','-' + onl + 'px');
		}
		else{
			$('.tab-nav ul').css('margin-left',0);
		}
	});
// 结束

// 右键菜单
	// 屏蔽右键
	// $("body").on("contextmenu","#main",function(){
	//     return false;
	// })
	// $('#main').mousedown(function(e){ 
	// 	if(3 == e.which){ 
	// 		// console.log('这 是右键单击事件'); 
	// 	   	var l = e.pageX
	// 	   	var t = e.pageY
	// 	   	console.log(l + ',' + t)
	// 		$('#c-right-menu').show();
	// 		$('#c-right-menu').css({
	// 			'left':l+'px',
	// 			'top':t+'px'
	// 		})
	// 	}else if(1 == e.which){ 
	// 	   console.log('这 是左键单击事件'); 
	// 	   $('#c-right-menu').hide();
	// 	} 
 	//  })

// 结束

// 屏幕大小改变时
	$(window).resize(function(event) {
		// 侧边栏滚动条
		navScrool();
		// 内容区高度
		$('#main').css('min-height',$(window).height()-30);
		$('#content').css('min-height',$(window).height()-170);
	});
// 结束

// 翻页
	// 判断是否为第一页或者最后一页
	function pageIf(){
		$('.pager').each(function(index, el) {
			var pager_a = $('.pager .li.active');
			if(pager_a.prev().hasClass('previous')){
				$('.pager li.previous').addClass('disabled');
			}else{
				$('.pager li.previous').removeClass('disabled');
			}
			if(pager_a.next().hasClass('next')){
				$('.pager li.next').addClass('disabled');
			}else{
				$('.pager li.next').removeClass('disabled');
			}
		});
	};
	pageIf();
	// 点击后添加样式并判断是否为第一页或者最后一页
	$('body').on('click','.pager .li a',function(){
		var li = $(this).parent('li');
		li.addClass('active').siblings('li').removeClass('active');
		pageIf();
	});
	// 点击上一页
	$('body').on('click','.pager li.previous',function(){
		// var pager_a = $('.pager .li.active');
		var pager_a = $(this).siblings('.active');
		pager_a.prev().addClass('active').siblings().removeClass('active');
		pageIf();	// 判断是否为第一页
	});
	// 点击下一页
	$('body').on('click','.pager li.next',function(){
		var pager_a = $(this).siblings('.active');
		// var pager_a = $('.pager .li.active');
		pager_a.next().addClass('active').siblings().removeClass('active');
		pageIf();  	//判断是否为最后一页
		
	});
// 结束

// 插件引入以及配置
	// bootbox
	bootbox.setDefaults({
		locale:"zh_cn",
		size:"small",
		closeButton:false
	});

	// 提示消息插件初始化
	$('[data-toggle="tooltip"]').tooltip();

	// 单张图片上传预览
 	$('body').on('change','.nt-imgfile input[type="file"]',function(){
		var f = $(this);
		var files = f[0].files[0];
		var src = window.URL.createObjectURL(files);
		$(this).parents('.nt-imgfile').css('background-image','url('+src+')');
 	});

 	// 多图上传预览
 	$('body').on('change','.nt-imgfiles input[type="file"]',function(){
		var f = $(this);
		var len =f[0].files.length;
		f.parent().siblings('.nt-imgsyulan').empty();
		for(var i = 0;i < len;i++){
			var files = f[0].files[i];
			var src = window.URL.createObjectURL(files);
			f.parent().siblings('.nt-imgsyulan').append('<img src="'+src+'" alt="">');
		}
 	});
// 结束

// jquery结束
});


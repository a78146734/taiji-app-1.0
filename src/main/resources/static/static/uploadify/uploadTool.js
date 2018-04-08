	var basepath = path;
	var id = "";
	var css = document.createElement('link');
    css.href=basepath+"/static/uploadify/uploadTool.css";
    css.rel="stylesheet";
    css.type="text/css";
    document.getElementsByTagName('head')[0].appendChild(css);	
    var layer = null;
    var index = null;
	layui.use('layer', function(){
		layer = layui.layer;
	});
    
	// upload start 
	//打开弹窗加载上传页面,divid存放上传文件div，隐藏文件input的id，part模块名称（自己定义），type展示文件大小，填写small问小图标格式，默认为大
	function upload(divid,str,part,type){
		if($("#"+str).length==0){
			//alert("未找到key对象"+str);
			return;
		}else if($("#"+divid).length==0){
			alert("未找到文件div对象"+str);
			return;
		}
			this.id=str;
			//判断key值是否为空 anjl 2016.7.1
			if($("#"+str).val()==null||$("#"+str).val()==""){
				$("#"+str).val(uuid());
			}
			 index = layer.open({
				  type: 2,
				  title: '文件上传',
				  shadeClose: true,
				  shade: [0.8, '#fff'],
				  shadeClose: true,
				  maxmin: true, //开启最大化最小化按钮
				  area: ['60%', '60%'],
				  content: basepath+"/jsp/utils/uploadify/fileUpload.jsp?key="+$("#"+str).val()+"&part="+part+"&divid="+divid+"&type="+type //iframe的url
				}); 
			uploader.options.formData.uid = $("#"+str).val();
		}
	
	
	//查询已上传附件信息请key值为保存在你文件表中的唯一文件标示，divid存放文件的div的id，edit设置为“edit”则有删除按钮，type为展示图标大小，设置为“small”为小图标
	function getFile(key,divid,edit,type){
		debugger;
		var fontLength = 3;
		if(key==""||key==null){
			//alert("未找到key对象file");
			return;
		}else if(divid==""||divid==null){
			alert("请设置放置文件列表的空间divid");
			return;
		}
		
		if(type=="small"){
			$(css).remove();
			var css2 = document.createElement('link');
		    css2.href=basepath+"/static/uploadify/uploadToolSmall.css";
		    css2.rel="stylesheet";
		    css2.type="text/css";
		    document.getElementsByTagName('head')[0].appendChild(css2);
		    fontLength = 2;
		}
		
		$.ajax({
	 		type: "post",
	 		url: basepath+"/sysToolFile/list",
	 		data:{
	 			"fileKey":key
	 		},
	 		async: false,
	 		dataType: "json",
	 		beforeSend: function(){},
	        complete: function(){},
	 		success: function(data){
	 			var content1 = "<div   style='float:left;overflow:hidden;width:99%;'>";
	 			$.each(data.obj,function(i,obj){ 
	 
	 				if(edit==null||edit==""){
		 					content1 += "<div id='"+obj.fileId+"' class='bgmenu' title='"+obj.fileRealname+obj.fileType+"' ><div class='imgdv' ><img class='imgf' src='"+checkFileType(obj)+"'><br><span class='menuft'></span></div><div class='ftdv'><span  class='namedv'>"+subLength(obj.fileRealname,fontLength)+obj.fileType+"</span></div><div class='ftcz'><span class='ftsp'><a href='#' onclick='downFile(\""+obj.fileId+"\");'>下载</a></span></div></div>";
	 				}else{
		 					content1 += "<div id='"+obj.fileId+"' class='bgmenu' title='"+obj.fileRealname+obj.fileType+"'><div class='imgdv' ><img class='imgf' src='"+checkFileType(obj)+"'><br><span class='menuft'></span></div><div class='ftdv'><span title='"+obj.fileRealname+obj.fileType+"' class='namedv'>"+subLength(obj.fileRealname,fontLength)+obj.fileType+"</span></div><div class='ftcz'><span class='ftsp'><a href='#' onclick='downFile(\""+obj.fileId+"\");'>下载</a>&nbsp;|&nbsp;<a href='#' onclick='delFile(\""+obj.fileId+"\");'>删除</a></span></div></div>";
	 				}
	 			});
	 			content1 += "</div>";
	 			$("#"+divid).html(content1);
	 		},
	 		error: function(xml){
	 			alert("错误");	
	 		}
			});
		}
		
	
	
	//下载文件
	function downFile(id){
		location.href=basepath+"/sysToolFile/download?fileId="+id;
	}
	
	//删除文件
	function delFile(id){
		$.ajax({
	 		type: "get",
	 		url: basepath+"/sysToolFile/delete",
	 		data:{
	 			"id":id
	 		},
	 		async: false,
	 		dataType: "json",
	 		success: function(data){
	 			if(data.success==true){
	 				$("#"+id).remove();
	 			}else{
	 				alert("文件删除失败，请稍后重试！");
	 			}
	 		},
	 		error: function(xml){
	 			alert("错误");	
	 		}
		});
	}
	
	
	//检查文件类型
	function checkFileType(obj){
		var type = obj.fileType.toLowerCase();
		if(type==".bmp"||type==".jpg"||type==".jpeg"||type==".png"||type==".gif"){
			return basepath+"/static/file/"+obj.filePart+"/"+obj.filePath+"/"+obj.fileName+obj.fileType;
		}else if(type==".doc"||type==".docx"||type==".docm"||type==".dotx"){
			return basepath+"/static/uploadify/images/word.png";
		}else if(type==".xlsx"||type==".xlsm"||type==".xltx"||type==".xltm"||type==".xlsb"||type==".xlam"){
			return basepath+"/static/uploadify/images/excel.png";
		}else if(type==".pptx"||type==".pptm"||type==".ppsx"||type==".ppam"||type==".xlam"){
			return basepath+"/static/uploadify/images/ppt.png";
		}else if(type==".aiff"||type==".avi"||type==".mkv"||type==".mpeg"||type==".mpg"||type==".qt"||type==".ram"||type==".viv"||type==".mp4"){
			return basepath+"/static/uploadify/images/video.png";
		}else if(type==".txt"){
			return basepath+"/static/uploadify/images/text.png";
		}else if(type==".mp3"||type==".wmv"||type==".wma"||type==".mid"||type==".wav"){
			return basepath+"/static/uploadify/images/mp3.png";
		}else if(type==".rar"||type==".zip"){
			return basepath+"/static/uploadify/images/zip.png";
		}else if(type==".pdf"){
			return basepath+"/static/uploadify/images/zip.png";
		}else{
			return basepath+"/static/uploadify/images/knowfile.png";
		}
		
	}
	
	
	//生成uuid做为key值
	function uuid() {
		var s = [];
		var hexDigits = "0123456789abcdef";
		for (var i = 0; i < 36; i++) {
			s[i] = hexDigits.substr(Math.floor(Math.random() * 0x10), 1);
		}
		s[14] = "4"; // bits 12-15 of the time_hi_and_version field to 0010
		s[19] = hexDigits.substr((s[19] & 0x3) | 0x8, 1); // bits 6-7 of the clock_seq_hi_and_reserved to 01
		s[8] = s[13] = s[18] = s[23] = "-";
		
		var uuid = s.join("");
		uuid = uuid.replace(/-/g,"");
		return uuid;
	}
	
	function subLength(str,_length){
		if(str==null||str==""){
			return "";
		}
		if(str.length>_length){
	  		str=str.substring(0,_length)+".";
		}
			return str;
	}
	
	function subEndLength(str,start){
		if(str==null||str==""){
			return "";
		}
		if(str.length>start){
	  		str=str.substring(start);
		}
			return str;
	}
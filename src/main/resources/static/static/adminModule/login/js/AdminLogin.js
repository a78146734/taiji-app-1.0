// 判断时候在Iframe框架内,在则刷新父页面
if (self != top) {
    parent.location.reload(true);
    if (!!(window.attachEvent && !window.opera)) {
        document.execCommand("stop");
    } else {
        window.stop();
    }
}

function submitForm(){
	var params = $("#loginform").serialize();
	
	$.ajax({
 		type: "post",
 		url: basePath+"/login",
 		data:params,
 		async: true,
 		dataType: "json",
 		beforeSend: function() {},
 		complete: function(XMLHttpRequest, textStatus) {},
 	    error: function(){},
 		success: function(data){
 			if (data.success) {
                window.location.href = basePath + '/index';
            }else{
                alert(data.msg);
            }
 		}
	});
}
function clearForm(){
    $('#loginform').form('clear');
}
//回车登录
function enterlogin(){
    if (event.keyCode == 13){
        event.returnValue=false;
        event.cancel = true;
        $('#loginform').submit();
    }
}

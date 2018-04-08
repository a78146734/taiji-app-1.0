<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String path2 = request.getContextPath();
	String basePath2 = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path2;
%>
	<script type="text/javascript"  src="<%=basePath2%>/static/commons/page/js/basecontrol.js" charset="utf-8"></script>
	
	<script type="text/javascript">
		function changePageSize(obj) {
			document.getElementById("nowpage").value = obj.value;
			document.forms[0].submit();
		}
	</script>
    <table cellpadding="0" cellspacing="0" class="fenye-tab" style="overflow: hidden;">
          <tr>
          <td id="page1" style="display: none;" >
          	<a href="javascript:void(0);" onClick="javascript:jump('first',this);return false;">首页</a>&nbsp;&nbsp;&nbsp;
          </td>
          <td id="noPage1" style="display:none;">
          	<a><%-- <img src="<%=basePath2%>/static/commons/page/images/left-img1no.png" /> --%></a>
          </td>
          <td id="page2">
			<a href="javascript:void(0);" onClick="javascript:jump('pre',this);return false;">上一页</a>&nbsp;&nbsp;&nbsp;
		  </td>
		  
          <td id="noPage2" style="display:none;">
			<a href="javascript:void(0);" ><%-- <img src="<%=basePath2%>/static/commons/page/images/left-img2no.png" /> --%></a>
		  </td>
		  <td id="page3">
			<a href="javascript:void(0);" onClick="javascript:jump('next',this);return false;">下一页</a>&nbsp;&nbsp;&nbsp;
          </td>
		  <td id="noPage3" style="display:none;">
			<a href="javascript:void(0);" ><%-- <img src="<%=basePath2%>/static/commons/page/images/left-img3no.png" /> --%></a>
          </td>
          <td id="page4" style="display: none;">
          	<a href="javascript:void(0);" onClick="javascript:jump('end',this);return false;">末页</a>&nbsp;&nbsp;&nbsp;
          </td>
          <td id="noPage4" style="display:none;">
          	<a href="javascript:void(0);" ><%-- <img src="<%=basePath2%>/static/commons/page/images/left-img4no.png" > --%></a>
          </td>
          <td style="width:44px;">
          	&nbsp;<input name="jumpPage" style="width:30px;" type="text" />
          </td>
          <td>
          	<a href="javascript:void(0);"  onClick="javascript:jump('jump',this)">跳转</a>
          </td>
       <td style="width:90px">共<label id="totalRecordSpan"></label>条记录</td>
       <td>第<label id="nowpageSpan"></label>页</td>
       <td>共<label id="totalpageSpan"></label>页</td>
         </tr>
         </table>
    
<input type=hidden name=nowpage value="1"><!-- 当前页 -->
<input type=hidden name=total ><!-- 总记录数 -->
<input type=hidden name=totalpage ><!-- 总页数 -->
<input type=hidden name=pagesize value="7"><!-- 每页记录数 -->
<input type=hidden name=sortType value="asc"><!--排序  升序asc 降序desc-->
<input type=hidden name=sortColumn value=""><!--排序  升序asc 降序desc-->


<script type="text/javascript">
	var totalpage = parseInt( document.forms[0].totalpage.value );
	var nowpage = parseInt( document.forms[0].nowpage.value );
 	function jump(act,obj){
 		if(!doJump(act,totalpage)){ return false; }
 		doQuery();
 	}
 	
 	//页面跳转
	function doJump( cmd ,totalpage){
		if(cmd == 'first'){	
			document.forms[0].nowpage.value='0'; 
		} 
		else if(cmd == 'pre'){	
			//alert(nowpage);
			if( nowpage <= 1  ){
				return false;
			}
			document.forms[0].nowpage.value= nowpage -1 ; 
			$("[name=jumpPage]").val(nowpage - 1);
		} 
		else if(cmd == 'next'){	
			if( nowpage >= totalpage ){
				return false;
			}
			document.forms[0].nowpage.value= nowpage +1; 
			$("[name=jumpPage]").val(nowpage + 1);
		} 
		else if(cmd == 'end'){	
			document.forms[0].nowpage.value= totalpage; 
		}
		else if(cmd == 'jump'){	
			var page = document.forms[0].jumpPage.value;
			if( !isInteger( page ) ){
				alert('请输入正确的数字!');
				return false;
			}
			else if( page > totalpage ){
				alert('超出上限!');
				return false;
			}
			else if( page < 1  ){
				alert('超出下限!请输入1以上(包含1)的数字');
				return false;
			}
			else{
				document.forms[0].nowpage.value=  page  ; 
			}
			
		}
		return true;
	} 
	
	
	function isInteger(obj) {
	  var reg = /[^0-9]/;
	  if (obj != "") {
	    if (obj.search(reg) < 0) return true
	  }
	  return false;
	}

	//设置排序方式
	function changeOrder( order , order_style ){
		
		document.forms[0].order.value= order;
		document.forms[0].order_style.value = order_style;
		doQuery();
	}
	
	
	function doDisableBackspace(){
		if( event.srcElement.tagName == "INPUT" || event.srcElement.tagName == "TEXTAREA"){
			if( !event.srcElement.readOnly ){
				return true; 
			}
			
		}
		if ( event.srcElement.tagName == "SELECT" ){
			return (event.keyCode!=8);
		}
		return (event.keyCode!=8);
	}
 </script>
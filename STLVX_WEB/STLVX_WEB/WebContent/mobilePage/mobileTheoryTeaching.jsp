<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta content="yes" name="apple-mobile-web-app-capable" />
<meta content="black" name="apple-mobile-web-app-status-bar-style" />
<meta content="telephone=no" name="format-detection" />
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0;" name="viewport" />
<link rel="stylesheet" type="text/css" href="/STLVX_WEB/mobilePage/css/touch.css" />
<title>理论教学</title>
<script type="text/javascript"
	src="/STLVX_WEB/mobilePage/js/jquery-1.8.2.js"></script>
<script type="text/javascript"
	src="/STLVX_WEB/mobilePage/js/zepto_min.js"></script>
<script type="text/javascript"
	src="/STLVX_WEB/mobilePage/js/touchslider.js"></script>
</head>
<body>
	<div class="top">
		<div class="fanhui">
			<a href="${pageContext.request.contextPath}/mobilePage/index.jsp">返回</a>
		</div>
		<h2 class="title">理论教学</h2>
	</div>
	<ul id="pagenavi1" class="newtitle">
		<li><span><a href="#" class="curnewbtn">知识导学</a></span></li>
		<li><span><a href="#">讲稿</a></span></li>
		<li><span><a href="#">教案</a></span></li>
	</ul>
	<div class="newbox" id="slider1">
		<ul class="bigbox">
			<!--知识导学-->
			<li class="li_list">
				<div id="zsdx"></div>
			</li>
			<!--讲稿-->
			<li class="li_list">
				<div id="jg"></div>
			</li>
			<!--教案-->
			<li class="li_list">
				<div id="ja"></div>
			</li>
		</ul>
	</div>
	<div class="newrow">
		<ul id="pagenavi2" class="newtitle">
			<li><span><a href="#" class="curnewbtn">课件</a></span></li>
			<li><span><a href="#">授课视频</a></span></li>
			<!-- <li><span><a href="#">习题</a></span></li> -->
		</ul>
		<div class="newbox" id="slider2">
			<ul class="bigbox">
				<!--课件-->
				<li class="li_list">
					<div id="kj"></div>
				</li>
				<!--授课视频-->
				<li class="li_list">
					<div id="sksp"></div>
				</li>
				<!--习题-->
				<!-- <li class="li_list">
					<div id="xt"></div>
				</li> -->
			</ul>
		</div>
	</div>
	<script type="text/javascript">
	for (n = 1; n < 4; n++) {
		var page = 'pagenavi' + n;
		var mslide = 'slider' + n;
		var as = document.getElementById(page).getElementsByTagName('a');
		var tt = new TouchSlider({
			id: mslide,
			'auto': '-1',
			fx: 'ease-out',
			direction: 'left',
			speed: 600,
			timeout: 5000,
			'before': function (index) {
				var as = document.getElementById(this.page).getElementsByTagName('a');
				as[this.p].className = '';
				as[index].className = 'curnewbtn';
				this.p = index;
				//as.style.display = "none";
				// as[this.p].style.display = "";
				//var txt = as[index].innerText;
				// $("#" + this.page).parent().find('.emtitle').text(txt);
				//var txturl = as[index].getAttribute('href');
				//var turl = txturl.split('#');
				//$("#" + this.page).parent().find('.go_btn').attr('href', turl[1]);
				$("#" + this.page).parent().find('.go_btn').hide();
				$("#" + this.page).parent().find('.go_btn').eq(index).show();
			}
		});
		tt.page = page;
		tt.p = 0;
		for (var i = 0; i < as.length; i++) {
			(function () {
				var j = i;
				as[j].tt = tt;
				as[j].onclick = function () {
					this.tt.slide(j);
					return false;
				}
			})();
		}
	}
</script>
	<div class="footer">
		<p>Copyright&copy;2016-2017 All Rights Reserved</p>
		<p>主办：沈阳农业大学</p>
	</div>
</body>
</html>
<script type="text/javascript">
function createAjaxObj() {
	var req;
	if (window.XMLHttpRequest) {
		req = new XMLHttpRequest();
	} else {
		req = new ActiveXObject("Msxml2.XMLHTTP"); 
	}
	return req;
}	

	var req = createAjaxObj();
	req.open("post", "<%=basePath%>Article.do?method=selectMobileTheoryTeaching");
	req.setRequestHeader("accept", "application/json");
	req.onreadystatechange = function() {
		if (req.readyState == 4 && req.status == 200) {
			//alert(req.responseText);
			eval("var result=" + req.responseText);
			$('#zsdx').empty();
			$('#jg').empty();
			$('#ja').empty();
			$('#kj').empty();
			$('#sksp').empty();
			$('#xt').empty();
			for(var i=0;i<result.length;i++){
				 if(result[i].iArticleKind==5){
			        $('#zsdx').append("<p> <a href='<%=basePath%>Article.do?method=selectMobileArtilceDetaile&articleid="+result[i].sArticleId+"'>"+result[i].sTitle+"</a></p>");	
				}
				 if(result[i].iArticleKind==6){ 
				    $('#jg').append("<p> <a href='<%=basePath%>Article.do?method=selectMobileArtilceDetaile&articleid="+result[i].sArticleId+"'>"+result[i].sTitle+"</a></p>");	
				}
				if(result[i].iArticleKind==7){ 
					$('#ja').append("<p> <a href='<%=basePath%>Article.do?method=selectMobileArtilceDetaile&articleid="+result[i].sArticleId+"'>"+result[i].sTitle+"</a></p>");	
				}
				if(result[i].iArticleKind==8){ 
					$('#kj').append("<p> <a href='<%=basePath%>Article.do?method=selectMobileVideo&articleid="+result[i].sArticleId+"'>"+result[i].sTitle+"</a></p>");	
			    } 
				if(result[i].iArticleKind==9){ 
					$('#sksp').append("<p> <a href='<%=basePath%>Article.do?method=selectMobileVideo&articleid="+result[i].sArticleId+"'>"+result[i].sTitle+"</a></p>");	
				} 
				<%-- if(result[i].iArticleKind==10){ 
					$('#xt').append("<p> <a href='<%=basePath%>Article.do?method=selectMobileArtilceDetile&articleid="+ result[i].sArticleId+ "'>"+ result[i].sTitle + "</a></p>");
				} --%>
			}
		}
	}
	req.send(null);
</script>
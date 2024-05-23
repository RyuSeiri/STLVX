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
<title>课程概况</title>
<script type="text/javascript"
	src="/STLVX_WEB/mobilePage/js/jquery-1.8.2.js"></script>
<script type="text/javascript"
	src="/STLVX_WEB/mobilePage/js/zepto_min.js"></script>
<script type="text/javascript"
	src="/STLVX_WEB/mobilePage/js/touchslider.js"></script>
<script type="text/javascript">
$(document).ready(function(){
$("#content1").hide();
$("#content2").hide();
$("#content3").hide();
$("#content4").hide();
});
</script>
</head>
<body>
	<div class="top">
		<div class="fanhui">
			<a href="${pageContext.request.contextPath}/mobilePage/index.jsp">首页</a>
		</div>
		<h2 class="title">课程概括</h2>
	</div>
	<div class="nav">
		<ul>
			<li id="kcjj" class="title">课程简介</li>
		</ul>
		<div class="contents" id="content1"></div>
		<ul>
			<li id="kcdg" class="title">课程大纲</li>
		</ul>
		<div class=contents id="content2"></div>
		<ul>
			<li id="jjrl" class="title">教学日历</li>
		</ul>
		<div id="content3"></div>
		<ul>
			<li id="ksxs" class="title">考试形式</li>
		</ul>
		<div id="content4"></div>
	</div>
<script type="text/javascript">
$("#kcjj").toggle(
	      function () {
	    	$("#content1").fadeIn("slow");
	      },
	      function () {
	    	$("#content1").fadeOut("slow");
	      });
 $("#kcdg").toggle(
	      function () {
	    	$("#content2").fadeIn("slow");
	      },
	      function () {
	    	$("#content2").fadeOut("slow");
	      });
$("#jjrl").toggle(
	      function () {
	    	$("#content3").fadeIn("slow");
	      },
	      function () {
	    	$("#content3").fadeOut("slow");
	      });
$("#ksxs").toggle(
	      function () {
	    	$("#content4").fadeIn("slow");
	      },
	      function () {
	    	$("#content4").fadeOut("slow");
	      }); 
</script>
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
	req.open("post", "<%=basePath%>Article.do?method=selectCourseOverview");
		req.setRequestHeader("accept", "application/json");
		req.onreadystatechange = function() {
			if (req.readyState == 4 && req.status == 200) {
				eval("var result=" + req.responseText);
				for (var i = 0; i < result.length; i++) {
					if (result[i].iArticleKind == 1) {
						$('#content1').html(result[i].sContent);
					}
					if (result[i].iArticleKind == 2) {
						$('#content2').html(result[i].sContent);
					}
					if (result[i].iArticleKind == 3) {
						$('#content3').html(result[i].sContent);
					}
					if (result[i].iArticleKind == 4) {
						$('#content4').html(result[i].sContent);
					}
				}
			}
		}
		req.send(null);
	</script>
	<div class="footer">
		<p>Copyright&copy;2016-2017 All Rights Reserved</p>
		<p>主办：沈阳农业大学</p>
	</div>
  </body>
</html>
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
<title>${articleTitile==null?'文章详情':articleTitile}</title>
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
			<a href="${pageContext.request.contextPath}/mobilePage/index.jsp">首页</a>
		</div>
		<h2 class="title">${result[0].sTitle==null?'文章详情':result[0].sTitle}</h2>
	</div>
	<div class="contents"> ${result[0].sContent} </div>
	<div class="nav">
		<ul>
			<li><a href="#" onclick="javascript :history.go(-2);" class="title">返回上一页</a></li>
		</ul>
	</div>
	<div class="footer">
		<p>Copyright&copy;2016-2017 All Rights Reserved</p>
		<p>主办：沈阳农业大学</p>
	</div>
</body>
</html>
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
<title>视频详情页</title>
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
		<h2 class="title">视频详情</h2>
	</div>
	<div class="newboxdd">
		<p>
			<strong>${title}</strong>
		</p>
			<div class="video">
			<%
               String  filepath = (String) request.getAttribute("filepath");
                String exname= filepath.substring(filepath.indexOf(".")+1);
                if("mp4".equals(exname)||"avi".equals(exname)){
                request.setAttribute("path", filepath);
                %>
					<video controls="controls">
						<source src="${path}">
						<element>您的浏览器不支持视频标签。( Your browser does support the videotag.)</element>
					</video>
					<% } else {%>
					<img src="${filepath}" />
			  <%}%>
			</div>
	</div>
	<div class="contents">${content}</div>
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
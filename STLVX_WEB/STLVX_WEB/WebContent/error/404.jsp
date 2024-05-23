<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true"%>
<% 
String path = request.getContextPath(); 
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/"; 
%>

<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head >
<title>404 - Not found</title>
<link rel="stylesheet" type="text/css" href="/STLVX_WEB/error/css/error.css" />
<link href="/STLVX_WEB/css/about.css" rel="stylesheet" type="text/css">
<link href="/STLVX_WEB/css/main.css" rel="stylesheet" type="text/css" />
<link href="/STLVX_WEB/css/scroll.css" rel="stylesheet" type="text/css" />
<script src="/STLVX_WEB/js/jquery-1.8.2.js" type="text/javascript"></script>
<script src="/STLVX_WEB/js/jquery.sudoSlider.min.js"></script>
<script type="text/javascript" src="/STLVX_WEB/js/bar.js"></script>
<script type="text/javascript" src="/STLVX_WEB/js/PopUp.js"></script>
<script type="text/javascript" src="/STLVX_WEB/js/mobileCheck.js"></script>
<script type="text/javascript">
	function init() {
		if (window.mobilecheck()) {
			$("#mobile").show();
		} else {
			$("#computer").show();
		}
	}
</script>
</head>
<body onload="init()">
	<!--电脑版网页  -->
	<div id="computer"
		style="background: url(/STLVX_WEB/images/bg_sea.jpg) no-repeat center top; display: none;">
		<header class="yc_header">
			<div class="index_banner" id="banner_tabs">
			</div>
		</header>
		<div>
			<div>
				<h1 class="font">404</h1>
			</div>
			<div class="norsTitle">很抱歉，您要访问的页面不存在！</div>
			<br> <font size="5"><a href="${userName!=null?'/STLVX_WEB/Admin/index.jsp':'/STLVX_WEB/jsp/index.jsp'}">点击此处返回首页</a></font><br/><br/>
		</div>
		<div>
	   <footer class="yc_footer">
			<div class="yc_flinks">
				<a href="${userName!=null?'/STLVX_WEB/Admin/AboutUS.jsp':'/STLVX_WEB/jsp/AboutUS.jsp'}">关于本站</a>|
				<a href="${userName!=null?'/STLVX_WEB/Admin/UsingHelp.jsp':'/STLVX_WEB/jsp/UsingHelp.jsp'}">使用帮助</a> | <a
					href="javascript:popup('<div>联系电话：13022479530</div>')">联系我们</a> | <a
					href="javascript:void(0);"
					onclick="javascript:popup('<p>欢迎您访问并使用生态旅游网教学网站!我们以本隐私申明声明对访问者隐私保护的许诺。'
				+'在未经您同意之下，我们绝不会将您的个人数据提供予任何与本网站服务无关的第三人。如您访问本网站，那么您便接受了本隐私声明。'
				+'以下文字公开我站对信息收集和使用的情况。本站的隐私申明会不断改进，随着我站服务的增加，我们会随时更新我们的隐私申明。'
				+'欢迎您随时查看本申明，并可向客服反馈您的意见。</p>')">网站声明</a>
				| <a href="javascript:void(0);"
					onclick="SetHome(this,window.location);">设为首页</a>| <a
					href="javascript:void(0);"
					onclick="AddFavorite(document.title,location.href)">收藏本站</a>
			</div>
			<div class="yc_copyright">
				Copyright&copy;2016-2017 All Rights Reserved<br> 主办：沈阳农业大学<br>
			</div>
		</footer>
		</div>
	</div>
	<!--popup用的div-->
	<div id="dialog-overlay"></div>
	<div id="dialog-box">
		<div class="dialog-content">
			<div id="dialog-message"></div>
			<a href="javascript:void(0);" class="button">关闭</a>
		</div>
	</div>
	<!--手机版网页  -->
	<div id="mobile" style="display: none;">
		<div class="top">
			<br /> <br /> <br /> <br /> <br />
			<h1 class="mobilefont">404</h1>
		</div>
		<div>
			<br /> <br /> <br /> <br /> <br />
			<p class="mobileNorsTitle">很抱歉，您要访问的页面不存在！</p>
			<br /> <br /> <br /> <font size="5">
			 <a href='/STLVX_WEB/mobilePage/index.jsp'>点击此处返回首页</a></font> <br /> <br /> <br />
		</div>
		<div class="footer" style="text-align: center;">
			<p>Copyright&copy;2016-2017 All Rights Reserved</p>
			<p>主办：沈阳农业大学</p>
		</div>
	</div>
</body>
</html>
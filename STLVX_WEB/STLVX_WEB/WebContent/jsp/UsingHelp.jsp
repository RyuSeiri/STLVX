<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
String path = request.getContextPath(); 
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/"; 
%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>使用帮助</title>
<link href="/STLVX_WEB/css/about.css" rel="stylesheet" type="text/css">
<link href="/STLVX_WEB/css/main.css" rel="stylesheet" type="text/css" />
<link href="/STLVX_WEB/css/scroll.css" rel="stylesheet" type="text/css" />
<script src="/STLVX_WEB/js/jquery-1.8.2.js" type="text/javascript"></script>
<script src="/STLVX_WEB/js/jquery.sudoSlider.min.js"></script>
<script type="text/javascript" src="/STLVX_WEB/js/bar.js"></script>
<script type="text/javascript" src="/STLVX_WEB/js/PopUp.js"></script>
</head>
<body style="background:url(/STLVX_WEB/images/bg_sea.jpg) no-repeat center top" onload="index_show()">
	<!-- <div class="yc_bg_flash flash-replaced" id="bgFlash" > -->
	<header class="yc_header">
		<script type="text/javascript" src="/STLVX_WEB/js/jcarousellite_index.js"></script>
	    <div class="index_banner" id="banner_tabs">
			<img class="shoolLog" src="/STLVX_WEB/images/schoolLog.png">
		</div>
    </header>
 	<div class="navbg"> 
		<div class="nave">
			<h3><a href="${userName!=null?'/STLVX_WEB/Admin/index.jsp':'/STLVX_WEB/jsp/index.jsp'}">首页</a>|<a href="AboutUS.jsp" >关于本站</a>|<a href="UsingHelp.jsp" class="fcous">使用帮助</a>|</h3>
		</div>
    </div>
	<div style="width:1000px;position: relative; margin: 47px auto 0px; box-shadow: 1px 1px 7px #999;">
		<div class="help_tx" style="margin: 24px 0 0 0">
			<h4>使用帮助：</h4>
		</div><br><br>
		<div style="margin: 65px 0 0 10px">
			<p>
				<span style="font-size: 16px;">有关文章添加的说明：</span>
			</p>
			<p>
				<span style="font-size: 16px;"><img
					src="/STLVX_WEB/images/help/20170419191824_732.png" width="800"
					height="300" alt="使用帮助的图片" /><br /> </span>
			</p>
			<p>
				<span style="font-size: 16px;">&nbsp;
					在上传图片右侧的按钮为批量上传点击此按钮可实现批量上传（ps：切记该批量上传功能只能用于文章的内容中的图片上传在进行首页上传图片的时候批量上传每次也只能上传一张图片），还有上传首页图片的时候最好首页图片的大小为【460
					X 270】，这样看起来图片就不会被压缩了。</span>
			</p>
			<p>
				<span style="font-size: 16px;">&nbsp; 再上传视频的时候需要点击下面的图片中的按钮</span>
			</p>
			<p>
				<span style="font-size: 16px;"><img
					src="/STLVX_WEB/images/help/20170419192829_350.png" alt="使用帮助的图片" /><br />
				</span>
			</p>
			<p>
				<span style="font-size: 16px;"><br /> </span>
			</p>
			<p>
				<span style="font-size: 16px;">点击之后会出现下面的对话框然后点击上传按钮进行上传视频，如果想上传之前上传过的视频请点击[文件空间]按钮进行选择视频高度默认就可以了</span>
			</p>
			<p>
				<span style="font-size: 16px;"><img
					src="/STLVX_WEB/images/help/20170419192933_797.png" alt="使用帮助的图片" /></span>
			</p>
			<p>
				<span style="font-size: 16px;">上传完之后看下图：</span>
			</p>
			<p>
				<span style="font-size: 16px;"><img
					src="/STLVX_WEB/images/help/20170419193649_854.png" alt="使用帮助的图片" /><br />
				</span>
			</p>
			<p>
				<span style="font-size: 16px;">此时点击完提交或确定按钮之后就会提示添加成功的字样这回点击返回到文章的一览就会发现该文章已经添加成功请看下图：</span>
			</p>
			<p>
				<span style="font-size: 16px;"><img
					src="/STLVX_WEB/images/help/20170419194540_987.png" alt="使用帮助的图片" /><br />
				</span>
			</p>
			<p>
				<span style="font-size: 16px;"><br /> </span>
			</p>
		</div>
		<!--yc_content_inner-->
		<div class="yc_shadow_bot boxImg">
			<img src="" width="1000" height="0">
		</div>
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
	<div id="dialog-overlay"></div>
	<div id="dialog-box">
		<div class="dialog-content">
			<div id="dialog-message"></div>
			<a href="javascript:void(0);" class="button">关闭</a>
		</div>
	</div>
</body>
</html>
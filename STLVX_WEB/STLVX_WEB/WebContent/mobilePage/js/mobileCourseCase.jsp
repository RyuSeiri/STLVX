<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta content="yes" name="apple-mobile-web-app-capable" />
<meta content="black" name="apple-mobile-web-app-status-bar-style" />
<meta content="telephone=no" name="format-detection" />
<meta content="width=device-width,height=device-height, initial-scale=1.0, maximum-scale=1.0, user-scalable=0;" name="viewport" />
<link rel="stylesheet" type="text/css" href="css/touch.css" />
<title>课程案例</title> 
<script type="text/javascript" src="/STLVX_WEB/mobilePage/js/jquery-1.8.2.js"></script>
<script type="text/javascript" src="/STLVX_WEB/mobilePage/js/zepto_min.js"></script>
<script type="text/javascript" src="/STLVX_WEB/mobilePage/js/touchslider.js"></script>
</head>
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
	req.open("post", "<%=basePath%>Article.do?method=selectCourseCase&kind=14");
	req.setRequestHeader("accept", "application/json");
	req.onreadystatechange = function() {
		if (req.readyState == 4 && req.status == 200) {
			//alert(req.responseText)
			$('#CaseContent').empty();
			eval("var result=" + req.responseText);
		  for(var i=0;i<result.length;i++){
			 var contents="<ul><li><strong><a href='<%=basePath%>"
	                    +"Article.do?method=selectMobileCourseCaseDetail&articleid="
						+ result[i].sArticleId + "'>";
				contents += result[i].sTitle + "</a></strong></li></ul>";
				$('#CaseContent').append(contents);
			}
		}
	}
	req.send(null);
</script>
<body>
	<div class="top">
		<div class="fanhui">
			<a href="index.jsp">返回</a>
		</div>
		<h2 class="title">课程案例</h2>

	</div>
	<div class="list" id="CaseContent">
	    <ul>
			<!-- <li><strong><a href="#">课程案例 </a></strong>
			</li> -->
		</ul>
	</div>
	<div class="footer">
		<p>Copyright&copy;2016-2017 All Rights Reserved</p>
		<p>主办：沈阳农业大学</p>
	</div>
</body>
</html>
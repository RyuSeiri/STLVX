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
<title>拓展学习</title> 
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
	req.open("post", "<%=basePath%>Article.do?method=selectMobileCourseCase&kind=18");
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
			<a href="${pageContext.request.contextPath}/mobilePage/index.jsp">首页</a>
		</div>
		<h2 class="title">拓展学习</h2>

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
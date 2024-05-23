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
<title>环境教育</title>
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
		<h2 class="title">环境教育</h2>
	</div>
	<div class="list">
		<p>
			<strong>环境教育大纲</strong><span>Cinematography and Film/Video Production</span>
		</p>
		<p>简介：</p>
		<div class="jianjie">
				<div id="stjydg"><!-- 生态教育 --></div>
		</div>
	</div>
	<div class="newtitle">
		<ul id="pagenavi1">
			<li><span><a href="#">环境教育效果</a></span></li>
		</ul>
	</div>
	<div class="newbox">
		<ul class="bigbox" id="slider1">
			<li class="li_list" id="ewsj"><!-- 列表 --></li>
			<li class="li_list" style-="margin-right:5px;">
				<div class="pic_list" style="height: auto;">
					<p
						style="line-height: 30px; font-size: 16px; text-align: left; display: block; height: auto; overflow: auto; background: none;"></p>
				</div>
			</li>
		</ul>
	</div>
	<script type="text/javascript">
	for (n = 1; n <= 1; n++) {
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
				//var txt = as[index].innerText;
				//$("#" + this.page).parent().find('.emtitle').text(txt);
				//var txturl = as[index].getAttribute('href');
				// var turl = txturl.split('#');
				//$("#" + this.page).parent().find('.go_btn').attr('href', turl[1]);
				// $("#" + this.page).parent().find('.go_btn').hide();
				// $("#" + this.page).parent().find('.go_btn').eq(index).show();
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
	req.open("post", "<%=basePath%>Article.do?method=selectEducation");
	req.setRequestHeader("accept", "application/json");
	req.onreadystatechange = function() {
		if (req.readyState == 4 && req.status == 200) {
			//alert(req.responseText);
			eval("var result=" + req.responseText);
			$('#stjydg').html('');
			$('#ewsj').html('');
			for(var i=0;i<result.length;i++){
	            if (result[i].iArticleKind == 15) {
					$('#stjydg').html(result[i].sContent);
				}
				if (result[i].iArticleKind == 16) {
					$('#ewsj').append("<p><a href='<%=basePath%>Article.do?method=selectMobileVideo&articleid="+ result[i].sArticleId + "'>"+ result[i].sTitle + "</a></p>");
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

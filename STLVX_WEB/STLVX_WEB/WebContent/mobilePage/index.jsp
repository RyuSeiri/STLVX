<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta content="yes" name="apple-mobile-web-app-capable" />
<meta content="black" name="apple-mobile-web-app-status-bar-style" />
<meta content="telephone=no" name="format-detection" />
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0;" name="viewport" />
<link rel="stylesheet" type="text/css" href="/STLVX_WEB/mobilePage/css/touch.css" />
<title>首页</title>
<script type="text/javascript"
	src="/STLVX_WEB/mobilePage/js/jquery-1.8.2.js"></script>
<script type="text/javascript"
	src="/STLVX_WEB/mobilePage/js/zepto_min.js"></script>
<script type="text/javascript"
	src="/STLVX_WEB/mobilePage/js/touchslider.js"></script>
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
function index_show() {
	selectMobileCourseCase();
	selectMobileTheoryTeaching();
	selectMobileExtensionTeaching();
	selectMobilePicture();
}
</script>
<script type="text/javascript">
function selectMobileCourseCase(){
	var req = createAjaxObj();
	req.open("post", "<%=basePath%>Article.do?method=selectMobileCourseCase&kind=14&time="+new Date());
	req.setRequestHeader("accept", "application/json");
	req.onreadystatechange = function() {
		if (req.readyState == 4 && req.status == 200) {
		  //alert(req.responseText);
		  $('#kcal').empty();
		  eval("var result=" + req.responseText);
		  for(var i=0;i<result.length;i++){
			  $('#kcal').append("<p><a href='<%=basePath%>Article.do?method=selectMobileCourseCaseDetail&articleid="+result[i].sArticleId+"'>"+result[i].sTitle+"</a></p>");
			 }
		}
	}
	req.send(null);
}
</script>
<script type="text/javascript">
function selectMobileTheoryTeaching(){
	var req = createAjaxObj();
	req.open("post", "<%=basePath%>Article.do?method=selectMobileTheoryTeaching&time="+new Date());
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
			for(var i=0;i<result.length;i++){
				 if(result[i].iArticleKind==5){
			        $('#zsdx').append("<p><a href='<%=basePath%>Article.do?method=selectMobileArtilceDetaile&articleid="+result[i].sArticleId+"'>"+result[i].sTitle+"</a></p>");	
				}
				 if(result[i].iArticleKind==6){ 
				    $('#jg').append("<p><a href='<%=basePath%>Article.do?method=selectMobileArtilceDetaile&articleid="+result[i].sArticleId+"'>"+result[i].sTitle+"</a></p>");	
				}
				if(result[i].iArticleKind==7){ 
					$('#ja').append("<p><a href='<%=basePath%>Article.do?method=selectMobileArtilceDetaile&articleid="+result[i].sArticleId+"'>"+result[i].sTitle+"</a></p>");	
				}
				if(result[i].iArticleKind==8){ 
					$('#kj').append("<p><a href='<%=basePath%>Article.do?method=selectMobileVideo&articleid="+result[i].sArticleId+"'>"+result[i].sTitle+"</a></p>");	
			    } 
				if(result[i].iArticleKind==9){ 
					$('#sksp').append("<p><a href='<%=basePath%>Article.do?method=selectMobileVideo&articleid="+result[i].sArticleId+"'>"+result[i].sTitle+"</a></p>");	
				} 
			}
		}
	}
	req.send(null);
}
</script>
<script type="text/javascript">
function selectMobileExtensionTeaching(){
	var req = createAjaxObj();
	req.open("post", "<%=basePath%>Article.do?method=selectMobileCourseCase&kind=18&time="+new Date());
	req.setRequestHeader("accept", "application/json");
	req.onreadystatechange = function() {
		if (req.readyState == 4 && req.status == 200) {
		  //alert(req.responseText);
		  $('#tzxx').empty();
		  eval("var result=" + req.responseText);
		  for(var i=0;i<result.length;i++){
			  $('#tzxx').append("<p><a href='<%=basePath%>Article.do?method=selectMobileCourseCaseDetail&articleid="+result[i].sArticleId+"'>"+result[i].sTitle+"</a></p>");
			 }
		}
	}
	req.send(null);
}
</script>
<script type="text/javascript">
function selectMobilePicture(){
	var req = createAjaxObj();
	req.open("post", "<%=basePath%>Article.do?method=selectAllMobilePicture&time="+new Date());
	req.setRequestHeader("accept", "application/json");
	req.onreadystatechange = function() {
		if (req.readyState == 4 && req.status == 200) {
		  //alert(req.responseText);
		  $('#tpk').empty();
		  eval("var result=" + req.responseText);
		  for(var i=0;i<result.length;i++){
			  var contents="<div class='pic_list'>"
				  contents +="<a href='<%=basePath%>Article.do?method=selectMobilePictureById&Id="+result[i].sArticleId+"'><img src='"+result[i].filepath+"' width='111' height='83'></a><span>"
				  if(result[i].sContent.length>25){
					     contents+="<strong><a href='<%=basePath%>Article.do?method=selectMobilePictureById&Id="+result[i].sArticleId+"'>"+result[i].sTitle+"</a></strong>"+result[i].sContent.substring(0,25)+"......</span></div>";
					}else{
						 contents+="<strong><a href='<%=basePath%>Article.do?method=selectMobilePictureById&Id="+result[i].sArticleId+"'>"+result[i].sTitle+"</a></strong>"+result[i].sContent+"</span></div>";
					}
			      $('#tpk').append(contents);
			}
		}
	}
	req.send(null);
}
</script>
</head>
<body onload="index_show()">
	<div class="top">
	<div class="logo"><img src="images/logo.png" width="130" height="44"/></div>
		<h2 class="title">生态旅游学</h2>
	</div>
	<div class="menu">
		<ul>
			<li><span><a
					href="${pageContext.request.contextPath}/mobilePage/mobileCourseOverView.jsp"><img
						src="images/daxueso.png" width="30" height="30" /><br /> 课程概况</a></span></li>
			<li><span><a
					href="${pageContext.request.contextPath}/mobilePage/mobileTheoryTeaching.jsp"><img
						src="images/rank.png" width="30" height="30" /><br /> 理论教学</a></span></li>
			<li><span><a
					href="${pageContext.request.contextPath}/mobilePage/mobileCourseCase.jsp"><img
						src="images/major.png" width="30" height="30" /><br /> 课程案例</a></span></li>
			<li><span><a
					href="${pageContext.request.contextPath}/mobilePage/mobileEducation.jsp"><img
						src="images/free.png" width="30" height="30" /><br /> 生态旅游环境教育</a></span></li>
			<li><span><a
					href="${pageContext.request.contextPath}/mobilePage/mobileEcoloProductDe.jsp"><img
						src="images/guwen.png" width="30" height="30" /><br /> 生态旅游产品设计</a></span></li>
			<li><span><a
					href="${pageContext.request.contextPath}/mobilePage/mobileExtensionTeaching.jsp"><img
						src="images/news.png" width="30" height="30" /><br /> 扩展学习</a></span></li>
		</ul>
	</div>
	<div class="newrow">
		<ul id="pagenavi1" class="newtitle">
			<li><span><a href="#" class="curnewbtn">知识导学</a></span></li>
			<li><span><a href="#">教案</a></span></li>
			<li><span><a href="#">课程案例</a></span></li>
		</ul>
		<div class="newbox" id="slider1">
			<ul class="bigbox">
				<!-- 知识导学 -->
				<li class="li_list">
					<div id="zsdx"></div>
				</li>
				<!--  教案 -->
				<li class="li_list">
					<div id="ja"></div>
				</li>
				<!-- 课程案例 -->
				<li class="li_list">
					<div id="kcal"></div>
				</li>
			</ul>
		</div>
	</div>
	<div class="newrow">
		<ul id="pagenavi2" class="newtitle">
			<li><span><a href="#" class="curnewbtn">拓展学习</a></span></li>
			<li><span><a href="#">图片库</a></span></li>
		</ul>
		<div class="newbox" id="slider2">
			<ul class="bigbox">
				<!-- 拓展学习-->
				<li class="li_list">
					<div id="tzxx"></div>
				</li>
				<!-- 图片库 -->
				<li class="li_list">
					<span id="tpk"></span>
				</li>
			</ul>
		</div>
	</div>
<script type="text/javascript">
	for (n = 1; n <= 5; n++) {
		var page = 'pagenavi' + n;
		var mslide = 'slider' + n;
		var as = document.getElementById(page).getElementsByTagName('a');
		var tt = new TouchSlider({
			id: mslide,
			'auto': '-1',
			fx: 'ease-out',
			speed: 500,
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
	<div class="footer">
		<p>Copyright&copy;2016-2017 All Rights Reserved</p>
		<p>主办：沈阳农业大学</p>
	</div>
</body>
</html>

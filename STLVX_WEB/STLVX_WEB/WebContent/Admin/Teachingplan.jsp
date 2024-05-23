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
<title>教案</title>
<link href="/STLVX_WEB/css/main.css" rel="stylesheet" type="text/css" />
<link href="/STLVX_WEB/css/scroll.css" rel="stylesheet" type="text/css" />
<script src="/STLVX_WEB/js/jquery-1.8.2.js" type="text/javascript"></script>
<script src="/STLVX_WEB/js/jquery.sudoSlider.min.js"></script>
<script type="text/javascript" src="/STLVX_WEB/js/bar.js"></script>
<script type="text/javascript" src="/STLVX_WEB/js/PopUp.js"></script>
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
$(document).ready(function(){
	var req = createAjaxObj();
	req.open("post", "<%=basePath%>Article.do?method=selectActicleChapter");
	req.setRequestHeader("accept", "application/json");
	req.onreadystatechange = function() {
		if (req.readyState == 4 && req.status == 200) {
		  //alert(req.responseText);
			eval("var results=" + req.responseText);
			$("#chapter").html('');
			for(var i=0;i<results.length;i++){
			   var contents=" <li onclick='selectChapterArticle("+results[i].chapterid+")'>"+results[i].chapterinfo+"</li>"
				$("#chapter").append(contents);
			} 
		}
	}
	req.send(null);
});
</script>
<script type="text/javascript">
var req = createAjaxObj();
req.open("post", "<%=basePath%>Article.do?method=selectTheoryArticleBy&kind=7&ChapterId=1");
req.setRequestHeader("accept", "application/json");
req.onreadystatechange = function() {
	if (req.readyState == 4 && req.status == 200) {
	  //alert(req.responseText);
		eval("var result=" + req.responseText);
		for(var i=0;i<result.length;i++){
			var contents =  "<p align='center' style='text-align: center'><b>";
			contents = contents +result[i].sTitle+"</b></p>";
			contents = contents + "<span class='p0'>"+result[i].sContent+"</span>";
			$('#zoom').html(contents);
			$('#time').html("时间:"+result[i].dMakeTime);
		}
		 $("#local").html("当前位置：<a href='#'>首页</a> &gt; <a href='#'>教案</a> &gt; <a href='#'>第1章</a>");
	}
}
req.send(null);
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
function selectChapterArticle(chapter){
	$("#zoom").empty();
	$('#time').empty();
	var req = createAjaxObj();
	req.open("post", "<%=basePath%>Article.do?method=selectTheoryArticleBy&kind=7&ChapterId="+chapter);
	req.setRequestHeader("accept", "application/json");
	req.onreadystatechange = function() {
		if (req.readyState == 4 && req.status == 200) {
		  //alert(req.responseText);
			eval("var result=" + req.responseText);
			for(var i=0;i<result.length;i++){
				var contents =  "<p align='center' style='text-align: center'><b>";
				contents = contents +result[i].sTitle+"</b></p>";
				contents = contents + "<span class='p0'>"+result[i].sContent+"</span>";
				$('#zoom').html(contents);
			    $('#time').html("时间:"+result[i].dMakeTime);
			}
			 $("#local").html("当前位置：<a href='#'>首页</a> &gt; <a href='#'>教案</a> &gt; <a href='#'>第"+chapter+"章</a>");
		}
	}
	req.send(null);
}
</script>
<body style="background: url(../images/bg_sea.jpg) no-repeat center top">
	<!-- <div class="yc_bg_flash flash-replaced" id="bgFlash" > -->
	<header class="yc_header">
		<script type="text/javascript" src="../js/jcarousellite_index.js"></script>
		<div class="index_banner" id="banner_tabs">
			<img class="shoolLog" src="/STLVX_WEB/images/schoolLog.png">
		</div>
	</header>
	<div class="navbg">
		<div class="col960">
			<ul id="navul" class="cl">
				<li class="navhome"><a href="${pageContext.request.contextPath}/Admin/index.jsp">首页</a></li>
				<li>
					<a href="${pageContext.request.contextPath}/Admin/CourseOverView.jsp">课程概况</a>
					<ul>
					    <li><a href="${pageContext.request.contextPath}/Admin/Courseintroduction.jsp">课程简介</a></li>
						<li><a href="${pageContext.request.contextPath}/Admin/Syllabus.jsp">课程大纲</a></li>
						<li><a href="${pageContext.request.contextPath}/Admin/TeachingCalendar.jsp">教学日历</a></li>
						<li><a href="${pageContext.request.contextPath}/Admin/TestType.jsp">考试形式</a></li>
					</ul>
				</li>
				<li>
					<a href="${pageContext.request.contextPath}/Admin/TheoryTeaching.jsp">理论教学</a>
					<ul>
						<li><a href="${pageContext.request.contextPath}/Admin/KnowledgeGuidance.jsp">知识导学</a></li>
						<li><a href="${pageContext.request.contextPath}/Admin/Notes.jsp">讲稿</a></li>
						<li><a href="${pageContext.request.contextPath}/Admin/Teachingplan.jsp">教案</a></li>
						<li><a href="${pageContext.request.contextPath}/Admin/CourseWare.jsp">课件</a></li>
						<li><a href="${pageContext.request.contextPath}/Admin/videoOverView.jsp">授课视频</a></li>
						<li><a href="${pageContext.request.contextPath}/Admin/exercises.jsp">习题</a></li>
					</ul>
				</li>
				<li>
					<a href="${pageContext.request.contextPath}/Admin/EcoloProductDe.jsp">生态产品设计</a>
					<ul>
						<li><a href="${pageContext.request.contextPath}/Admin/ProduRequirements.jsp">产品设计要求</a></li>
						<li><a href="${pageContext.request.contextPath}/Admin/ProddesProcess.jsp">产品设计过程</a></li>
						<li><a href="${pageContext.request.contextPath}/Admin/ProddesResult.jsp">产品设计结果</a></li>
					</ul>
				</li>
				<li>
					<a href="${pageContext.request.contextPath}/Admin/CourseCase.jsp">课程案例</a>
				</li>
				<li>
					<a href="${pageContext.request.contextPath}/Admin/education.jsp">环境教育</a>
					<ul>
						<li><a href="${pageContext.request.contextPath}/Admin/Environmentaleducationprogram.jsp">环境教育大纲</a></li>
						<li><a href="${pageContext.request.contextPath}/Admin/EnvironmentaleducationEffect.jsp">环境教育效果</a></li>
					</ul>
				</li>
				<li>
					<a href="${pageContext.request.contextPath}/Admin/PictureLibrary.jsp">图片库</a>
				</li>
				<li>
					<a href="${pageContext.request.contextPath}/Admin/OnlineTest.jsp">在线测试</a>
				</li>
				<li>
					<a href="${pageContext.request.contextPath}/Admin/extensionTeaching.jsp">扩展学习</a>
					<%-- <ul>
						<li><a href="${pageContext.request.contextPath}/Admin/">外国国家公园系列</a></li>
						<li><a href="${pageContext.request.contextPath}/Admin/">中国国家森林公园</a></li>
					</ul> --%>
				</li>
				<li>
					<a href="${pageContext.request.contextPath}/Admin/Question.jsp">互动教学</a>
				</li>
			</ul>
		</div>
	</div>
	<script type="text/javascript"> 
$(document).ready(function(){
	$("#zoom").empty();
	$("#navul > li").not(".navhome").hover(function(){
		$(this).addClass("navmoon");
	},function(){
		$(this).removeClass("navmoon");
	});
});
</script>
	<div
		style="width: 1000px; position: relative; margin: 47px auto 0px; box-shadow: 1px 1px 7px #999;">
		<div class="yc_content_inner">
			<div id="local" class="yc_location">
				当前位置：<a href="${pageContext.request.contextPath}/Admin/index.jsp">首页</a>
				&gt; <a href="#">教案</a> &gt; <a href="#" id="cp">第1章</a>
			</div>
			<aside class="yc_left_box fl">
				<div class="yc_left_title">教案</div>
				<div class="yc_left_list">
					<ul id="chapter">
		<!--<li onclick="selectChapterArticle(1)">第一章</li>
            <li onclick="selectChapterArticle(2)">第二章</li>
            <li onclick="selectChapterArticle(3)">第三章</li>  -->
					</ul>
				</div>
				<div class="<!-- boxImg -->">
					<img src="../images/img_left_shadow_bot.png" alt="" width="206"
						height="180">
				</div>
			</aside>
			<div class="yc_right_box fl"></div>
			<div class="yc_right_comlist">
				<div id="cpsjyq" class="yc_content_inner" style="width: 700px;">
					<section class="showCon"
						style="width: 700px; margin: 15px auto; overflow: hidden; margin-top: 50px;">
						<h1>教案</h1>
						<h3>
							<span id="time">时间:</span>&nbsp;
							<!-- &nbsp;来源：XXX  -->
							&nbsp;&nbsp;<font color="#ff0000">字体显示：</font> &nbsp;<span
								id="big" style="cursor: pointer">大</span> &nbsp;<span
								id="middle" style="cursor: pointer">中</span> &nbsp;<span
								id="small" style="cursor: pointer">小 </span>
							<%-- &nbsp;&nbsp;阅读：${viewtimes} 次--%>
						</h3>
						<article id="zoom">

							<p align="center" style="text-align: center">
								<b style="font-size: 30px" style="font-weight:bold"></b>
							</p>

							<p class="p0"></p>

						</article>

						<script type="text/javascript" charset="utf-8" async defer>
                $("#big").click(function() {
                    $(".p0").css("font-size","large");
                });
                $("#middle").click(function() {
                    $(".p0").css("font-size","medium");
                });
                $("#small").click(function() {
                    $(".p0").css("font-size","small");
                });
            </script>

					</section>
				</div>
				<!--yc_content_inner-->
				<ul id="cpsjgc" style="display: none;">
					<li><span>2016-7-22</span><a target="_blank"
						href="/showxxgk.aspx?Id=114523&amp;ctlgid=264622">设计过程</a></li>
				</ul>
				<ul id="cpsjjg" style="display: none">
					<li><span>2016-7-22</span><a target="_blank"
						href="/showxxgk.aspx?Id=114523&amp;ctlgid=264622">设计结果</a></li>
				</ul>
			</div>
		</div>
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
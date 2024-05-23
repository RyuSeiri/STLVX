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
<title>课件</title>
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
</script>
<script type="text/javascript">
$(document).ready(function(){
	var req = createAjaxObj();
	req.open("post", "<%=basePath%>Article.do?method=selectActicleChapter");
	req.setRequestHeader("accept", "application/json");
	req.onreadystatechange = function() {
		if (req.readyState == 4 && req.status == 200) {
		  //alert(req.responseText);
			eval("var results=" + req.responseText);
			$("#chapter").empty();
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
req.open("post", "<%=basePath%>Article.do?method=selectArticleBykindAndChapterId&kind=8&ChapterId=1");
req.setRequestHeader("accept", "application/json");
req.onreadystatechange = function() {
	if (req.readyState == 4 && req.status == 200) {
	  //alert(req.responseText);
		eval("var result=" + req.responseText);
		$('#leftContents').empty();
		$('#rightContents').empty();
		for(var i=0;i<6;i++){
			var contents="<li style='list-style:none;border-bottom-style: none;'><div class='withpic'>";
			if(null!=result[i].filepath&&result[i].filepath.length>0){
				contents=contents+"<div class='pic'><a href='<%=basePath%>Article.do?method=selectvideoByid&articleid="+result[i].sArticleId+"'><img src='"+result[i].filepath+"'></a></div>";
			}else{
				contents=contents+"<div class='pic'><a href='<%=basePath%>Article.do?method=selectvideoByid&articleid="+result[i].sArticleId+"'><img src='/STLVX_WEB/images/pictureNotFound.jpg'></a></div>";
			}
			contents=contents+"<div class='text'>";
			contents=contents+"<h3 style='margin-top:1px;'><a href='<%=basePath%>Article.do?method=selectvideoByid&articleid="+result[i].sArticleId+"'>"+result[i].sTitle+"</a></h3>";
			if(result[i].sContent.length>40){
				contents=contents+"<p style='margin-top:-10px;'>"+result[i].sContent.substring(0,40)+"......</p>";
			}else{
				contents=contents+"<p style='margin-top:-10px;'>"+result[i].sContent+"</p>";
			}
			contents=contents+"</div>";
			contents=contents+"</div></li>";
		    $("#leftContents").append(contents);
		}
		for(var i=6;i<result.length;i++){
			var contents="<li style='list-style:none;border-bottom-style: none;'><div class='withpic'>";
			if(null!=result[i].filepath&&result[i].filepath.length>0){
				contents=contents+"<div class='pic'><a href='<%=basePath%>Article.do?method=selectvideoByid&articleid="+result[i].sArticleId+"'><img src='"+result[i].filepath+"'></a></div>";
			}else{
				contents=contents+"<div class='pic'><a href='<%=basePath%>Article.do?method=selectvideoByid&articleid="+result[i].sArticleId+"'><img src='/STLVX_WEB/images/pictureNotFound.jpg'></a></div>";
			}
			contents=contents+"<div class='text'>";
			contents=contents+"<h3 style='margin-top:1px;'><a target='_blank' href='<%=basePath%>Article.do?method=selectvideoByid&articleid="+result[i].sArticleId+"'>"+result[i].sTitle+"</a></h3>";
			if(result[i].sContent.length>40){
				contents=contents+"<p style='margin-top:-10px;'>"+result[i].sContent.substring(0,40)+"......</p>";
			}else{
				contents=contents+"<p style='margin-top:-10px;'>"+result[i].sContent+"</p>";
			}
			contents=contents+"</div>";
			contents=contents+"</div></li>";
			$("#rightContents").append(contents);
		}
	}
 }
  req.send(null);
	</script>
	<script type="text/javascript">
function selectChapterArticle(chapter){
	$("#leftContents").empty();
	$("#rightContents").empty();
	var req = createAjaxObj();
	req.open("post", "<%=basePath%>Article.do?method=selectArticleBykindAndChapterId&kind=8&ChapterId="+chapter);
	req.setRequestHeader("accept", "application/json");
	req.onreadystatechange = function() {
		if (req.readyState == 4 && req.status == 200) {
		  //alert(req.responseText);
			eval("var result=" + req.responseText);
			$("#leftContents").html('');
			$("#rightContents").html('');
			for(var i=0;i<6;i++){
				var contents="<li style='list-style:none;border-bottom-style: none;'><div class='withpic'>";
				if(null!=result[i].filepath&&result[i].filepath.length>0){
					contents=contents+"<div class='pic'><a href='<%=basePath%>Article.do?method=selectvideoByid&articleid="+result[i].sArticleId+"'><img src='"+result[i].filepath+"'></a></div>";
				}else{
					contents=contents+"<div class='pic'><a href='<%=basePath%>Article.do?method=selectvideoByid&articleid="+result[i].sArticleId+"'><img src='/STLVX_WEB/images/pictureNotFound.jpg'></a></div>";
				}
				contents=contents+"<div class='text'>";
				contents=contents+"<h3 style='margin-top:1px;'><a href='<%=basePath%>Article.do?method=selectvideoByid&articleid="+result[i].sArticleId+"'>"+result[i].sTitle+"</a></h3>";
				if(result[i].sContent.length>40){
					contents=contents+"<p style='margin-top:-10px;'>"+result[i].sContent.substring(0,40)+"......</p>";
				}else{
					contents=contents+"<p style='margin-top:-10px;'>"+result[i].sContent+"</p>";
				}
				contents=contents+"</div>";
				contents=contents+"</div></li>";
			    $("#leftContents").append(contents);
			}
			for(var i=6;i<result.length;i++){
				var contents="<li style='list-style:none;border-bottom-style: none;'><div class='withpic'>";
				if(null!=result[i].filepath&&result[i].filepath.length>0){
					contents=contents+"<div class='pic'><a href='<%=basePath%>Article.do?method=selectvideoByid&articleid="+result[i].sArticleId+"'><img src='"+result[i].filepath+"'></a></div>";
				}else{
					contents=contents+"<div class='pic'><a href='<%=basePath%>Article.do?method=selectvideoByid&articleid="+result[i].sArticleId+"'><img src='/STLVX_WEB/images/pictureNotFound.jpg'></a></div>";
				}
				contents=contents+"<div class='text'>";
				contents=contents+"<h3 style='margin-top:1px;'><a  href='<%=basePath%>Article.do?method=selectvideoByid&articleid="+result[i].sArticleId+"'>"+result[i].sTitle+"</a></h3>";
				if(result[i].sContent.length>40){
					contents=contents+"<p style='margin-top:-10px;'>"+result[i].sContent.substring(0,40)+"......</p>";
				}else{
					contents=contents+"<p style='margin-top:-10px;'>"+result[i].sContent+"</p>";
				}
				contents=contents+"</div>";
				contents=contents+"</div></li>";
				$("#rightContents").append(contents);
			}
		}
		$("#local").html("当前位置：<a href='index.jsp'>首页</a> &gt; <a href='#'>课件</a> &gt; <a href='#'>第"+chapter+"章</a>");
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
				<li class="navhome"><a
					href="${pageContext.request.contextPath}/jsp/index.jsp">首页</a></li>
				<li><a
					href="${pageContext.request.contextPath}/jsp/CourseOverView.jsp">课程概况</a>
					<ul>
						<li><a
							href="${pageContext.request.contextPath}/jsp/Courseintroduction.jsp">课程简介</a></li>
						<li><a
							href="${pageContext.request.contextPath}/jsp/Syllabus.jsp">课程大纲</a></li>
						<li><a
							href="${pageContext.request.contextPath}/jsp/TeachingCalendar.jsp">教学日历</a></li>
						<li><a
							href="${pageContext.request.contextPath}/jsp/TestType.jsp">考试形式</a></li>
					</ul></li>
				<li><a
					href="${pageContext.request.contextPath}/jsp/TheoryTeaching.jsp">理论教学</a>
					<ul>
						<li><a
							href="${pageContext.request.contextPath}/jsp/KnowledgeGuidance.jsp">知识导学</a></li>
						<li><a
							href="${pageContext.request.contextPath}/jsp/Notes.jsp">讲稿</a></li>
						<li><a
							href="${pageContext.request.contextPath}/jsp/Teachingplan.jsp">教案</a></li>
						<li><a
							href="${pageContext.request.contextPath}/jsp/CourseWare.jsp">课件</a></li>
						<li><a
							href="${pageContext.request.contextPath}/jsp/videoOverView.jsp">授课视频</a></li>
						<li><a
							href="${pageContext.request.contextPath}/jsp/exercises.jsp">习题</a></li>
					</ul></li>
				<li><a
					href="${pageContext.request.contextPath}/jsp/EcoloProductDe.jsp">生态产品设计</a>
					<ul>
						<li><a
							href="${pageContext.request.contextPath}/jsp/ProduRequirements.jsp">产品设计要求</a></li>
						<li><a
							href="${pageContext.request.contextPath}/jsp/ProddesProcess.jsp">产品设计过程</a></li>
						<li><a
							href="${pageContext.request.contextPath}/jsp/ProddesResult.jsp">产品设计结果</a></li>
					</ul></li>
				<li><a
					href="${pageContext.request.contextPath}/jsp/CourseCase.jsp">课程案例</a>
				</li>
				<li><a
					href="${pageContext.request.contextPath}/jsp/education.jsp">环境教育</a>
					<ul>
						<li><a
							href="${pageContext.request.contextPath}/jsp/Environmentaleducationprogram.jsp">环境教育大纲</a></li>
						<li><a
							href="${pageContext.request.contextPath}/jsp/EnvironmentaleducationEffect.jsp">环境教育效果</a></li>
					</ul></li>
				<li><a
					href="${pageContext.request.contextPath}/jsp/PictureLibrary.jsp">图片库</a>
				</li>
				<li><a
					href="${pageContext.request.contextPath}/jsp/OnlineTest.jsp">在线测试</a>
				</li>
				<li><a
					href="${pageContext.request.contextPath}/jsp/extensionTeaching.jsp">扩展学习</a>
				<li><a
					href="${pageContext.request.contextPath}/jsp/Question.jsp">互动教学</a>
				</li>
			</ul>
		</div>
	</div>
	<script type="text/javascript"> 
$(document).ready(function(){
	$("#leftContents").empty();
	$("#rightContents").empty();
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
				当前位置：<a href="${pageContext.request.contextPath}/jsp/index.jsp">首页</a>
				&gt; <a href="#">课件</a> &gt; <a href="#" id="cp">第1章</a>
			</div>

			<aside class="yc_left_box fl">
				<div class="yc_left_title">课件</div>
				<div class="yc_left_list">
					<ul id="chapter">
						<!--   
            <li onclick="selectChapterArticle(1)">第一章</li>
             
            <li onclick="selectChapterArticle(2)">第二章</li>
            
            <li onclick="selectChapterArticle(3)">第三章</li>  -->
					</ul>
				</div>
				<div class="<!-- boxImg -->">
					<img src="../images/img_left_shadow_bot.png" width="206"
						height="180">
				</div>
			</aside>
			<div class="yc_right_box fl">
				<div class=""></div>
			</div>
		</div>
		<div style="height: 500px;">
			<ul id="one" class="content" style="margin-top: 50px">
				<li>
					<ul id="leftContents">
					</ul>
				</li>
				<li>
					<ul id="rightContents">
					</ul>
				</li>
			</ul>
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
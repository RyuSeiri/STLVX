<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% 
String path = request.getContextPath(); 
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/"; 
%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>分数详情页</title>
<link href="/STLVX_WEB/css/main.css" rel="stylesheet" type="text/css" />
<link href="/STLVX_WEB/css/scroll.css" rel="stylesheet" type="text/css" />
<script src="/STLVX_WEB/js/jquery-1.8.2.js" type="text/javascript"></script>
<script src="/STLVX_WEB/js/jquery.sudoSlider.min.js"></script>
<script type="text/javascript" src="/STLVX_WEB/js/bar.js"></script>
<script type="text/javascript" src="/STLVX_WEB/js/PopUp.js"></script>
</head>
<body style="background:url(/STLVX_WEB/images/bg_sea.jpg) no-repeat center top">
    <!-- <div class="yc_bg_flash flash-replaced" id="bgFlash" > -->
    <header class="yc_header">
        <script type="text/javascript" src="/STLVX_WEB/js/jcarousellite_index.js"></script>
       <div class="index_banner" id="banner_tabs">
			<img class="shoolLog" src="/STLVX_WEB/images/schoolLog.png">
		</div>
    </header>
    <!-- </div> -->
	<div class="navbg">
		<div class="col960">
			<ul id="navul" class="cl">
				<li class="navhome"><a href="${pageContext.request.contextPath}/jsp/index.jsp">首页</a></li>
				<li>
					<a href="${pageContext.request.contextPath}/jsp/CourseOverView.jsp">课程概况</a>
					<ul>
					    <li><a href="${pageContext.request.contextPath}/jsp/Courseintroduction.jsp">课程简介</a></li>
						<li><a href="${pageContext.request.contextPath}/jsp/Syllabus.jsp">课程大纲</a></li>
						<li><a href="${pageContext.request.contextPath}/jsp/TeachingCalendar.jsp">教学日历</a></li>
						<li><a href="${pageContext.request.contextPath}/jsp/TestType.jsp">考试形式</a></li>
					</ul>
				</li>
				<li>
					<a href="${pageContext.request.contextPath}/jsp/TheoryTeaching.jsp">理论教学</a>
					<ul>
						<li><a href="${pageContext.request.contextPath}/jsp/KnowledgeGuidance.jsp">知识导学</a></li>
						<li><a href="${pageContext.request.contextPath}/jsp/Notes.jsp">讲稿</a></li>
						<li><a href="${pageContext.request.contextPath}/jsp/Teachingplan.jsp">教案</a></li>
						<li><a href="${pageContext.request.contextPath}/jsp/CourseWare.jsp">课件</a></li>
						<li><a href="${pageContext.request.contextPath}/jsp/videoOverView.jsp">授课视频</a></li>
						<li><a href="${pageContext.request.contextPath}/jsp/exercises.jsp">习题</a></li>
					</ul>
				</li>
				<li>
					<a href="${pageContext.request.contextPath}/jsp/EcoloProductDe.jsp">生态产品设计</a>
					<ul>
						<li><a href="${pageContext.request.contextPath}/jsp/ProduRequirements.jsp">产品设计要求</a></li>
						<li><a href="${pageContext.request.contextPath}/jsp/ProddesProcess.jsp">产品设计过程</a></li>
						<li><a href="${pageContext.request.contextPath}/jsp/ProddesResult.jsp">产品设计结果</a></li>
					</ul>
				</li>
				<li>
					<a href="${pageContext.request.contextPath}/jsp/CourseCase.jsp">课程案例</a>
				</li>
				<li>
					<a href="${pageContext.request.contextPath}/jsp/education.jsp">环境教育</a>
					<ul>
						<li><a href="${pageContext.request.contextPath}/jsp/Environmentaleducationprogram.jsp">环境教育大纲</a></li>
						<li><a href="${pageContext.request.contextPath}/jsp/EnvironmentaleducationEffect.jsp">环境教育效果</a></li>
					</ul>
				</li>
				<li>
					<a href="${pageContext.request.contextPath}/jsp/PictureLibrary.jsp">图片库</a>
				</li>
				<li>
					<a href="${pageContext.request.contextPath}/jsp/OnlineTest.jsp">在线测试</a>
				</li>
				<li>
					<a href="${pageContext.request.contextPath}/jsp/">扩展学习</a>
					<%-- <ul>
						<li><a href="${pageContext.request.contextPath}/jsp/">外国国家公园系列</a></li>
						<li><a href="${pageContext.request.contextPath}/jsp/">中国国家森林公园</a></li>
					</ul> --%>
				</li>
				<li>
					<a href="${pageContext.request.contextPath}/jsp/Question.jsp">互动教学</a>
				</li>
			</ul>
		</div>
	</div>
<script  type="text/javascript">
$(document).ready(function(){
	//$(".navbg").capacityFixed();
	$("#navul > li").not(".navhome").hover(function(){
		$(this).addClass("navmoon");
	},function(){
		$(this).removeClass("navmoon");
	});
});
</script>
<div style="width:1000px;position: relative;margin: 0 auto 0px;box-shadow:1px 1px 7px #999;padding: 8px">
	<h1 class="font">分数</h1>
        <div class="norsTitle">
                  <article>您得分数为：<font color="red"><b>${point}</b></font></article>
        </div>
        
        <span   id="answer" style="font-size: 15px">
			答案：  <c:forEach var="x"  items="${answerArray}" varStatus="xh">
				   <b>&nbsp;${xh.count}.&nbsp;${x}</b>
                  </c:forEach>
				</span>
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
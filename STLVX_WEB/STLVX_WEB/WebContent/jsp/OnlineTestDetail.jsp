<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% 
String path = request.getContextPath(); 
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/"; 
%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>在线测试</title>
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
					<a href="${pageContext.request.contextPath}/jsp/extensionTeaching.jsp">扩展学习</a>
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
	<script type="text/javascript">
		$(document).ready(function() {
			//$(".navbg").capacityFixed();
			$("#navul > li").not(".navhome").hover(function() {
				$(this).addClass("navmoon");
			}, function() {
				$(this).removeClass("navmoon");
			});
		});
	</script>
	<div style="width: 1000px; position: relative; margin: 47px auto 0px; box-shadow: 1px 1px 7px #999;">
		<!--  <div class="yc_location">当前位置：<a href="/">首页</a> &gt; <a href="/xxgk">理论教学</a> &gt; <a href="/xxgk/ggzy">讲稿</a> </div> -->
		<div class="yc_content_inner">
			<section class="showCon">
				<h1>在线测试</h1> 
	          <h3><span id="time">时间：${result[0].dMakeTime}</span>&nbsp;&nbsp;&nbsp;&nbsp;<font color="#ff0000">字体显示：</font>
					&nbsp;<span id="big" style="cursor: pointer">大</span> 
					&nbsp;<span id="middle" style="cursor: pointer">中</span> 
					&nbsp;<span id="small" style="cursor: pointer">小 </span>
				</h3>
				<article id="zoom">
					<p align="center" style="text-align: center">
						<b style="font-size: 30px" style="font-weight:bold">
						${result[0].sTitle}
						</b>
					</p>
					<span class="p0">
                      ${result[0].praxisInfo}
					</span>
					<br/><br/><div id="show" >显示答题卡区域&nbsp;&nbsp;<span style="cursor: pointer">[+]</span></div> 
				</article>
				<article>
				<form id="answerform" method="post" action="<%=basePath%>Article.do?method=judgePaper&articleid=${result[0].sArticleId}&onlineTestCount=${onlineTestCount}">
				<span  style="display: none;" id="answer">
				 <c:forEach var="x"  begin="1" step="1" end="${null!=onlineTestCount?onlineTestCount:10}">
				   <b>${x}. &nbsp; A<input id="selectanswer"   type="checkbox" name="answer${x}" value="A"/>&nbsp; B<input id="selectanswer" type="checkbox" name="answer${x}" value="B"/>&nbsp; C<input id="selectanswer" type="checkbox" name="answer${x}" value="C"/>&nbsp; D<input id="selectanswer" type="checkbox"  name="answer${x}" value="D"/></b><br><br>
                  </c:forEach>
                  <!-- <textarea style="height: 100px;width: 500px;margin:140px 50px 15px 100px;padding: 22" placeholder="描述你的问题，200字以内" id="contents"  name="contents" style="height: 100px;width: 800px"></textarea> -->
				<input style="margin: 0px 0 0 0 1000px" type="button" value="交卷"  onclick="getSubmit()">
				</span>
				</form>
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
               <script  type="text/javascript">
                function getSubmit(){
                    if(confirm("是否确认提交？")){
                    	var form=document.getElementById("answerform");
                    	form.submit();
                    }else{
                          return false;
                   }
                }
               </script>
               <script type="text/javascript">
          $("#show").toggle(
	      function () {
	    	  $("#show").html("收起答题卡区域 &nbsp;&nbsp;<span style='cursor: pointer'>[-]</span>");
	    	  /* $("#answer").fadeIn("slow");  */
	    	  $("#answer").show();
	      },
	      function () {
	    	  $("#show").html("显示答题卡区域&nbsp;&nbsp;<span style='cursor: pointer'>[+]</span>");
	    	 /*  $("#answer").fadeOut("slow"); */
	    	  $("#answer").hide();
	      });
               </script>
			</section>
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
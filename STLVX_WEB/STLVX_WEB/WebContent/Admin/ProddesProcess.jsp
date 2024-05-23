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
<title>环境教育效果</title>
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

var req = createAjaxObj();
req.open("post", "<%=basePath%>Article.do?method=selectActicleByKind&kind=12");
req.setRequestHeader("accept", "application/json");
req.onreadystatechange = function() {
	if (req.readyState == 4 && req.status == 200) {
	 //alert(req.responseText);
		eval("var result=" + req.responseText);
		$('#cpsjgc').html('');
		for(var i=0;i<result.length;i++){
			  var contents =  "<li><span>"+result[i].dMakeTime+"</span><a href='<%=basePath%>Article.do?method=selectCourseCaseVideo&articleid="+result[i].sArticleId+"'>"+result[i].sTitle+"</a></li>";
			 $('#cpsjgc').append(contents);
		}
	}
}
req.send(null);
</script>
<body style="background:url(../images/bg_sea.jpg) no-repeat center top" onload="init()">
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
    <div style="width:1000px;position: relative;margin: 47px auto 0px;box-shadow:1px 1px 7px #999;">
        <div class="yc_content_inner">
        <div id="local" class="yc_location">当前位置：<a href="${pageContext.request.contextPath}/Admin/index.jsp">首页>首页</a> &gt; <a href="EcoloProductDe.jsp">教育</a> &gt; <a href="/xxgk/ggzy\">环境教育效果</a></div>
              <div class="yc_right_box fl">
                    <div id="2jtitle" class="yc_right_title0"><span style="float:left;">环境教育效果</span> 
                      <div class="gradient_line"></div>
                    </div>
               </div>
			<div class="huanjing">
				<ul id="cpsjgc" >
					<li><span>2016-7-22</span><a target="_blank" href="/showxxgk.aspx?Id=114523&amp;ctlgid=264622">设计过程</a></li>
				</ul>
			</div>
			<!--pagebox-->
                   <!-- <div class="pagebox" style="display:none;"><span style="line-height:22px;">&nbsp;共有24条记录，当前第<b>1</b>/2页&nbsp;&nbsp;&nbsp;</span><span class="pagebox_pre"><a href="index.html">第一页</a></span><span class="pagebox_pre"><a href="javascript:void(0);">上一页</a></span><span class="pagebox_num_nonce">1</span><span class="pagebox_num"><a href="/xxgklist.aspx?p=2&amp;ctlgid=264622" target="_self">2</a></span><span class="pagebox_next"><a href="/xxgklist.aspx?p=2&amp;ctlgid=264622" target="_self">下一页</a></span><span class="pagebox_next"><a href="/xxgklist.aspx?p=2&amp;ctlgid=264622">最末页</a></span></div> -->
                <!--pagebox-->
          </div>

      <div class="yc_shadow_bot boxImg"><img src="" width="1000" height="0"></div>
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
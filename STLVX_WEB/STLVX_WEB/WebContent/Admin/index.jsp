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
<title>首页</title>
<link href="/STLVX_WEB/css/main.css" rel="stylesheet" type="text/css" />
<link href="/STLVX_WEB/css/scroll.css" rel="stylesheet" type="text/css" />
<script src="/STLVX_WEB/js/jquery-1.8.2.js" type="text/javascript"></script>
<script src="/STLVX_WEB/js/jquery.sudoSlider.min.js"></script>
<script type="text/javascript" src="/STLVX_WEB/js/bar.js"></script>
<script type="text/javascript" src="/STLVX_WEB/js/PopUp.js"></script>
<script type="text/javascript">
function createAjaxObj_index() {
	var req;
	if (window.XMLHttpRequest) {
		req = new XMLHttpRequest();
	} else {
		req = new ActiveXObject("Msxml2.XMLHTTP"); 
	}
	return req;
}
function index_show() {
	index_selectLljx();
	index_selectSksp();
	index_selectKcal();
	index_selectTpk();
	index_selectDttp();
	index_selectKzxx();
}
/* 查询首页理论教学列表 */
function index_selectLljx() {
	var req = createAjaxObj_index();
	req.open("post", "<%=basePath%>index.do?method=selectLljxActicleForIndex");
	req.setRequestHeader("accept", "application/json");
	req.onreadystatechange = function() {
		if (req.readyState == 4 && req.status == 200) {
			eval("var result=" + req.responseText);
			var len=result.length;
			var contents = "";
			contents = contents + "<ul class='content'>";
			contents = contents + "<li>";
			contents = contents + "<ul>";
			for (i = 0; i < 6; i++) {
				contents = contents + "<li><a href='<%=basePath%>Article.do?method=selectActicleByid&articleid="+result[i].articleId+"'>" + result[i].title + "</a><span>"
						+ result[i].time + "</span></li>";
			}
			contents = contents + "</ul>";
			contents = contents + "</li>";
			contents = contents + "<li>";
			contents = contents + "<ul>";

			for (i = 6; i < 12; i++) {
				contents = contents + "<li><a href='<%=basePath%>Article.do?method=selectActicleByid&articleid="+result[i].articleId+"'>" + result[i].title + "</a><span>"+ result[i].time + "</span></li>";
			}
			if(len>12){
				contents = contents + "<li><span style='margin-left:265px;'><a href='moreTheoryTeaching.jsp'>更多</a></span></li>";	
			}else{
				contents = contents + "<li><span style='margin-left:265px;'></span></li>";
			}
			contents = contents + "</ul>";
			contents = contents + "</li>";
			contents = contents + "</ul>";
			$('#index_lljxList').html(contents);
		}
	}
	req.send(null);
}
/* 查询首页授课视频列表 */
function index_selectSksp() {
	var req = createAjaxObj_index();
	req.open("post", "<%=basePath%>index.do?method=selectSkspActicleForIndex");
	req.setRequestHeader("accept", "application/json");
	req.onreadystatechange = function() {
		if (req.readyState == 4 && req.status == 200) {
			eval("var result=" + req.responseText);
			var len=result.length;
			var contents ="<ul class='content'>";
			contents = contents + "<li>";
			contents = contents + "<ul>";
			for (i = 0; i < 6; i++) {
				contents = contents + "<li><a href='<%=basePath%>Article.do?method=selectCourseCaseVideo&articleid="+result[i].articleId+"'>" + result[i].title + "</a><span>"+ result[i].time + "</span></li>";
			}
			contents = contents + "</ul>";
			contents = contents + "</li>";
			contents = contents + "<li>";
			contents = contents + "<ul>";

			for (i = 6; i < 12; i++) {
				contents = contents + "<li><a href='<%=basePath%>Article.do?method=selectCourseCaseVideo&articleid="+result[i].articleId+"'>" + result[i].title + "</a><span>"+ result[i].time + "</span></li>";
			}
		
			if(len>12){
				contents = contents + "<li><span style='margin-left:265px;'><a href='MoreTeachingVideo.jsp'>更多</a></span></li>";	
			}else{
				contents = contents + "<li><span style='margin-left:265px;'></span></li>";
			}
			contents = contents + "</ul>";
			contents = contents + "</li>";
			contents = contents + "</ul>";
			$('#index_skspList').html(contents);
		}
	}
	req.send(null);
}
/* 查询首页课程案例列表 */
function index_selectKcal() {
	var req = createAjaxObj_index();
	req.open("post", "<%=basePath%>index.do?method=selectKcalActicleForIndex");
	req.setRequestHeader("accept", "application/json");
	req.onreadystatechange = function() {
		if (req.readyState == 4 && req.status == 200) {
			//alert(req.responseText)
			eval("var result=" + req.responseText);
			var contents = "";
			contents = contents + "<div class='dqinfo'>";
			for (i = 0; i < 2; i++) {
				//alert(result[i].img)
				contents = contents + "<div class='withpic'> ";
				contents = contents + "<div class='pic'> ";
				contents = contents + "<a href='<%=basePath%>Article.do?method=selectIndexCourseCase&articleid="+result[i].articleId+"'> ";
				if(null!=result[i].img&&result[i].img.length>0){
				contents = contents + "<img src='"+result[i].img+"'> ";
				}else{
				contents = contents + "<img src='/STLVX_WEB/images/pictureNotFound.jpg'> ";
				}
				contents = contents + "</a></div> ";
				contents = contents + "<div class='text'> ";
				contents = contents + "<h3><a  href='<%=basePath%>Article.do?method=selectIndexCourseCase&articleid="+result[i].articleId+"'><span class='hua'>";
				contents = contents + result[i].title;
				contents = contents + "</span></a></h3>";
				if(result[i].brief.length>50){
				contents = contents + "<p>" + result[i].brief.substring(0,50)+"......</p>";
				}else{
					contents = contents + "<p>" + result[i].brief  + "</p>";	
				}
				contents = contents + "</div>";
				contents = contents + "</div>";
			}
			contents = contents + "</div>";
			contents = contents + "<div class='dqinfo' style='margin-left:300px;'>";
			for (i = 2; i <4; i++) {
				contents = contents + "<div class='withpic'> ";
				contents = contents + "<div class='pic'> ";
				contents = contents + "<a href='<%=basePath%>Article.do?method=selectIndexCourseCase&articleid="+result[i].articleId+"'> ";
				if(null!=result[i].img&&result[i].img.length>0){
					contents = contents + "<img src='"+result[i].img+"'> ";
					}else{
					contents = contents + "<img src='/STLVX_WEB/images/pictureNotFound.jpg'> ";
					}
				contents = contents + "</a></div> ";
				contents = contents + "<div class='text'> ";
				contents = contents + "<h3><a href='<%=basePath%>Article.do?method=selectIndexCourseCase&articleid="+result[i].articleId+"'><span class='hua'>";
				contents = contents + result[i].title;
				contents = contents + "</span></a></h3>";
				if(result[i].brief.length>50){
				contents = contents + "<p>" + result[i].brief.substring(0,50)+"......</p>";
				}else{
				contents = contents + "<p>" + result[i].brief  + "</p>";	
				}
				contents = contents + "</div>";
				contents = contents + "</div>";
			}
			contents = contents + "</div>";
			$('#index_kcalList').html(contents);
		}
	}
	req.send(null);
	
}
/* 查询首页扩展学习列表 */
function index_selectKzxx() {
	var req = createAjaxObj_index();
	req.open("post", "<%=basePath%>index.do?method=selectKzxxActicleForIndex");
	req.setRequestHeader("accept", "application/json");
	req.onreadystatechange = function() {
		if (req.readyState == 4 && req.status == 200) {
			//alert(req.responseText)
			eval("var result=" + req.responseText);
			var contents = "";
			contents = contents + "<div class='dqinfo'>";
			for (i = 0; i < 2; i++) {
				contents = contents + "<div class='withpic'> ";
				contents = contents + "<div class='pic'> ";
				contents = contents + "<a href='<%=basePath%>Article.do?method=selectIndexCourseCase&articleid="+result[i].articleId+"'> ";
				if(null!=result[i].img&&result[i].img.length>0){
				contents = contents + "<img src='"+result[i].img+"'> ";
				}else{
				contents = contents + "<img src='/STLVX_WEB/images/pictureNotFound.jpg'> ";
				}
				contents = contents + "</a></div> ";
				contents = contents + "<div class='text'> ";
				contents = contents + "<h3><a  href='<%=basePath%>Article.do?method=selectIndexCourseCase&articleid="+result[i].articleId+"'><span class='hua'>";
				contents = contents + result[i].title;
				contents = contents + "</span></a></h3>";
				if(result[i].brief.length>50){
				contents = contents + "<p>" + result[i].brief.substring(0,50)+"......</p>";
				}else{
					contents = contents + "<p>" + result[i].brief  + "</p>";	
				}
				contents = contents + "</div>";
				contents = contents + "</div>";
			}
			contents = contents + "</div>";
			contents = contents + "<div class='dqinfo' style='margin-left:300px;'>";
			for (i = 2; i <4; i++) {
				contents = contents + "<div class='withpic'> ";
				contents = contents + "<div class='pic'> ";
				contents = contents + "<a href='<%=basePath%>Article.do?method=selectIndexCourseCase&articleid="+result[i].articleId+"'> ";
				if(null!=result[i].img&&result[i].img.length>0){
					contents = contents + "<img src='"+result[i].img+"'> ";
					}else{
					contents = contents + "<img src='/STLVX_WEB/images/pictureNotFound.jpg'> ";
					}
				contents = contents + "</a></div> ";
				contents = contents + "<div class='text'> ";
				contents = contents + "<h3><a href='<%=basePath%>Article.do?method=selectIndexCourseCase&articleid="+result[i].articleId+"'><span class='hua'>";
				contents = contents + result[i].title;
				contents = contents + "</span></a></h3>";
				if(result[i].brief.length>50){
				contents = contents + "<p>" + result[i].brief.substring(0,50)+"......</p>";
				}else{
				contents = contents + "<p>" + result[i].brief  + "</p>";	
				}
				contents = contents + "</div>";
				contents = contents + "</div>";
			}
			contents = contents + "</div>";
			$('#index_kzxxList').html(contents);
		}
	}
	req.send(null);
	
}
/*查询首页图片库列表  */
function index_selectTpk() {
	var req = createAjaxObj_index();
	req.open("post", "<%=basePath%>index.do?method=selectTpkForIndex");
	req.setRequestHeader("accept", "application/json");
	req.onreadystatechange = function() {
		if (req.readyState == 4 && req.status == 200) {
			//alert(req.responseText);
			eval("var result=" + req.responseText);
			var contents = "";
			contents = contents + "<ul>";
			for (i = 0; i < 8; i++) {
			contents = contents+ "<li><img src='" + result[i].img + "'  width='212' height='159'/><a target='_blank' href='<%=basePath%>Article.do?method=selectIndexPicDetail&fileId="+result[i].articleId+"' class='img_mark nodis'>图片</a></li>";
			}
			contents = contents + "</ul>";
			$('#slider').html(contents);
			var sudoSlider = $("#slider").sudoSlider({
				slideCount:4,
				continuous:true,
				numeric:false,
				prevNext:true,
				continuous:true,
				auto:true,
				speed:800,
				pause:3000,
				prevHtml:'<a href="#" class="prevBtn"></a>',
				nextHtml:'<a href="#" class="nextBtn"></a>'
			});
			$("#slider li").on("mouseenter",function(){
			 $(this).find(".img_mark").fadeIn(200).removeClass("nodis");
			})
			$("#slider li").on("mouseleave",function(){
			 $(this).find(".img_mark").fadeOut(200).addClass("nodis")
			})
		}
	}
	req.send(null);
}

/*查询首页动态图片  */
function index_selectDttp() {
	var req = createAjaxObj_index();
	req.open("post", "<%=basePath%>index.do?method=selectDttpForIndex");
	req.setRequestHeader("accept", "application/json");
	req.onreadystatechange = function() {
		if (req.readyState == 4 && req.status == 200) {
			eval("var result=" + req.responseText);
				for (i = 0; i < 7; i++) {
					document.getElementById("top_img" + (i+1)).src = "<%=basePath.replace(basePath, "")%>" + result[i].img;
				}
		}
	}
	req.send(null);
}
</script>
</head>
<body
	style="background: url(/STLVX_WEB/images/bg_sea.jpg) no-repeat center top"
	onload="index_show()">
	<!-- <div class="yc_bg_flash flash-replaced" id="bgFlash" > -->
	<header class="yc_header">
		<script type="text/javascript"
			src="/STLVX_WEB/js/jcarousellite_index.js"></script>
		<div class="index_banner" id="banner_tabs">
			<img class="shoolLog" src="/STLVX_WEB/images/schoolLog.png">
		</div>
	</header>
	<!-- </div> -->
	<script type="text/javascript">
			(function(){
		        if(!Function.prototype.bind){
		            Function.prototype.bind = function(obj){
		                var owner = this,args = Array.prototype.slice.call(arguments),callobj = Array.prototype.shift.call(args);
		                return function(e){e=e||top.window.event||window.event;owner.apply(callobj,args.concat([e]));};
		            };
		        }
		    })();
		    var banner_tabs = function(id){
		        this.ctn = document.getElementById(id);
		        this.adLis = null;
		        this.btns = null;
		        this.animStep = 0.4;//动画速度0.1～0.9
		        this.switchSpeed =6;//自动播放间隔(s)
		        this.defOpacity = 1;
		        this.tmpOpacity = 1;
		        this.crtIndex = 0;
		        this.crtLi = null;
		        this.adLength = 0;
		        this.timerAnim = null;
		        this.timerSwitch = null;
		        this.init();
		    };
		    banner_tabs.prototype = {
		        fnAnim:function(toIndex){
		            if(this.timerAnim){window.clearTimeout(this.timerAnim);}
		            if(this.tmpOpacity <= 0){
		                this.crtLi.style.opacity = this.tmpOpacity = this.defOpacity;
		                this.crtLi.style.filter = 'Alpha(Opacity=' + this.defOpacity*100 + ')';
		                this.crtLi.style.zIndex = 0;
		                this.crtIndex = toIndex;
		                return;
		            }
		            this.crtLi.style.opacity = this.tmpOpacity = this.tmpOpacity - this.animStep;
		            this.crtLi.style.filter = 'Alpha(Opacity=' + this.tmpOpacity*100 + ')';
		            this.timerAnim = window.setTimeout(this.fnAnim.bind(this,toIndex),50);
		        },
		        fnNextIndex:function(){
		            return (this.crtIndex >= this.adLength-1)?0:this.crtIndex+1;
		        },
		        fnSwitch:function(toIndex){
		            if(this.crtIndex==toIndex){return;}
		            this.crtLi = this.adLis[this.crtIndex];
		            for(var i=0;i<this.adLength;i++){
		                this.adLis[i].style.zIndex = 0;
		            }
		            this.crtLi.style.zIndex = 2;
		            this.adLis[toIndex].style.zIndex = 1;
		            for(var i=0;i<this.adLength;i++){
		                this.btns[i].className = '';
		            }
		            this.btns[toIndex].className = 'cur'
		            this.fnAnim(toIndex);
		        },
		        fnAutoPlay:function(){
		            this.fnSwitch(this.fnNextIndex());
		        },
		        fnPlay:function(){
		            this.timerSwitch = window.setInterval(this.fnAutoPlay.bind(this),this.switchSpeed*1000);
		        },
		        fnStopPlay:function(){
		            window.clearTimeout(this.timerSwitch);
		        },
		        init:function(){
		            this.adLis = this.ctn.getElementsByTagName('li');
		            this.btns = this.ctn.getElementsByTagName('cite')[0].getElementsByTagName('span');
		            this.adLength = this.adLis.length;
		            for(var i=0,l=this.btns.length;i<l;i++){
		                with({i:i}){
		                    this.btns[i].index = i;
		                    this.btns[i].onclick = this.fnSwitch.bind(this,i);
		                    this.btns[i].onclick = this.fnSwitch.bind(this,i);
		                }
		            }
		            this.adLis[this.crtIndex].style.zIndex = 2;
		            this.fnPlay();
		            this.ctn.onmouseover = this.fnStopPlay.bind(this);
		            this.ctn.onmouseout = this.fnPlay.bind(this);
		        }
		    };
		    var player1 = new banner_tabs('banner_tabs');
		</script>
	<%-- <div style="margin: -30px 0 0 13%;font-size: 15px;font-weight:lighter;">${null==sessionScope.userName?"您的身份：学生<!-- ":"您的身份：老师"} --></div> --%>
	<div class="navbg">
		<div class="col960">
			<ul id="navul" class="cl">
				<li class="navhome"><a
					href="${pageContext.request.contextPath}/Admin/index.jsp">首页</a></li>
				<li><a
					href="${pageContext.request.contextPath}/Admin/CourseOverView.jsp">课程概况</a>
					<ul>
						<li><a
							href="${pageContext.request.contextPath}/Admin/Courseintroduction.jsp">课程简介</a></li>
						<li><a
							href="${pageContext.request.contextPath}/Admin/Syllabus.jsp">课程大纲</a></li>
						<li><a
							href="${pageContext.request.contextPath}/Admin/TeachingCalendar.jsp">教学日历</a></li>
						<li><a
							href="${pageContext.request.contextPath}/Admin/TestType.jsp">考试形式</a></li>
					</ul></li>
				<li><a
					href="${pageContext.request.contextPath}/Admin/TheoryTeaching.jsp">理论教学</a>
					<ul>
						<li><a
							href="${pageContext.request.contextPath}/Admin/KnowledgeGuidance.jsp">知识导学</a></li>
						<li><a
							href="${pageContext.request.contextPath}/Admin/Notes.jsp">讲稿</a></li>
						<li><a
							href="${pageContext.request.contextPath}/Admin/Teachingplan.jsp">教案</a></li>
						<li><a
							href="${pageContext.request.contextPath}/Admin/CourseWare.jsp">课件</a></li>
						<li><a
							href="${pageContext.request.contextPath}/Admin/videoOverView.jsp">授课视频</a></li>
						<li><a
							href="${pageContext.request.contextPath}/Admin/exercises.jsp">习题</a></li>
					</ul></li>
				<li><a
					href="${pageContext.request.contextPath}/Admin/EcoloProductDe.jsp">生态产品设计</a>
					<ul>
						<li><a
							href="${pageContext.request.contextPath}/Admin/ProduRequirements.jsp">产品设计要求</a></li>
						<li><a
							href="${pageContext.request.contextPath}/Admin/ProddesProcess.jsp">产品设计过程</a></li>
						<li><a
							href="${pageContext.request.contextPath}/Admin/ProddesResult.jsp">产品设计结果</a></li>
					</ul></li>
				<li><a
					href="${pageContext.request.contextPath}/Admin/CourseCase.jsp">课程案例</a>
				</li>
				<li><a
					href="${pageContext.request.contextPath}/Admin/education.jsp">环境教育</a>
					<ul>
						<li><a
							href="${pageContext.request.contextPath}/Admin/Environmentaleducationprogram.jsp">环境教育大纲</a></li>
						<li><a
							href="${pageContext.request.contextPath}/Admin/EnvironmentaleducationEffect.jsp">环境教育效果</a></li>
					</ul></li>
				<li><a
					href="${pageContext.request.contextPath}/Admin/PictureLibrary.jsp">图片库</a>
				</li>
				<li><a
					href="${pageContext.request.contextPath}/Admin/OnlineTest.jsp">在线测试</a>
				</li>
				<li><a
					href="${pageContext.request.contextPath}/Admin/extensionTeaching.jsp">扩展学习</a>
					<%-- <ul>
						<li><a href="${pageContext.request.contextPath}/Admin/">外国国家公园系列</a></li>
						<li><a href="${pageContext.request.contextPath}/Admin/">中国国家森林公园</a></li>
					</ul> --%></li>
				<li><a
					href="${pageContext.request.contextPath}/Admin/Question.jsp">互动教学</a>
				</li>
			</ul>
		</div>
	</div>
	<script type="text/javascript">
$(document).ready(function(){
	//$(".navbg").capacityFixed();
	$("#navul > li").not(".navhome").hover(function(){
		$(this).addClass("navmoon");
	},function(){
		$(this).removeClass("navmoon");
	});
});
</script>
	<div class="caroursel poster-main"
		data-setting='{
	        "height":270,
	        "posterWidth":640,
	        "posterHeight":270,
	        "scale":0.8,
	        "dealy":"2000",
	        "algin":"middle"
	    }'>
		<div id="posterlist">
			<ul class="poster-list">
				<li class="poster-item"><img id="top_img2" src="" width="100%"
					height="100%"></li>
				<li class="poster-item"><img id="top_img3" src="" width="100%"
					height="100%"></li>
				<li class="poster-item"><img id="top_img4" src="" width="100%"
					height="100%"></li>
				<li class="poster-item"><img id="top_img5" src="" width="100%"
					height="100%"></li>
				<li class="poster-item"><img id="top_img6" src="" width="100%"
					height="100%"></li>
				<li class="poster-item"><img id="top_img1" src="" width="100%"
					height="100%"></li>
				<li class="poster-item"><img id="top_img7" src="" width="100%"
					height="100%"></li>
			</ul>
		</div>
		<div class="poster-btn poster-prev-btn"></div>
		<div class="poster-btn poster-next-btn"></div>
	</div>

	<script src="/STLVX_WEB/js/scroll.js"></script>
	<script>
        Caroursel.init($('.caroursel'))
    </script>
	<div
		style="width: 1000px; position: relative; margin: 0 auto 0px; box-shadow: 1px 1px 7px #999;">
		<div style="width: 950px; position: relative; margin: 0 auto -30px;">
			<div class="title">
				<div class="titlepic">
					<img src="/STLVX_WEB/images/hua_icon.png">
				</div>
				<h6>理论教学</h6>
				<a href="#"><img src="/STLVX_WEB/images/img-07.jpg"></a>
			</div>
			<div
				style="position: relative; margin: 40px auto 0; width: 950px; height: 140px;"
				id="index_lljxList">
				<!-- <ul class="content">
					<li>
						<ul>
							<li><a>理论教学</a><span>11-07</span></li>
							<li><a>理论教学</a><span>11-07</span></li>
							<li><a>理论教学</a><span>11-07</span></li>
							<li><a>理论教学</a><span>11-07</span></li>
							<li><a>理论教学</a><span>11-07</span></li>
							<li><a>理论教学</a><span>11-07</span></li>
						</ul>
					</li>
					<li>
						<ul>
							<li><a>理论教学12345678910</a><span>11-07</span></li>
							<li><a>理论教学</a><span>11-07</span></li>
							<li><a>理论教学</a><span>11-07</span></li>
							<li><a>理论教学</a><span>11-07</span></li>
							<li><a>理论教学</a><span>11-07</span></li>
							<li><a>理论教学</a><span>11-07</span></li>
							<li><span style="margin-left: 265px;"><a>更多</a></span></li>
						</ul>
					</li>
				</ul> -->
			</div>
		</div>
		<div style="width: 950px; position: relative; margin: 0 auto -30px;">
			<div class="title">
				<div class="titlepic">
					<img src="/STLVX_WEB/images/img-46.png">
				</div>
				<h6>授课视频</h6>
				<a href="#"><img src="/STLVX_WEB/images/img-07.jpg"></a>
			</div>
			<div
				style="position: relative; margin: 40px auto 0; width: 950px; height: 140px;"
				id="index_skspList">
				<!-- <ul class="content">
					<li>
						<ul>
							<li><a>理论教学</a><span>11-07</span></li>
							<li><a>理论教学</a><span>11-07</span></li>
							<li><a>理论教学</a><span>11-07</span></li>
							<li><a>理论教学</a><span>11-07</span></li>
							<li><a>理论教学</a><span>11-07</span></li>
							<li><a>理论教学</a><span>11-07</span></li>
						</ul>
					</li>
					<li>
						<ul>
							<li><a>理论教学</a><span>11-07</span></li>
							<li><a>理论教学</a><span>11-07</span></li>
							<li><a>理论教学</a><span>11-07</span></li>
							<li><a>理论教学</a><span>11-07</span></li>
							<li><a>理论教学</a><span>11-07</span></li>
							<li><a>理论教学</a><span>11-07</span></li>
							<li><span style="margin-left: 265px;"><a>更多</a></span></li>
						</ul>
					</li>
				</ul> -->
			</div>
		</div>
		<div style="width: 950px; position: relative; margin: 0 auto -30px;">
			<div class="title">
				<div class="titlepic">
					<img src="/STLVX_WEB/images/hua_icon.png">
				</div>
				<h6>课程案例</h6>
				<a href="#"><img src="/STLVX_WEB/images/img-07.jpg"></a>
			</div>
			<div
				style="position: relative; margin: 40px auto 0; width: 950px; height: 190px;"
				id="index_kcalList">
				<!-- <div class="dqinfo">
					<div class="withpic">
						<div class="pic">
							<a href="#"><img src=""></a>
						</div>
						<div class="text">
							<h3>
								<a target="_blank" href="#"><span class="hua">案例</span>简介</a>
							</h3>
							<p>简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介</p>
						</div>
					</div>
					<div class="withpic">
						<div class="pic">
							<a href="#"><img src=""></a>
						</div>
						<div class="text">
							<h3>
								<a target="_blank" href="#"><span>案例</span>简介</a>
							</h3>
							<p>简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介</p>
						</div>
					</div>
				</div>
				<div class="dqinfo" style="margin-left: 300px;">
					<div class="withpic">
						<div class="pic">
							<a href="#"><img src=""></a>
						</div>
						<div class="text">
							<h3>
								<a target="_blank" href="#" class="red"><span class="hua">案例</span>简介</a>
							</h3>
							<p>简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介</p>
						</div>
					</div>
					<div class="withpic">
						<div class="pic">
							<a href="#"><img src=""></a>
						</div>
						<div class="text">
							<h3>
								<a target="_blank" href="#" class="red"><span class="hua">案例</span>简介</a>
							</h3>
							 <p>简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介</p>
						</div>
					</div>
				</div> -->
			</div>
		</div>
		<div style="width: 950px; position: relative; margin: 0 auto -30px;">
			<div class="title">
				<div class="titlepic">
					<img src="/STLVX_WEB/images/tu_icon.png">
				</div>
				<h6>图片库</h6>
				<a href="#"><img src="/STLVX_WEB/images/img-07.jpg"></a>
			</div>
			<div
				style="position: relative; margin: 40px auto 0; width: 950px; height: 150px; padding-top: 10px;">
				<div class="dq_picture_box">
					<div class="yc_studio_slider">
						<div id="slider">
							<ul>
								<li><img src="" alt="" width="212" height="159" /><a
									target="_blank" href="" class="img_mark nodis">图片</a></li>
								<li><img src="" alt="" width="212" height="159" /><a
									target="_blank" href="" class="img_mark nodis">图片</a></li>
								<li><img src="" alt="" width="212" height="159" /><a
									target="_blank" href="" class="img_mark nodis">图片</a></li>
								<li><img src="" alt="" width="212" height="159" /><a
									target="_blank" href="" class="img_mark nodis">图片</a></li>
								<li><img src="" alt="" width="212" height="159" /><a
									target="_blank" href="" class="img_mark nodis">图片</a></li>
							</ul> 
						</div>
					</div>
				</div>
			</div>
		</div>
		<div style="width: 950px; position: relative; margin: 0 auto 15px;">
			<div class="title">
				<div class="titlepic">
					<img src="/STLVX_WEB/images/hua_icon.png">
				</div>
				<h6>扩展学习</h6>
				<a href="#"><img src="/STLVX_WEB/images/img-07.jpg"></a>
			</div>
			<div
				style="position: relative; margin: 40px auto 0; width: 950px; height: 190px;"
				id="index_kzxxList">
				<!-- <div class="dqinfo">
					<div class="withpic">
						<div class="pic">
							<a href="#"><img src=""></a>
						</div>
						<div class="text">
							<h3>
								<a target="_blank" href="#"><span class="hua">案例</span>简介</a>
							</h3>
							<p>简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介</p>
						</div>
					</div>
					<div class="withpic">
						<div class="pic">
							<a href="#"><img src=""></a>
						</div>
						<div class="text">
							<h3>
								<a target="_blank" href="#"><span>案例</span>简介</a>
							</h3>
							<p>简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介</p>
						</div>
					</div>
				</div>
				<div class="dqinfo" style="margin-left: 300px;">
					<div class="withpic">
						<div class="pic"><a href="#"><img src=""></a></div>
						<div class="text">
							<h3>
								<a target="_blank" href="#" class="red"><span class="hua">案例</span>简介</a>
							</h3>
							<p>简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介</p>
						</div>
					</div>
					<div class="withpic">
						<div class="pic">
							<a href="#"><img src=""></a>
						</div>
						<div class="text">
							<h3>
								<a target="_blank" href="#" class="red"><span class="hua">案例</span>简介</a>
							</h3>
							<p>简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介</p>
						</div>
					</div>
				</div> -->
			</div>
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

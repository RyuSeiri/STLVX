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
<title>理论教学</title>
<link href="/STLVX_WEB/css/main.css" rel="stylesheet" type="text/css" />
<link href="/STLVX_WEB/css/scroll.css" rel="stylesheet" type="text/css" />
<script src="/STLVX_WEB/js/jquery-1.8.2.js" type="text/javascript"></script>
<script type="text/javascript" src="/STLVX_WEB/js/bar.js"></script>
</head>
<body
	style="background: url(/STLVX_WEB/images/bg_sea.jpg) no-repeat center top">
	<!-- <div class="yc_bg_flash flash-replaced" id="bgFlash" > -->
	<header class="yc_header">
		<script type="text/javascript"
			src="/STLVX_WEB/js/jcarousellite_index.js"></script>
		 <div class="index_banner" id="banner_tabs">
			<img class="shoolLog" src="/STLVX_WEB/images/schoolLog.png">
		</div>
	</header>
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
req.open("post", "<%=basePath%>Article.do?method=selectTheoryTeachingArticle&orderFlg=1");
req.setRequestHeader("accept", "application/json");
req.onreadystatechange = function() {
	if (req.readyState == 4 && req.status == 200) {
	  //alert(req.responseText);
		eval("var result=" + req.responseText);
		$("#zsdx").empty();
		$("#jg").empty();
		$("#ja").empty();
		$("#kj").empty();
		$("#sksp").empty();
		$("#xt").empty();
		for(var i=0;i<result.length;i++){
			if(result[i].iArticleKind==5){
			   var contents="<li><span>"+result[i].dMakeTime+"&nbsp;<a href='<%=basePath%>Article.do?method=selectEditerArticle&articleid="+result[i].sArticleId+"'>编辑</a>&nbsp;<a onclick='article_delete("+result[i].sArticleId+")' style='cursor: pointer'>删除</a></span>";
			   contents=contents+"<a href='<%=basePath%>Article.do?method=selectActicleByid&articleid="+result[i].sArticleId+"'>"+result[i].sTitle+"</a></li>";
				$("#zsdx").append(contents);	
			}
			if(result[i].iArticleKind==6){
				var contents="<li><span>"+result[i].dMakeTime+"&nbsp;<a href='<%=basePath%>Article.do?method=selectEditerArticle&articleid="+result[i].sArticleId+"'>编辑</a>&nbsp;<a onclick='article_delete("+result[i].sArticleId+")' style='cursor: pointer'>删除</a></span>";
				contents=contents+"<a  href='<%=basePath%>Article.do?method=selectActicleByid&articleid="+result[i].sArticleId+"'>"+result[i].sTitle+"</a></li>";
				$("#jg").append(contents);
			}
			if(result[i].iArticleKind==7){
				var contents="<li><span>"+result[i].dMakeTime+"&nbsp;<a href='<%=basePath%>Article.do?method=selectEditerArticle&articleid="+result[i].sArticleId+"'>编辑</a>&nbsp;<a onclick='article_delete("+result[i].sArticleId+")' style='cursor: pointer'>删除</a></span>";
				contents=contents+"<a  href='<%=basePath%>Article.do?method=selectActicleByid&articleid="+result[i].sArticleId+"'>"+result[i].sTitle+"</a></li>";
				$("#ja").append(contents);
			}
			if(result[i].iArticleKind==8){
				var contents= "<li><span>"+result[i].dMakeTime+"&nbsp;<a href='<%=basePath%>Article.do?method=selectEditerArticle&articleid="+result[i].sArticleId+"'>编辑</a>&nbsp;<a onclick='article_delete("+result[i].sArticleId+")' style='cursor: pointer'>删除</a></span>";
				if(null!=result[i].filepath&&result[i].filepath.length>0){
					contents=contents+"<a  href='<%=basePath%>Article.do?method=selectActicleByid&articleid="+result[i].sArticleId+"'>"+result[i].sTitle+"</a><input type='button' value='下载' onclick='fileDownLoad()'/><input id='filepath' type='hidden' value='"+result[i].filepath+"'/></li>";
				}else{
					contents=contents+"<a  href='<%=basePath%>Article.do?method=selectActicleByid&articleid="+result[i].sArticleId+"'>"+result[i].sTitle+"</a></li>";
				}
				$("#kj").append(contents);
			}
			if(result[i].iArticleKind==9){
				var contents="<li><span>"+result[i].dMakeTime+"&nbsp;<a href='<%=basePath%>Article.do?method=selectEditerArticle&articleid="+result[i].sArticleId+"'>编辑</a>&nbsp;<a onclick='article_delete("+result[i].sArticleId+")' style='cursor: pointer'>删除</a></span>";
				contents=contents+"<a  href='<%=basePath%>Article.do?method=selectvideoByid&articleid="+result[i].sArticleId+"'>"+result[i].sTitle+"</a></li>";
				$("#sksp").append(contents);
			}
			if(result[i].iArticleKind==10){
				var contents="<li><span>"+result[i].dMakeTime+"&nbsp;<a href='<%=basePath%>Article.do?method=selectEditerArticle&articleid="+result[i].sArticleId+"'>编辑</a>&nbsp;<a onclick='article_delete("+result[i].sArticleId+")' style='cursor: pointer'>删除</a></span>";
				contents=contents+"<a  href='<%=basePath%>Article.do?method=selectExercises&articleid="+ result[i].sArticleId + "'>"+ result[i].sTitle + "</a></li>";
						$("#xt").append(contents);
					}
				}
			}
		}
		req.send(null); 
</script>
	<script type="text/javascript">
function init(){
	var req = createAjaxObj();
	req.open("post", "<%=basePath%>Article.do?method=selectTheoryTeachingArticle&orderFlg=1");
	req.setRequestHeader("accept", "application/json");
	req.onreadystatechange = function() {
		if (req.readyState == 4 && req.status == 200) {
		  //alert(req.responseText);
			eval("var result=" + req.responseText);
			$("#zsdx").empty();
			$("#jg").empty();
			$("#ja").empty();
			$("#kj").empty();
			$("#sksp").empty();
			$("#xt").empty();
			for(var i=0;i<result.length;i++){
				if(result[i].iArticleKind==5){
				   var contents="<li><span>"+result[i].dMakeTime+"&nbsp;<a href='<%=basePath%>Article.do?method=selectEditerArticle&articleid="+result[i].sArticleId+"'>编辑</a>&nbsp;<a onclick='article_delete("+result[i].sArticleId+")' style='cursor: pointer'>删除</a></span>";
				   contents=contents+"<a href='<%=basePath%>Article.do?method=selectActicleByid&articleid="+result[i].sArticleId+"'>"+result[i].sTitle+"</a></li>";
					$("#zsdx").append(contents);	
				}
				if(result[i].iArticleKind==6){
					var contents="<li><span>"+result[i].dMakeTime+"&nbsp;<a href='<%=basePath%>Article.do?method=selectEditerArticle&articleid="+result[i].sArticleId+"'>编辑</a>&nbsp;<a onclick='article_delete("+result[i].sArticleId+")' style='cursor: pointer'>删除</a></span>";
					contents=contents+"<a  href='<%=basePath%>Article.do?method=selectActicleByid&articleid="+result[i].sArticleId+"'>"+result[i].sTitle+"</a></li>";
					$("#jg").append(contents);
				}
				if(result[i].iArticleKind==7){
					var contents="<li><span>"+result[i].dMakeTime+"&nbsp;<a href='<%=basePath%>Article.do?method=selectEditerArticle&articleid="+result[i].sArticleId+"'>编辑</a>&nbsp;<a onclick='article_delete("+result[i].sArticleId+")' style='cursor: pointer'>删除</a></span>";
					contents=contents+"<a  href='<%=basePath%>Article.do?method=selectActicleByid&articleid="+result[i].sArticleId+"'>"+result[i].sTitle+"</a></li>";
					$("#ja").append(contents);
				}
				if(result[i].iArticleKind==8){
					var contents= "<li><span>"+result[i].dMakeTime+"&nbsp;<a href='<%=basePath%>Article.do?method=selectEditerArticle&articleid="+result[i].sArticleId+"'>编辑</a>&nbsp;<a onclick='article_delete("+result[i].sArticleId+")' style='cursor: pointer'>删除</a></span>";
					if(null!=result[i].filepath&&result[i].filepath.length>0){
						contents=contents+"<a  href='<%=basePath%>Article.do?method=selectActicleByid&articleid="+result[i].sArticleId+"'>"+result[i].sTitle+"</a><input type='button' value='下载' onclick='fileDownLoad()'/><input id='filepath' type='hidden' value='"+result[i].filepath+"'/></li>";
					}else{
						contents=contents+"<a  href='<%=basePath%>Article.do?method=selectActicleByid&articleid="+result[i].sArticleId+"'>"+result[i].sTitle+"</a></li>";
					}
					$("#kj").append(contents);
				}
				if(result[i].iArticleKind==9){
					var contents="<li><span>"+result[i].dMakeTime+"&nbsp;<a href='<%=basePath%>Article.do?method=selectEditerArticle&articleid="+result[i].sArticleId+"'>编辑</a>&nbsp;<a onclick='article_delete("+result[i].sArticleId+")' style='cursor: pointer'>删除</a></span>";
					contents=contents+"<a  href='<%=basePath%>Article.do?method=selectvideoByid&articleid="+result[i].sArticleId+"'>"+result[i].sTitle+"</a></li>";
					$("#sksp").append(contents);
				}
				if(result[i].iArticleKind==10){
					var contents="<li><span>"+result[i].dMakeTime+"&nbsp;<a href='<%=basePath%>Article.do?method=selectEditerArticle&articleid="+result[i].sArticleId+"'>编辑</a>&nbsp;<a onclick='article_delete("+result[i].sArticleId+")' style='cursor: pointer'>删除</a></span>";
					contents=contents+"<a  href='<%=basePath%>Article.do?method=selectExercises&articleid="+ result[i].sArticleId + "'>"+ result[i].sTitle + "</a></li>";
							$("#xt").append(contents);
						}
					}
				}
			}
			req.send(null); 
}
</script>
	<script type="text/javascript">
	function article_delete(articleId){
		if(confirm("是否删除？")){
			var req = createAjaxObj();
			req.open("post", "<%=basePath%>Article.do?method=deleteByArticleId&articleId="+articleId);
			req.setRequestHeader("accept", "application/json");
			req.onreadystatechange = function() {
				if (req.readyState == 4 && req.status == 200) {
					//alert(req.responseText);
					eval("var result=" + req.responseText);
					if(result==1){
						init();
						alert("删除成功！");
					}else if(result==0){
						alert("删除失败！");
					}
				}
			}
			req.send(null);
		}else{
	          return false;
	   }
	}
</script>
	<script type="text/javascript">
function addArticle(){
	
}
</script>
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
				当前位置：<a href="index.jsp">首页</a> &gt; <a href="#">理论教学</a> &gt; <a
					href="#">知识导学</a>
			</div>
			<aside class="yc_left_box fl">
				<div class="yc_left_title">理论教学</div>
				<div class="yc_left_list">
					<ul>
						<li id="zsdxt">知识导学</li>
						<li id="jgt">讲稿</li>
						<li id="jat">教案</li>
						<li id="kjt">课件</li>
						<li id="skspt">授课视频</li>
						<li id="xtt">习题</li>
					</ul>
				</div>
				<div class="<!-- boxImg -->">
					<img src="/STLVX_WEB/images/img_left_shadow_bot.png" alt=""
						width="206" height="180">
				</div>
			</aside>
			<div class="yc_right_box fl">

				<div id="2jtitle" class="yc_right_title0">
					<span style="float: left;">知识导学</span>
					<div class="gradient_line"></div>
				</div>
				<div
					style="float: right; display: block; height: 32px; padding: 20px 0 0 10px; color: #0083d7; z-index: 0; position: inherit;">
					<input type="button" onclick="addArticle()" value="添加文章" />
				</div>
				<div class="gradient_line"></div>
				<div class="yc_right_comlist">
					<ul id="zsdx">
						<li><span>2016-7-22</span><a target="_blank"
							href="/showxxgk.aspx?Id=114523&amp;ctlgid=264622">知识导学</a></li>
					</ul>
					<ul id="jg" style="display: none">
						<li><span>2016-7-22</span><a target="_blank"
							href="/showxxgk.aspx?Id=114523&amp;ctlgid=264622">讲稿</a></li>
					</ul>
					<ul id="ja" style="display: none">
						<li><span>2016-7-22</span><a target="_blank"
							href="/showxxgk.aspx?Id=114523&amp;ctlgid=264622">教案</a></li>
					</ul>
					<ul id="kj" style="display: none">
						<li><span>2016-7-22</span><a target="_blank"
							href="/showxxgk.aspx?Id=114523&amp;ctlgid=264622">课件</a><input
							type="button" value="下载" /></li>
					</ul>
					<ul id="sksp" style="display: none">
						<li><span>2016-7-22</span><a target="_blank"
							href="/showxxgk.aspx?Id=114523&amp;ctlgid=264622">授课视频</a></li>
					</ul>
					<ul id="xt" style="display: none">
						<li><span>2016-7-22</span><a target="_blank"
							href="/showxxgk.aspx?Id=114523&amp;ctlgid=264622">习题</a></li>
					</ul>
					<script type="text/javascript" charset="utf-8">
                        $("#zsdxt").click(function(){
                            // alert("点击");
                            $("#2jtitleupload").hide();
                            $("#2jtitleupload1").hide();
                            $("#zsdx").show();
                            $("#jg").hide();
                            $("#kj").hide();
                            $("#sksp").hide();
                            $("#xt").hide();
                            $("#ja").hide();
                            $("#local").html("当前位置：<a href='${pageContext.request.contextPath}/Admin/index.jsp">首页'>首页</a> &gt; <a href='#'>理论教学</a> &gt; <a href='#'>知识导学</a>");
                            $("#2jtitle").html("<span>知识导学</span>");
                            $("#2jtitle").show();
                        })
                        $("#jgt").click(function() {
                            $("#2jtitleupload").hide();
                            $("#2jtitleupload1").hide();
                            $("#zsdx").hide();
                            $("#jg").show();
                            $("#kj").hide();
                            $("#sksp").hide();
                            $("#xt").hide();
                            $("#ja").hide();
                            $("#local").html("当前位置：<a href='${pageContext.request.contextPath}/Admin/index.jsp">首页'>首页</a> &gt; <a href='#'>理论教学</a> &gt; <a href='#'>讲稿</a>");
                            $("#2jtitle").html("<span>讲稿</span>");
                            $("#2jtitle").show();
                        });
                        $("#kjt").click(function() {
                            $("#2jtitleupload").show();
                            $("#2jtitleupload1").hide();
                            $("#2jtitle").hide();
                            $("#zsdx").hide();
                            $("#jg").hide();
                            $("#kj").show();
                            $("#sksp").hide();
                            $("#xt").hide();
                            $("#ja").hide();
                            $("#local").html("当前位置：<a href='${pageContext.request.contextPath}/Admin/index.jsp">首页'>首页</a> &gt; <a href='#'>理论教学</a> &gt; <a href='#'>课件</a>");
                            
                        });
                        $("#skspt").click(function() {
                            $("#2jtitleupload1").show();
                            $("#2jtitleupload").hide();
                            $("#2jtitle").hide();
                            $("#zsdx").hide();
                            $("#jg").hide();
                            $("#kj").hide();
                            $("#sksp").show();
                            $("#xt").hide();
                            $("#ja").hide();
                            $("#local").html("当前位置：<a href='${pageContext.request.contextPath}/Admin/index.jsp">首页'>首页</a> &gt; <a href='#'>理论教学</a> &gt; <a href='#'>授课视频</a>");
                        });
                        $("#xtt").click(function() {
                            $("#2jtitleupload").hide();
                            $("#2jtitleupload1").hide();
                            $("#zsdx").hide();
                            $("#jg").hide();
                            $("#kj").hide();
                            $("#sksp").hide();
                            $("#xt").show();
                            $("#ja").hide();
                            $("#local").html("当前位置：<a href='${pageContext.request.contextPath}/Admin/index.jsp">首页'>首页</a> &gt; <a href='#'>理论教学</a> &gt; <a href='#'>习题</a>");
                            $("#2jtitle").html("<span>习题</span>");
                            $("#2jtitle").show();
                        });
                        $("#jat").click(function() {
                            $("#2jtitleupload").hide();
                            $("#2jtitleupload1").hide();
                            $("#zsdx").hide();
                            $("#jg").hide();
                            $("#kj").hide();
                            $("#sksp").hide();
                            $("#xt").hide();
                            $("#ja").show();
                            $("#local").html("当前位置：<a href='${pageContext.request.contextPath}/Admin/index.jsp">首页'>首页</a> &gt; <a href='#'>理论教学</a> &gt; <a href='#'>教案</a>");
                            $("#2jtitle").html("<span>教案</span>");
                            $("#2jtitle").show();
                        });
                    </script>
					<script type="text/javascript">
                   <%String msg=(String)request.getAttribute("msg");
                       if(msg!=null&&msg!=""){%>
                    alert("${msg}");<%} %>
                   </script>
				</div>
			</div>
			<div class="yc_shadow_bot boxImg">
				<img src="" width="1000" height="0">
			</div>
			<footer class="yc_footer">
				<div class="yc_flinks">
					<a href="#">关于本站</a> | <a href="#">使用帮助</a> | <a href="#">联系我们</a>
					| <a href="#">网站声明</a> | <a href="#">设为首页</a> | <a href="#">收藏本站</a>
				</div>
				<div class="yc_copyright">
					版权所有&copy;<a href="http://www.nddq.gov.cn/">XXXXX</a>
					Copyright&copy;20016-2016 All Rights Reserved<br>
					主办：沈阳农业大学XXXX<br> 您是本站第<span>000000</span>位访客 ICP备00000000号
				</div>
			</footer>
		</div>
		<!--yc_content_inner-->
	</div>
</body>
</html>
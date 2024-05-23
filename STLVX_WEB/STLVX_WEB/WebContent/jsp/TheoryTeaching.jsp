<%@page import="java.util.Date"%>
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
<script src="/STLVX_WEB/js/jquery.sudoSlider.min.js"></script>
<script type="text/javascript" src="/STLVX_WEB/js/bar.js"></script>
<script type="text/javascript" src="/STLVX_WEB/js/PopUp.js"></script>
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
	function videofilejude(){
		 var filePath = $("#video").val();
		 var sTitle=$("#sVideoTitle").val();
		 if(sTitle.length<1){
			 alert("请输入文件的标题");
			 return false;
		 }
		 if(filePath.length < 1){
		  alert("请选择要上传的视频文件");
		  return false ;
		 }else{
			 var fileLx = filePath.toString().substring(filePath.toString().lastIndexOf(".")+1) ;
			  if(fileLx== "mp4" || fileLx == "swf"
					  || fileLx== "MP4" ||fileLx== "SWF" ){
				  $("#videos").submit();				  
			  }else{
				  alert("只支持mp4、swf 格式的视频文件！");
				   return false ; 
				 }
		 }
	}
	</script>
	<script type="text/javascript">
	function filejude(){
		 var filePath = $("#file").val();
		 var sTitle=$("#sCourseTitle").val();
		 if(sTitle.length<1){
			 alert("请输入文件的标题");
			 return false;
		 }
		 if(filePath.length < 1){
		  alert("请选择要上传的文件");
		  return false ;
		 }else{
			 var fileLx = filePath.toString().substring(filePath.toString().lastIndexOf(".")+1) ;
			  /* if(fileLx== "pptx" || fileLx == "ppt" || fileLx == "txt" ||fileLx == "doc" || fileLx=="docx"
				|| fileLx== "PPTX" || fileLx== "PPT" || fileLx== "TXT" ||fileLx== "DOC" ||fileLx== "DOCX"){ */
				 if(fileLx== "mp4" || fileLx == "swf"
					  || fileLx== "MP4" ||fileLx== "SWF"){
				  $("#files").submit();				  
			  }else{
				  /* alert("只支持ppt、pptx、txt、doc、docx格式的视频文件！"); */
				  alert("只支持mp4、swf 格式的视频文件！");
				   return false ; 
				 }
		 }
	}
	</script>

	<script type="text/javascript">
	function fileDownLoad(articleId){
		var form=document.getElementById("filedownload");
		form.action="<%=basePath%>file.do?method=filedownload&articleId="+articleId;
		form.submit();
	}
	</script>
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
					<%-- <ul>
						<li><a href="${pageContext.request.contextPath}/jsp/">外国国家公园系列</a></li>
						<li><a href="${pageContext.request.contextPath}/jsp/">中国国家森林公园</a></li>
					</ul> --%></li>
				<li><a
					href="${pageContext.request.contextPath}/jsp/Question.jsp">互动教学</a>
				</li>
			</ul>
		</div>
	</div>
	<script type="text/javascript"> 
$(document).ready(function(){
	$("#zsdx").empty();
	$("#jg").empty();
	$("#ja").empty();
	$("#kj").empty();
	$("#sksp").empty();
	$("#xt").empty();
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
				当前位置：<a href="${pageContext.request.contextPath}/jsp/index.jsps">首页</a>
				&gt; <a href="#">理论教学</a> &gt; <a href="#">知识导学</a>
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
				<!-- <span style="margin: 30px 0 0 600px"><input  type="button" id="orderFlg" value="排序" style="width:80px;"/></span> -->
				<div id="2jtitle" class="yc_right_title0">
					<span style="float: left;">知识导学</span>
					<div class="gradient_line"></div>
				</div>
				<div id="2jtitleupload" class="yc_right_title0"
					style="display: none;">
					<span style="float: left;">
						<!-- 课件 -->
					</span>
					<div
						style="float: right; display: block; height: 32px; padding: 20px 0 0 10px; color: #0083d7; z-index: 0; position: inherit;">
						<form id="files"
							action="${pageContext.request.contextPath}/file.do?method=uploadFile&time=<%=new Date().getTime()%>"
							method="post" enctype="multipart/form-data">
							请输入上传文件的标题：<input size="10" type="text" name="sCourseTitle"
								id="sCourseTitle">请选择上传的文件：<input size="10" type="file"
								name="file" id="file" /> <input type="button"
								onclick="filejude()" value="上传" />
						</form>
					</div>
					<div class="gradient_line"></div>
				</div>
				<div id="2jtitleupload1" class="yc_right_title0"
					style="display: none;">
					<span style="float: left; size: 1px">
						<!-- 授课视频 -->
					</span>
					<div
						style="float: right; display: block; height: 32px; padding: 20px 0 0 10px; color: #0083d7; z-index: 0; position: inherit;">
						<form id="videos"
							action="${pageContext.request.contextPath}/file.do?method=videoFileAdd&time=<%=new Date().getTime()%>"
							method="post" enctype="multipart/form-data">
							请输入上传文件的标题：<input size="10" type="text" name="sVideoTitle"
								id="sVideoTitle">请选择上传的文件：<input size="10" type="file"
								name="video" id="video" /> <input type="button"
								onclick="videofilejude()" value="上传" />
						</form>
					</div>
					<div class="gradient_line"></div>
				</div>
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
					<form id="filedownload" method='post' action=""></form>
					<ul id="kj" style="display: none">
						<li><span>2016-7-22</span><a target="_blank"
							href="/showxxgk.aspx?Id=114523&amp;ctlgid=264622">课件</a><input
							type="button" value="下载" /></li>

					</ul>
					<ul id="sksp" style="display: none">

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
                            $("#local").html("当前位置：<a href='${pageContext.request.contextPath}/jsp/index.jsp'>首页</a> &gt; <a href='#'>理论教学</a> &gt; <a href='#'>知识导学</a>");
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
                            $("#local").html("当前位置：<a href='${pageContext.request.contextPath}/jsp/index.jsp'>首页</a> &gt; <a href='#'>理论教学</a> &gt; <a href='#'>讲稿</a>");
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
                            $("#local").html("当前位置：<a href='${pageContext.request.contextPath}/jsp/index.jsp'>首页</a> &gt; <a href='#'>理论教学</a> &gt; <a href='#'>课件</a>");
                            
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
                            $("#local").html("当前位置：<a href='${pageContext.request.contextPath}/jsp/index.jsp'>首页</a> &gt; <a href='#'>理论教学</a> &gt; <a href='#'>授课视频</a>");
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
                            $("#local").html("当前位置：<a href='${pageContext.request.contextPath}/jsp/index.jsp'>首页</a> &gt; <a href='#'>理论教学</a> &gt; <a href='#'>习题</a>");
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
                            $("#local").html("当前位置：<a href='${pageContext.request.contextPath}/jsp/index.jsp'>首页</a> &gt; <a href='#'>理论教学</a> &gt; <a href='#'>教案</a>");
                            $("#2jtitle").html("<span>教案</span>");
                            $("#2jtitle").show();
                        });
                    </script>
					<script type="text/javascript">
                   <%String msg=(String)request.getAttribute("msg");
                       if(msg!=null&&msg!=""){%>
                    alert("${msg}");<%} %>
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
req.open("post", "<%=basePath%>Article.do?method=selectTheoryTeachingArticle&orderFlg=1");
req.setRequestHeader("accept", "application/json");
req.onreadystatechange = function() {
	if (req.readyState == 4 && req.status == 200) {
	  //alert(req.responseText);
		eval("var result=" + req.responseText);
		for(var i=0;i<result.length;i++){
			if(result[i].iArticleKind==5){
			   var contents="<li><span>"+result[i].dMakeTime+"</span>";
			   contents=contents+"<a href='<%=basePath%>Article.do?method=selectActicleByid&articleid="+result[i].sArticleId+"'>"+result[i].sTitle+"</a></li>";
				$("#zsdx").append(contents);	
			}
			if(result[i].iArticleKind==6){
				var contents="<li><span>"+result[i].dMakeTime+"</span>";
				contents=contents+"<a  href='<%=basePath%>Article.do?method=selectActicleByid&articleid="+result[i].sArticleId+"'>"+result[i].sTitle+"</a></li>";
				$("#jg").append(contents);
			}
			if(result[i].iArticleKind==7){
				var contents="<li><span>"+result[i].dMakeTime+"</span>";
				contents=contents+"<a  href='<%=basePath%>Article.do?method=selectActicleByid&articleid="+result[i].sArticleId+"'>"+result[i].sTitle+"</a></li>";
				$("#ja").append(contents);
			}
			if(result[i].iArticleKind==8){
				var contents= "<li><span>"+result[i].dMakeTime+"</span>";
				if(null!=result[i].filepath&&result[i].filepath.length>0){
  					contents=contents+"<a  href='<%=basePath%>Article.do?method=selectvideoByid&articleid="+result[i].sArticleId+"'>"+result[i].sTitle+"</a><input type='button' value='下载' onclick='fileDownLoad("+result[i].sArticleId+")'/></li>";
  				}else{
  					contents=contents+"<a  href='<%=basePath%>Article.do?method=selectvideoByid&articleid="+result[i].sArticleId+"'>"+result[i].sTitle+"</a></li>";
  				}
				$("#kj").append(contents);
			}
			if(result[i].iArticleKind==9){
				var contents="<li><span>"+result[i].dMakeTime+"</span>";
				if(null!=result[i].filepath&&result[i].filepath.length>0){
  					contents=contents+"<a  href='<%=basePath%>Article.do?method=selectvideoByid&articleid="+result[i].sArticleId+"'>"+result[i].sTitle+"</a><input type='button' value='下载' onclick='fileDownLoad("+result[i].sArticleId+")'/></li>";
  				}else{
  					contents=contents+"<a  href='<%=basePath%>Article.do?method=selectvideoByid&articleid="+result[i].sArticleId+"'>"+result[i].sTitle+"</a></li>";
  				}				
				$("#sksp").append(contents);
			}
			if(result[i].iArticleKind==10){
				var contents="<li><span>"+result[i].dMakeTime+"</span>";
				contents=contents+"<a  href='<%=basePath%>Article.do?method=selectExercises&articleid="+ result[i].sArticleId + "'>"+ result[i].sTitle + "</a></li>";
						$("#xt").append(contents);
					}
				}
			}
		}
		req.send(null); 

	</script>
			</div>
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

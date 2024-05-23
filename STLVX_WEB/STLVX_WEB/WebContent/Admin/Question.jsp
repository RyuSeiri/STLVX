<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Date"%>
<% 
String path = request.getContextPath(); 
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/"; 
%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>互动教学</title>
<link rel="stylesheet" type="text/css" href="/STLVX_WEB/css/uicss.css">
<link href="/STLVX_WEB/css/main.css" rel="stylesheet" type="text/css" />
<link href="/STLVX_WEB/css/scroll.css" rel="stylesheet" type="text/css" />
<script src="/STLVX_WEB/js/jquery-1.8.2.js" type="text/javascript"></script>
<script src="/STLVX_WEB/js/jquery.sudoSlider.min.js"></script>
<script type="text/javascript" src="/STLVX_WEB/js/bar.js"></script>
<script type="text/javascript" src="/STLVX_WEB/js/PopUp.js"></script>
    <style type="text/css">
        body,a{ font-size: 14px; color: #555;}
        .wordCount{ position:relative;width: 600px;height: 300px; }
        .wordCount textarea{ width: 100%; height: 100px;}
        .wordCount .wordwrap{ position:absolute; right: 6px; top: 106px;}
        .wordCount .word{ color: red; padding: 0 4px;;}
    </style>
</head>
<body style="background:url(/STLVX_WEB/images/bg_sea.jpg) no-repeat center top">
    <!-- <div class="yc_bg_flash flash-replaced" id="bgFlash" > -->
    <header class="yc_header">
        <script type="text/javascript" src="/STLVX_WEB/js/jcarousellite_index.js"></script>
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
$(document).ready(function(){
	var req = createAjaxObj();
	req.open("post", "<%=basePath%>Article.do?method=selectPageCount");
	req.setRequestHeader("accept", "application/json");
	req.onreadystatechange = function() {
		if (req.readyState == 4 && req.status == 200) {
		  // alert(req.responseText);
			eval("var results=" + req.responseText);
			var contents="<span style='line-height:22px;'>当前第<b id='curentPage'>1</b>/<b>"+results+"</b>页&nbsp;&nbsp;&nbsp;</span><span class='pagebox_pre'><a onclick='chagePage("+1+")'>第一页</a></span>";
			for(var i=0;i<results;i++){
				contents+="<span class='pagebox_num'><a onclick='chagePage("+(i+1)+")' target='_self'>"+(i+1)+"</a></span>";
			} 
			contents+="<span class='pagebox_next'><a onclick='chagePage("+results+")'>最末页</a></span>";
			$("#pagebox").html(contents);
		}
	}
	req.send(null);

});
	</script> 
	<script type="text/javascript">
	function chagePage(page){
		var req = createAjaxObj();
		req.open("post", "<%=basePath%>Article.do?method=selectQuestionAndReply&page="+page);
		req.setRequestHeader("accept", "application/json");
		req.onreadystatechange = function() {
			if (req.readyState == 4 && req.status == 200) {
				//alert(req.responseText);
				eval("var result=" + req.responseText);
				$('#nei').html('');
				for(var i=0;i<result.length;i++){
					if(result[i].contentType==1){
					var contents="<li class='item cl'> <div class='avatar size-L radius'><img src='/STLVX_WEB/images/avatar-default.jpg'></div>";
						contents=contents+"<div class='comment-main'>";
						contents=contents+"<header class='comment-header'>";
						contents=contents+"<div class='comment-meta'><a class='comment-author' >老师：</a> 发表于 "+result[i].time+"</div><a style='color: red' onclick='article_delete("+result[i].contentId+","+page+")'>删除</a>";
						contents=contents+"</header><div class='comment-body'>";
						contents=contents+"<p>"+result[i].content+"</p></div></div></li>";
						$('#nei').append(contents);	
					}else{
			        var contents="<li class='item cl comment-flip'> <div class='avatar size-L radius'><img src='/STLVX_WEB/images/avatar-default.jpg'></div>";
						contents=contents+"<div class='comment-main'>";
						contents=contents+"<header class='comment-header'>";
						contents=contents+"<div class='comment-meta'><a class='comment-author'>学生：</a> 发表于 "+result[i].time+"</div><a style='color: red' onclick='article_delete("+result[i].contentId+","+page+")'>删除</a>";
						contents=contents+"</header><div class='comment-body'>";
						contents=contents+"<p>"+result[i].content+"</p></div></div></li>";
						$('#nei').append(contents);	
					}
					$("#curentPage").html(page);
					
				}
			}
		}
		req.send(null);
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
	req.open("post", "<%=basePath%>Article.do?method=selectQuestionAndReply&page=1");
	req.setRequestHeader("accept", "application/json");
	req.onreadystatechange = function() {
		if (req.readyState == 4 && req.status == 200) {
			//alert(req.responseText);
			eval("var result=" + req.responseText);
			$('#nei').html('');
			for(var i=0;i<result.length;i++){
				if(result[i].contentType==1){
				var contents="<li class='item cl'> <div class='avatar size-L radius'><img src='/STLVX_WEB/images/avatar-default.jpg'></div>";
					contents=contents+"<div class='comment-main'>";
					contents=contents+"<header class='comment-header'>";
					contents=contents+"<div class='comment-meta'><a class='comment-author' >老师：</a> 发表于 "+result[i].time+"</div><a style='color: red' onclick='article_delete("+result[i].contentId+",1)'>删除</a>";
					contents=contents+"</header><div class='comment-body'>";
					contents=contents+"<p>"+result[i].content+"</p></div></div></li>";
					$('#nei').append(contents);	
				}else{
		        var contents="<li class='item cl comment-flip'><div class='avatar size-L radius'><img src='/STLVX_WEB/images/avatar-default.jpg'></div>";
					contents=contents+"<div class='comment-main'>";
					contents=contents+"<header class='comment-header'>";
					contents=contents+"<div class='comment-meta'><a class='comment-author'>学生：</a> 发表于 "+result[i].time+"</div><a style='color: red' onclick='article_delete("+result[i].contentId+",1)'>删除</a>";
					contents=contents+"</header><div class='comment-body'>";
					contents=contents+"<p>"+result[i].content+"</p></div></div></li>";
					$('#nei').append(contents);	
				}
			}
		}
	}
	req.send(null);
	</script>
	<script type="text/javascript">
	function article_delete(contentId,page){
		if(confirm("是否删除？")){
			var req = createAjaxObj();
			//alert(contentId+","+page)
			req.open("post", "<%=basePath%>Article.do?method=deleteBycontentId&contentId="+contentId);
			req.setRequestHeader("accept", "application/json");
			req.onreadystatechange = function() {
				if (req.readyState == 4 && req.status == 200) {
					//alert(req.responseText);
					eval("var result=" + req.responseText);
					if(result==1){
						chagePage(page);/*刷新页面用 */
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
	<!-- </div> -->
    	<div style="height:40px;width:1020px;background:#02A73F;box-shadow:1px 1px 7px #999;position:absolute;top:200px;z-index:99;left:49.4%;margin-left: -498px;">
		<div class="col960">
			<ul id="navul" class="cl">
				<li class="navhome"><a href="${pageContext.request.contextPath}/Admin/index.jsp">首页</a></li>
				<li >
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
						<li><a href="${pageContext.request.contextPath}/jsp/">外国国家公园系列</a></li>
						<li><a href="${pageContext.request.contextPath}/jsp/">中国国家森林公园</a></li>
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
<script type="text/javascript">
function conmmit(){
	var wordCount = $("#wordCount"),
    textArea = wordCount.find("textarea"),
     word = wordCount.find(".word");
	var curLength = textArea.val().length;
	if(curLength==0){
		alert("提问的问题不能为空")
		return false;
	}
	 if(curLength>200){
		 alert("问题的字数不能超过200字")
		 return false;
	 }if(curLength>0&&curLength<=200){
		 var form=document.getElementById("Reply");
			form.action="<%=basePath%>Article.do?method=addReply&time=<%=new Date().getTime()%>";
			form.submit();
	 }
}
</script>
 <div style="width:1015px;position: relative;margin: 0 auto 0px;box-shadow:1px 1px 7px #999;padding: 8px">
	<h1 class="page_title"  style="font-size:22px;margin: 30px 100px 50px 10px">问题</h1>
        <div >
          <ul class="commentList" id="nei">
           <!--  <li class="item cl"> 
            <div class="avatar size-L radius"><img src="/STLVX_WEB/images/avatar-default.jpg"></div>
              <div class="comment-main">
                <header class="comment-header">
                  <div class="comment-meta"><a class="comment-author" >老师：</a> 发表于 2014-8-31 15:20 </div>
                </header>
                <div class="comment-body">
                  <p> 你是猴子派来的救兵来恶心我的吗？你是猴子派来的救兵来恶心我的吗？你是猴子派来的救兵来恶心我的吗？你是猴子派来的救兵来恶心我的吗？你是猴子派来的救兵来恶心我的吗？你是猴子派来的救兵来恶心我的吗？你是猴子派来的救兵来恶心我的吗？你是猴子派来的救兵来恶心我的吗？你是猴子派来的救兵来恶心我的吗？你是猴子派来的救兵来恶心我的吗？你是猴子派来的救兵来恶心我的吗？你是猴子派来的救兵来恶心我的吗？</p>
                </div>
              </div>
            </li>
            <li class="item cl comment-flip"> 
            <div class="avatar size-L radius"><img src="/STLVX_WEB/images/avatar-default.jpg"></div>
              <div class="comment-main">
                <header class="comment-header">
                  <div class="comment-meta"><a class="comment-author">学生：</a> 发表于 2014-8-31 15:20
                  </div>
                </header>
                <div class="comment-body">
                  <p> 你是猴子派来的救兵来恶心我的吗？你是猴子派来的救兵来恶心我的吗？你是猴子派来的救兵来恶心我的吗？你是猴子派来的救兵来恶心我的吗？你是猴子派来的救兵来恶心我的吗？你是猴子派来的救兵来恶心我的吗？你是猴子派来的救兵来恶心我的吗？你是猴子派来的救兵来恶心我的吗？你是猴子派来的救兵来恶心我的吗？你是猴子派来的救兵来恶心我的吗？你是猴子派来的救兵来恶心我的吗？你是猴子派来的救兵来恶心我的吗？</p>
                </div>
              </div>
            </li> -->
            <!-- <li class="item cl"> <a href="#"><i class="avatar size-L radius"><img alt="" src="/STLVX_WEB/images/avatar-default.jpg"></i></a>
              <div class="comment-main">
                <header class="comment-header">
                  <div class="comment-meta"><a class="comment-author" >老师：</a> 发表于 2014-8-31 15:20 </div>
                </header>
                <div class="comment-body">
                  <p> 你是猴子派来的救兵来恶心我的吗？你是猴子派来的救兵来恶心我的吗？你是猴子派来的救兵来恶心我的吗？你是猴子派来的救兵来恶心我的吗？你是猴子派来的救兵来恶心我的吗？你是猴子派来的救兵来恶心我的吗？你是猴子派来的救兵来恶心我的吗？你是猴子派来的救兵来恶心我的吗？你是猴子派来的救兵来恶心我的吗？你是猴子派来的救兵来恶心我的吗？你是猴子派来的救兵来恶心我的吗？你是猴子派来的救兵来恶心我的吗？</p>
                </div>
              </div>
            </li>
            <li class="item cl comment-flip"> <div class="avatar size-L radius"><img alt="" src="/STLVX_WEB/images/avatar-default.jpg"></div>
              <div class="comment-main">
                <header class="comment-header">
                  <div class="comment-meta"><a class="comment-author">学生：</a> 发表于 2014-8-31 15:20
                  </div>
                </header>
                <div class="comment-body">
                  <p> 你是猴子派来的救兵来恶心我的吗？你是猴子派来的救兵来恶心我的吗？你是猴子派来的救兵来恶心我的吗？你是猴子派来的救兵来恶心我的吗？你是猴子派来的救兵来恶心我的吗？你是猴子派来的救兵来恶心我的吗？你是猴子派来的救兵来恶心我的吗？你是猴子派来的救兵来恶心我的吗？你是猴子派来的救兵来恶心我的吗？你是猴子派来的救兵来恶心我的吗？你是猴子派来的救兵来恶心我的吗？你是猴子派来的救兵来恶心我的吗？</p>
                </div>
              </div>
            </li> -->
          </ul>
        </div>
		<!--  <span style="margin:88px 50px 15px 130px;">发表问题</span> -->
        <div class="wordCount" id="wordCount">
        <form method="post" action=""  id="Reply">
            <textarea style="height: 100px;width: 500px;margin:140px 50px 15px 100px;padding: 22" placeholder="描述你的问题，200字以内" id="contents"  name="contents" style="height: 100px;width: 800px"></textarea>
            <span  style="margin: 0px 50px 1500px 100px;"><span><input style="height: 25px;width: 45px" type="button" onclick="conmmit()" value="提交"></span>
           <var style="margin-left: 335px " class="word">200</var>/200</span>
		</form>
        </div>
        <span id="clock"></span>
        <script type="text/javascript">
        $(function(){
           var wordCount = $("#wordCount"),
           textArea = wordCount.find("textarea"),
            word = wordCount.find(".word");
            //调用
            statInputNum(textArea,word);  
            }); 
            /*
            * 剩余字数统计
            * 注意 最大字数只需要在放数字的节点哪里直接写好即可 如：<var class="word">200</var>
            */
            function statInputNum(textArea,numItem) {
                var max = numItem.text(),
                curLength;
                textArea[0].setAttribute("maxlength", max);
                curLength = textArea.val().length;
                numItem.text(max - curLength);
                textArea.on('input propertychange', function () {
                numItem.text(200 - $(this).val().length);
                });
            } 
        </script>
          <script type="text/javascript">
                   <%String msg=(String)request.getAttribute("msg");
                       if(msg!=null&&msg!=""){%>
                    alert("${msg}");<%} %>
           </script>
      <div class="pagebox" id="pagebox"><span style="line-height:22px;">当前第<b>1</b>/<b>3</b>页&nbsp;&nbsp;&nbsp;</span><span class="pagebox_pre"><a >第一页</a></span><span class="pagebox_pre"><a onclick="prePage(page-1)">上一页</a></span><span class="pagebox_num_nonce">1</span><span class="pagebox_num"><a  target="_self">2</a></span><span class="pagebox_next"><a target="_self" onclick="nextPage(page+1)">下一页</a></span><span class="pagebox_next"><a onclick="chagePage()">最末页</a></span></div>
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
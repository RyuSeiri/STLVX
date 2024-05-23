<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
	String htmlData = request.getParameter("content") != null ? request.getParameter("content") : "";
%>
<% 
String path = request.getContextPath(); 
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/"; 
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>添加首页动态图片</title>
<link rel="stylesheet" href="/STLVX_WEB/css/themes/default/default.css" />
<link rel="stylesheet" href="/STLVX_WEB/css/prettify.css" />
<link href="/STLVX_WEB/css/editer.css" rel="stylesheet" type="text/css" />
<script charset="utf-8" src="/STLVX_WEB/js/kindeditor-all-min.js"></script>
<script charset="utf-8" src="/STLVX_WEB/js/zh_CN.js"></script>
<script charset="utf-8" src="/STLVX_WEB/js/prettify.js"></script>
<script charset="utf-8" type="text/javascript" src="/STLVX_WEB/js/jquery-1.8.2.js"></script>
<script  type="text/javascript">
function createAjaxObj() {
	var req;
	if (window.XMLHttpRequest) {
		req = new XMLHttpRequest();
	} else {
		req = new ActiveXObject("Msxml2.XMLHTTP"); 
	}
	return req;
}	

	var editor1;
	KindEditor.ready(function(K) {
		editor1 = K.create('textarea[name="content",id="content"]', {
			cssPath : '/STLVX_WEB/css/prettify.css',
			uploadJson : '<%=basePath%>file_upload.do',
			fileManagerJson : '<%=basePath%>file_manager.do',
			allowFileManager : true,
			afterCreate : function() {
				var self = this;
				K.ctrl(document, 13, function() {
					//self.sync();
					//document.forms['contentCommit'].submit();
				});
				K.ctrl(self.edit.doc, 13, function() {
					//self.sync();
					//document.forms['contentCommit'].submit();
				});
			}
		});
		prettyPrint();
	});
</script>
<script charset="utf-8" type="text/javascript">
var editor1;
function editArticle() {
	var req = createAjaxObj();
	editor1.sync();
	var content = $("#content").val();
	//alert(content)
	$.ajax({
		url : "<%=basePath%>Article.do?method=addDynamicPicture",
	    type:"POST",
	    data:{
	    	content : content,
	    },
	   //dataType:"json",
	    //timeout:5000,
	    success:function (result) {
	    	if(result==1){
				alert("操作成功！");
			}else if(result==0){
				alert("操作失败！");
			}
	    },
	    error:function (data) {
	        alert("操作失败！");
	    }
	});
}
</script>
</head>
<body>
<div id="mainDiv">
	<div id="topDiv">
	<div id="tmenu"><ul>
	<li ><a href="${pageContext.request.contextPath}/Admin/index.jsp">首页</a></li>
	<li ><a href="#" onclick="javascript :history.back(-1);">返回</a></li>
	</ul></div></div>
	<div id="centerDiv">
	<div id="left">
	<div id="lhead">管理菜单</div>
	<ul>
	<li ><a href="<%=basePath%>Article.do?method=selectDeleteDynamicPicture">删除首页动态图片</a></li>
	<li ><a href="${pageContext.request.contextPath}/Admin/addChapter.jsp">添加文章的章节</a></li>
	<li ><a href="${pageContext.request.contextPath}/Admin/deleteChapter.jsp">删除文章的章节</a></li>
	</ul>
	</div>
	<div id="right"> 
	<div id="current">&nbsp;&nbsp;&nbsp;&nbsp;当前位置:添加首页图片情页</div>
<div id="form">
<form action="" method="post" id="contentCommit">
		<!-- <b>选择您要编辑的内容:</b> -->
	  <%=htmlData%>
	<textarea name="content" id="content" style="width: 500px; height: 300px;"><%=htmlspecialchars(htmlData)%></textarea>
 <br> 	<input style="margin: 0 0 0 30px" type="button" name="button" value="提交"onclick="editArticle();" />
</form>
</div>
</div>
</div>
<div id="bottomDiv"></div>
</div>
</body>
</html>
<%!private String htmlspecialchars(String str) {
		str = str.replaceAll("&", "&amp;");
		str = str.replaceAll("<", "&lt;");
		str = str.replaceAll(">", "&gt;");
		str = str.replaceAll("\"", "&quot;");
		return str;
	}%>
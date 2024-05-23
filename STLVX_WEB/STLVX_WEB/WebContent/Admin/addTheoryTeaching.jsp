﻿<%@page import="java.util.Date"%>
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
<title>添加理论教学文章页</title>
<link rel="stylesheet" href="/STLVX_WEB/css/themes/default/default.css" />
<link rel="stylesheet" href="/STLVX_WEB/css/prettify.css" />
<link href="/STLVX_WEB/css/editer.css" rel="stylesheet" type="text/css" />
<script charset="utf-8" src="/STLVX_WEB/js/kindeditor-all-min.js"></script>
<script charset="utf-8" src="/STLVX_WEB/js/zh_CN.js"></script>
<script charset="utf-8" src="/STLVX_WEB/js/prettify.js"></script>
<script charset="utf-8" type="text/javascript" src="/STLVX_WEB/js/jquery-1.8.2.js"></script>
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
			$("#chapter").empty();
			var contents="<option value='0'>--请选择--</option>";
			for(var i=0;i<results.length;i++){
			   contents+=" <option value='"+results[i].chapterid+"'>"+results[i].chapterinfo+"</option>"
			} 
			$("#chapter").html(contents);
		}
	}
	req.send(null);

});
</script> 
<script charset="utf-8" type="text/javascript">
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
function article_add() {
	var selector=$("#selector").val();
	if(selector==0){
		alert("请选择您要编辑的内容！")
		return false;
	}
	var chapterId=$("#chapter").val();
	if(chapterId==0){
		alert("请选择文章的章节！")
		return false;
	}
	var title = $("#title").val();
	if(title==undefined||title==null||title==""){
		alert("请输入文章的标题！")
		return false;
	}
	var order=$("#order").val();
	if(order!=null&&isNaN(order)){
		alert("请输入正确数字！")
		return false;
	}
	var req = createAjaxObj();
	editor1.sync();
	var content = $("#content").val();
	//alert(content)
		$.ajax({
			url : "<%=basePath%>Article.do?method=addTheoryTeachingArticle",
		    type:"POST",
		    data:{
		    	content : content,
		    	kind : selector,
		    	title : title,
		    	order : order,
		    	chapterId : chapterId
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
	<li ><a href="${pageContext.request.contextPath}/Admin/addChapter.jsp">添加文章的章节</a></li>
	<li ><a href="${pageContext.request.contextPath}/Admin/deleteChapter.jsp">删除文章的章节</a></li>
	</ul>
	</div>
	<div id="right"> 
	<div id="current">&nbsp;&nbsp;&nbsp;&nbsp;当前位置:添加理论教学</div>
<div id="form">
<form action="" method="post" id="contentCommit">
		<b>选择您要编辑的内容:</b>
		<select id="selector">
		<option value="0">--请选择--</option>
		<option value="5">知识导学</option>
		<option value="6">讲稿</option>
		<option value="7">教案</option>
		<option value="8">课件</option>
		<option value="9">授课视频</option>
		</select>
		<b>请输入文章的标题:</b><input type="text" id="title"/>&nbsp;
		<b>请选择文章的章节:</b>
		<select id="chapter" >
		 <option value="0">--请选择--</option>
		<!--<option value="12">产品设计过程</option>
		<option value="13">产品设计结果</option> -->
		</select>&nbsp;
		<b>文章的排列顺序：</b>&nbsp;<input type="text" id="order" style="width: 30px">
		<input type="button" name="button" value="添加文章"
			onclick="article_add();" />
	<%=htmlData%>
	<textarea name="content" id="content" style="width: 958px; height: 500px;"><%=htmlspecialchars(htmlData)%></textarea>
</form>
</div>
</div></div>
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
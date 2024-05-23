<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<title>添加章节</title>
<link rel="stylesheet" href="/STLVX_WEB/css/themes/default/default.css" />
<link rel="stylesheet" href="/STLVX_WEB/css/prettify.css" />
<link href="/STLVX_WEB/css/editer.css" rel="stylesheet" type="text/css" />
<script charset="utf-8" src="/STLVX_WEB/js/kindeditor-all-min.js"></script>
<script charset="utf-8" src="/STLVX_WEB/js/zh_CN.js"></script>
<script charset="utf-8" src="/STLVX_WEB/js/prettify.js"></script>
<script charset="utf-8" type="text/javascript" src="/STLVX_WEB/js/jquery-1.8.2.js"></script>
<script charset="utf-8" type="text/javascript">
function createAjaxObj() {
	var req;
	if (window.XMLHttpRequest) {
		req = new XMLHttpRequest();
	} else {
		req = new ActiveXObject("Msxml2.XMLHTTP"); 
	}
	return req;
}	
function addChapter() {
	var chapter=$("#chapter").val();
	var chapterContent=$("#chapterContent").val();
	if(chapter==0){
		alert("请选择您要添加文章的章节！")
		return false;
	}
	/* if(chapterContent==null||chapterContent==""||chapterContent==undefined){
		alert("请输入文章的章节名称");
		return false;
	} */
	var req = createAjaxObj();
	req.open("post", "<%=basePath%>Article.do?method=addChapter&chapter="+chapter+"&chapterContent="+chapterContent);
	req.setRequestHeader("accept", "application/json");
	req.onreadystatechange = function() {
		if (req.readyState == 4 && req.status == 200) {
			eval("var result=" + req.responseText);
			if(result==1){
			alert("添加成功！");
			}else if(result==0){
			alert("添加失败！");
			}else if(result==3){
			alert("该章节已经存在,请重新选择!");
			}
			
		}
	}
	req.send(null);
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
	<div id="current">&nbsp;&nbsp;&nbsp;&nbsp;当前位置:添加文章章节详情页</div>
<div id="form">
<form action="" method="post" id="contentCommit">
		<!-- <b>选择您要编辑的内容:</b> -->
		<b>请选择添加的章节:</b>
		<select id="chapter">
		<option value="0">==请选择==</option>
		<c:forEach begin="1" end="60" var="x">
		<option value="${x}">第${x}章节</option>
		</c:forEach>
		</select>
		<b>请输入文章的章节名称：</b><input type="text" id="chapterContent">
		&nbsp;
		<input type="button" name="button" value="确定"onclick="addChapter();" />
	  <%=htmlData%>
<%-- <textarea name="content" id="content" style="width: 958px; height: 650px;"><%=htmlspecialchars(htmlData)%></textarea> --%>
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
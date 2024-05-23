<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
String path = request.getContextPath(); 
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/"; 
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>文章删除页</title>
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
<script type="text/javascript">
function init(){
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
}
</script>
<script type="text/javascript">
function deleteChapter(){
	var chapter=$("#chapter").val();
	if(chapter==0){
		alert("请选择要删除的文章！")
		return false;
	}
	if(confirm("是否删除？")){
		var req = createAjaxObj();
		req.open("post", "<%=basePath%>Article.do?method=deleteChapter&chapterId="+chapter);
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
	<div id="current">&nbsp;&nbsp;&nbsp;&nbsp;当前位置:文章删除页</div>
<div id="form">
<form action="" method="post" id="contentCommit">
		<b>请选择您想要删除文章的章节:</b>
		<select id="chapter" >
		 <option value="0">--请选择--</option>
		<!--<option value="12">产品设计过程</option>
		<option value="13">产品设计结果</option> -->
		</select>&nbsp;
		<input type="button" name="button" value="删除文章"onclick="deleteChapter();" />
</form>
</div>
</div>
</div>
<div id="bottomDiv"></div>
</div>
</body>
</html>
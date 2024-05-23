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
<title>删除首页动态图片</title>
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
<script type="text/javascript">
function article_delete(FileId){
	if(confirm("是否删除？")){
		var req = createAjaxObj();
		req.open("post", "<%=basePath%>Article.do?method=deleteByFileId&FileId="+FileId);
		req.setRequestHeader("accept", "application/json");
		req.onreadystatechange = function() {
			if (req.readyState == 4 && req.status == 200) {
				//alert(req.responseText);
				eval("var result=" + req.responseText);
				if(result==1){
					window.location.href="<%=basePath%>Article.do?method=selectDeleteDynamicPicture";
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
<script charset="utf-8" type="text/javascript">
var editor1;
function editArticle() {
	var req = createAjaxObj();
	editor1.sync();
	var content = $("#content").val();
	//alert(content)
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
	<li ><a href="${pageContext.request.contextPath}/Admin/addDynamicPicture.jsp">添加首页动态图片</a></li>
	<li ><a href="${pageContext.request.contextPath}/Admin/addChapter.jsp">添加文章的章节</a></li>
	<li ><a href="${pageContext.request.contextPath}/Admin/deleteChapter.jsp">删除文章的章节</a></li>
	</ul>
	</div>
	<div id="right"> 
	<div id="current">&nbsp;&nbsp;&nbsp;&nbsp;当前位置:删除首页图片情页</div>
				<div id="form">
				<br>
					<div>
						<c:forEach items="${result}" var="x" varStatus="i">
							${i.count}. <img style="width: 300px; height: 200px" src="${x.filePath}"> &nbsp;<a onclick='article_delete(${x.fileId})' style='cursor: pointer;margin: -10px 0 0 0;color: red;' >删除</a><br><br></c:forEach>
					</div>
				</div>
			</div>
</div>
<div id="bottomDiv"></div>
</div>
</body>
</html>
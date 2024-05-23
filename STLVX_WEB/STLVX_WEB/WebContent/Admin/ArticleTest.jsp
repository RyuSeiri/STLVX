<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
	String htmlData = request.getParameter("content1") != null ? request.getParameter("content1") : "";
%>
<% 
String path = request.getContextPath(); 
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/"; 
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>KindEditor JSP</title>
<link rel="stylesheet" href="/STLVX_WEB/css/themes/default/default.css" />
<link rel="stylesheet" href="/STLVX_WEB/css/prettify.css" />
<script charset="utf-8" src="/STLVX_WEB/js/kindeditor-all-min.js"></script>
<script charset="utf-8" src="/STLVX_WEB/js/zh_CN.js"></script>
<script charset="utf-8" src="/STLVX_WEB/js/prettify.js"></script>
<script charset="utf-8" type="text/javascript" src="/STLVX_WEB/js/jquery-1.8.2.js"></script>
<script charset="utf-8" type="text/javascript">
	function createAjaxObj1() {
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
		editor1 = K.create('textarea[name="content1"]', {
			cssPath : '../css/prettify.css',
			uploadJson : '<%=basePath%>file_upload.do',
			fileManagerJson : '<%=basePath%>file_manager.do',
			allowFileManager : true,
			afterCreate : function() {
				var self = this;
				K.ctrl(document, 13, function() {
					self.sync();
					document.forms['example'].submit();
				});
				K.ctrl(self.edit.doc, 13, function() {
					self.sync();
					document.forms['example'].submit();
				});
			}
		});
		prettyPrint();
	});

	function article_add(articleType) {
		var req = createAjaxObj1();
		editor1.sync();
		var content = $("#content").val();
		req.open("post", "<%=basePath%>Article.do?method=addArticle&content=" + encodeURI(content)+"&articleType="+2);
		req.setRequestHeader("accept", "application/json");
		/* req.onreadystatechange = function() {
		} */
		req.send(null);
	}
</script>
</head>
<body>
	<%=htmlData%>
	<form name="example" method="post" action="">
		<textarea name="content1" cols="100" rows="8" id="content"
			style="width: 700px; height: 200px; visibility: hidden;"><%=htmlspecialchars(htmlData)%></textarea>
		<br /> <input type="button" name="button" value="提交内容"
			onclick="article_add();" /> (提交快捷键: Ctrl + Enter)
	</form>
</body>
</html>
<%!private String htmlspecialchars(String str) {
		str = str.replaceAll("&", "&amp;");
		str = str.replaceAll("<", "&lt;");
		str = str.replaceAll(">", "&gt;");
		str = str.replaceAll("\"", "&quot;");
		return str;
	}%>
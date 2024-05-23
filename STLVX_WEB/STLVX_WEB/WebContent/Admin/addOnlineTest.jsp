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
<title>添加在线测试题</title>
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
<%-- $(document).ready(function(){
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

}); --%>
</script> 
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
function editArticle() {
	editor1.sync();
	var content = $("#content").val();
	var chapter=$("#chapter").val();
	if(chapter==0){
		alert("没有指定第几套题！")
		return false;
	}
	var title = $("#title").val();
	if(title==undefined||title==null||title==""){
		alert("请输入文章的标题！")
		return false;
	}
	/* var questionCount=$("#questionCount").val();
	if(questionCount==undefined||questionCount==null||questionCount==""){
		alert("请指定在线习题的问题数！");
		return false;
	} */
	/* if(isNaN(questionCount)){
		alert("请输入正确的问题数！");
		return false;
	} */
	var answerInfo=$("#answer").val();
	if(answerInfo==""||answerInfo=="该习题目前没有答案"){
		alert("请输入答案！")
		return false;
	}
		$.ajax({
			url : "<%=basePath%>Article.do?method=addOnlineTest",
		    type:"POST",
		    data:{
		    	content : content,
		    	chapterId : chapter,
		    	title : title,
		    	//questionCount : questionCount,
		    	answer : answerInfo
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
		    error:function () {
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
	<%-- <li ><a href="${pageContext.request.contextPath}/Admin/addChapter.jsp">添加文章的章节</a></li>
	<li ><a href="${pageContext.request.contextPath}/Admin/deleteChapter.jsp">删除文章的章节</a></li> --%>
	</ul>
	</div>
	<div id="right"> 
	<div id="current">&nbsp;&nbsp;&nbsp;&nbsp;当前位置:在线测试编辑详情页</div>
<div id="form">
<form action="" method="post" id="contentCommit">
		<!-- <b>选择您要编辑的内容:</b> -->
		<b>请选择文章的章节:</b>
		<select id="chapter" >
		 <option value="0">--请选择--</option>
		<option value="1">第一套题</option>
		<option value="2">第二套题</option>
		<option value="3">第三套题</option>
		<option value="4">第四套题</option>
		<option value="5">第五套题</option>
		<option value="6">第六套题</option>
		<option value="7">第七套题</option>
		<option value="8">第八套题</option>
		<option value="9">第九套题</option>
		<option value="10">第十套题</option>
		</select>&nbsp;
		<b>请输入在线测试的标题:</b><input type="text" id="title" >&nbsp;
		<!-- <b>请输入在线测是的问题数：</b><input type="text" id="questionCount" />&nbsp; -->
		<input type="button" name="button" value="确定"onclick="editArticle();" />  <br/> <br/>
		<b>习题的答案：</b><input name="answer" id="answer" style="width: 300px; height: 20px;" />
	  （ps：每道题答案中间用逗号或者顿号进行分割）
	  <%=htmlData%>
	<textarea name="content" id="content" style="width: 958px; height: 650px;"><%=htmlspecialchars(htmlData)%></textarea>
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
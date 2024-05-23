/*function createAjaxObj1() {
	var req;
	if (window.XMLHttpRequest) {
		req = new XMLHttpRequest();
	} else {
		req = new ActiveXObject("Msxml2.XMLHTTP");
	}
	return req;
}*/
function login(BasePath) {
	var name = $("#username").val();
	var password = $("#password").val();
	var code=$("#code").val();
	if (name == null || name == "") {
		//alert("请输入用户名");
		$("#msg").empty();
		$("#msg").html("请输入用户名");
		return false;
	}
	if (password == null || password == "") {
		//("请输入密码");
		$("#msg").empty();
		$("#msg").html("请输入密码");
		return false;
	}
	if(code==null||code==""){
		$("#msg").empty();
		$("#msg").html("请输入验证码");
		return false;
	}
	var form=document.getElementById("loginform");
	form.action=BasePath+"login.do?method=login";
	form.submit();
}	
/*	var req = createAjaxObj1();
	req.open("get", globalBasePath + "login.do?method=login&name=" + name + "&password="
			+ password);

	// req.open("get","myajax.do?method=test1&uname=张三&a="+Math.random());
	req.setRequestHeader("accept", "application/json");
	req.onreadystatechange = function() {
//		 alert(req.responseText);
//		 eval("var result="+req.responseText);
//		 document.getElementById("div1").innerHTML=result[0].username;
		if (req.readyState == 4 && req.status == 200) {
			eval("var result=" + req.responseText);
			//alert(username);
			if (result.length > 0 && (result[0].susername !== undefined && result[0].susername !== null && result[0].susername !== '')) {
				window.location.href=globalBasePath + "Admin/index.jsp";
			} else {
				window.location.href=globalBasePath + "jsp/index.jsp";
				$("#msg").html("您输入的用户名或密码有误！");
				alert("您输入的用户名或密码有误!");
			}
		}
	}
	req.send(null);*/


function createAjaxObj_index() {
	var req;
	if (window.XMLHttpRequest) {
		req = new XMLHttpRequest();
	} else {
		req = new ActiveXObject("Msxml2.XMLHTTP");
	}
	return req;
}
function index_selectLljx() {
	var req = createAjaxObj_index();
	req.open("post", "index.do?method=selectLljxActicleForIndex");
	req.setRequestHeader("accept", "application/json");
	req.onreadystatechange = function() {
		if (req.readyState == 4 && req.status == 200) {
			eval("var result=" + req.responseText);
			$('#index_lljxList').html("");
			$('#index_lljxList').append("<ul class='content'>");
			$('#index_lljxList').append("<li>");
			$('#index_lljxList').append("<ul");
			for (i = 0; i < 6; i++) {
				var createobj = $("<li><a>" + result[i].title + "</a><span>"
						+ result[i].time + "</span></li>");
				$('#index_lljxList').append(createobj);
			}
			$('#index_lljxList').append("</ul>");
			$('#index_lljxList').append("</li>");

			$('#index_lljxList').append("<li>");
			$('#index_lljxList').append("<ul");
			for (i = 6; i < 12; i++) {
				var createobj = $("<li><a>" + result[i].title + "</a><span>"
						+ result[i].time + "</span></li>");
				$('#index_lljxList').append(createobj);
			}
			$('#index_lljxList').append("</ul>");
			$('#index_lljxList').append("</li>");
			$('#index_lljxList').append("</ul>");
		}
	}
	req.send(null);
}
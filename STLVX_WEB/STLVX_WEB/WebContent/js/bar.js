/*banner_tabsbanner_tabs(function($){
    $.fn.capacityFixed = function(options) {
        var opts = $.extend({},$.fn.capacityFixed.deflunt,options);
        var FixedFun = function(element) {
            var top = opts.top;
            element.css({
                'top':top
            });
            $(window).scroll(function() {
                var scrolls = $(this).scrollTop();
                if (scrolls > top) {

                    if (window.XMLHttpRequest) {
                        element.css({
                            position: "fixed",
                            top: 0							
                        });
                    } else {
                        element.css({
                            top: scrolls
                        });
                    }
                }else {
                    element.css({
                        position: "absolute",
                        top: top
                    });
                }
            });
            element.find(".close-ico").click(function(event){
                element.remove();
                event.preventDefault();
            })
        };
        return $(this).each(function() {
            FixedFun($(this));
        });
    };
    $.fn.capacityFixed.deflunt={
		right : 0,//鐩稿浜庨〉闈㈠搴︾殑鍙宠竟瀹氫綅
        top:200
	};
})(jQuery);*/

//设为首页
function SetHome(obj, url) {
	try {
		obj.style.behavior = 'url(#default#homepage)';
		obj.setHomePage(url);
	} catch (e) {
		if (window.netscape) {
			try {
				netscape.security.PrivilegeManager
						.enablePrivilege("UniversalXPConnect");
			} catch (e) {
				alert("抱歉，此操作被浏览器拒绝！\n\n请在浏览器地址栏输入“about:config”并回车然后将[signed.applets.codebase_principal_support]设置为'true'");
			}
		} else {
			alert("抱歉，您所使用的浏览器无法完成此操作。\n\n您需要手动将【" + url + "】设置为首页。");
		}
	}
}

// 收藏本站
function AddFavorite(title, url) {
	if (document.all) {
		window.external.addFavorite(url, title);
	} else if (window.sidebar) {
		window.sidebar.addPanel(title, url, "");
	}

	try {
		window.external.addFavorite(url, title);
	} catch (e) {
		try {
			window.sidebar.addPanel(title, url, "");
		} catch (e) {
			alert("抱歉，您所使用的浏览器无法完成此操作。\n\n加入收藏失败，请使用Ctrl+D进行添加");
		}
	}
}

$(function() {
	// 展示层
	function showLayer(id) {
		var layer = $('#' + id), layerwrap = layer.find('.hw-layer-wrap');
		layer.fadeIn();
		// 屏幕居中
		layerwrap.css({
			'margin-top' : -layerwrap.outerHeight() / 2
		});
	}

	// 隐藏层
	function hideLayer() {
		$('.hw-overlay').fadeOut();
	}

	$('.hwLayer-ok,.hwLayer-cancel,.hwLayer-close').on('click', function() {
		hideLayer();
	});

	// 触发弹出层
	$('.show-layer').on('click', function() {
		var layerid = $(this).data('show-layer');
		showLayer(layerid);
	});

	// 点击或者触控弹出层外的半透明遮罩层，关闭弹出层
	$('.hw-overlay').on('click', function(event) {
		if (event.target == this) {
			hideLayer();
		}
	});

	// 按ESC键关闭弹出层
	$(document).keyup(function(event) {
		if (event.keyCode == 27) {
			hideLayer();
		}
	});
});

$(document).ready(function() {
	// if user clicked on button, the overlay layer or the dialogbox, close the
	// dialog
	$('a.btn-ok, #dialog-overlay, #dialog-box').click(function() {
		$('#dialog-overlay, #dialog-box').hide();
		return false;
	});
	// if user resize the window, call the same function again
	// to make sure the overlay fills the screen and dialogbox aligned to center
	$(window).resize(function() {
		// only do it if the dialog box is not hidden
		if (!$('#dialog-box').is(':hidden'))
			popup();
	});
});

function popup(message) {
	alert(message)
	// get the screen height and width
	var maskHeight = $(document).height();
	var maskWidth = $(window).width();
	// calculate the values for center alignment
	var dialogHeight = $('#dialog-box').outerHeight();
	var dialogWidth = $('#dialog-box').outerWidth();
	// assign values to the overlay and dialog box
	$('#dialog-overlay').css({
		height : maskHeight,
		width : maskWidth
	}).show();
	$('#dialog-box').css({
		top : "100%",
		left : "50%",
		"margin-left" : -(dialogWidth / 2),
		"margin-top" : -(dialogHeight / 2)
	}).show();
	// display the message
	$('#dialog-message').html(message);
}

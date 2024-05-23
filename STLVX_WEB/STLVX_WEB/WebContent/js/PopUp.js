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
		top : "50%",
		left : "50%",
		"margin-left" : -(dialogWidth / 2),
		"margin-top" : -(dialogHeight / 2)
	}).show();
	// display the message
	$('#dialog-message').html(message);
}
$(function(){
	
	$('.row-fluid [class*="span"]:first-child').addClass('first-child');
	
	$('.dropdown-toggle').click (function () {
		if ($(this).hasClass('exp')) {
			$(this).removeClass('exp');
			$(this).next().hide();
		}
		else {
			$(this).addClass('exp');
			$(this).next().show();
		}
		return false;
	});
	
});
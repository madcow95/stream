$(document).ready(function() {
	var changeBtn = $("button[name='updateInfo']");
	
	changeBtn.on("click", function(){
		$("form[class='form-signin']").submit();
	});
});
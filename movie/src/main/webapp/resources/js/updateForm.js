$(document).ready(function() {
	var changeBtn = $("button[name='updateInfo']");
	var toList = $("button[name='toList']");
	
	changeBtn.on("click", function(){
		$("form[class='form-signin']").submit();
	});
	
	toList.on("click", function () {
		location.href="/member/mypage";
	}); 
});
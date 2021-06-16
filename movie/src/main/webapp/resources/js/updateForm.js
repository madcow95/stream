$(document).ready(function() {
	var changeBtn = $("button[name='updateInfo']");
	var toList = $("button[name='toList']");
	
	changeBtn.on("click", function(){
	var pwd = document.getElementById("inputPassword1").value;
	var pwdChk = document.getElementById("inputConfirmPassword").value;
	if (pwd != pwdChk) {
		alert("비밀번호가 일치하지 않습니다.");
	} else {
		$("form[class='form-signin']").submit();
	}
});
	
	toList.on("click", function () {
		location.href="/member/mypage";
	}); 
});
/**
 * 
 */
 $(document).ready(function() {
	var change = $("button[name='change']");
	
	change.on("click", function() {
		var id = document.getElementById("inputEmail").value;
		var originPwd = document.getElementById("originPwd").value;
		var pwd = document.getElementById("inputPassword").value;
		
		if(originPwd != pwd) {
			alert("비밀번호가 일치하지 않습니다.");
		} else {
			document.frm.submit();
		}
	});
});
/**
 * 
 */
 $(document).ready(function() {
	var change = $("button[name='change']");
	
	change.on("click", function() {
	var pwdcheck = document.getElementById("inputPassword").value;
	if(pwdcheck == "") {
		alert("비밀번호를 입력해주세요");
	} else {
		document.frm.submit();
	}
	});
});
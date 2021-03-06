/**
 * 
 */
 $(document).ready(function() {
	
	var loginBtn = $("button[name='loginBtn']");
	loginBtn.on("click", function() {
		var id = $("input[name='username']").val();
		var pwd = $("input[name='password']").val();
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		var mDto = new Object();
		mDto.id = id;
		mDto.pwd = pwd;
		if(id == "") {
			alert("아이디를 입력해주세요.");
			id.focus();
		} else if(pwd == "") {
			alert("비밀번호를 입력해주세요.");
			password.focus();
		} else {
			$.ajax({
				type : "post",
				beforeSend : function(xhr) {
					xhr.setRequestHeader(header, token);
				},
				url : "/loginPost",
				data : JSON.stringify(mDto),
				contentType : "application/json; charset=UTF-8",
				success : function (result) {
					if(result == "fail") {
						alert("아이디와 비밀번호를 확인해주세요");
					} else {
						location.href="/";
					}
				}
			});
		}
	});
	
});
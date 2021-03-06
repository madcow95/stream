/**
 * 
 */
 $(document).ready(function() {
	var change = $("button[name='change']");
	var exit = $("button[name='exit']");
	var realExit = $("button[name='realExit']");
	
	change.on("click", function() {
		var id = document.getElementById("inputId").value;
		var pwd = document.getElementById("password12").value;
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		var mDto = new Object();
		mDto.id = id;
		mDto.pwd = pwd;
		if(pwd== "") {
			alert("비밀번호를 입력해주세요");
		} else {
			$.ajax({
				url : "updateForm",
				type : "post",
				beforeSend : function(xhr){
					xhr.setRequestHeader(header, token);
				},
				data : JSON.stringify(mDto),
				contentType : "application/json; charset=UTF-8",
				success : function(result) {
					if(result == "fail"){
						alert("비밀번호가 일치하지 않습니다.");
					} else {
						location.href="updateForm";
					}
				}
			}); // ajax end
		} // else end
	}); // change end
	
		exit.on("click", function() {
			if(confirm("탈퇴하시겠습니까?")) {
				$("button[name='test']").click();
			} else {
				alert("탈퇴취소");
			}
		}); // exit end
	
	realExit.on("click", function () {
		var id = $("input[name='exitId']").val();
		var pwd = $("input[name='exitPwd']").val();
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		var exit = new Object();
		exit = {
			id : id,
			pwd : pwd
		}
		console.log(exit);
		var ctx = "${ctx}";
		$.ajax({
			type : "post",
			url : "/member/exit",
			data : JSON.stringify(exit),
			beforeSend : function(xhr){
					xhr.setRequestHeader(header, token);
				},
			contentType : "application/json; charset=UTF-8",
			success : function(result) {
				if(result == "exitSucc") {
					alert("회원탈퇴가 완료되었습니다.");
					alert("회원탈퇴 후 일주일동안 계정을 복구할 수 있습니다.");
					location.href="/member/exitResult";
				} else {
					alert("비밀번호가 일치하지 않습니다.");
				}
			}
			
		});
	});
	
}); // ready end
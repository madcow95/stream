/**
 * 
 */
 $(document).ready(function() {
	var change = $("button[name='change']");
	
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
		}
	}); // on end
	
	
	
}); // ready end
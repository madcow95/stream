
	
	$(document).ready(function () {
	
		$("#uid").on("change keyup paste", function () {
			var len = document.getElementById("uid").value.length;
			var textChk = document.getElementById("uid").value;
			textChk = textChk.replace(/[^a-z0-9]/gi,"");
			if (len < 4) {
				$("#idmessage").val("4글자 이상으로 입력해주세요").css("color","red").css("font-size","12px");
			} else {
				$("#idmessage").val("");
				var token = $("meta[name='_csrf']").attr("content");
				var header = $("meta[name='_csrf_header']").attr("content");
				var id = document.getElementById("uid").value;
				$.ajax({
					type : "post",
					url : "/member/id_check",
					data : JSON.stringify(id),
					contentType : "application/json; charset=UTF-8",
					beforeSend : function(xhr){
						xhr.setRequestHeader(header, token);
					},
					success : function (data) {
						if(data.message == "1"){
							$("#idmessage").val("이미 사용중인 아이디 입니다.").css("color","red").css("font-size","12px");
							$("#reid").val("1");
						} else {
							$("#idmessage").val("사용가능한 아이디입니다.").css("color","blue").css("font-size","12px");
							$("#reid").val("-1");
						} 
					}, // success end
					fail : function () {
						alert("system error");
					}
				}); // ajax end
			} // else end
		}); // on end
		
		$("#pwd").on("change keyup paste", function () {
			var pwdlen = document.getElementById("pwd").value.length;
			if(pwdlen < 6){
				$("#pwdmessage").val("6글자 이상 입력해주세요").css("color","red").css("font-size","12px");
			} else {
				$("#pwdmessage").val("");
			}
		});
		
		$("#pwdChk").on("change keyup paste", function () {
			var pwd = document.getElementById("pwd").value;
			var pwdChk = document.getElementById("pwdChk").value;
			if(pwd != pwdChk){
				$("#pwdchkmessage").val("비밀번호가 일치하지 않습니다.").css("color","red").css("font-size","12px");
			} else {
				$("#pwdchkmessage").val("good").css("color","green").css("font-size","12px");
			}
		});
		
		$("#join").click(function () {
			var id = $("input[name='id']").val();
			var pwd = $("input[name='pwd']").val();
			var pwdChk = $("input[name='pwdChk']").val();
			var name = $("input[name='name']").val();
			var email = $("input[name='email']").val();
			var idLen = $("input[name='id']").val().length;
			var pwdLen = $("input[name='pwd']").val().length;
			var emailCheck = $("input[name='emailCheck1']").val();
			var reid = $("input[name='reid']").val();
			if(id == "") {
				alert("아이디는 필수 입력사항입니다.");
				$("input[name='id']").focus();
			} else if(pwd == "") {
				alert("비밀번호는 필수 입력사항 입니다.");
				$("input[name='pwd']").focus();
			} else if(pwdChk == "") {
				alert("비밀번호 확인란을 입력해주세요.");
				$("input[name='pwdChk']").focus();
			} else if(pwd != pwdChk) {
				alert("비밀번호가 일치하지 않습니다.");
				$("input[name='pwd']").focus();
			} else if(name == "") {
				alert("이름은 필수 입력사항 입니다.");
				$("input[name='name']").focus();
			} else if(email == "") {
				alert("이메일은 필수 입력사항 입니다.");
				$("input[name='email']").focus();
			} else if(idLen < 4) {
				alert("아이디는 4글자 이상 입력해주세요");
				$("input[name='id']").focus();
			} else if(pwdLen < 6) {
				alert("비밀번호는 6글자 이상 입력해주세요");
				$("input[name='pwd']").focus();
			} else if(emailCheck != 3) {
				alert("이메일 중복체크를 확인주세요");
				$("button[name='emailCheck1']").focus();
			} else if(email == "") {
				alert("이메일을 입력해주세요");
				$("input[name='email']").focus();
			} else if(reid == 1) {
				alert("아이디 중복체크를 확인해주세요");
				$("input[name='id']").focus();
			} else {
				document.getElementById("frm").submit();
			}
		});
		
	}); // ready end
	
	function txtblock(e) {
		e.value=e.value.replace(/[^a-z0-9A-Z]/g,'');
	}
	
	function engBlock(e) {
		e.value=e.value.replace(/[a-z0-9A-Z!@#$%^&\]*()-=_+`~;:,\\\|\}{./<>?\"\[']/gi,"");
	}
	
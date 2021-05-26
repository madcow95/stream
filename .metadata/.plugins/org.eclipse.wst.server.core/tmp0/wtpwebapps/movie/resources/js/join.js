function findAddr(){
		var pop = window.open("jusoPopup","pop","width=570,height=420, scrollbars=yes, resizable=yes"); 
	}
	
	function jusoCallBack(roadFullAddr,zipNo) {
		document.getElementById("zip_num").value = zipNo;
		document.getElementById("address").value = roadFullAddr;
	}
	
	$(document).ready(function () {
		$("#uid").on("change keyup paste", function () {
			var len = document.getElementById("uid").value.length;
			var textChk = document.getElementById("uid").value;
			textChk = textChk.replace(/[^a-z0-9]/gi,"");
			if (len < 4) {
				$("#idmessage").val("4글자 이상으로 입력해주세요").css("color","red").css("font-size","12px");
			} else {
				$("#idmessage").val("");
				var id = document.getElementById("uid").value;
				$.ajax({
					type : "post",
					url : "/member/id_check",
					dataType : "json",
					data : "id="+id,
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
		
		$("#btnJoin").click(function () {
			var uid = document.getElementById("uid").value;
			var uidlen = document.getElementById("uid").value.length;
			var uPwd = document.getElementById("pwd").value;
			var uPwdlen = document.getElementById("pwd").value.length
			var uPwdChk = document.getElementById("pwdChk").value;
			var name = document.getElementById("iname").value;
			var email = document.getElementById("email").value;
			var zip_num = document.getElementById("zip_num").value;
			var address = document.getElementById("address").value;
			var mobile = document.getElementById("mobile").value;
			var reid = document.getElementById("reid").value;
			if(uid == ""){
				alert("아이디를 입력해주세요");
				document.getElementById("uid").focus();
			} else if (uidlen < 4){
				alert("아이디는 4글자 이상 입력해주세요");
				document.getElementById("uid").focus();
			} else if(uPwd == ""){
				alert("비밀번호를 입력해주세요");
				document.getElementById("pwd").focus();
			} else if(uPwdlen < 6){
				alert("비밀번호는 6글자 이상 입력해주세요");
				document.getElementById("pwd").focus();
			} else if(uPwdChk == ""){
				alert("비밀번호 확인칸을 입력해주세요");
				document.getElementById("pwdChk").focus();
			} else if(uPwd != uPwdChk){
				alert("비밀번호가 일치하지 않습니다.");
				document.getElementById("pwd").focus();
			} else if(name == ""){
				alert("이름을 입력해주세요.");
				document.getElementById("iname").focus();
			} else if(email == ""){
				alert("이메일을 입력해주세요");
				document.getElementById("email").focus();
			} else if(zip_num == "" || address == ""){
				alert("주소를 입력해주세요");
				document.frm.address.focus();
			} else if(mobile == ""){
				alert("전화번호를 입력해주세요");
				document.frm.phone.focus();
			} else if(reid == "-1"){
				document.getElementById("frm").submit();
			}
		});
		
		/* $("#name").on("change keyup paste", function () {
			var name = document.getElementById("name").value;
			name = name.replace(/[^ㄱ-ㅎ]/gi,"");
			
		}); */
	}); // ready end
	
	function txtblock(e) {
		e.value=e.value.replace(/[^a-z0-9A-Z]/g,'');
	}
	
	function engBlock(e) {
		e.value=e.value.replace(/[a-z0-9A-Z!@#$%^&*()-=_+`~;:,./<>?]/gi,"");
	}
	function test() {
		var reid = document.getElementById("reid").value;
		if(reid == "1") {
			alert("aaa");
		} else if(reid == "-1"){
			alert("bbb");
		}
	}
	
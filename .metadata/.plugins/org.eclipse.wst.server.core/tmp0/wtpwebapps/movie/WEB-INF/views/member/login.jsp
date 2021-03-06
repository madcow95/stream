<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="${ctx}/resources/css/login.css" rel="stylesheet" />
<title>Insert title here</title>
</head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function () {
		$("#find1").on("click", function () {
			location.href="${ctx}/member/findid";
		});
		
		$("#contract1").on("click", function () {
			location.href="${ctx}/member/contract";
		});
		
		var loginBtn1 = $("button[name='loginBtn1']");
		loginBtn1.on("click", function () {
			var id = $("input[name=username1]").val();
			var pwd = $("input[name=password1]").val();
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			var loginInfo = new Object();
			loginInfo.id = id;
			loginInfo.pwd = pwd;
			if(id == "") {
				alert("아이디를 입력해주세요.");
				id.focus();
			} else if(pwd == "") {
				alert("비밀번호를 입력해주세요.");
				pwd.focus();
			} else {
				$.ajax({
					url : "login",
					type : "post",
					beforeSend : function(xhr){
						xhr.setRequestHeader(header, token);
					},
					data : "username="+id+"&password="+pwd,
					success : function (result) {
						if(result == "loginsuccess"){
							location.href="/";
						} else {
							alert("입력한 정보를 확인해주세요");
						}
					}
				}); // ajax end
				/* document.loginfrm.submit(); */
			}
			}); // onclick end
			
	});
</script>
<body>
<%@ include file="../header.jsp" %>
  <div class="container">
    <div class="row">
      <div class="col-sm-9 col-md-7 col-lg-5 mx-auto">
        <div class="card card-signin my-5">
          <div class="card-body">
            <h5 class="card-title text-center">로그인</h5>
            <form class="form-signin" method="post" action="${ctx}/login">
              <div class="form-label-group">
                <input type="text" id="inputEmail1" class="form-control" placeholder="ID" autofocus name="username1">
                <label for="inputEmail1">ID</label>
              </div>
              <div class="form-label-group">
                <input type="password" id="inputPassword1" class="form-control" placeholder="Password"  name="password1">
                <label for="inputPassword1">Password</label>
              </div>
              <div class="form-label-group">
                <input type="text" class="form-control" style="height: 25px; color: red; font-size: 8px; padding-top: 0px; padding-bottom:0px; text-align: center; border: 0px #ffffff; margin-top: 0px; background-color: #ffffff;" disabled="disabled" value="${loginFailMsg}">
              </div>
              <button class="btn btn-lg btn-primary btn-block text-uppercase" type="button" name="loginBtn1" style="margin-top: 0px;">Login</button>
              <hr class="my-4">
              <button type="button" class="btn btn-lg btn-google btn-block text-uppercase" id="contract1">회원가입</button>
              <button type="button" class="btn btn-lg btn-facebook btn-block text-uppercase" id="find1">아이디 / 비밀번호 찾기</button>
              <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
</body>
</html>
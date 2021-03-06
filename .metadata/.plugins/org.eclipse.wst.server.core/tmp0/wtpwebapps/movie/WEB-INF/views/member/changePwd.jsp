<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="${ctx}/resources/css/find.css" rel="stylesheet" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/find.js"></script>
<script type="text/javascript">
	$(document).ready(function () {
		$("button[type='button']").on("click", function () {
			var password = $("input[name='password12']").val();
			var passwordCheck = $("input[name='passwordCheck']").val();
			var passwordLen = $("input[name='password12']").val().length;
			var passwordCheckLen = $("input[name='passwordCheck']").val().length;
			console.log("pwd >> " + password + "/// pwdchk >>> " + passwordCheck)
			if(password != passwordCheck) {
				alert("비밀번호가 일치하지 않습니다.");
			} else if(password == ""){
				alert("비밀번호를 입력해주세요.");
				$("input[name='password']").focus();
			} else if(passwordCheck == "") {
				alert("비밀번호 확인칸을 입력해주세요.");
				$("input[name='passwordCheck']").focus();
			} else if(passwordLen < 6 || passwordCheckLen < 6){
				alert("비밀번호는 6글자 이상으로 입력해주세요.");
			} else {
				$("form[class='form-signin']").submit();
			}
		});
	});
</script>
<title>Insert title here</title>
</head>
<body>
<%@ include file="../header.jsp"%>
  <div class="container">
    <div class="row">
      <div class="col-sm-9 col-md-7 col-lg-5 mx-auto">
        <div class="card card-signin my-5">
          <div class="card-body">
            <h5 class="card-title text-center">비밀번호 변경하기</h5>
            <form class="form-signin" method="post" action="${ctx}/member/changePwd">
              <div class="form-group">
                <input type="password" id="pwd" class="form-control" placeholder="비밀번호" name="password12">
              </div>
              <div class="form-group">
                <input type="password" id="pwdChk" class="form-control" placeholder="비밀번호 확인" name="passwordCheck">
              </div>
              <button class="btn btn-lg btn-primary btn-block text-uppercase" type="button">비밀번호 변경</button>
              <hr class="my-4">
              <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
              <input type="hidden" name="id" value="${id}">
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
</body>
</html>
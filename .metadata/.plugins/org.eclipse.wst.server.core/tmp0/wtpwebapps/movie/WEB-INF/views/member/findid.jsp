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
		var findIdBtn = $("button[name='findId']");
		findIdBtn.on("click", function () {
			var name = $("input[name='name']").val();
			var email = $("input[name='email']").val();
			
			if(name == ""){
				alert("이름을 입력해주세요");
				$("input[name='name']").focus();
			} else if (email == "") {
				alert("이메일을 입력해주세요");
				$("input[name='email']").focus();
			} else {
				$("form[name=frm]").submit();
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
            <h5 class="card-title text-center">아이디 찾기</h5>
            <form class="form-signin" action="${ctx}/member/find" method="post" name="frm">
              <div class="form-group">
                <input type="text" id="inputName" class="form-control" placeholder="이름" autofocus name="name">
              </div>
              <div class="form-group">
                <input type="email" id="inputEmail2" class="form-control" placeholder="이메일" name="email">
              </div>
              <button class="btn btn-lg btn-primary btn-block text-uppercase" type="button" name="findId">아이디 찾기</button>
              <hr class="my-4">
              <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
              <button type="button" class="btn btn-lg btn-success btn-block text-uppercase" id="contract1">회원가입</button>
              <div class="text-center"><a class="small" href="${ctx}/member/findPwd">비밀번호 찾기</a></div>
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
</body>
</html>
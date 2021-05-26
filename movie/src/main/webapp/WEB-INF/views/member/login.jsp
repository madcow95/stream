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
		$("#find").on("click", function () {
			location.href="${ctx}/member/findid";
		});
		
		$("#contract").on("click", function () {
			location.href="${ctx}/member/contract";
		});
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
            <form class="form-signin" action="${ctx}/member/login" method="post">
              <div class="form-label-group">
                <input type="text" id="inputEmail" class="form-control" placeholder="ID" required autofocus name="id">
                <label for="inputEmail">ID</label>
              </div>

              <div class="form-label-group">
                <input type="password" id="inputPassword" class="form-control" placeholder="Password" required name="password">
                <label for="inputPassword">Password</label>
              </div>

              <button class="btn btn-lg btn-primary btn-block text-uppercase" type="submit">Login</button>
              <hr class="my-4">
              <button class="btn btn-lg btn-google btn-block text-uppercase" id="contract">회원가입</button>
              <button class="btn btn-lg btn-facebook btn-block text-uppercase" id="find">아이디 / 비밀번호 찾기</button>
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
</body>
</html>
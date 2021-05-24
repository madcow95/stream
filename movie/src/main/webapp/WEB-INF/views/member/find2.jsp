<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="${ctx}/resources/css/find.css" rel="stylesheet" />
<title>Insert title here</title>
</head>
<body>
<%@ include file="../header.jsp"%>
	<!-- <form name="frm" method="post" action="">
		<div class="login-page" style="margin 0; padding: 0;">
			<h3>아이디찾기</h3>
			<div class="form">
				<input type="text" placeholder="이름" name="irum" class="form-control"> <input
					type="text" placeholder="이메일" name="idemail" class="form-control">
				<button onclick="toCode()">이메일 전송</button>
			</div>
			<hr>
		</div>
		<div class="login-page" style="padding-top: 0;">
			<h3>비밀번호찾기</h3>
			<div class="form">
				<input type="text" placeholder="아이디" name="id" class="form-control"> <input
					type="text" placeholder="이메일" name="pwdemail" class="form-control">
				<button onclick="toCodePwd()">이메일 전송</button>
			</div>
		</div>
	</form> -->
	<div class="container-fluid" >
		<div class="row no-gutter">
			<div class="col-md-8 col-lg-6">
				<div class="login d-flex align-items-center py-5">
					<div class="container">
						<div class="row">
							<div class="col-md-9 col-lg-8 mx-auto">
							<h3 class="login-heading mb-4">아이디 찾기</h3>
							<form>
				                <div class="form-label-group">
				                  <input type="text" class="form-control" placeholder="name" required autofocus>
				                  <label for="inputEmail">이름</label>
				                </div>
				                <button class="btn btn-lg btn-primary btn-block btn-login text-uppercase font-weight-bold mb-2" type="submit">인증번호 받기</button>
				                <div class="text-center">
				                  <a class="small" href="#">Forgot password?</a></div>
				              </form>
				              </div>
				          </div>
					</div>
              	</div>
              </div>
		</div>
	</div>
</body>
</html>
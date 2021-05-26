<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${ctx}/resources/css/newfind.css">
<title>Insert title here</title>
<style type="text/css">
</style>
</head>
<body>
<%@ include file="../header.jsp" %>
<div class="container-fluid">
  <div class="row no-gutter">
    <div class="d-none d-md-flex col-md-4 col-lg-6 bg-image"></div>
    <div class="col-md-8 col-lg-6">
      <div class="login d-flex align-items-center py-5">
        <div class="container">
          <div class="row">
            <div class="col-md-9 col-lg-8 mx-auto">
              <h3 class="login-heading mb-4">비밀번호 찾기</h3>
              <form>
                <div class="form-label-group">
                  <input type="text" class="form-control" placeholder="id" required autofocus>
                  <label for="inputId">아이디</label>
                </div>

                <div class="form-label-group">
                  <input type="text" id="inputEmail" class="form-control" placeholder="email" required>
                  <label for="inputEmail">이메일</label>
                </div>

                <button class="btn btn-lg btn-primary btn-block btn-login text-uppercase font-weight-bold mb-2" type="submit">인증번호 받기</button>
                <div class="text-center"><a class="small" href="${ctx}/member/findpwd">Forgot password?</a></div>
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
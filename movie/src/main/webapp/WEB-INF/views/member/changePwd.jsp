<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="${ctx}/resources/css/find.css" rel="stylesheet" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/find.js"></script>
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
              <div class="form-label-group">
                <input type="password" id="pwd" class="form-control" placeholder="비밀번호" name="password">
                <label></label>
              </div>

              <div class="form-label-group">
                <input type="password" id="pwdChk" class="form-control" placeholder="비밀번호 확인" name="passwordCheck">
                <label></label>
              </div>
              <button class="btn btn-lg btn-primary btn-block text-uppercase" type="submit">비밀번호 변경</button>
              <hr class="my-4">
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
</body>
</html>
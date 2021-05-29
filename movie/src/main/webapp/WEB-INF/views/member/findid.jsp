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
            <h5 class="card-title text-center">아이디 찾기</h5>
            <form class="form-signin" action="${ctx}/member/find" method="post">
              <div class="form-label-group">
                <input type="text" id="inputName" class="form-control" placeholder="이름" name="name">
                <label></label>
              </div>

              <div class="form-label-group">
                <input type="email" id="inputEmail" class="form-control" placeholder="이메일" name="email">
                <label></label>
              </div>

              <button class="btn btn-lg btn-primary btn-block text-uppercase" type="submit">아이디 찾기</button>
              <hr class="my-4">
            </form>
              <button class="btn btn-lg btn-google btn-block text-uppercase" id="contract" style="border: 2px solid #000000;">회원가입</button>
              <div class="text-center"><a class="small" href="${ctx}/member/findPwd">비밀번호 찾기</a></div>
          </div>
        </div>
      </div>
    </div>
  </div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath == '/' ? '' : pageContext.request.contextPath }" scope="application"></c:set>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/mypage.js"></script>
<link href="${ctx}/resources/css/mypage.css" rel="stylesheet" />
<title>Insert title here</title>
</head>
<body>
<%@ include file="../header.jsp" %>
  <div class="container">
    <div class="row">
      <div class="col-sm-9 col-md-7 col-lg-5 mx-auto">
        <div class="card card-signin my-5">
          <div class="card-body">
            <h5 class="card-title text-center">내 정보</h5>
            <form class="form-signin" name="frm" method="post" action="${ctx}/member/updateForm">
              <div class="form-label-group">
                <input type="text" id="inputEmail" name="id" class="form-control" placeholder="Email address" autofocus value="${sessionScope.memList.id}" readonly="readonly">
                <label for="inputEmail">ID</label>
              </div>

              <div class="form-label-group">
                <input type="password" name="pwd" id="inputPassword" class="form-control" placeholder="Password" required maxlength="15">
                <label for="inputPassword">Password</label>
              </div>

              <button class="btn btn-lg btn-primary btn-block text-uppercase" type="button" name="change">정보 변경</button>
              <button class="btn btn-lg btn-danger btn-block text-uppercase" type="button" name="quit">회원 탈퇴</button>
              <input type="hidden" id="originPwd" value="${sessionScope.memList.pwd}">
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
</body>
</html>
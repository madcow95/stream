<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath == '/' ? '' : pageContext.request.contextPath }" scope="application"></c:set>
<html>
<head>
<meta charset="UTF-8">
<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">
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
                <input type="text" id="inputId" name="id1" class="form-control" value="${sessionScope.mDto.id}" readonly="readonly">
                <label for="inputId">ID</label>
              </div>
              <div class="form-label-group">
                <input type="password" name="pwd" id="password12" class="form-control" autofocus maxlength="15">
                <label for="inputPassword">Password</label>
              </div>
              <button class="btn btn-lg btn-primary btn-block text-uppercase" type="button" name="change">정보 변경</button>
              <button class="btn btn-lg btn-danger btn-block text-uppercase" type="button" name="exit">회원 탈퇴</button>
              <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
  <button name="test" data-toggle="modal" data-target=".bs-example-modal-lg9" style="display: none;"></button>
<div class="modal fade bs-example-modal-lg9" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg" >
    <div class="modal-content">
		<div class="container">
			<div class="row">
				<div class="col-sm-9 col-md-7 col-lg-5 mx-auto">
					<div class="card card-signin my-5">
						<div class="card-body">
							<h5 class="card-title text-center">회원 탈퇴</h5>
							<form action="${ctx}/member/exit" method="post" name="exitForm">
								<div class="form-group">
									<input type="text" name="exitId" class="form-control" placeholder="ID" value="${mDto.id}" readonly="readonly" style="font-size: 14px;">
								</div>
								<div class="form-group">
									<input type="password" name="exitPwd" class="form-control" placeholder="비밀번호를 입력해주세요" style="font-size: 14px;">
								</div>
								<button class="btn btn-lg btn-danger btn-block text-uppercase" type="button" name="realExit">회원 탈퇴</button>
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
    </div>
  </div>
</div>
</body>
</html>
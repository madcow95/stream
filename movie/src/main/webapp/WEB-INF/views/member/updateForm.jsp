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
<script type="text/javascript" src="${ctx}/resources/js/update.js"></script>
<link href="${ctx}/resources/css/update.css" rel="stylesheet" />
<title>Insert title here</title>
</head>
<body>
<%@ include file="../header.jsp" %>
  <div class="container">
    <div class="row">
      <div class="col-lg-10 col-xl-9 mx-auto">
        <div class="card card-signin flex-row my-5">
          <div class="card-body">
            <h5 class="card-title text-center">회원정보 수정</h5>
            <form class="form-signin" method="get" action="${ctx}/member/update">
              <div class="form-label-group">
                <input type="text" id="inputId" class="form-control" placeholder="Username" value="${sessionScope.memList.id}" disabled="disabled">
                <input type="hidden" name="originId" value="${sessionScope.memList.id}">
                <label for="inputID">User ID</label>
              </div>

              
              <div class="form-label-group">
                <input type="password" id="inputPassword" class="form-control" placeholder="Password" maxlength="15">
                <label for="inputPassword">Password</label>
              </div>
              
              <div class="form-label-group">
                <input type="password" id="inputConfirmPassword" class="form-control" placeholder="Password" maxlength="15">
                <label for="inputConfirmPassword">Confirm password</label>
              </div>
              
              <div class="form-label-group">
                <input type="email" id="inputEmail" class="form-control" placeholder="Email address" value="${sessionScope.memList.email}">
                <label for="inputEmail">Email address</label>
              </div>
              
              <div class="form-label-group" style="margin-bottom: 5px;">
                <input type="text" id="inputUserame" class="form-control" placeholder="Username" value="${sessionScope.memList.name}" disabled="disabled">
                <label for="inputUsername">User Name</label>
              </div>
              
	          <button type="button" class="btn btn-primary btn-sm" style="margin-bottom: 5px;" name="findAddr">주소찾기</button>
	          
              <div class="form-label-group">
                <input type="text" id="inputZip_num" class="form-control" placeholder="Post Code" value="${sessionScope.memList.zip_num}" disabled="disabled">
                <label for="inputZip_num">Post Code</label>
              </div>
              
              <div class="form-label-group">
                <input type="text" id="inputAddress" class="form-control" placeholder="Address" value="${sessionScope.memList.address}" disabled="disabled">
                <label for="inputAddress">Address</label>
              </div>
              
              <div class="form-label-group">
                <input type="text" id="inputPhone" class="form-control" placeholder="Phone" value="${sessionScope.memList.phone}" disabled="disabled">
                <label for="inputPhone">Phone</label>
              </div>

              <!-- <button class="btn btn-lg btn-primary btn-block text-uppercase" type="submit">Register</button> -->
              <p style="margin: 0 auto; text-align: center;">
  				<button type="button" class="btn btn-warning btn-lg">취소</button>
  				<button type="button" class="btn btn-primary btn-lg">정보 수정</button>
			  </p>
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath == '/' ? '' : pageContext.request.contextPath }" scope="application"></c:set>
<html>
<head>
<meta charset="UTF-8">
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/updateForm.js"></script>
<link href="${ctx}/resources/css/update.css" rel="stylesheet" />
<script type="text/javascript">
function findAddr() {
    new daum.Postcode({
        oncomplete: function(data) {
            document.getElementById("inputAddress").value = data.roadAddress + " ("+data.jibunAddress+") " + data.buildingName;
            document.getElementById("inputZip_num").value = data.zonecode;
        }
    }).open();
}
</script>
<title>Insert title here</title>
</head>
<body style="background-color: #ffffff;">
<%@ include file="../header.jsp" %>
  <div class="container">
    <div class="row">
      <div class="col-lg-10 col-xl-9 mx-auto">
        <div class="card card-signin flex-row my-5">
          <div class="card-body">
            <h5 class="card-title text-center">회원정보 수정</h5>
            <form class="form-signin" method="post" action="${ctx}/member/update">
              <div class="form-label-group">
                <input type="text" id="inputId" class="form-control" placeholder="Username" value="${sessionScope.mDto.id}" disabled="disabled">
                <input type="hidden" name="id" value="${sessionScope.mDto.id}">
                <label for="inputID">User ID</label>
              </div>

              <div class="form-label-group">
                <input type="password" id="inputPassword1" class="form-control" placeholder="Password" maxlength="15" name="pwd">
                <label for="inputPassword1">Password</label>
              </div>
              
              <div class="form-label-group">
                <input type="password" id="inputConfirmPassword" class="form-control" placeholder="Password" maxlength="15" name="pwdChk">
                <label for="inputConfirmPassword">Confirm password</label>
              </div>
              
              <div class="form-label-group">
                <input type="email" id="inputEmail1" class="form-control" placeholder="Email address" value="${sessionScope.mDto.email}" name="email">
                <label for="inputEmail1">Email address</label>
              </div>
              
              <div class="form-label-group" style="margin-bottom: 5px;">
                <input type="text" id="inputUserame" class="form-control" placeholder="Username" value="${sessionScope.mDto.name}" disabled="disabled">
                <label for="inputUsername">User Name</label>
              </div>
              
	          <button type="button" class="btn btn-primary btn-sm" style="margin-bottom: 5px;" onclick="findAddr()">주소찾기</button>
	          
              <div class="form-label-group">
                <input type="text" id="inputZip_num" class="form-control" placeholder="Post Code" value="${sessionScope.mDto.zip_num}" name="zip_num">
                <label for="inputZip_num">Post Code</label>
              </div>
              
              <div class="form-label-group">
                <input type="text" id="inputAddress" class="form-control" placeholder="Address" value="${sessionScope.mDto.address}" name="addr1">
                <label for="inputAddress">Address</label>
              </div>
              
              <div class="form-label-group">
                <input type="text" id="inputDetailAddress" class="form-control" placeholder="Detail Address" name="addr2">
                <label for="inputDetailAddress">Detail Address</label>
              </div>
              
              <div class="form-label-group">
                <input type="text" id="inputPhone" class="form-control" placeholder="Phone" value="${sessionScope.mDto.phone}" disabled="disabled">
                <label for="inputPhone">Phone</label>
              </div>

              <!-- <button class="btn btn-lg btn-primary btn-block text-uppercase" type="submit">Register</button> -->
              <p style="margin: 0 auto; text-align: center;">
  				<button type="button" class="btn btn-warning btn-lg" name="toList">취소</button>
  				<button type="button" class="btn btn-primary btn-lg" name="updateInfo" >정보 수정</button>
			  </p>
			  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" id="token">
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
</body>
</html>
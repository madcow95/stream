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
<script type="text/javascript">
	$(document).ready(function () {
		$("#codeChk").on("click", function () {
			var code = document.getElementById("rCode").value;
			var codeChk = document.getElementById("code").value;
			console.log("code , codeChk"+ code + codeChk);
			if(codeCheck(code, codeChk) == true) {
				console.log("true check")
				location.href="${ctx}/member/changePwd";
			} else {
				alert("인증번호가 일치하지 않습니다.");
			}
		});
		function codeCheck(code, codeChk) {
			console.log("code와 codeChk 체크"+code+"/"+codeChk);
			if(code == codeChk) {
				return true;
			} else {
				return false;
			}
		}
	});
</script>
<body>
<%@ include file="../header.jsp" %>
<input type="hidden" value="${code}" id="rCode">
  <div class="container">
    <div class="row">
      <div class="col-sm-9 col-md-7 col-lg-5 mx-auto">
        <div class="card card-signin my-5">
          <div class="card-body">
            <h5 class="card-title text-center">인증번호 입력</h5>
            <form class="form-signin" method="post">
              <div class="form-label-group">
                <input type="text" class="form-control" placeholder="인증번호입력" id="code">
                <label></label>
              </div>
              <hr class="my-4">
            </form>
              <button class="btn btn-lg btn-google btn-block text-uppercase" id="codeChk" style="border: 2px solid #000000;">인증번호 확인</button>
          </div>
        </div>
      </div>
    </div>
  </div>
</body>
</html>
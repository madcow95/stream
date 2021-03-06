<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath == '/' ? '' : pageContext.request.contextPath }" scope="application"></c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">
<link href="${ctx}/resources/css/find.css" rel="stylesheet" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/find.js"></script>
<title>Insert title here</title>
</head>
<script type="text/javascript">
	$(document).ready(function () {
		$("button[name='codeChkBtn']").on("click", function () {
			var insertCode = $("input[name=insertCode]").val();
			var encodedCode = $("input[name=rCode]").val();
			var id = $("input[name=id]").val();
			
			var codeList = new Object();
			codeList.insertCode = insertCode;
			codeList.encodedCode = encodedCode;
			codeList.id = id;
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");		
			$.ajax({
				url : "/member/codeChk",
				type : "post",
				data : JSON.stringify(codeList),
				contentType : "application/json; charset=UTF-8",
				beforeSend : function(xhr){
					xhr.setRequestHeader(header, token);
				},
				success : function (result) {
					if(result == "code_fail") {
						alert("인증번호가 일치하지 않습니다");
					} else if (result == id){
						alert("인증번호가 일치합니다.");
						location.href="${ctx}/member/changePwd?id="+id;
					}
				}
			}); // ajax end
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
            <h5 class="card-title text-center">인증번호 입력</h5>
            <form class="form-signin" method="post" name="frm">
              <div class="form-label-group">
                <input type="text" class="form-control" placeholder="인증번호입력" id="code" name="insertCode">
                <label></label>
              </div>
              <hr class="my-4">
			  <input type="hidden" value="${code}" id="rCode" name="rCode">
			  <input type="hidden" value="${id}" id="id" name="id">
              <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
              <button class="btn btn-lg btn-google btn-block text-uppercase" id="codeChk" style="border: 2px solid #000000;" type="button" name="codeChkBtn">인증번호 확인</button>
              
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
</body>
</html>
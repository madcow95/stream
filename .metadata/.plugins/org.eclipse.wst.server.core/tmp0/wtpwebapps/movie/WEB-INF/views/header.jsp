<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath == '/' ? '' : pageContext.request.contextPath }" scope="application"></c:set>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
</style>
<meta charset="UTF-8">
<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">
<title>Insert title here</title>
<link href="${ctx}/resources/css/styles.css" rel="stylesheet" />
<link rel="stylesheet" href="${ctx}/resources/css/login.css">
<link rel="stylesheet" href="${ctx}/resources/css/contract.css">
<script src="${ctx}/resources/js/scripts.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://use.fontawesome.com/releases/v5.15.3/js/all.js" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<script type="text/javascript">
	$(document).ready(function () {
		$("#navbarDropdownPortfolio").on("click", function () {
			$(".dropdown-menu dropdown-menu-right").slideToggle();
		});
		
		$(".chkAll").click(function() {
			$(".chkA").prop("checked", this.checked);
		});
		
		$("#toJoin").on("click", function () {
			if(document.getElementById("chk1").checked == true && document.getElementById("chk2").checked == true){
				document.getElementById("joinForm").action = "${ctx}/member/join";
				document.getElementById("joinForm").submit();
			} else {
				alert("약관에 동의해주세요");
			}
		});
		
		$("#toHome").on("click", function () {
			document.getElementById("joinForm").action = "/";
			document.getElementById("joinForm").submit();
		});
		
		$("#find").on("click", function () {
			location.href="${ctx}/member/findid";
		});
		
		/* $("#contract").on("click", function () {
			location.href="${ctx}/member/contract";
		}); */
		
		var loginBtn = $("button[name='loginBtn']");
		loginBtn.on("click", function () {
			var id = $("input[name=username]").val();
			var pwd = $("input[name=password]").val();
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			var loginInfo = new Object();
			loginInfo.id = id;
			loginInfo.pwd = pwd;
			if(id == "") {
				alert("아이디를 입력해주세요.");
				$("input[name=username]").focus();
			} else if(pwd == "") {
				alert("비밀번호를 입력해주세요.");
				$("input[name=password]").focus();
			} else {
				$.ajax({
					url : "${ctx}/login",
					type : "post",
					beforeSend : function(xhr){
						xhr.setRequestHeader(header, token);
					},
					data : "username="+id+"&password="+pwd,
					success : function (result) {
						console.log("ajax result >>> " + result);
						if(result == "loginsuccess"){
							location.href="/";
						} else {
							alert("입력한 정보를 확인해주세요");
						}
					}
				}); // ajax end
				/* document.loginfrm.submit(); */
			}
		}); // onclick end
	}); // on end
</script>
<body>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
  <div class="container">
      <a class="navbar-brand" href="${ctx}/">MOVIE</a>
      <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
      <div class="collapse navbar-collapse" id="navbarResponsive">
          <ul class="navbar-nav ml-auto">
          <sec:authentication property="principal" var="sec"/>
          <c:choose>
          	<c:when test="${empty sessionScope.mDto}">
          		<li class="nav-item"><button class="nav-link" style="border: 0px; background-color: #343A40;" data-toggle="modal" data-target=".bs-example-modal-lg">LOGIN</button></li>
  				<li class="nav-item"><button class="nav-link" style="border: 0px; background-color: #343A40;" data-toggle="modal" data-target=".bs-example-modal-lg1">JOIN</button></li>
          	</c:when>
          	<c:otherwise>
          		<sec:authorize access="hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')">
	          		<li class="nav-item"><a class="nav-link" href="${ctx}/member/mypage">${sessionScope.mDto.name}님</a></li>
          		</sec:authorize>
	   			<li class="nav-item"><a class="nav-link" href="${ctx}/logout">LOGOUT</a></li>
	   			<sec:authorize access="hasAnyRole({'ROLE_MEMBER', 'ROLE_ADMIN'})">
		   			<li class="nav-item"><a class="nav-link" href="${ctx}/member/mypage">MY PAGE</a></li>
          		</sec:authorize>
          	</c:otherwise>
          </c:choose>
	   			<sec:authorize access="hasAnyRole({'ROLE_MEMBER', 'ROLE_ADMIN'})">
		           	<li class="nav-item"><a href="${ctx}/board/list" class="nav-link" >BOARD</a></li>
          		</sec:authorize>
            </ul>
        </div>
    </div>
</nav>
<!-- login modal -->
<div class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
      </div>
      <div class="container">
    <div class="row">
      <div class="col-sm-9 col-md-7 col-lg-5 mx-auto">
        <div class="card card-signin my-5">
          <div class="card-body">
            <h5 class="card-title text-center">로그인</h5>
            <form class="form-signin" method="post" action="${ctx}/login" name="loginfrm">
              <div class="form-label-group">
                <input type="text" id="inputEmail" class="form-control" placeholder="ID" autofocus name="username">
                <label for="inputEmail">ID</label>
              </div>
              <div class="form-label-group">
                <input type="password" id="inputPassword" class="form-control" placeholder="Password"  name="password">
                <label for="inputPassword">Password</label>
              </div>
              <div class="form-label-group">
                <input type="text" name="failmessage" class="form-control" style="height: 25px; color: red; font-size: 8px; padding-top: 0px; padding-bottom:0px; text-align: center; border: 0px #ffffff; margin-top: 0px; background-color: #ffffff;" disabled="disabled" value="">
              </div>
              <button class="btn btn-lg btn-primary btn-block text-uppercase" type="button" name="loginBtn" style="margin-top: 0px;">Login</button>
              <hr class="my-4">
              <button type="button" class="btn btn-lg btn-google btn-block text-uppercase" id="contract" data-toggle="modal" data-target=".bs-example-modal-lg1">회원가입</button>
              <button type="button" class="btn btn-lg btn-facebook btn-block text-uppercase" id="find">아이디 / 비밀번호 찾기</button>
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

<!-- contact modal -->
<div class="modal fade bs-example-modal-lg1" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
      </div>
      <form action="" id="joinForm" name="frm" method="get" style="margin-bottom: 5%;">
		<ul class="join_box" style="margin-top: 20%;">
			<li class="checkBox check01">
				<ul class="clearfix">
					<li>이용약관, 개인정보 수집 및 이용, 위치정보 이용약관(선택), 프로모션 안내 메일 수신(선택)에 모두
						동의합니다.</li>
					<li class="checkAllBtn"><input type="checkbox" name="chkAll"
						id="chk" class="chkAll"></li>
				</ul>
			</li>
			<li class="checkBox check02">
				<ul class="clearfix">
					<li>이용약관 동의(필수)</li>
					<li class="checkBtn"><input type="checkbox" name="chk" id="chk1"
						class="chkA"></li>
				</ul> <textarea  readonly="readonly">여러분을 환영합니다.
OOO 서비스 및 제품(이하 ‘서비스’)을 이용해 주셔서 감사합니다. 본 약관은 다양한 OOO 서비스의 이용과 관련하여 OOO 서비스를 제공하는 OOO 주식회사(이하 ‘OOO’)와 이를 이용하는 OOO 서비스 회원(이하 ‘회원’) 또는 비회원과의 관계를 설명하며, 아울러 여러분의 OOO 서비스 이용에 도움이 될 수 있는 유익한 정보를 포함하고 있습니다.
       </textarea>
			</li>
			<li class="checkBox check03">
				<ul class="clearfix">
					<li>개인정보 수집 및 이용에 대한 안내(필수)</li>
					<li class="checkBtn"><input type="checkbox" name="chk" id="chk2"
						class="chkA"></li>
				</ul> <textarea readonly="readonly">여러분을 환영합니다.
OOO 서비스 및 제품(이하 ‘서비스’)을 이용해 주셔서 감사합니다. 본 약관은 다양한 OOO 서비스의 이용과 관련하여 OOO 서비스를 제공하는 OOO 주식회사(이하 ‘OOO’)와 이를 이용하는 OOO 서비스 회원(이하 ‘회원’) 또는 비회원과의 관계를 설명하며, 아울러 여러분의 OOO 서비스 이용에 도움이 될 수 있는 유익한 정보를 포함하고 있습니다.
       </textarea>
			</li>
		</ul>
		<p style="margin: 0 auto; text-align: center;">
 		 <button type="button" class="btn btn-default btn-lg" class="close" data-dismiss="modal" aria-label="Close" style="border: 1px solid #000000;">비동의</button>
		 <button type="button" class="btn btn-primary btn-lg" id="toJoin" >동의</button>
		</p>
	</form>
    </div>
  </div>
</div>
</body>
</html>
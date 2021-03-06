<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${ctx}/resources/css/join.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function () {
		$("button[name='joinBtn']").on("click", function () {
			var id = $("input[name='username1']");
			var pwd = $("input[name='pwd']");
			var name = $("input[name='name']");
			var gender = $("input[name='gender']");
			document.frm2.submit();
		});
	});
</script>
<title>Insert title here</title>
</head>
<body>
<%@ include file="header.jsp" %>
<form action="${ctx}/kakaojoin2" name="frm2" method="post" id="frm" style="margin-top: 10%;">
	<div id="wrapper">
		<div id="content">
			<div>
   				<h3 class="join_title"><label for="id">아이디</label></h3>
	   	 		<span class="box int_id">
        			<input type="text" id="username" class="int" maxlength="15" name="username1" value="${kakaoMap.email}" placeholder="4 ~ 15글자의 영어 + 숫자만 입력해주세요" style="font-size: 12px;" >
    				<input type="hidden" name="reid" id="reid">
				</span>
				<input type="text" id="idmessage" style="border: 0; width: 15cm; background-color: #f7f7f7;" disabled="disabled"><!-- <span id="idmessage"></span> -->
			</div>
			<div>
    			<h3 class="join_title"><label for="pswd1">비밀번호</label></h3>
    			<span class="box int_pass">
        			<input type="password" id="pwd" class="int" maxlength="20" name="pwd" style="font-size: 12px;" placeholder="6 ~ 20글자의 문자 + 숫자를 조합하면 좋아요">
				</span>
 				<input type="text" id="pwdmessage" style="border: 0; width: 15cm; background-color: #f7f7f7;" disabled="disabled">
			</div>
			<div>
    			<h3 class="join_title"><label for="pswd2">비밀번호 재확인</label></h3>
    			<span class="box int_pass_check">
        			<input type="password" id="pwdChk" class="int" maxlength="20" name="pwdChk" style="font-size: 12px;">
				</span>
 				<input type="text" id="pwdchkmessage" style="border: 0; width: 15cm; background-color: #f7f7f7;" disabled="disabled">
			</div>
			<div>
    			<h3 class="join_title"><label for="name">이름</label></h3>
    			<span class="box int_name">
        			<input type="text" id="iname" class="int" value="${kakaoMap.name}" maxlength="8" name="name" style="font-size: 12px;" onkeyup="engBlock(this)" placeholder="한글만 입력해주세요">
				</span>
				<input type="text" id="4" style="border: 0; width: 15cm; background-color: #f7f7f7;" disabled="disabled">
    			<span class="error_next_box"></span>
			</div>
			<div>
    			<h3 class="join_title"><label for="name">성별</label></h3>
    			<input type="text" value="${kakaoMap.gender}" name="gender">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    			<input type="radio" value="male">Male&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    			<input type="radio" value="femail">Female
			</div>
	         <div class="btn_area" >
    	         <p style="margin: 0 auto; text-align: center;">
  					<button type="button" class="btn btn-default btn-lg" style="border: 1px solid #000000;" id="toList">취소</button>
  					<button type="button" class="btn btn-primary btn-lg" id="join" name="joinBtn">회원가입</button>
				</p>
        	 </div>
     	</div> 
 </div> 
 <input type="hidden" name="category" value="${kakaoMap.category}" id="category">
 <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" id="token">
</form>
</body>
</html>
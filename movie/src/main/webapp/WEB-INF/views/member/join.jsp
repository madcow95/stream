<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath == '/' ? '' : pageContext.request.contextPath }" scope="application"></c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href="${ctx}/resources/css/join.css">
<script src="${ctx}/resources/js/join.js"></script>
<script type="text/javascript">
	$(document).ready(function () {
		$("#toList").on("click", function () {
			location.href="${ctx}/";
		});
	});
</script>
<title>Insert title here</title>
</head>
<body>
<%@ include file="../header.jsp" %>
<form action="/member/join" name="frm" method="post" id="frm" style="margin-top: 10%;">
	<div id="wrapper">
		<div id="content">
			<div>
   				<h3 class="join_title"><label for="id">아이디</label></h3>
	   	 		<span class="box int_id">
        			<input type="text" id="uid" class="int" maxlength="15" name="id" placeholder="4 ~ 15글자의 영어 + 숫자만 입력해주세요" style="font-size: 12px;" onkeyup="txtblock(this)" >
    				<input type="hidden" name="reid" id="reid">
				</span>
				<input type="text" id="idmessage" style="border: 0; width: 15cm; background-color: #ffffff;" disabled="disabled"><!-- <span id="idmessage"></span> -->
			</div>
			<div>
    			<h3 class="join_title"><label for="pswd1">비밀번호</label></h3>
    			<span class="box int_pass">
        			<input type="password" id="pwd" class="int" maxlength="20" name="pwd" style="font-size: 12px;" placeholder="6 ~ 20글자의 문자 + 숫자를 조합하면 좋아요">
				</span>
 				<input type="text" id="pwdmessage" style="border: 0; width: 15cm; background-color: #ffffff;" disabled="disabled">
			</div>
			<div>
    			<h3 class="join_title"><label for="pswd2">비밀번호 재확인</label></h3>
    			<span class="box int_pass_check">
        			<input type="password" id="pwdChk" class="int" maxlength="20" name="pwdChk" style="font-size: 12px;">
				</span>
 				<input type="text" id="pwdchkmessage" style="border: 0; width: 15cm; background-color: #ffffff;" disabled="disabled">
			</div>
			<div>
    			<h3 class="join_title"><label for="name">이름</label></h3>
    			<span class="box int_name">
        			<input type="text" id="iname" class="int" maxlength="8" name="name" style="font-size: 12px;" onkeyup="engBlock(this)" placeholder="한글만 입력해주세요">
				</span>
				<input type="text" id="" style="border: 0; width: 15cm; background-color: #ffffff;" disabled="disabled">
    			<span class="error_next_box"></span>
			</div>
			<div>
    			<h3 class="join_title"><label for="email">본인확인 이메일</label></h3>
    			<span class="box int_email">
        			<input type="text" id="email" class="int" maxlength="100" name="email" style="font-size: 12px;">
				</span>
				<input type="text" id="" style="border: 0; width: 15cm; background-color: #ffffff;" disabled="disabled">
            </div>
			<div>
                <h3 class="join_title"><label for="addr">우편번호&nbsp;&nbsp;<button type="button" onclick="findAddr()" id="findaddr" class="btn btn-info" style="background-color: #819FF7; border-color: #819FF7;">주소찾기</button></label></h3>
				<span class="box int_zip_num">
    				<input type="text" id="zip_num" class="int" maxlength="7" name="zip_num" style="font-size: 12px;">
				</span>
				<input type="text" id="" style="border: 0; width: 15cm; background-color: #ffffff;" disabled="disabled">
                <span class="error_next_box"></span>    
            </div>
			<div>
                <h3 class="join_title"><label for="addr">주소</label></h3>
            	    <span class="box int_addr">
	                    <input type="text" id="address" class="int" maxlength="100" name="address" style="font-size: 12px;">
					</span>
					<input type="text" id="" style="border: 0; width: 15cm; background-color: #ffffff;" disabled="disabled">
   				<span class="error_next_box"></span>    
			</div>
			<div>
    			<h3 class="join_title"><label for="phoneNo">휴대전화</label></h3>
   				<span class="box int_mobile">
    			    <input type="tel" id="mobile" class="int" maxlength="16" placeholder="'-' 를 빼고 입력해주세요" name="phone" style="font-size: 12px;">
    			</span>
    			<span class="error_next_box"></span>    
			</div>
	         <div class="btn_area" >
    	         <p style="margin: 0 auto; text-align: center;">
  					<button type="button" class="btn btn-default btn-lg" style="border: 1px solid #000000;" id="toList">취소</button>
  					<button type="submit" class="btn btn-primary btn-lg">회원가입</button>
				</p>
        	 </div>
     	</div> 
 </div> 
</form>
</body>
</html>
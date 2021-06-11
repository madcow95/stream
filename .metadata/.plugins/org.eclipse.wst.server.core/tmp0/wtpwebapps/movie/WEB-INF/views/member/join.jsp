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
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href="${ctx}/resources/css/join.css">
<script src="${ctx}/resources/js/join.js"></script>
<script type="text/javascript">
	$(document).ready(function () {
		
		$("#email").on("change keyup paste", function () {
			var email = this.value;
			var emailRule = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
			if(!emailRule.test(email)){
				$("#emailMessage").val("이메일 형식이 올바르지 않습니다.").css("color", "red").css("font-size", "10px")
				document.getElementById("emailCheck1").value = 0;
			} else {
				$("#emailMessage").val("");
				document.getElementById("emailCheck1").value = 1;
			}
		});
		
		$("#toList").on("click", function () {
			location.href="${ctx}/";
		});
		
		$("#emailCheck").on("click", function () {
			var email = document.getElementById("email").value;
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			if(document.getElementById("emailCheck1").value != 1 || email == ""){
				alert("이메일 형식을 확인해주세요");
				$("#email").focus();
			}
			 else {
					$.ajax({
						url : "${ctx}/member/emailCheck",
						type : "POST",
						data : "email="+email,
						beforeSend : function(xhr){
							xhr.setRequestHeader(header, token);
						},
						success : function (result) {
							if (result == "used") {
								$("#emailMessage").val("이미 사용중인 이메일입니다.").css("color", "red").css("font-size", "10px");
								document.getElementById("emailCheck1").value = 2;
							} else {
								$("#emailMessage").val("사용가능한 이메일입니다.").css("color", "blue").css("font-size", "10px");
								document.getElementById("emailCheck1").value = 3;
								/* change(result); */
							}
							
						}
					}); // ajax end
			}
		});
	});
	
	function change(result) {
		if(result == "canuse"){
			document.getElementById("emailCheck1").value = 1;
		}
	}
	
	function findAddr() {
	    new daum.Postcode({
	        oncomplete: function(data) {
	            document.getElementById("address").value = data.roadAddress + " ("+data.jibunAddress+") " + data.buildingName;
	            document.getElementById("zip_num").value = data.zonecode;
	            document.getElementById("DetailAddress").focus();
	        }
	    }).open();
	}
	
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
        			<input type="text" id="iname" class="int" maxlength="8" name="name" style="font-size: 12px;" onkeyup="engBlock(this)" placeholder="한글만 입력해주세요">
				</span>
				<input type="text" id="4" style="border: 0; width: 15cm; background-color: #f7f7f7;" disabled="disabled">
    			<span class="error_next_box"></span>
			</div>
			<div style="margin-bottom: 15px;">
    			<h3 class="join_title"><label for="email">본인확인 이메일&nbsp;&nbsp;<button type="button" id="emailCheck" class="btn btn-info" style="background-color: #819FF7; border-color: #819FF7;">이메일 중복확인</button></label></h3>
    			<span class="box int_email">
        			<input type="text" id="email" class="int" maxlength="100" name="email" style="font-size: 12px;" placeholder="이메일을 입력해주세요">
        			<input type="hidden" id="emailCheck1" name="emailCheck1" value="0">
				</span>
				<input type="text" id="emailMessage" style="border: 0; width: 15cm; background-color: #f7f7f7;" disabled="disabled">
            </div>
			<div>
                <h3 class="join_title"><label for="addr">우편번호&nbsp;&nbsp;<button type="button" onclick="findAddr()" id="findaddr" class="btn btn-info" style="background-color: #819FF7; border-color: #819FF7;">주소찾기</button></label></h3>
				<span class="box int_zip_num">
    				<input type="text" id="zip_num" class="int" maxlength="7" name="zip_num" style="font-size: 12px;" readonly="readonly" placeholder="주소 찾기로 입력됩니다.">
				</span>
				<input type="text" id="2" style="border: 0; width: 15cm; background-color: #f7f7f7;" disabled="disabled">
                <span class="error_next_box"></span>    
            </div>
			<div>
                <h3 class="join_title"><label for="addr">주소</label></h3>
            	    <span class="box int_addr">
	                    <input type="text" id="address" class="int" maxlength="100" name="address" style="font-size: 12px;" readonly="readonly" placeholder="주소 찾기로 입력됩니다.">
					</span>
					<input type="text" id="3" style="border: 0; width: 15cm; background-color: #f7f7f7;" disabled="disabled">
   				<span class="error_next_box"></span>    
			</div>
			<div>
                <h3 class="join_title"><label for="addr">상세주소</label></h3>
            	    <span class="box int_addr">
	                    <input type="text" id="DetailAddress" class="int" maxlength="100" name="DetailAddress" style="font-size: 12px;" placeholder="상세 주소를 입력해주세요.">
					</span>
					<input type="text" id="5" style="border: 0; width: 15cm; background-color: #f7f7f7;" disabled="disabled">
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
  					<button type="button" class="btn btn-primary btn-lg" id="join">회원가입</button>
				</p>
        	 </div>
     	</div> 
 </div> 
 <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" id="token">
</form>
</body>
</html>
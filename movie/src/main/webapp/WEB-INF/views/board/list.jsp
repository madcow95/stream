<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath == '/' ? '' : pageContext.request.contextPath }" scope="application"></c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	#wrapper {
		padding-left: 5%;
		padding-right: 5%;
		padding-top: 5%;
	}
</style>
</head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
//	var result = '<c:out value="${result}"/>';
	var result = "${result}";
	
	// 파라메터에 따라서 모달창을 보여주거나 내용을 수정한 뒤 보이도록 작성하기 위함.
	//checkModal(result);
	
	// history 객체에 현재 저장된 데이터를 변경 (새 기록을 작성하는 대신 사용자의 동작에 따라 현재 히스토리 엔트리의 URL을 업데이트 하려고 할 때 매우 유용)
	// window.history.replace(data, title [, url]);
	// 사용 예) window.history.replaceState("http://example.ca", "Sample Title", "/example/path.html");
    // 이 예제는 현재 기록, 주소 표시 줄 및 페이지 제목을 바꿉니다.
	history.replaceState({}, null, null);
	
	function checkModal(result) {
		if (result === "" || history.state) {
			return;
		}

		if (parseInt(result) > 0) {
			$(".modal-body").html("게시글 " + parseInt(result) + " 번이 등록되었습니다.");
		}

		$("#myModal").modal("show");
    }
	
	$("#regBtn").on("click", function() {
		self.location = "${contextPath}/board/register";
	});
	
	// 페이지 번호를 클릭하면 처리하는 부분
	var actionForm = $("#actionForm");
	$(".page-item a").on("click", function(e) {
		e.preventDefault(); // <a>태그를 클릭해도 페이지 이동이 없도록 처리
		
		console.log("click");

		actionForm.find("input[name='pageNum']").val($(this).attr("href"));
		actionForm.submit();
	});

	$(".move").on("click", function(e) {
		e.preventDefault();
		actionForm.append("<input type='hidden' name='articleno' value='"
										+ $(this).attr("href")
										+ "'>");
		actionForm.attr("action", "${contextPath}/board/read");
		actionForm.submit();
	});

	var searchForm = $("#searchForm");

	$("#searchForm button").on("click", function(e) {
		if (!searchForm.find("option:selected").val()) {
			alert("검색종류를 선택하세요");
			
			return false;
		}

		if (!searchForm.find("input[name='keyword']").val()) {
			alert("키워드를 입력하세요");
			$("input[name='keyword']").focus();
			return false;
		}

		searchForm.find("input[name='pageNum']").val("1");
		
		e.preventDefault();

		searchForm.submit();
	});
	
});
</script>
<%@ include file="../header.jsp" %>
<body>
<div id="wrapper">
        <div id="page-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">공지사항</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <select class="form-control" onchange="window.location.href=this.value" style="border: 1px solid #000000; margin-bottom: 5px;">
			  <!-- <option>선택</option> -->
			  <option value="${ctx}/board/list">선택</option>
			  <option value="${ctx}/board/list">공지사항</option>
			  <option value="${ctx}/board/freeBoard">자유게시판</option>
			  <option value="${ctx}/board/movieBoard" id="movie">영화정보</option>
			  <option value="${ctx}/board/movieBoardtest" id="movie">영화정보_testVER</option>
			</select>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="table-responsive">
                            <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                                <thead>
                                    <tr>
                                        <th>번호</th>
                                        <th>작성자</th>
                                        <th>제목</th>
                                        <th>날짜</th>
                                        <th>조회수<a style="cursor: pointer;">∇</a></th>
                                    </tr>
                                </thead>
                                <tbody>
                                	<c:choose>
                                		<c:when test="${empty boardList}">
	                                		<tr height="10">
												<th colspan="5">
													<p align="center">
														<b><span style="font-size: 20px;">등록된 글이 없습니다.</span></b>
													</p>
												</th>
											</tr>
                                		</c:when>
                                		<c:when test="${!empty boardList}">
		                                	<c:forEach items="${boardList}" var="boardList" varStatus="status">
			                                	<tr class="odd gradeX">
			                                        <td width="10%">${boardList.articleno }</td>
			                                        <td width="15%">${boardList.id}</td>
			                                        <td width="50%">
			                                        <c:choose>
				                                        <c:when test="${boardList.re_level > 1}">
				                                        	<c:forEach begin="2" end="${boardList.re_level}" step="1">
				                                        		<span></span>
				                                        	</c:forEach>
				                                        	<span style="padding-left: 10px;">[답변]</span>
					                                        <a href="${ctx}/board/read?pageNum=${pageMaker.cri.pageNum}&articleno=${boardList.articleno}&type=${pageMaker.cri.type}&keyword=${pageMaker.cri.keyword}">${boardList.subject}</a>
				                                        </c:when>
				                                        <c:otherwise>
					                                        <a href="${ctx}/board/read?pageNum=${pageMaker.cri.pageNum}&articleno=${boardList.articleno}&type=${pageMaker.cri.type}&keyword=${pageMaker.cri.keyword}">${boardList.subject}</a>
				                                        </c:otherwise>
			                                        </c:choose>
			                                        </td>
			                                        <td width="15%">${boardList.reg_date}</td>
			                                        <td width="10%">${boardList.readcount}</td>
			                                    </tr>
			                                </c:forEach>
                                		</c:when>
                                	</c:choose>
                                </tbody>
                            </table>
                            <div class='center' >
								<ul class="pagination justify-content-center" >
									<c:if test="${pageMaker.prev}">
										<li class="page-item previous"><a class="page-link" href="${pageMaker.startPage -1}">Previous</a></li>
									</c:if>
									<c:forEach var="num" begin="${pageMaker.startPage}"	end="${pageMaker.endPage}">
										<li class="page-item  ${pageMaker.cri.pageNum == num ? "active":""} ">
											<a href="${num}" class="page-link">${num}</a>
										</li>
									</c:forEach>
									<c:if test="${pageMaker.next}">
										<li class="page-item next"><a class="page-link" href="${pageMaker.endPage +1 } ">Next</a></li>
									</c:if>
								</ul>
							</div>
							<div class="row" style="margin: 0 auto; text-align: center;">
								<div class="col-lg-12">
									<form id="searchForm" action="${ctx}/board/list" method="get">
										<select name="type" >
											<option value="" <c:out value="${pageMaker.cri.type == null?'selected':''}"/>>선택</option>
											<option value="T" <c:out value="${pageMaker.cri.type eq 'T'?'selected':''}"/>>제목</option>
											<option value="C" <c:out value="${pageMaker.cri.type eq 'C'?'selected':''}"/>>내용</option>
											<option value="W" <c:out value="${pageMaker.cri.type eq 'W'?'selected':''}"/>>작성자</option>
											<option value="TC" <c:out value="${pageMaker.cri.type eq 'TC'?'selected':''}"/>>제목 + 내용</option>
											<option value="TW" <c:out value="${pageMaker.cri.type eq 'TW'?'selected':''}"/>>제목 + 작성자</option>
										</select>
										<input type="text" style="width: 8cm;" name="keyword" placeholder="검색어를 입력하세요" value="${pageMaker.cri.keyword}">
										<button class="btn btn-default">검색</button>
									</form>
								</div>
							</div>
                            <form id='actionForm' action="${ctx}/board/list" method='get'>
								<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum}'>
								<input type='hidden' name='amount' value='${pageMaker.cri.amount}'>
								<input type='hidden' name='type' value='${pageMaker.cri.type}'>
								<input type='hidden' name='keyword' value='${pageMaker.cri.keyword}'>
							</form>
                            <!-- /.table-responsive -->
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
        </div>
        <!-- /#page-wrapper -->
    </div>
</body>
</html>
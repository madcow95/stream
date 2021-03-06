<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath == '/' ? '' : pageContext.request.contextPath }" scope="application"></c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">
<title>Insert title here</title>
<style type="text/css">
	.row {
		padding-left: 5%;
		padding-right: 5%;
		padding-top: 5%;
	}
	
	.uploadResult {
		width:100%;
		background-color: gray;
	}
	
	.uploadResult ul{
		display:flex;
		flex-flow: row;
		justify-content: center;
		align-items: center;
	}
	
	.uploadResult ul li {
		list-style: none;
		padding: 10px;
		align-content: center;
		text-align: center;
	}
	
	.uploadResult ul li img{
		width: 100px;
	}
	
	.uploadResult ul li span {
		color:white;
	}
	
	.bigPictureWrapper {
		position: absolute;
		display: none;
		justify-content: center;
		align-items: center;
		top:0%;
		width:100%;
		height:100%;
		background-color: gray; 
		z-index: 100;
		background:rgba(255,255,255,0.5);
	}
	
	.bigPicture {
		position: relative;
		display:flex;
		justify-content: center;
		align-items: center;
	}
	
	.bigPicture img {
		width:600px;
	}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <link href="${ctx}/resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="${ctx}/resources/vendor/metisMenu/metisMenu.min.css" rel="stylesheet">
    <link href="${ctx}/resources/vendor/datatables-plugins/dataTables.bootstrap.css" rel="stylesheet">
    <link href="${ctx}/resources/vendor/datatables-responsive/dataTables.responsive.css" rel="stylesheet">
    <link href="${ctx}/resources/dist/css/sb-admin-2.css" rel="stylesheet">
    <link href="${ctx}/resources/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link href="${ctx}/resources/css/register.css">
    <script src="${ctx}/resources/vendor/bootstrap/js/bootstrap.min.js"></script>
    <script src="${ctx}/resources/vendor/metisMenu/metisMenu.min.js"></script>
    <script src="${ctx}/resources/vendor/datatables/js/jquery.dataTables.min.js"></script>
    <script src="${ctx}/resources/vendor/datatables-plugins/dataTables.bootstrap.min.js"></script>
    <script src="${ctx}/resources/vendor/datatables-responsive/dataTables.responsive.js"></script>
    <script type="text/javascript" src="${ctx}/resources/js/reply.js"></script>
<script type="text/javascript">
	
	
	$(document).ready(function () {
		var operForm = $("#operForm")
		$("button[data-oper = 'list']").on("click", function (e) {
			/* operForm.attr("action", "${ctx}/board/freeBoard").submit(); */
		});
		
		/* $("button[data-oper = 'modify']").on("click", function () {
			/* operForm.submit(); */
			/* alert("asdf"); */
		/* }); */
		
		var scopeId = document.getElementById("scopeId").value;
		
		var articleno = "${boardList.articleno}";
		var replyUL = $(".chat");
		  
	    var pageNum = 1;
	    var replyPageFooter = $(".panel-footer");
	    
	    
	    $("button[data-oper='remove']").on("click", function () {
			var articleno = $("input[name=articleno]").val();
			location.href="${ctx}/board/freeboarddel?articleno="+articleno;
		});
	    
	    var replyUL = $(".chat");
		  
		showList(1);
		
		function showList(page) {
			console.log("show list " + page);
			console.log("articleno " + articleno);
			
			replyService.getList(
					{articleno:articleno, contextPath:"${ctx}", page: page || 1 }, 
					function(replyCnt, list) {
						console.log("replyCnt: "+ replyCnt );
						console.log("list: " + list);
						if(page == -1){
							pageNum = Math.ceil(replyCnt/10.0);
							showList(pageNum);
							return;
						}
						  
						var str="";
						 
						if(list == null || list.length == 0){
							return;
						}
						for (var i = 0, len = list.length || 0; i < len; i++) {
							str +="<sec:authentication property='principal' var='sec'/><li class='left clearfix' data-rno='"+list[i].rno+"'>";
							str +="  <div><div class='header'><strong class='primary-font'>["
								+ list[i].rno+"] "+list[i].id+"</strong>&nbsp;&nbsp;<button class='btn btn-danger' type='button'";														
							str	+=' onclick="replyDel('+list[i].rno+', ' + '\'' + list[i].id +'\'' + ')">??????</button>&nbsp;&nbsp;<button type="button" style="display: none;" data-toggle="modal" data-target=".bs-example-modal-lg2" class="btn btn-warning" >??????</button>';
							str +="    <small class='pull-right text-muted'>"
								+ replyService.displayTime(list[i].updatedate)+"</small></div>";
							str +="   <p>"+list[i].replytext+"</p></div></li>";
						}
						 
						replyUL.html(str);
						 
						showReplyPage(replyCnt);
						
			});//end function
		}//end showList
	});
</script>
<script type="text/javascript">
	/* var operForm = $("#operForm"); 
		$("button[data-oper='modify']").on("click", function(e){
	  	operForm.attr("action","${ctx}/board/modify").submit();
	}); */
$(document).ready(function() {
	var modifyForm = $("#modifyForm");
	$("#modify").on("click", function () {
		var articleno = $("input[name='artno']").val();
		var title = $("input[name='title']").val();
		var content = $("textarea[name='content']").val();
		modifyForm.submit();
	});
	
});
</script>

<script>
$(document).ready(function() {
	  (function() {
	  	var articleno = "${boardList.articleno}";
	    
	    $.getJSON("${ctx}/board/getAttachList", {articleno: articleno}, function(arr) {
	        
	       console.log("arr test"+arr);
	       
	       var str = "";
	       
	       $(arr).each(function(i, attach){
	       
	         if(attach.filetype){
	           var fileCallPath =  encodeURIComponent(attach.uploadPath+ "/s_" + attach.uuid +"_" + attach.fileName);
	           
	           str += "<li data-path='" + attach.uploadPath + "' data-uuid='" + attach.uuid + "' data-filename='" + attach.fileName + "' data-type='" + attach.filetype + "' ><div>";
	           str += "<img src='${ctx}/upload/display?fileName=" + fileCallPath+"'>";
	           str += "</div>";
	           str +"</li>";
	         } else {
	           str += "<li data-path='" + attach.uploadPath + "' data-uuid='" + attach.uuid + "' data-filename='" + attach.fileName + "' data-type='" + attach.filetype+"' ><div>";
	           str += "<span> "+ attach.fileName + "</span><br/>";
	           str += "<img src='${ctx}/resources/image/thumbnail.jpg'style='cursor: pointer;'></a>";
	           str += "</div>";
	           str +"</li>";
	         }
	       });
	       
	       $(".uploadResult ul").html(str);
	     });//end getjson
	  })();//end function
	  
	  $(".uploadResult").on("click","li", function(e){
	      
	    console.log("view image");
	    
	    var liObj = $(this);
	    
	    var path = encodeURIComponent(liObj.data("path")+"/" + liObj.data("uuid")+"_" + liObj.data("filename"));

	    if(liObj.data("type")){
	      showImage(path.replace(new RegExp(/\\/g),"/"));
	    } else {
	      self.location ="${ctx}/upload/download?fileName=" + path;
	    }
	    
	    
	  });
	  
	  function showImage(fileCallPath){
	    $(".bigPictureWrapper").css("display","flex").show();
	    
	    $(".bigPicture")
	    .html("<img src='${ctx}/upload/display?fileName="+fileCallPath+"' >")
	    .animate({width:"100%", height: "100%"}, 1000);
	    
	  }

	  $(".bigPictureWrapper").on("click", function(e){
	    $(".bigPicture").animate({width:"0%", height: "0%"}, 1000);
	    setTimeout(function(){
	      $(".bigPictureWrapper").hide();
	    }, 1000);
	  });
	});
</script>
</head>
<body>
<%-- <%@ include file="../header.jsp" %> --%>
<div class="row">
  <div class="col-lg-12">
    <div class="panel panel-default">
      <!-- /.panel-heading -->
      <div class="panel-body">
        <form role="form" action="${ctx}/board/modifyBoard" method="POST" id="modifyForm">
          <div class="form-group">
            <label>Articleno</label> <input class="form-control" name='articleno' value="${boardList.articleno }" readonly="readonly">
            <%-- <input type="hidden" name='artno' value="${boardList.articleno }"> --%>
          </div>
          <div class="form-group">
            <label>Subject</label> <input class="form-control" name='title' value="${boardList.title }">
          </div>

          <div class="form-group">
            <label>Content</label>
            <textarea class="form-control" rows="3" name='content' >${boardList.content }</textarea>
          </div>

          <div class="form-group">
            <label>ID</label> <input class="form-control" name='id' value="${boardList.id }" disabled="disabled">
          </div>
          <div class="form-group">
            <label>RegDate</label> <input class="form-control" name='regdate' value="${boardList.regdate}" disabled="disabled">
          </div>
          <div class="form-group" style="margin: 0 auto; text-align: center;">
          <sec:authentication property="principal" var="sec"/>
          	<sec:authorize access="isAuthenticated()">
          		<c:if test="${sec.username eq boardList.id}">
		          <button class="btn btn-primary" data-oper="modify" id="modify">Modify</button>
		          <button type="button" class="btn btn-danger" data-oper="remove" id="remove">Delete</button>
          		</c:if>
          	</sec:authorize>
	          <button data-oper="list" class="btn btn-default" style="border: 1px solid #000000;">Prev</button>
          </div>
          <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
          </form>
          <form action="${ctx}/board/modify" method="get" id="operForm">
          	<input type="hidden" id="articleno" name="articleno" value="${boardList.articleno}">
          	<input type="hidden" id="pageNum" name="pageNum" value="${cri.pageNum}">
          	<input type="hidden" id="type" name="type" value="${cri.type}">
          	<input type="hidden" id="keyword" name="keyword" value="${cri.keyword}">
          	<input type="hidden" id="scopeId" name="scopeId" value="${sessionScope.mDto.id}">
          	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
          </form>
        <!-- </form> -->
      </div>
      <!--  end panel-body -->
    </div>
    <!--  end panel-body -->
  </div>
  <!-- end panel -->
</div>

<div class='bigPictureWrapper'>
  <div class='bigPicture'>
  </div>
</div>

<div class="row">
  <div class="col-lg-12">
    <div class="panel panel-default">

      <div class="panel-heading">Files</div>
      <!-- /.panel-heading -->
      <div class="panel-body">
        
        <div class="uploadResult"> 
          <ul>
          </ul>
        </div>
      </div>
      <!--  end panel-body -->
    </div>
    <!--  end panel-body -->
  </div>
  <!-- end panel -->
</div>
<!-- /.row -->
<div class='row'>
  <div class="col-lg-12">

    <!-- /.panel -->
  </div>
  <!-- ./ end row -->
</div>
<div class="panel-body">        
        <ul class="chat">
        </ul>
        <!-- ./ end ul -->
      </div>
</body>
</html>
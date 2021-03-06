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
    <script src="${ctx}/resources/dist/js/sb-admin-2.js"></script>
    
<script type="text/javascript">
$(document).ready(function() {
	var formObj = $("form[role='form']");
	
	$("button[type='submit']").on("click", function(e){
		e.preventDefault();
		    
		console.log("submit clicked");
		var str = "";
		    
		$(".uploadResult ul li").each(function(i, obj){
			var jobj = $(obj);
		      
			console.dir(jobj);
			console.log("-------------------------");
			console.log(jobj.data("filename"));
		      
			str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
			str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
			str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
			str += "<input type='hidden' name='attachList["+i+"].filetype' value='"+ jobj.data("type")+"'>";
		});
		    
		console.log(str);
		formObj.append(str).submit();
	});
		  
	var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
	var maxSize = 5242880; //5MB
		  
	function checkExtension(fileName, fileSize) {
		if(fileSize >= maxSize) {
			alert("?????? ????????? ??????");
			return false;
		}
		    
		if(regex.test(fileName)) {
			alert("?????? ????????? ????????? ???????????? ??? ????????????.");
			return false;
		}
		
		return true;
	}
	
	$("input[type='file']").change(function(e){

		var formData = new FormData();
		    
		var inputFile = $("input[name='uploadFile']");
		    
		var files = inputFile[0].files;
		
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		    
		for(var i = 0; i < files.length; i++){

			if(!checkExtension(files[i].name, files[i].size) ){
				return false;
			}
			
			formData.append("uploadFile", files[i]);
		}
		    
		$.ajax({
			url: "${ctx}/upload/uploadAjaxAction",
			processData: false, 
			contentType: false,data: 
			formData,type: "POST",
			dataType:"json",
			beforeSend : function(xhr) {
				xhr.setRequestHeader(header, token);
			},
			success: function(result){
				console.log(result); 
				showUploadResult(result); 
			}
		}); //$.ajax
	});  

	function showUploadResult(uploadResultArr) {
		    
	    if(!uploadResultArr || uploadResultArr.length == 0) { 
	    	return;
	    }
		    
	    var uploadUL = $(".uploadResult ul");
	    var str ="";
		    
	    $(uploadResultArr).each(function(i, obj) {
			if(obj.image){
				var fileCallPath = encodeURIComponent(obj.uploadPath+ "/s_" + obj.uuid + "_" + obj.fileName);
				str += "<li data-path='" + obj.uploadPath + "'";
				str +=" data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName + "' data-type='" + obj.image + "'"
				str +" ><div>";
				str += "<span> " + obj.fileName + "</span>";
				str += "<button type='button' data-file=\'" + fileCallPath + "\' "
				str += "data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
				str += "<img src='${ctx}/upload/display?fileName=" + fileCallPath + "'>";
				str += "</div>";
				str +"</li>";
			} else {
				var fileCallPath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);			      
			    var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");
				      
				str += "<li "
				str += "data-path='" + obj.uploadPath + "' data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName + "' data-type='" + obj.image + "' ><div>";
				str += "<span> " + obj.fileName + "</span>";
				str += "<button type='button' data-file=\'" + fileCallPath + "\' data-type='file' " 
				str += "class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
				str += "<img src='${contextPath}/resources/img/attach.png'></a>";
				str += "</div>";
				str +"</li>";
			}
		});
		    
		uploadUL.append(str);
	}

	$(".uploadResult").on("click", "button", function(e) {
		    
		console.log("delete file");
		      
		var targetFile = $(this).data("file");
		var type = $(this).data("type");
		var targetLi = $(this).closest("li");
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		    
		$.ajax({
			url: "${ctx}/upload/deleteFile",
			data: {fileName: targetFile, type:type},
			dataType:"text",
			type: "POST",
			beforeSend : function(xhr){
				xhr.setRequestHeader(header, token);
			},
			success: function(result){
				alert(result);
		           
				targetLi.remove();
			}
		}); //$.ajax
	});

});
</script>
<title>Insert title here</title>

</head>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"></script>
<body>
<%@ include file="../header.jsp" %>

<%-- <form method="post" style="margin-left: 15%; margin-right: 15%; margin-top: 5%;" action="${ctx}/board/register" role="form">
     <div class="form-group">
            <label>Title</label> <input class="form-control" name="subject">
     </div>
     <div class="form-group">
            <label>Writer</label> <input class="form-control" name="id" value="${sessionScope.mDto.id}" readonly="readonly">
     </div>
     <div class="form-group">
            <label>Text area</label>
            <textarea class="form-control" rows="3" name="content"></textarea>
     </div>
		<div style="margin: 0 auto; text-align: center;">
	     <button type="submit" class="btn btn-info">????????????</button>
	     <button type="button" class="btn btn-secondary">????????????</button>
		</div>
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
</form>
	 <div class="row">
	  <div class="col-lg-12">
	    <div class="panel panel-default">
	      <div class="panel-heading">File Attach</div>
	      <div class="panel-body">
		    <div class="form-group uploadDiv">
	            <input type="file" name="uploadFile" multiple>
	        </div>
	        <div class="uploadResult"> 
	          <ul>
		          
	          </ul>
		        </div>
		      </div>
		    </div>
		  </div>
		</div> --%>
		
		
		
		<div class="row" >
  <div class="col-lg-12" >
    <h1 class="page-header">Board Register</h1>
  </div>
  <!-- /.col-lg-12 -->
</div>
<!-- /.row -->

<div class="row" >
  <div class="col-lg-12" >
    <div class="panel panel-default" style="margin-left: 15%; margin-right: 15%;">

      <div class="panel-heading">Board Register</div>
      <!-- /.panel-heading -->
      <div class="panel-body" >

        <form role="form" action="${contextPath}/board/register" method="post">
          <div class="form-group">
            <label>Title</label> <input class="form-control" name="title">
          </div>

          <div class="form-group">
            <label>Text area</label>
            <textarea class="form-control" rows="3" name="content"></textarea>
          </div>

          <div class="form-group">
            <label>Writer</label> <input class="form-control" name="id" value="${sessionScope.mDto.id}" readonly="readonly">
          </div>
          <button type="submit" class="btn btn-default">Submit
            Button</button>
          <button type="reset" class="btn btn-default">Reset Button</button>
          <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
        </form>

      </div>
    </div>
  </div>
</div>
<div class="row">
  <div class="col-lg-12">
    <div class="panel panel-default" style="margin-left: 15%; margin-right: 15%;">

      <div class="panel-heading">File Attach</div>
      <div class="panel-body">
        <div class="form-group uploadDiv">
            <input type="file" name="uploadFile" multiple>
        </div>
        
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
            <h5 class="card-title text-center">?????????</h5>
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
              <button type="button" class="btn btn-lg btn-google btn-block text-uppercase" id="contract" data-toggle="modal" data-target=".bs-example-modal-lg1">????????????</button>
              <button type="button" class="btn btn-lg btn-facebook btn-block text-uppercase" id="find">????????? / ???????????? ??????</button>
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
					<li>????????????, ???????????? ?????? ??? ??????, ???????????? ????????????(??????), ???????????? ?????? ?????? ??????(??????)??? ??????
						???????????????.</li>
					<li class="checkAllBtn"><input type="checkbox" name="chkAll"
						id="chk" class="chkAll"></li>
				</ul>
			</li>
			<li class="checkBox check02">
				<ul class="clearfix">
					<li>???????????? ??????(??????)</li>
					<li class="checkBtn"><input type="checkbox" name="chk" id="chk1"
						class="chkA"></li>
				</ul> <textarea  readonly="readonly">???????????? ???????????????.
OOO ????????? ??? ??????(?????? ???????????????)??? ????????? ????????? ???????????????. ??? ????????? ????????? OOO ???????????? ????????? ???????????? OOO ???????????? ???????????? OOO ????????????(?????? ???OOO???)??? ?????? ???????????? OOO ????????? ??????(?????? ????????????) ?????? ??????????????? ????????? ????????????, ????????? ???????????? OOO ????????? ????????? ????????? ??? ??? ?????? ????????? ????????? ???????????? ????????????.
       </textarea>
			</li>
			<li class="checkBox check03">
				<ul class="clearfix">
					<li>???????????? ?????? ??? ????????? ?????? ??????(??????)</li>
					<li class="checkBtn"><input type="checkbox" name="chk" id="chk2"
						class="chkA"></li>
				</ul> <textarea readonly="readonly">???????????? ???????????????.
OOO ????????? ??? ??????(?????? ???????????????)??? ????????? ????????? ???????????????. ??? ????????? ????????? OOO ???????????? ????????? ???????????? OOO ???????????? ???????????? OOO ????????????(?????? ???OOO???)??? ?????? ???????????? OOO ????????? ??????(?????? ????????????) ?????? ??????????????? ????????? ????????????, ????????? ???????????? OOO ????????? ????????? ????????? ??? ??? ?????? ????????? ????????? ???????????? ????????????.
       </textarea>
			</li>
		</ul>
		<p style="margin: 0 auto; text-align: center;">
 		 <button type="button" class="btn btn-default btn-lg" id="toHome" style="border: 1px solid #000000;">?????????</button>
		 <button type="button" class="btn btn-primary btn-lg" id="toJoin" >??????</button>
		</p>
	</form>
    </div>
  </div>
</div>
</body>
</html>
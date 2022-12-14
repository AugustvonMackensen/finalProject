<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<style type="text/css">
.imgFile {
   display: none;
}
.rightbtn3{
    font-size: 12px;
    width: 5rem;
    border-radius: 10px;
    height: 3.2rem;
    background-color: #fff;
    color: #7c7474;
    border: 1px solid #aaa;
    font-family: 'Noto Sans KR', sans-serif;
}

#loading {
   width: 100%;
   height: 100%;
   top: 0;
   left: 0;
   position: fixed;
   display: block;
   opacity: 0.8;
   background: white;
   z-index: 99;
   text-align: center;
}

#loading>img {
   position: absolute;
   top: 50%;
   left: 50%;
   z-index: 100;
}

#loading > p {
       position: absolute;
       top: 56%;
       left: 49%;
       z-index: 101;
    }
</style>
<script src="https://unpkg.com/dropzone@5/dist/min/dropzone.min.js"></script>
<link rel="stylesheet"
   href="https://unpkg.com/dropzone@5/dist/min/dropzone.min.css"
   type="text/css" />
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
   Dropzone.autoDiscover = false;

   $(function() {
	   $('#loading').hide();
      $('#imgUpload').click(function(e) {
         //기본 클릭 동작 방지
         e.preventDefault();
         $('#imgFile').click();
      });
      
      const dropzone = new Dropzone('div.dropzone', {
         url : 'transmitImg.do',
         method : 'post',
         maxFiles : 1,
         parallelUploads : 1,
         autoQueue : true,
         uploadMultiple : false,
         addRemoveLinks : false,
         acceptedFiles : '.jpeg, .jpg, .png, .JPEG, .PNG, .JPG',
         init : function() {
            var myDropZone = this;
            
            //학습 성공시 처리할 내역
            this.on('success', function(data, response) {
               var keyword = response;
               const url = "result.do?keyword=" + keyword;
               location.href = url;
               //const encoded = encodeURI(url);
               //location.href = encoded;
            });

            //학습 실패시
            this.on('error', function(data, response) {
               alert("에러가 발생하였습니다.");
            });
         }
      });

   });

   function fileTransmit(fileObj) {
      var form = $('#dnd');
      form.submit();
      $('#loading').show();
   }

   function upFileTransmit(fileObj) {
      var form = $('#transmitImg');
      form.submit();
      $('#loading').show();
   }
</script>

<style>

.rightbtn3 {
   font-size: 12px;
   width: 5rem;
   border-radius: 10px;
   height: 3.2rem;
   background-color: #fff;
   color: #7c7474;;
   border: 1px solid #aaa;
   font-family: 'Noto Sans KR', sans-serif;
}

</style>


</head>
<body>
   <br>
   <br>
   <c:import url="/WEB-INF/views/common/menubar.jsp" />
   
   <div class="bgc">
   
      <div style="max-width : 1130px; margin : 0 auto;">
   <br><br>
         <h4 style="font-family: 'CookieRun';">
            사진을 드래그해<br>음식을 검색해보세요!
         </h4>
         <div style="width: 500px; height: 375px; margin: 0 auto;"  id="dropzone"
            class="dropzone"></div>
         <br>
         <br>
         <br>
         <!-- input 태그 감추기 -->
         <div>
            <form id="transmitImg" class="sendImgForm" action="upImg.do"
               method="post" enctype="multipart/form-data">
               <input type="file" id="imgFile" name="imgFile" class="imgFile"
                  onchange="upFileTransmit(this)" accept="image/*">
            </form>

            <form id="dnd" class="dragAndDropForm" action="transmitImg.do"
               method="post" enctype="multipart/form-data">
               <input type="file" id="file" name="file" class="imgFile"
                  onchange="fileTransmit(this)" accept="image/*">
            </form>
            <div style="width: 500px;  margin: 0 auto;" class="imgUploadBtn">
               <button style="margin:0" class="rightbtn7" id="imgUpload" class="imgUploadBtn">이미지 업로드</button>&nbsp;&nbsp;
               <button class="rightbtn3" onclick="javascript:location.href='main.do';">홈으로</button>
            </div>
         
            </div>
         </div>
         <br><br>
      </div>
	<div id="loading" style="margin-left: 0px;">
        <img src="${ pageContext.servletContext.contextPath }/resources/img/img.gif">
        <p>로딩중입니다..</p>
    </div>
   <c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
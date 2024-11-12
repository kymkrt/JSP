<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>pdsContent.jsp</title>
  <jsp:include page="/include/bs4.jsp" />
   <style>
    th {
      text-align: center;
      background-color: #eee;
    }
    h6 {
			position: fixed;
			right: 1rem; /* 1em만큼 거리를 둔다 가운데 r은 다른 의미 */
			bottom: -50px;
			transition: 0.7s ease;   
    }
    .on {
    	opacity: 0.8;
    	cursor: pointer;
    	bottom: 0;	
    }
    
    /*별점에 스타일 설정하기*/
    #reviewForm fieldset {
    	direction: rtl;
    }
    
    /*라디오 버튼 감추기  */
    #reviewForm input[type=radio] {
    	display: none;
    }
    
    /*별크기 키우고 회색으로 변경*/
    #reviewForm label {
      font-size: 1.6em;
      color: transparent;
      text-shadow: 0 0 0 #f0f0f0;
    }
    
    /*마우스 올리면 별 보이기*/
    #reviewForm label:hover {
      text-shadow: 0 0 0 rgba(250, 200, 0, 0.98);
    }
    
    /*마우스 올리면 별 보이기*/
    #reviewForm label:hover ~ label {
      text-shadow: 0 0 0 rgba(250, 200, 0, 0.98);
    }
    
    /**/
    #reviewForm input[type=radio]:checked ~ label {/*기존것과 연결시켜주는 개념 */
      text-shadow: 0 0 0 rgba(250, 200, 0, 0.98);/* a는 불투명도 1이 백프로 그냥 보임 */
    }
  </style>
  <script>
    'use strict';
    
    $(function() {
    	$("#reviewShowBtn").hide();
    	$("#reviewHideBtn").show();
    	$("#reviewBox").show();
    });
    
    // 리뷰 보이기 버튼 클릭
    function reviewShow() {
    	$("#reviewShowBtn").hide();
    	$("#reviewHideBtn").show();
    	$("#reviewBox").show();
    }
    
    // 리뷰 가리기 버튼 클릭
    function reviewHide() {
    	$("#reviewShowBtn").show();
    	$("#reviewHideBtn").hide();
    	$("#reviewBox").hide();
    }
    
    // 화살표클릭시 화면 상단이동(부드럽게)
    $(window).scroll(function(){
    	if($(this).scrollTop() > 100) {
    		$("#topBtn").addClass("on");
    	}
    	else {
    		$("#topBtn").removeClass("on");
    	}
    	
    	$("#topBtn").click(function(){
    		window.scrollTo({top:0, behavior: "smooth"});
    	});
    });
    
    // 리뷰 등록하기
    function reviewCheck() {
    	let star = reviewForm.star.value;
    	let review = reviewForm.review.value;
    	
    	if(star == "") {
    		alert("별점을 부여해 주세요");
    	}
    	/*
    	else if(review.trim() == "") {
    		alert("리뷰를 입력해 주세요");
    		reviewForm.review.focus();
    	}
    	*/
    	//alert("별점 : " + star);
    	let query = {
    			part : 'pds',
    			partIdx: ${vo.idx},
    			mid    : '${sMid}',
    			nickName    : '${sNickName}',
    			star     : star,
    			content: review
    	}
    	
    	$.ajax({
    		type : "post",
    		url  : "ReviewInputOk.ad",
    		data : query,
    		success:function(res) {
    			alert(res);
    			location.reload();
    		},
    		error : function() {
    			alert('전송오류!!');
    		}
    	});
    }
    
    // 리뷰 삭제하기
    function reviewDelete(idx) {
    	let ans = confirm("리뷰를 삭제하시겠습니까?");
    	if(!ans) return false;
    	
    	$.ajax({
    		url  : "ReviewDelete.ad",
    		type : "post",
    		data : {idx : idx},
    		success:function(res) {
    			if(res != "0") {
    				alert('리뷰가 삭제되었습니다.');
    				location.reload();
    			}
    			else alert("리뷰 삭제 실패~~\n하위 댓글이 존재합니다.");
    		},
    		error : function() {
    			alert("전송오류!");
    		}
    	});
    }
    
    // 리뷰 댓글 달기폼 보여주기
    function reviewReply(idx, nickName, content) {
    	if(content == "") content = "글내용 없음"; 
    	$("#myModal #reviewIdx").val(idx);
    	$("#myModal #reviewReplyNickName").text(nickName);
    	$("#myModal #reviewReplyContent").html(content);
    }
    
    // 리뷰 댓글 달기
    function reviewReplyCheck() {
    	let replyContent = reviewReplyForm.replyContent.value;
    	let reviewIdx = reviewReplyForm.reviewIdx.value;
    	
    	if(replyContent.trim() == "") {
    		alert("리뷰 댓글을 입력하세요");
    		return false;
    	}
    	
    	let query = {
    			reviewIdx : reviewIdx,
    			replyMid  : '${sMid}',
    			replyNickName : '${sNickName}',
    			replyContent  : replyContent
    	}
    	
    	$.ajax({
    		url  : "ReviewReplyInputOk.ad",
    		type : "post",
    		data : query,
    		success:function(res) {
    			if(res != "0") {
    				alert("댓글이 등록되었습니다.");
    				location.reload();
    			}
    			else alert("댓글 등록 실패~~");
    		},
    		error : function() {
    			alert("전송 오류!");
    		}
    	});
    }
    
    // 리뷰 댓글 삭제
    function reviewReplyDelete(replyIdx) {
    	let ans = confirm("리뷰 댓글을 삭제하시겠습니까?");
    	if(!ans) return false;
    	
    	$.ajax({
    		type : "post",
    		url  : "ReviewReplyDelete.ad",
    		data : {replyIdx : replyIdx},
    		success:function(res) {
    			if(res != "0") {
    				alert('리뷰댓글이 삭제 되었습니다.');
    				location.reload();
    			}
    			else alert("삭제 실패~~");
    		},
    		error : function() {
    			alert("전송오류!");
    		}
    	});
    }
  </script>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<jsp:include page="/include/nav.jsp" />
<p><br /></p>
<div class="container">
  <h2>자료실 내용 상세 보기</h2>
  <br/>
  <table class="table table-bordered text-center">
  	<tr>
  		<th>올린이</th>
  		<td>${vo.nickName}</td>
  		<th>올린날짜</th>
  		<td>${vo.fDate}</td>
  	</tr>
  	<tr>
  		<th>파일명</th>
  		<td>
  			<c:set var="fNames" value="${fn:split(vo.fName, '/')}"/>
  			<c:set var="fSNames" value="${fn:split(vo.fSName, '/')}"/>
  			<c:forEach var="fName" items="${fNames}" varStatus="st">
	  			<c:if test="${sLevel != 1}"><a href="${ctp}/images/pds/${fSNames[st.index]}" download="${fName}" onclick="downNumCheck(${vo.idx})">${fName}</a><br/></c:if>
  			</c:forEach>
	  			(<fmt:formatNumber value="${vo.fSize/1024}" pattern="#,##0.0" />KByte)
  		</td>
  		<th>다운횟수</th>
  		<td>${vo.downNum}</td>
  	</tr>
  	<tr>
  		<th>분류</th>
  		<td>${vo.part}</td>
  		<th>접속IP</th>
  		<td>${vo.hostIp}</td>
  	</tr>
  	<tr>
  	<th>상세내용</th>
  		<td colspan="3" class="text-left">
  			${fn:replace(vo.content, newLine, "<br/>")}
  		</td>
  	</tr>
  </table>
  <br/>
  <div class="text-center"><a href="PdsList.pds" class="btn btn-warning">돌아가기</a></div>
  <hr/>
  
  <!--리뷰 작성하기 -->
  <div>
  	<form name="reviewForm" id="reviewForm">
  		<fieldset style="border:0px">
  			<div class="test-left">
  				<input type="radio" name="star" value="5" id="star1" /><label for="star1">⭐</label>
  				<input type="radio" name="star" value="4" id="star2" /><label for="star2">★</label>
  				<input type="radio" name="star" value="3" id="star3" /><label for="star3">⭐</label>
  				<input type="radio" name="star" value="2" id="star4" /><label for="star4">★</label>
  				<input type="radio" name="star" value="1" id="star5" /><label for="star5">⭐</label>
  				: 별점을 선택해주세요 ㉿
  			</div>
  		</fieldset>
  		<div class="m-0 p-0">
  			<textarea rows="3" name="review" id="review" class="form-control mb-1" placeholder="별점후기를 남겨주시면 100포인트를 지급합니다"></textarea>
  		</div>
  		<div>
  			<input type="button" value="별점/리뷰등록" onclick="reviewCheck()" class="btn-primary form-control" />
  		</div>
  	</form>
  </div>
  <br/>
  <!--자료실에 등록된 자료가 사진이라면 아래쪽에 사진들을 모두 보여준다-->
  <div class="text-center">
    <c:forEach var="fSName" items="${fSNames}" varStatus="st">
    	${st.count}. ${fNames[st.index]}<br/>
    	<c:set var="len" value="${fn:length(fSName)}" />
    	<c:set var="ext" value="${fn:substring(fSName, len-3, len)}" />
    	<c:set var="extLower" value="${fn:toLowerCase(ext)}" />
    	<c:if test="${extLower == 'jpg' || extLower == 'gif' || extLower == 'png'}">
    	  <img src="${ctp}/images/pds/${fSName}" width="90%" />
    	</c:if>
    	<hr/>
    </c:forEach>
  </div>
  
  <!--위로가기버튼-->
	<h6 id="topBtn" class="text-right mr-3"><img src="${ctp}/images/top.gif" title="위로 이동" /></h6>
	
</div>

<!-- 댓글달기를 위한 모달처리 -->
<div class="modal fade" id="myModal" style="font-size:0.9em;">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title">>> 리뷰에 댓글달기</h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>
      <div class="modal-body">
        <form name="reviewReplyForm" id="reviewReplyForm" class="was-vilidated">
          <table class="table table-bordered">
            <tr>
              <th style="width:25%">원본글작성자</th>
              <td style="width:75%"><span id="reviewReplyNickName"></span></td>
            </tr>
            <tr>
              <th>원본글</th>
              <td><span id="reviewReplyContent"></span></td>
            </tr>
          </table>
          <hr/>
          댓글 작성자 : ${sNickName}<br/>
          댓글 내용 : <textarea rows="3" name="replyContent" id="replyContent" class="form-control" required></textarea><br/>
          <input type="button" value="리뷰댓글등록" onclick="reviewReplyCheck()" class="btn btn-success form-control"/>
          <input type="hidden" name="reviewIdx" id="reviewIdx"/>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>


<p><br /></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>
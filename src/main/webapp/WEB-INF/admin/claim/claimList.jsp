<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>claimList.jsp</title>
  <jsp:include page="/include/bs4.jsp" />
  <script type="text/javascript">
  	'use strict'
  	
  	function claimViewCheck(flag, partIdx) {
			$.ajax({
				type : "post",
				url : "ClaimViewCheck.ad",
				data : {
					flag : flag,
					idx : partIdx		
				},
				success: function(res) {
					if(res != 0){
						if(flag=='NO') alert("게시글을 표시합니다");
						else alert("게시글을 감춥니다");
						location.reload();
					}
					else alert("작업실패");
				},
				error : function() {
					alert("전송오류");
				}
			});
		}
  	
  	//신고글 삭제처리
  	function claimDeleteOk(part, partIdx) {
			let ans = confirm("현재 신고된 글을 삭제하시겠습니까");
			if(!ans) return false;
			
			$.ajax({
				type : "post",
				url : "ClaimDeleteOk.ad",
				data : {
					part : part	,
					idx : partIdx
				},
				success: function (res) {
					if(res != "0"){
						alert("신고글이 삭제 되었습니다");
						location.reload();
					}
					else alert('신고글 삭제 실패');
				},
				error: function() {
					alert("전송 오류");					
				}
			});
		}
  </script>
</head>
<body>
<p><br /></p>
<div class="container">
  <h2 class="text-center">신 고 리 스 트</h2>
  <table class="table table-hover text-center">
  	<tr class="table-secondary">
  		<th>번호</th>
  		<th>분류</th>
  		<th>글제목</th>
  		<th>글쓴이</th>
  		<th>신고자</th>
  		<th>신고내역</th>
  		<th>신고날짜</th>
  		<th>처리결과</th>
  	</tr>
  	<c:forEach var="vo" items="${vos}" varStatus="st">
  		<tr>
				<td>${st.count }</td>  		
				<td>${vo.part}</td>  		
				<td>${vo.title}</td>  		
				<td>${vo.mid}</td>  		
				<td>${vo.claimMid}</td>  		
				<td>${vo.claimContent}</td>  		
				<td>${vo.claimDate}</td>  		
				<td>
					<a href="javascript:claimDeleteOk('${vo.part}','${vo.partIdx}')" class="badge badge-danger">삭제</a>
					<!-- 일반글로 바꿔서 다른 사람도 볼수 있게 한다                                 앞에''가 있으면 뒤가 숫자라도 '' 붙이기-->
					<c:if test="${vo.claim == 'OK'}"><a href="javascript:claimViewCheck('NO', '${vo.partIdx}')" class="badge badge-warning">표시하기</a></c:if>
					<!--재신고된 글을 감춰둔다 -->
					<c:if test="${vo.claim != 'OK'}"><a href="javascript:claimViewCheck('OK', '${vo.partIdx}')" class="badge badge-warning">감추기</a></c:if>
				</td>  		
  		</tr>
  	</c:forEach>
  	<tr><td colspan="8" class="m-0 p-0"></td></tr>
  </table>
  <!-- 블록페이지 시작 -->
<div class="text-center">
  <ul class="pagination justify-content-center">
	  <c:if test="${pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="ClaimList.common?tableName=claim&pageSize=${pageSize}&pag=1">첫페이지</a></li></c:if>
	  <c:if test="${curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="ClaimList.common?tableName=claim&pageSize=${pageSize}&pag=${(curBlock-1)*blockSize + 1}">이전블록</a></li></c:if>
	  <c:forEach var="i" begin="${(curBlock*blockSize)+1}" end="${(curBlock*blockSize) + blockSize}" varStatus="st">
	    <c:if test="${i <= totPage && i == pag}"><li class="page-item active"><a class="page-link bg-secondary border-secondary" href="ClaimList.common?tableName=claim&pageSize=${pageSize}&pag=${i}">${i}</a></li></c:if>
	    <c:if test="${i <= totPage && i != pag}"><li class="page-item"><a class="page-link text-secondary" href="ClaimList.common?tableName=claim&pageSize=${pageSize}&pag=${i}">${i}</a></li></c:if>
	  </c:forEach>
	  <c:if test="${curBlock < lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="ClaimList.common?tableName=claim&pageSize=${pageSize}&pag=${(curBlock+1)*blockSize+1}">다음블록</a></li></c:if>
	  <c:if test="${pag < totPage}"><li class="page-item"><a class="page-link text-secondary" href="ClaimList.common?tableName=claim&pageSize=${pageSize}&pag=${totPage}">마지막페이지</a></li></c:if>
  </ul>
</div>
<!-- 블록페이지 끝 -->
</div>
<p><br /></p>
	</body>
</html>
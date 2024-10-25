<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%
	pageContext.setAttribute("newLine", "\n");
%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>guestList.jsp</title>
  <jsp:include page="/include/bs4.jsp" />
  <style type="text/css">
  	th {
  		text-align: center;
  		background-color: #eee;
  	}
  </style>
  <script type="text/javascript">
  	'use strict'	
  	
  	function deleteCheck(idx) {
			let ans = confirm("현 방명록을 삭제하시겠습니까?");
			if(ans) location.href = "GuestDeleteOk.gu?idx="+idx; //자바스크립트 변수라서 밖에 쓴다
	}
  
  </script>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<jsp:include page="/include/nav.jsp" />
<p><br /></p>
<div class="container">
  <h2 class="text-center">방 명 록 리 스 트</h2>
  <!--글쓰기 / 관리자 버튼 혼자 튀어나오면 보기 안좋으니 테이블로 처리 -->
  <br/>
  <table class="table table-borderless m-0 p-0">
  	<tr>
			<td class="text-left">
				<!-- <input type="button" value="글올리기" onclick="location.href=''" class="btn btn-success" /> 실무는 보통 이렇게 한다 -->
				<!--확장자 패턴은 앞 경로는 신경안쓰기 때문에 전부 생략가능 뒤에 .내용 만 잘쓰면 된다 -->
				<a href="GuestInput.gu" class="btn btn-success">글올리기</a> <!--공부용 가는 주소 보려고 a태그 씀  -->
			 <!--공부용 가는 주소 보려고 a태그 씀  --> <!--위 방식 아래 방식 다 가능  -->
				<%-- <c:if test="${sAdmin != null}"><a href="GuestAdmin.gu" class="btn btn-primary">관리자</a></c:if>
				<c:if test="${sAdmin == null}"><a href="GuestAdmin.gu" class="btn btn-primary">관리자</a></c:if> --%>
				<c:if test="${sAdmin != 'adminOk'}"><a href="GuestAdmin.gu" class="btn btn-primary">관리자</a></c:if>
				<c:if test="${sAdmin == 'adminOk'}"><a href="GuestAdminOut.gu" class="btn btn-primary">관리자 로그아웃</a></c:if>
			</td>  	
			<td class="text-right">
				<c:if test="${pag > 1}">
					<a href="GuestList.gu?pag=${pag - 1}" title="이전페이지">◀</a>
					<a href="GuestList.gu?pag=1" title="첫페이지">◁◁</a>
				</c:if>
				${pag} / ${totPage}
				<c:if test="${pag < totPage}">
					<a href="GuestList.gu?pag=${pag + 1}" title="다음페이지">▶</a>
					<a href="GuestList.gu?pag=${totPage}" title="마지막페이지">▷▷</a>
				</c:if>
			</td>
  	</tr>
  </table>
  
  <!--방명록 내용  -->
  <!--백엔드에서 역순 호 처리 하는법 서블릿에서 리스트계열이니까 size() 사용해서 값을 가져옴  -->
  <c:set var="curScrStartNo" value="${curScrStartNo}" />
  <!--VOS로 넘어와서 forEach로 돌림 vo로꺼낸다   -->
  <c:forEach var="vo" items="${vos}" varStatus="st">
	  <table class="table table-borderless m-0 p-0">
	  	<tr>
				<td class="text-left">
					번호 : ${curScrStartNo} 
					<c:if test="${sAdmin == 'adminOk'}"><a href="javascript:deleteCheck(${vo.idx})" class="btn btn-danger btn-small">삭제</a></c:if>
				</td>  	
				<td class="text-right">
					방문IP : ${vo.hostIp}
				</td>
	  	</tr>
	  </table>
	  <table class="table table-bordered">
	  	<tr>
	  	<!--제목이라 th  -->
				<th style="width: 120px">글쓴이</th>  	
				<td>${vo.name}</td>
				<th style="width: 120px">방문일자</th>  	
				<td>${fn:substring(vo.visitDate, 0, 19)}</td>
	  	</tr>
	  	<!--VO 이름과 똑같아야 한다 열어두고 보면서 해도됨 -->
	  	<tr>
				<th>이메일</th>  	
				<td colspan="3"><!-- vo.email == '' || vo.email == null 이 2가지를 한번에 비교 empty  -->
					<c:if test="${empty vo.email || fn:length(vo.email)<6 || fn:indexOf(vo.email, '@')== -1 || fn:indexOf(vo.email, '.')== -1}" >- 없음 -</c:if>
						<!--else if가 없기 때문에 베타적으로 하나 추가해줘야함 not empty 해도 됨 -->
					<c:if test="${!empty vo.email && fn:length(vo.email)>=6 && fn:indexOf(vo.email, '@')!= -1 && fn:indexOf(vo.email, '.')!= -1}" >${vo.email}</c:if>
				</td> <!--3개 합침  -->
	  	</tr>
	  	<tr>
				<th>홈페이지</th>  	
					<!--target="_blank" 이러면 새창뜸 target="blank" 이건 같은창에서 변경 -->
					<td colspan="3">
						<c:if test="${empty vo.homePage || fn:length(vo.homePage)<=10 || fn:indexOf(vo.homePage, '.')== -1}"> - 없음 - </c:if>
						<c:if test="${!empty vo.homePage && fn:length(vo.homePage)>10 && fn:indexOf(vo.homePage, '.')!= -1}"><a href="${vo.homePage}" target="_blank">${vo.homePage}</a></c:if>
					</td> <!--대소문자 주의-->
	  	</tr>
	  	<tr>
				<th>방문소감</th>  	
				<td colspan="3">${fn:replace(vo.content, newLine, "<br/>")}</td> <!--대소문자 주의-->
	  	</tr>
	  </table>
	  <c:set var="curScrStartNo" value="${curScrStartNo - 1}" />
  </c:forEach>
  
  <!-- 블록페이지 시작-->
  <div class="text-center">
  <!-- []은 구별용으로 해둔것 나중에 꾸미면 좋다 -->
  	<c:if test="${pag > 1}">[<a href="GuestList.gu?pag=1">첫페이지</a>]</c:if>
  	<c:if test="${curBlock > 0}">[<a href="GuestList.gu?pag=${(curBlock - 1)*blockSize + 1}">이전 블록</a>]</c:if>
  	<c:forEach var="i" begin="${(curBlock*blockSize)+1}" end="${(curBlock*blockSize)+blockSize}" varStatus="st">
  		<c:if test="${i <= totPage && i == pag}">[<a href="GuestList.gu?pag=${i}"><font color="red"><b>${i}</b></font></a>]</c:if>
  	<!--배타적으로 해야한다  -->
  		<c:if test="${i <= totPage && i != pag}">[<a href="GuestList.gu?pag=${i}">${i}</a>]</c:if>
  	</c:forEach>
  	<c:if test="${curBlock < lastBlock}">[<a href="GuestList.gu?pag=${(curBlock + 1)*blockSize + 1}">다음 블록</a>]</c:if>
  	<c:if test="${pag < totPage}">[<a href="GuestList.gu?pag=${totPage}">마지막페이지</a>]</c:if>
  </div>
  <!-- 블록페이지 끝 -->
  
</div>
<p><br /></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>
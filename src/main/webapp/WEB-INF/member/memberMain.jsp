<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>memberMain.jsp</title>
  <jsp:include page="/include/bs4.jsp" />
</head>
<body>
<jsp:include page="/include/header.jsp" />
<jsp:include page="/include/nav.jsp" />
<p><br /></p>
<div class="container">
  <h2>회 원 전 용 방</h2>
  <hr/>
  <div>현재 <font color="blue"><b>${sNickName}(<font color="red">${sStrLevel}</font>)</b></font>님 로그인 중입니다.</div>
  <hr/>
  <c:if test="${sLevel == 1}">
  	<div><font color="red">정회원 등업조건 : <u>총 방문횟수 <b>10회</b>이상</u>, <u>방명록에 글쓰기 <b>2회</b> 이상</u></font></div>
  </c:if>
  <hr/>
  <div>총 방문 횟수 : <font color="blue"><b>${mVo.visitCnt }</b></font></div>
  <div>오늘 방문 횟수 : <font color="blue"><b>${mVo.todayCnt }</b></font></div>
  <div>최종 방문 일(기존) : <font color="blue"><b>${mVo.lastDate }</b></font></div><!--이렇게 찍으면 지금 시간 나옴 로그아웃 되야 시간이 되도록 바꿨기 때문  -->
  <div>최종 방문 일(JSTL) : <font color="blue"><b>${fn:substring(sLastDate,0,19)}</b></font></div><!--substring을 써야 하기 때문에 위에 펑션 JSTL사용  -->
  <div>총 포인트 : <font color="blue"><b>${mVo.point }</b></font></div>
  <hr/>
  <!--과제 방명록이 올린 이름이 같거나 닉네임이 같거나 id가 같으면 같은 사람이 쓴걸로 간주  -->
	<div>방명록에 작성한글 수 : <font color="blue">총 <b>${guestCnt}</b>건</font></div>
  <hr/>
  <div>회원사진 기존 : <img src="${ctp}/images/member/${mVo.photo}" width="300px" /></div>
  <div>회원사진 업로드 : <img src="${ctp}/images/pdstest/${mVo.photo}" width="300px" /></div>
</div>
  <!-- The Modal -->
<div class="modal fade" id="myModal">
  <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
    <div class="modal-content">
    
      <!-- Modal Header -->
      <div class="modal-header">
        <h3 class="modal-title">방명록에 올린글(총 : ${guestCnt}건)</h3>
        <button type="button" class="close" data-dismiss="modal">×</button>
      </div>
      
      <!-- Modal body -->
      <div class="modal-body">
        <c:forEach var="vo" items="${gVos}" varStatus="st">
	        <h5>${st.count}. 방문일자 : ${fn:substring(vo.visitDate,0,19)}</h5>
	        <p>${fn:replace(vo.content, newLine, '<br/>')}</p>
	        <c:if test="${!st.last}"><hr/></c:if>
        </c:forEach>
      </div>
      
      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
      </div>
      
    </div>
  </div>
</div>
<p><br /></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>
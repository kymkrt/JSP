<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<script>
	function memberDelete() {
		let ans = confirm("탈퇴 하시겠습니까?");
		if(ans) location.href = "MemberPwdDeleteCheck.mem";
	}
</script>
<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
 <%--  <a class="navbar-brand" href="${ctp}/">Home</a> --%>
  <a class="navbar-brand" href="http://192.168.50.58:9090/javaGroup">Home</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
    <span class="navbar-toggler-icon"></span>
  </button>
  <div class="collapse navbar-collapse" id="collapsibleNavbar">
    <ul class="navbar-nav">
      <li class="nav-item">
        <a class="nav-link" href="GuestList.gu">Guest</a>
      </li>
      <c:if test="${!empty sNickName}">
	      <li class="nav-item">
	        <a class="nav-link" href="BoardList.bo">Board</a>
	      </li>
	      <li class="nav-item">
	        <a class="nav-link" href="PdsList.pds">Pds</a>
	      </li>    
	      <li class="nav-item mr-2">
	    	 <div class="dropdown"><!--여기에 mr 붙여도 됨  -->
			    	<button type="button" class="btn btn-secondary dropdown-toggle" data-toggle="dropdown">
							Study1		    	
				   	</button>
			    	<div class="dropdown-menu">
				      <a class="dropdown-item" href="${ctp}/study2/mapping/Test1Ok">mapping(Directory 패턴)</a>
				      <a class="dropdown-item" href="${ctp}/study2/mapping/Test2">mapping(확장자 패턴)</a>
				      <a class="dropdown-item" href="${ctp}/study2/test/StorageMenu">Storage 연습</a>
				      <a class="dropdown-item" href="${ctp}/study/1018_JSTL/el.jsp">EL 연습</a>
				      <a class="dropdown-item" href="${ctp}/study/1018_JSTL/jstlMenu.jsp">JSTL 연습</a>
				      																								<!--.을 안썼으니까 디렉토리패턴  -->
				      <a class="dropdown-item" href="${ctp}/study2/database/DbList">DataBase 연습</a>
				      													<!--확장자 패턴이라 앞부분 필요없음  -->
				      <a class="dropdown-item" href="PassCheckForm.st">암호화 연습</a>
				      <a class="dropdown-item" href="AjaxTest.st">AJAX(아작스, 에이잭스 등) 연습</a>
				      <a class="dropdown-item" href="FileUpload.st">파일 업로드 연습</a>
				      <a class="dropdown-item" href="Calendar.st">인터넷 달력 연습</a>
	    			</div>
	  			</div>
	      </li>
	      <li class="nav-item">
	    	 <div class="dropdown">
			    	<button type="button" class="btn btn-secondary dropdown-toggle" data-toggle="dropdown">
							MyPage
				   	</button>
			    	<div class="dropdown-menu">
				      <a class="dropdown-item" href="MemberMain.mem">회원메인방</a>
				      <a class="dropdown-item" href="MemberPasswordCheck.mem">회원정보수정</a>
				      <a class="dropdown-item" href="javascript:memberDelete()">회원탈퇴</a>
				      <c:if test="${sLevel > 1 || sLevel == 0}">
					      <a class="dropdown-item" href="MemberList.mem">회원리스트</a>
					      <a class="dropdown-item" href="MemberMessage.msg">메세지 보내기</a>
					      <a class="dropdown-item" href="Schedule.sc">일정관리</a>
				      </c:if>
				      <a class="dropdown-item" href="">포인트사용내역</a>
				      <c:if test="${sLevel == 0}"><a class="dropdown-item" href="AdminMain.ad">관리자메뉴</a></c:if>
	    			</div>
	  			</div>
	      </li>
      </c:if>
	  	<li class="nav-item">
	  	<!--c if 면 항상 배타적 추가 != 대신에 empty가 좋다 공백도 포함 -->
	     <c:if test="${!empty sNickName}"><a class="nav-link" href="MemberLogout.mem">LogOut</a></c:if> <!--확장자 패턴이라 ctp 필요없음-->
	     <c:if test="${empty sNickName}"><a class="nav-link" href="MemberLogin.mem">Login</a></c:if> <!--확장자 패턴이라 ctp 필요없음-->
	    </li>          
	  	<li class="nav-item">
	  	<!--c if 면 항상 배타적 추가 != 대신에 empty가 좋다 공백도 포함 -->
	    	<c:if test="${empty sNickName}"><a class="nav-link" href="MemberJoin.mem">Join</a></c:if><!--확장자 패턴이라 ctp 필요없음-->
	    </li>          
    </ul>
  </div>
</nav>
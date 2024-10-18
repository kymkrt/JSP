<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String mid = (String)session.getAttribute("sMid"); //객체라서 스트링으로 형변화
	String nickName = (String)session.getAttribute("sNickName");
	String name = (String)session.getAttribute("sName");
	
	/* 프론트에서 쓰기 위한것? 브라우저의 페이지단위에서 살아있는것 */
	pageContext.setAttribute("mid", mid);
	pageContext.setAttribute("nickName", nickName);
	pageContext.setAttribute("name", name);

	//저장된 세션값들 확인하기
	Enumeration enumCk = session.getAttributeNames();
	String sessionName = "";
	String sessionName_ = ""; //임시변수 뒤에_ 혹은 앞에_
	String sessionValue = "";
	
	//열거형으로 들어가있을때는 ?
			//앞에 bof 뒤에 eof 주의
	while(enumCk.hasMoreElements()) { //리턴타입 불리언 있으면 참 없으면 거짓
		//임시변수
		sessionName_ = enumCk.nextElement().toString(); //객체라 타입 맞춰줘야함 임시변수는 스트링 여기다 담기
		//세션이름이 저장
		sessionName += sessionName_ + "/";
		//세션 값이 저장
		sessionValue += session.getAttribute(sessionName_) + "/";
	}
	System.out.println(sessionName + "\n" + sessionValue);
	
%>
<!-- 출력하는거라 뷰 -->
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>t2_SessionCheck.jsp</title>
  <jsp:include page="/include/bs4.jsp" />
</head>
<body>
<p><br /></p>
<div class="container">
<!--MVC 패턴을 지키기 위해 서블릿 코드인 꺽쇠 퍼센트 같은걸 빼라 꼭 넣어야 한다면 제일 위로 빼줘라   -->
<!--그래도 다 빼서 서블릿에서 처리시키는게 좋음 그게 MVC2  -->
<!--서버저장소에 있는건 EL로 꺼낼수 있다?  -->
  <h2>세션값 출력</h2>
  <p>아이디 : ${mid}</p>
  <p>닉네임 : ${nickName}</p>
  <p>성명 : ${name}</p>
   <hr />
   <!--인터페이스인데 이것도 내장객체라서 안올려도됨  -->
   <p>세션 아이디 : <%=session.getId() %></p>
   <hr />
  <p><a href="t2_Session.jsp" class="btn btn-info">돌아가기</a></p>
</div>
<p><br /></p>
</body>
</html>
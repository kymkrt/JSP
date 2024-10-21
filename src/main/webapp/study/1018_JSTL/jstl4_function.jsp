<%@	page import="java.util.ArrayList"%>
<%@	page import="study.j1018.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%
	String str = "Welcome to My Hompage";
	pageContext.setAttribute("str", str);
	
	String[] cards = {"국민", "BC", "LG", "현대", "삼성", "농협", "신한"};
/*저장소에 담아야 EL 사용가능 그래서 pageContext  */
	pageContext.setAttribute("cards", cards);
	
	MemberVO vo = null;
	ArrayList<MemberVO> vos = new ArrayList<>();
	
	vo = new MemberVO();
	//생성법 1생성자(사용자 정의) 2게터 세터 여기는 게터세터
	vo.setName("홍길동");
	vo.setAge(25);
	vo.setGender("남자");
	vo.setJob("학생");
	vo.setAddress("서울");
	vos.add(vo); //1째가 올라간것
	
	//생성해서 담아야 한다
	vo = new MemberVO();
	vo.setName("김말숙");
	vo.setAge(33);
	vo.setGender("여자");
	vo.setJob("의사");
	vo.setAddress("청주");
	vos.add(vo); //2째가 올라간것
	
	pageContext.setAttribute("vos", vos);
	
	String tel = "010-1234-5678";
	pageContext.setAttribute("tel", tel);
%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>jstl4_function.jsp</title>
  <jsp:include page="/include/bs4.jsp" />
</head>
<body>
<p><br /></p>
<div class="container">
  <h2>JSTL Function 라이브러리</h2>
  <pre>
  	taglib에 등록후 사용한다 : taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"
  </pre>
	<hr/>
	<div>
		str변수의 값? ${str}<br/>
																							<!--함수 쓰는법  -->
		1-1.str변수의 길이(length)? <%=str.length() %> / ${fn:length(str)}<br/><!--앞에 fn:함수(내용) -->
		1-2.cards 배열의 길이(length)? <%=cards.length %> / ${fn:length(cards)}<br/><!--앞에 fn:함수(내용) -->
		<!--arraylist 는 size  											EL은 저장소에 담아야 사용가능						-->
		1-3.vos 객체의 길이(length)? <%=vos.size() %> / ${fn:length(vos)}<br/><!--앞에 fn:함수(내용) -->
		<hr/>
		
		2-1.대문자변환(toUpperCase()) : <%=str.toUpperCase() %> / ${fn:toUpperCase(str)}<br/>
		2-1.소문자변환(toLowerCase()) : <%=str.toLowerCase() %> / ${fn:toLowerCase(str)}<br/>
		<hr/>
																																		<!-- 변수명  -->
		3-1.문자열추출(substring()) : <%=str.substring(0, 5) %> / ${fn:substring(str, 0, 5)}<br/>	
		3-1.문자열추출(substring()) :		<%=str.substring(5) %>  /	 ${fn:substring(str, 5, -1)}<br/><!--음수를 주면 뒤에서 부터 센다?  -->
		4-1.특정문자의 위치값(indexOf) : <%=str.indexOf("o") %> / ${fn:indexOf(str, 'o')}
		<hr/>
													<!--뒤에서부터 검색하지만 숫자는 앞부터  -->
		5-1.뒤에서부터검색(lastIndexOf) : <%=str.lastIndexOf("o") %> / <%--${fn:lastIndexOf(str, 'o')}  JSTL에는 없음	 --%>
		5-2.특정위치의 문자열 모두 검색 : 
		
<%--<c:set var="cnt" value="0" />
		<c:set var="su" value="" />
		<c:forEach var="i" begin="0" end="${fn:length(str)-1}">
			<c:if test="${fn:substring(str, 0, 5)} == 'o'">
				<c:set var="i" value="${fn:indexOf(str, 'o')}-1" />
				${cnt++}
			</c:if>
			'o'문자의 위치값 / <br/>
			'o'문자 갯수 / ${cnt}<br/>
		</c:forEach> --%>
		<br/>
		<c:set var="cnt" value="0" />
		<c:forEach var="i" begin="0" end="${fn:length(str)-1}">
			<c:if test="${fn:substring(str, i, i+1) == 'o'}">
				<c:set var="cnt" value="${cnt+1}" />
				'o'문자의 위치값 ${i} <br/>
			</c:if>
		</c:forEach>
			<br/>'o'문자 갯수 / ${cnt}<br/>
			<br/>
	6-1.substringAfter() / substringBefore()
	${fn:substringAfter(str, 'o')} / ${fn:substringBefore(str, 'o')}<br/>
	6-2.str변수의 2번째 'o'문자의 위치만 구하시오
	<hr/>
	
	7-1.split함수 : 예) 전화번호(tel변수)<br/>
<%
	String[] tels = tel.split("-");
	for(String t : tels){
		out.println(t + " / ");
	}
%>
	<br/>
	<!--따옴표는 규칙만 맞으면 된다  -->
	7-2.fn:split(변수명, '분리자') ==> 반환값은 배열로 저장된다<br/>
	<c:set var="tels" value="${fn:split(tel,'-')}" /> <!--tels에 배열로 들어간다  -->
	<c:forEach var="tel" items="${tels}" varStatus="st">
		${st.count} : ${tel}<br/>
	</c:forEach>
	<hr/>
	
	8.치환(replace)<br/>
	str변수의 'o'를 'O'로 치환 : 
	<%=str.replace("o", "O") %> / ${fn:replace(str, 'o','O')}
	<br/>
	
	9.문자의 포함유무 contains()<br/>
	str변수에 'My'의 포함유무 ${fn:contains(str, 'My')}<br/>
	str변수에 'my'의 포함유무 ${fn:contains(str, 'my')}<br/>
	
	</div>
</div>
<p><br /></p>
</body>
</html>
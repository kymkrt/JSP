<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- t1_CookiesSave.jsp 뷰가 아니라 필요 없음 -->
<!-- 여기는 로그인한 후에 나오는 부분? -->
<%
	/* 이건 자바 코드이기 때문에 서블릿에서 써도 똑같다 단 자바에서는 객체를 사용하기 위해서는 임포트하고 생성도 해야함  */
	/* 근데 JSP에서는 저 저장소들 쿠키나 리퀘스트등 이 전부 내장객체라 그냥 쓸수 있다 */
	
	/* 쿠키는 클라이언트에 저장하기 때문에 서버에 부담을 안준다 */
	String mid = "hkd1234";
	
	/* 쿠키는 생성하는게 저장이 된다 다른객체는 setAttribute */
	/* 우리끼리 약속으로 쿠키는 앞에 c를 붙인다 이러면 나중에 mid를 가져올때 앞에 c가 있으면 쿠키 구나 a가 있으면 애플리케이션이구나 알수 있게 */
	/* 그냥 생성만 하면 브라우저 끄면 삭제됨 그래서 따로 저장해둔다 */
	Cookie cookieMid = new Cookie("cMid", mid); /* 앞이 변수 뒤가 값 */ 
	/* 쿠키의 만료시간 초단위 1일: 60*60*24=86400초  */
	cookieMid.setMaxAge(60); /* 이렇게 총숫자가 아니라 계산을 적어도 됨  */
	/* 쿠키를 저장하는 명령 쿠키는 여러개가 올수 있기 때문에 add */
	response.addCookie(cookieMid); //add를 안해주면 그냥 메모리에만 있다가 없어짐 볼수도 없다
	
	String pwd = "1234";
	Cookie cookiePwd = new Cookie("cPwd", pwd);
	cookiePwd.setMaxAge(60*60);
	response.addCookie(cookiePwd);

%>
<script>
	alert("쿠키가 생성/저장 되었습니다");
	location.href = "t1_Cookies.jsp";
</script>

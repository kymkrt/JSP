<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- test06Ok.jsp -->

<%
	String mid = request.getParameter("mid");
	String pwd = request.getParameter("pwd");
	
	System.out.println("아이디 : " + mid);
	System.out.println("비밀번호 : " + pwd);

	/* 태그를 쓰려면 이 객체가 필요하다 근데 아래 방식으로 사용?  */
	/* PrintWriter out */ 
	
	if(mid.equals("admin") && pwd.equals("1234")) {
		out.println("<script>");
		out.println("location.href='test06Admin.jsp';");
		out.println("</script>");
	}
	else if(mid.equals("hkd1234") && pwd.equals("1234")) {
		out.println("<script>");
		out.println("location.href='test06Member.jsp';");
		out.println("</script>");
	}
	else {
		out.println("<script>");
		out.println("alert('아이디를 확인하시고 다시 로그인 해주세요');");
		/* out.println("location.href='test06.jsp';"); */
		out.println("history.back();");/* 무한루프가 될수 있어서 주의해야한다 잘모르면 위에거 */
		out.println("</script>");
	}

%>
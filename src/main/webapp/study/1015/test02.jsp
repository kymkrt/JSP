<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- <%@ page session="false" %> jsp 주석--%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>test02.jsp</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
	<script type="text/javascript">
		//1.이곳은 자바스크립트 한줄 주석입니다
		/*
			2.이곳은 자바스크립트 여러줄 주석입니다
		*/	
	</script>  
	<!-- 3.이곳은 html 주석입니다 한줄또는 여러줄 사용할수 있습니다 -->
	<style type="text/css">
		/* 4.이곳은 CSS 주석입니다 한줄 여러줄 가능합니다 */
	</style>
</head>
<body>
<p><br /></p>
<div class="container">
  <h2>각 언어별 주석 예제</h2>
  <div>JSP 코드(스크립틀릿)를 적어봅니다.</div>
  <%
  	int i = 0, tot = 0;
  	while(i<100) {
  		//i = i+ 1; 자바안이니까 자바코드 주석
  		i++;
  		/* tot = tot + i;  */
  		tot+=i;
  	}
  %>
  <div>
  	1~100까지의 합은 <font color="red"><b><%= tot %></b></font> 입니다
  </div>
  <hr />
  <%!
  	public int hap(int su) {
  		int hap = 0;
  		for(int i=1;i<=su;i++){
  			hap += i;
  		}
  		return hap;
  	}
  %>
  <h3>1~? 까지의 합을 출력</h3>
  <div>1~50까지의 합은 <%= hap(50) %></div>
  <div>작업을 마칩니다</div>
</div>
<p><br /></p>
</body>
</html>
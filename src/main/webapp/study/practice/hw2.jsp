<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>hw2.jsp</title>
  <jsp:include page="/include/bs4.jsp" />
  <script>
  	'use strict'
  	
  	function fCheck() {
			let selec = myform.sel.value;
			let img = "<img src='"+selec+"'/>";
			document.getElementById("demo").innerHTML = img;
		}
  </script>
</head>
<body>
<p><br /></p>
<div class="container">
  <div>사진을 고르세요</div>
  <form name="myform" id="myform">
		<select name="sel" class="form-control mb-3" onclick="fCheck()">
		<!-- <select name="sel" class="form-selec mb-3" onclick="fCheck()"> 부트스트랩5 -->
  		<option value="<%=request.getContextPath()%>/images/1.jpg">1.jpg</option>
  		<option value="<%=request.getContextPath()%>/images/2.jpg">2.jpg</option>
  		<option value="<%=request.getContextPath()%>/images/3.jpg">3.jpg</option>
  		<option value="<%=request.getContextPath()%>/images/4.jpg">4.jpg</option>
  		<option value="<%=request.getContextPath()%>/images/5.jpg">5.jpg</option>
  	</select>
  </form>
  <button onclick="fCheck()" class="form-control btn btn-info">사진변경</button>
<hr/>
<div id="demo"></div>
</div>
<p><br /></p>
</body>
</html>
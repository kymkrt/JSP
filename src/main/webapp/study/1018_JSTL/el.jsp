<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>el.jsp</title>
  <jsp:include page="/include/bs4.jsp" />
</head>
<body>
<p><br /></p>
<div class="container">
  <h2>EL(Expression Language)</h2>
  <p>저장소(서버 저장소 : ServletContext 컨테이너)에 기록되어 있는 자료에 대한 처리를 담당</p>
  <hr/>
  <pre>
  	용도 : 사용자가 '변수/값/수식/객체' 등을 서버에 전송받은 후에 저장(request/session/applicatio. setatt~), 또는 처리 한후 Client로 전송된 자료를 화면에 표시한다
  	표기법 : $ 여기 반드시 공백 붙이면 에러 {변수/값/객체/수식} 
  </pre>
  <hr/>
<%
	String atom = "seoul";
	String name = "홍길동";
	int su1 = 100, su2 = 200;
	int res = su1+ su2;
	String su3 = "100", su4 = "200";
%>
<h2>스크립틀릿을 이용한 출력</h2>
	<div>
		<%="안녕!!" %><br/>
		atom = <%=atom %><br/>
		name = <%=name%><br/>	
		su1 = <%=su1%><br/>
		su2 = <%=su2%><br/>
		res = <%=res %><br/>
		su1 * su2 = <%=(su1*su2)%><br/>
		su3 + su4 = <%=(su3 + su4)%><br/>
		<%-- su3 * su4 = <%=(su3 * su4)%><br/> --%>
	</div>
	<hr/>
	<%
		pageContext.setAttribute("atom", atom);
		pageContext.setAttribute("name", name);
		pageContext.setAttribute("su1", su1);
		pageContext.setAttribute("su2", su2);
		pageContext.setAttribute("su3", su3);
		pageContext.setAttribute("su4", su4);
		pageContext.setAttribute("res", res);
	%>
	<h2>EL을 이용한 출력</h2>
	<div>
		${"안녕"}<br/>
		atom = ${atom};<br/>
		name = ${name};<br/>
		su1 = ${su1};<br/>
		su2 = ${su2};<br/>
		res = ${res};<br/>
		<!-- 연산이되서(수식탑재가능) 따로 안담아도됨 -->
		su1 * su2 = ${su1*su2};<br/>
		<!--EL은 담지 않았을때 문자 + 문자 = 0 스트링은 계산이 들어가면 무조건 0으로 본다-->
		<!--저장소에 담으면 수식연산이 된다  -->
		su3 + su4 = ${(su3+su4)};<br/>
		su3 * su4 = ${(su3*su4)};<br/>
	</div>
	<hr>
	<h4>파라메터(parameter)를 통해서 넘어온 값의 처리(?변수1=값1&변수2=값2 == QueryString형식)(get방식도 맞음?)</h4> <!--PathCariable형식(경로로처리) //이런식으로 이어지는거 -->
	<div>주소창에 현재 주소 뒤에 '?mbc=200&kbs=50' 을 입력후 확인하시오<br/>
<%
	String mbc = request.getParameter("mbc");
	String kbs = request.getParameter("kbs");
	//pageContext.setAttribute("mbc", mbc);
	//pageContext.setAttribute("kbs", kbs);
%>		
<!-- 그냥 이렇게 하면 null이 뜨지만 ?mbc=200&kbs=50을 마지막에 넣어서 겟방식으로 보내주면 값이 나온다 이게 querystring -->
		mbc = <%=mbc %><br/>
		kbs = <%=kbs %><br/>
		
		<!--param 파라미터에서 바로 가져옴 저장소에 안넣어도됨-->
		mbc = ${param.mbc}<br/>
		kbs = ${param.kbs}<br/>
		mbc - kbs = ${param.mbc - param.kbs}<br/>
	</div>
	<hr/>
	<div>
		<form name="myform" method="post" action="<%=request.getContextPath()%>/1018/ElOk">
			<h3 class="text-centet mb-5">Form 자료 전송 연습</h3>
			<div>성명 :
				<input type="text" name="name" value="홍길동" class="form-control mb-3" />
			</div>
			<div class="mb-3">취미 :
				<input type="checkbox" name="hobby" value="등산" checked />등산 &nbsp;
				<input type="checkbox" name="hobby" value="낚시" />낚시 &nbsp;
				<input type="checkbox" name="hobby" value="바둑" />바둑 &nbsp;
				<input type="checkbox" name="hobby" value="수영" />수영 &nbsp;
				<input type="checkbox" name="hobby" value="승마" />승마 &nbsp;
				<input type="checkbox" name="hobby" value="바이크" />바이크
			</div>
			<div>
			<!-- 포스트 방식으로 보내면 URL에는 안나와도 파라미터로 간다 -->
				<input type="submit" value="전송" class="form-control btn btn-success">
			</div>
		</form>
	</div>
<%
//setattrubute로 보낸건 getattribute로 꺼내야한다 그냥 파라미터로 꺼내면 없는걸로 침 
	String name2 = request.getParameter("name")==null ? "" : request.getParameter("name");
	String hobby = request.getParameter("hobby")==null ? "" : request.getParameter("hobby");
	System.out.println("hobby2 : "+hobby);
	if(!name2.equals("") && !hobby.equals("")){
%>
<!-- 여기 아래에 값이 나온건 그냥 이미 밸류가 있어서 그게 나온것 -->
	<p>성명 : <%=name2 %> (X) - getAttribute</p>
	<p>취미 : <%=hobby %> (X)</p>
	<!-- 저장소에 담은건 무조건 EL로 꺼내야한다 아니면 getattribute 사용-->
	<p>성명 : ${name2} (O)</p>
	<p>취미 : ${hobby} (O)</p>
	<!--이건 안나오는데 파라미터로 값이 넘어올때만 이지 그냥 URL에 있다고해서 되는게 아니다  -->
	<!--전송되어온 파라미터만 가능  -->
	<p>성명(param) : ${param.name2} (X)</p>
	<p>취미(param) : ${param.hobby} (X)</p>
	
<%} %>
	<div><b>작업끝</b></div>
</div>
<p><br /></p>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>memberMessage.jsp</title>
  <jsp:include page="/include/bs4.jsp" />
  <script type="text/javascript">
  	'use strict';
  	
  	//검색하고 나서 그 모달안에서 목록을 보여주는것 재검색 같은거다 
  	//트리거 처럼 구현한것 내가 누른것처럼해서 보여준다
  	//검색버튼을 안누르면 mid가 없어서 전체목록이 나옴 mid가 있으면 공백이 아니니까 아래 버튼을 클릭해서 그 mid에 따른 목록이 보임 
  	//주소록 버튼을 눌렀다는거 자체가 아래 mid를 만들어내기때문에 따로 없어도 됨
  	$(function(){
			<c:if test="${!empty mid}">
				document.getElementById("jusorokBtn").click();
			</c:if>
			
			$("#receiverMessage").hide();
			$("#sendMessage").hide();
			
			if('${msgFlag}'=='r') {
				$("#receiverMessage").show();
			}
			else if('${msgFlag}'=='s') {
				$("#sendMessage").show();
			}
		});
  	
  	//주소록 모달창에서 아이디검색버튼을 클릭시 동적폼추가
  	function idSearchView() {
			$("#idSearchShowBtn").hide();
			let str = '';
	    	str += '<div class="input-group m-3">';
	    	str += '<input type="text" name="mid" id="mid" class="form-control"/>';
	    	str += '<div class="input-group-append">';
	    	str += '<input type="button" value="아이디검색" id="idSearchBtn" onclick="idSearchCheck()" class="btn btn-info btn-sm"/>';
	    	str += '</div>';
	    	str += '</div>';
			
			$("#idSearch").html(str);
			//idSearch.innerHTML = str;
		}
  
  	//아이디검색 동적폼에서 아이디 검색 버튼 클릭시 수행처리함수
  	function idSearchCheck() {
			let mid = $("#mid").val();
			if(mid.trim() == "") {
				alert("아이디를 입력하세요");
				return false;
			}
			location.href="MemberIdSearchCheck.msg?mid="+mid;
		}
  	
  	//메세지 보내기(전송)
  	function messageSend() {
  		let receiverId = $("#receiverId").val();
  		let content = $("#content").val();
  		if(receiverId.trim() == ""){
  			alert("받는 사람의 아이디를 입력해주세요");
  			return false;
  		}
  		else if(content.trim() == "") {
  			alert("메세지를 입력해주세요");
  			$("#content").focus();
  			return false;
  		}
  		
			let query = {
				senderId : $("#senderId").val(),
				receiverId : receiverId,
				content : content,
			}
			
			$.ajax({
				type: "post",
				url: "MemberMessageInput.msg",
				data: query,
				success: function(res) {
					if(res != "0"){
						alert(receiverId+"님에게 메세지를 전송했습니다");
						//새로보내는거라 동기화가 되는것 굳이 ajax를 쓸 이유가 없는데 유지보수 개념이라 어쩔수 없이 사용
						location.href="MemberMessageSearch.msg?mid=${sMid}&msgFlag=s";
					}else{
						alert("메세지 전송실패");
					}
				},
				error: function() {
					alert("전송오류");
				}
			});
		}
  	
  	//메세지 삭제
  	function memberDeleteCheck() {
			
		}
  	
  	//메세지 한건 가져오기(콘텐츠용)
  	function memberMessageContent(idx) {
  		$.ajax({
  			type: "post",
  			url: "MemberMessageSearch.msg",
  			data: {
  				idx: idx,
  				mid: "${sMid}",
  				msgFlag: "r"
  			},
  			success: function(res) {
					
				},
				error: function() {
					
				}
  		});
			location.href="MemberMessageSearch.msg?mid=${sMid}&msgFlag=r&idx="+idx;
		}
		 
 // AJAX로 내용을 가져오는 예제
  </script>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<jsp:include page="/include/nav.jsp" />
<p><br /></p>
<div class="container">
  <form name="myform">
  	<h3 class="text-center">메세지 보내기</h3>
  	<div class="input-group mb-2">
			<div class="input-group-prepend"><span class="input-group-text">보내는 사람</span></div>  	
			<input type="text" name="senderId" id="senderId" value="${sMid}" class="form-control" readonly />
  	</div>
  	<div class="input-group mb-2">
  	<!--주소록에서 찾아와서 보낸다-->
			<div class="input-group-prepend"><span class="input-group-text">받는 사람</span></div>  	
			<input type="text" name="receiverId" id="receiverId" value="${param.receiverId}" class="form-control" readonly />
			<!--트리거 사용-->
			<div class="input-group-append"><a href="#" id="jusorokBtn" data-toggle="modal" data-target="#myModal" class="btn btn-success">주소록</a></div>  	
  	</div>
  	<div class="input-group">
  		<textarea rows="3" name="content" id="content" placeholder="메세지를 입력하세요" class="form-control"></textarea>
			<div class="input-group-append"><input type="button" value="메세지전송" onclick="messageSend()" class="btn btn-info"></div>  	
  	</div>
  </form>
  <hr/>
  <div>
  	<input type="button" value="받은메세지" id="receiveMessageBtn" onclick="location.href='MemberMessageSearch.msg?mid=${sMid}&msgFlag=r'" class="btn btn-success" />
  	<input type="button" value="보낸메세지" id="sendMessageBtn" onclick="location.href='MemberMessageSearch.msg?mid=${sMid}&msgFlag=s'" class="btn btn-primary" />
  </div>	
  
  <hr/>
  <div id="receiverMessage">
  	<h3 class="text-center">받은 메세지</h3>
  	<table class="table table-hover text-center">
  		<tr class="table-secondary">
  			<th>번호</th>
  			<th>보낸사람</th>
  			<th>보낸날짜</th>
  			<th>비고</th>
  		</tr>
 			<c:set var="no" value="${fn:length(messageVos)}" />
  		<c:forEach var="vo" items="${messageVos}" varStatus="st">
  			<tr>
  				<td>${no}</td>
  				<td>${vo.senderId}</td>
  				<td>${vo.msgDate}</td>
  				<td>
  					<a href="javascript:memberDeleteCheck(${vo.idx})" class="btn btn-danger btn-sm">삭제</a>
  					<a href="javascript:memberMessageContent(${vo.idx})" id="contentChekBtn" data-toggle="modal" data-target="#contentModal" class="btn btn-info btn-sm">내용확인</a>
  				</td>
  			</tr>
  			<c:set var="no" value="${no - 1}" />
  		</c:forEach>
  		<tr><td colspan="4" class="m-0 p-0"></td></tr>
  	</table>
  </div>

  <hr/>
  <div id="sendMessage">
  	<h3 class="text-center">보낸 메세지</h3>
  	<table class="table table-hover text-center">
  		<tr class="table-secondary">
  			<th>번호</th>
  			<th>받은사람</th>
  			<th>보낸날짜</th>
  			<!--아무처리가 되있지 않아서 삭제하면 상대것도 지워지기 때문에 여기선 삭제 없음 -->
  		</tr>
 			<c:set var="no" value="${fn:length(messageVos)}" />
  		<c:forEach var="vo" items="${messageVos}" varStatus="st">
  			<tr>
  				<td>${no}</td>
  				<td>${vo.receiverId}</td>
  				<td>${vo.msgDate}</td>
  			</tr>
  			<c:set var="no" value="${no - 1}" />
  		</c:forEach>
  		<tr><td colspan="4" class="m-0 p-0"></td></tr>
  	</table>
  </div>
</div>

<!-- 회원 주소록을 모달로 처리 -->
<div class="modal" id="myModal">
  <div class="modal-dialog modal-dialog-scrollable">
    <div class="modal-content">
      <div class="m-3">
        <div class="row">
          <div class="col"><h4>회원 주소록</h4></div>
          <div class="col text-right"><input type="button" value="아이디검색" onclick="idSearchView()" id="idSearchShowBtn" class="btn btn-success btn-sm text-right"/></div>
        </div>
        <div class="row" id="idSearch"></div>
      </div>
      <div class="modal-body">
        <table class="table table-hover">
          <tr class="table-dark text-dark">
            <th>번호</th>
            <th>아이디</th>
            <th>닉네임</th>
          </tr>
          <c:forEach var="vo" items="${vos}" varStatus="st">
            <tr>
              <td>${st.count}</td>
              <td><a href="MemberMessage.msg?receiverId=${vo.mid}">${vo.mid}</a></td>
              <td>${vo.nickName}</td>
            </tr>
          </c:forEach>
          <tr><td colspan="3" class="m-0 p-0"></td></tr>
        </table>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>
<!-- 모달끝 -->

<!-- 받은메세지 콘텐츠를 모달로 처리 -->
<div class="modal" id="contentModal">
  <div class="modal-dialog modal-dialog-scrollable">
    <div class="modal-content">
      <div class="m-3">
        <div class="row">
          <div class="col"><h4>메세지 제목</h4></div>
          <div class="col text-right"><input type="button" value="답장하기" onclick="" id="answer" class="btn btn-info btn-sm text-right"/></div>
        </div>
        <div class="row" id="idSearch"></div>
      </div>
      <div class="modal-body">
        <table class="table table-hover">
          <tr class="table-dark text-dark">
            <th>보낸 아이디</th>
            <th>보낸시간</th>
            <th>콘텐츠(메세지내용)</th>
          </tr>
            <tr>
              <td>${contentVo.senderId}</td>
              <td>${contentVo.msgDate}</td>
              <td>${contentVo.content}</td>
            </tr>
          <tr><td colspan="3" class="m-0 p-0"></td></tr>
        </table>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>
<!-- 모달끝 -->

<p><br /></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>
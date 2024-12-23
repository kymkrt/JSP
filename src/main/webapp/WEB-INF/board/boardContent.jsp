<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>boardContent.jsp</title>
  <jsp:include page="/include/bs4.jsp" />
  <style type="text/css">
  	th {
  		text-align: center;
  		background-color: #eee;
  	}
  </style>
  <script type="text/javascript">
  	'use strict'
  	
  	$(function() {
			$(".replyUpdateForm").hide();
		});
  	
  	function boardDelete() {
			let ans = confirm("현재 게시글을 삭제 하시겠습니까");
			if(ans) location.href="BoardDelete.bo?idx=${vo.idx}";
		}
  	
  	//좋아요 처리 중복 허용
  	function goodCheck1() {
			$.ajax({
				type : "post",
				url : "BoardGoodCheck.bo",
				data : {idx : ${vo.idx}},
				success : function(res) {
					if(res != "0"){
						location.reload(); //전체 리로드
					} //실패때는 굳이 리로드 할필요 없음
				},
				error : function() {
					alert("전송오류");
				}
			});
		}
  	
  	//좋아요/싫어요 처리 중복 허용
  	function goodCheck2(goodCnt) {
			$.ajax({
				type : "post",
				url : "BoardGoodCheck.bo",
				data : {
					idx : ${vo.idx},
					goodCnt : goodCnt	
				},
				success : function(res) {
					if(res != "0"){
						location.reload(); //전체 리로드
					} //실패때는 굳이 리로드 할필요 없음
				},
				error : function() {
					alert("전송오류");
				}
			});
		}
  	
  	//좋아요 처리 중복 불허
  	function goodCheck3() {
			$.ajax({
				type : "post",
				url : "BoardGoodCheck3.bo",
				data : {idx : ${vo.idx}},
				success : function(res) {
					if(res != "0"){
						location.reload(); //전체 리로드
					} 
					else alert("이미 좋아요 버튼을 누르셨습니다");
				},
				error : function() {
					alert("전송오류");
				}
			});
		}
  	
  	//모달의 기타 내용 입력창 보여주기
  	function etcShow() {
			$("#claimTxt").show();
		}
  	
  	//모달창에서 신고항목 선택후 확인 버튼 클릭시 수행처리(ajax)
  	function claimCheck() {
			//태그선택자=이름  내부에 ""를 안주려면 따로 [] 처리
			if(!$("input[type=radio][name=claim]:checked").is(':checked')) {
				alert("신고항목을 선택하세요");
				return false;
			}
			if($("input[type=radio]:checked").val() == '기타' && $("#claimTxt").val() == ''){
				alert("기타 사유를 입력해주세요");
				return false;
			}
			
			let claimContent = modalForm.claim.value;
			if(claimContent == '기타') claimContent += '/' + $("#claimTxt").val();
			
			let query = {
					part : 'board',
					partIdx : ${vo.idx},
					claimMid : '${sMid}', //세션이라 객체인데 값을 문자로 바꿔야 하기 때문이다
					claimContent : claimContent
			}
			
			$.ajax({
				type : "post",
				url : "BoardClaimInput.ad",
				data : query, //내용이 길면(3개 이상) 따로 뽑아주는게 낫다 위에것
				success:function(res){
					if(res != "0"){
						alert("신고 되었습니다");
						location.reload();
					}
					else {
						alert("신고실패");
					}
				},
				error : function() {
					alert("전송오류!");
				}
			});
		}
  	
  	//댓글 달기 
  	function replyCheck() {
			let content = $("#content").val();
			if(content.trim() == ""){
				alert("댓글을 입력하세요");
				return false;
			}
			
			let query = {
				boardIdx : ${vo.idx}, //숫자니까 따옴표 필요 없음
				mid : '${sMid}', //문자니까 따옴표 필요
				nickName : '${sNickName}',
				content : content, //문자지만 변수라 따옴표 필요없음
				hostIp : '${pageContext.request.remoteAddr}'
			}
			
			$.ajax({
				type : "post",
				url : "BoardReplyInput.bo",
				data : query,
				success: function(res) {
					if(res != "0"){
						alert("댓글이 입력되었습니다");
						location.reload(); //전체 리로드
						//부분 리로드(제이쿼리방식)
						//$("#replyViewList").load(location.href+' #replyViewList'); //이거 자체가 명령어라 +가 아니라 공백으로 떨어트려야 한다
						//$(".replyUpdateForm").hide();
					}
					else alert("댓글 입력 실패");
				},
				error: function() {
					alert("전송오류");
				}
			});
		}
  	
  	//댓글 삭제 처리
  	function replyDeleteCheck(idx) {
			let ans = confirm("선택한 댓글을 삭제하시겠습니까?");
			if(!ans) return false;
				
			$.ajax({
				type: "post",
				url: "BoardReplyDelete.bo",
				data: {idx : idx},
				success: function(res) {
					if(res!="0") {
						alert("댓글이 삭제되었습니다");
						location.reload();
					}
					else alert("삭제 실패");
				},
				error: function() {
					alert("전송오류");
				}
			});
		}
  	
  	//댓글 수정창 보여주기
  	function replyDeleteUpdateCheck(idx) {
  		$(".replyUpdateForm").hide();
			$("#replyUpdateForm"+idx).show();
		}
  	
  	//댓글 수정하기
  	function replyUpdateCheck(idx) {
  		let content = $("#content"+idx).val();
			if(content.trim() == ""){
				alert("댓글을 입력하세요");
				return false;
			}
			
			let query = {
				idx : idx, //숫자니까 따옴표 필요 없음
				content : content, //문자지만 변수라 따옴표 필요없음
				hostIp : '${pageContext.request.remoteAddr}'
			}
			
			$.ajax({
				type : "post",
				url : "BoardReplyUpdate.bo",
				data : query,
				success: function(res) {
					if(res != "0"){
						alert("댓글이 수정되었습니다");
						location.reload();
					}
					else alert("댓글 수정 실패");
				},
				error: function() {
					alert("전송오류");
				}
			});
		}
  	
  	//댓글 수정창 닫기
  	function replyUpdateViewClose(idx) {
			$("#replyUpdateForm"+idx).hide();
		}
  </script>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<jsp:include page="/include/nav.jsp" />
<p><br /></p>
<div class="container">
  <h2 class="text-center">글 내용 보기</h2>
  <table class="table table-bordered mt-4">
  	<tr>
  		<th>글쓴이</th>
  		<td>${vo.nickName}</td>
  		<th>글조회수</th>
  		<td>${vo.readNum}</td>
  	</tr>
  	<tr>
  		<th>글쓴 날짜</th>
  		<td>${vo.wDate}</td>
  		<th>접속아이피</th>
  		<td>${vo.hostIp}</td>
  	</tr>
  	<tr>
  		<th>글제목</th>
  		<td colspan="3">${vo.title}
  		( <a href="javascript:goodCheck1()" title="좋아요">❤💗💖</a>(${vo.good}) /
  		( <a href="javascript:goodCheck2(1)" title="좋아요">👍</a>(${vo.good}) /
  		( <a href="javascript:goodCheck2(-1)" title="싫어요">👎</a>(${vo.good}) /
  		( <a href="javascript:goodCheck3()" title="좋아요"><font color="blue">♥</font></a>(${vo.good}) /
  		</td>
  	</tr>
  	<tr>
  		<th>글내용</th>
  		<td colspan="3" style="height:240px;">${fn:replace(vo.content, newLine, '<br/>')}</td>
  	</tr>
	</table>
	  <table class="table table-borderless">
	    <tr>
	      <c:if test="${sMid == vo.mid || sLevel == 0}">
		      <td colspan="2" class="text-left">
		        <c:if test="${sMid == vo.mid}">
		        	<input type="button" value="수정하기" onclick="location.href='BoardUpdate.bo?idx=${vo.idx}&pag=${pag}'" class="btn btn-primary"/>
		        </c:if>
		        <input type="button" value="삭제하기" onclick="boardDelete()" class="btn btn-danger"/>
		      </td>
		      <td colspan="2" class="text-right">
		        <input type="button" value="돌아가기" onclick="location.href='BoardList.bo?pag=${pag}'" class="btn btn-warning"/>
		      </td>
	      </c:if>
	      <c:if test="${sMid != vo.mid && sLevel != 0}">
		      <td colspan="4" class="text-center">
		        <input type="button" value="돌아가기" onclick="location.href='BoardList.bo?pag=${pag}'" class="btn btn-warning"/>
		      </td>
	      </c:if>
	      <!--온클릭으로 현재창에서 하려고 하이퍼링크에 아무것도 안준것 버튼으로 하면 온클릭만 하면된다  -->
	      <td>
	      <c:if test="${sMid != vo.mid && vo.claim == 'NO'}"><a href="#" data-toggle="modal" data-target="#myModal" class="btn btn-danger">신고하기</a></c:if>
	      <c:if test="${vo.claim != 'NO'}">현재 게시글은 신고된 글입니다</c:if>
	      </td>
	    </tr>
	  </table>
</div>
<hr/>

<div class="container">
	<!--이전글 다음글 시작 -->
	<table class="table table-borderless">
		<tr>
			<td>
				<c:if test="${!empty nextVo.title}">
					다음글 <a href="BoardContent.bo?idx=${nextVo.idx}&pag=${pag}&pageSize=${pageSize}">${nextVo.title}</a><br/>
				</c:if>
				<c:if test="${!empty preVo.title}">
					이전글 <a href="BoardContent.bo?idx=${preVo.idx}&pag=${pag}&pageSize=${pageSize}">${preVo.title}</a><br/>
				</c:if>
			</td>
		</tr>
	</table>
	<!--이전글 다음글 끝 -->
	<p><br/></p>
	
	<div id="replyViewList">
	<!--댓글 처리(리스트, 입력) 시작-->
		<!--댓글 리스트-->
		<table class="table table-hover text-center">
			<tr>
				<th>작성자</th>
				<th>댓글내용</th>
				<th>댓글올린날짜</th>
				<th>접속IP</th>
			</tr>
			<!--그냥 vos를 쓰면 위랑 겹쳐서 바꿔줌   -->
			<c:forEach var="vo" items="${replyVos}" varStatus="st">
				<tr>
					<td>${vo.nickName}
						<c:if test="${sMid == vo.mid || sLevel == 0}"><!--배타적 필요없음 조건맞을때만 나오니까 -->
							(<a href="javascript:replyDeleteCheck(${vo.idx})" title="댓글삭제">X</a>)<!--숫자라 따옴표 필요없이 그냥 idx  -->
							<c:if test="${sMid == vo.mid}">
								<a href="javascript:replyDeleteUpdateCheck(${vo.idx})" title="댓글수정">√</a>
							</c:if>
						</c:if>
					</td>
					<td>${fn:replace(vo.content, newLine, "<br/>")}</td>
					<td>${fn:substring(vo.wDate, 0, 19)}</td>
					<td>${vo.hostIp}</td>
				</tr>
				<tr>
					<td colspan="4" class="m-0 p-0">
						<div id="replyUpdateForm${vo.idx}" style="border: none;" class="replyUpdateForm">
							<form name="replyUpdateForm">
								<table class="table table-borderless text-center">
									<tr>
										<td style="width:85%" class="text-left">
											글 내용 : 
											<textarea rows="4" name="content" id="content${vo.idx}" class="form-control">${vo.content}</textarea>
										</td>
										<td style="width:15%"><br/>
											<p>작성자 : ${sNickName}</p>
											<a href="javascript:replyUpdateCheck(${vo.idx})" class="badge badge-primary">댓글수정</a>
											<a href="javascript:replyUpdateViewClose(${vo.idx})" class="badge badge-warning">댓글창닫기</a>
										</td>
									</tr>
								</table>	
							</form>
						</div>
					</td>
				</tr>
			</c:forEach>
			<tr><td colspan="4" class="m-0 p-0"></td></tr>
		</table>
		<!--댓글 입력창-->
		<form name="replyFrom">
			<table class="table table-borderless text-center">
				<tr>
					<td style="width:85%" class="text-left">
						글 내용 : 
						<textarea rows="4" name="content" id="content" class="form-control" placeholder="댓글을 입력하세요"></textarea>
					</td>
					<td style="width:15%"><br/>
						<p>작성자 : ${sNickName}</p>
						<p><input type="button" value="댓글달기" onclick="replyCheck()" class="btn btn-info btn-sm" /></p>
					</td>
				</tr>
			</table>	
		</form>
	<!--댓글 처리 끝-->
	</div>
</div><!--이전글/다음글의 마감 div -->

<!-- The Modal 시작 -->
<div class="modal fade" id="myModal">
  <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
    <div class="modal-content">
      <div class="modal-header">
        <h3 class="modal-title">현재 게시글을 신고합니다</h3>
        <button type="button" class="close" data-dismiss="modal">×</button>
      </div>
      <div class="modal-body">
      	<b>신고사유 선택</b>
      	<hr/>
      	<form name="modalForm">
	  		  <div><input type="radio" name="claim" id="claim1" value="광고,홍보,영리목적"/> 광고,홍보,영리목적</div>
	        <div><input type="radio" name="claim" id="claim2" value="욕설,비방,차별,혐오"/> 설,비방,차별,혐오</div>
	        <div><input type="radio" name="claim" id="claim3" value="불법정보"/> 불법정보</div>
	        <div><input type="radio" name="claim" id="claim4" value="음란,청소년유해"/> 음란,청소년유해</div>
	        <div><input type="radio" name="claim" id="claim5" value="개인정보노출,유포,거래"/> 개인정보노출,유포,거래</div>
	        <div><input type="radio" name="claim" id="claim6" value="도배,스팸"/> 도배,스팸</div>
	        <div><input type="radio" name="claim" id="claim7" value="기타" onclick="etcShow()"/> 기타</div>
	        <div id="etc"><textarea rows="2" id="claimTxt" class="form-control" style="display:none"></textarea></div>
	        <hr/>
	        <input type="button" value="확인" onclick="claimCheck()" class="btn btn-success form-control" />
      	</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>
<!-- The Modal 끝 -->
<p><br /></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>
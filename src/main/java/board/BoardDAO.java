package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import common.GetConn;
import member.MemberVO;

public class BoardDAO {
	
	
	private Connection conn = GetConn.getConn();
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	String sql = "";
	private BoardVO vo = null;
	
	public void pstmtClose() {
		if(pstmt != null) {
			try {
				pstmt.close();
			} catch (Exception e) {}
		}
	}
	
	public void rsClose() {
		if(rs != null) {
			try {
				rs.close();
			} catch (Exception e) {}
			finally {	pstmtClose();	}
		}
	}
	
	//게시판 전체글 리스트
	public List<BoardVO> getBoardList(int startIndexNo, int pageSize) {
		
		List<BoardVO> vos = new ArrayList<BoardVO>();
		try {
			sql = "select *, datediff(wDate, now()) as date_diff, timestampdiff(hour, wDate, now()) as time_diff, "
					+ "(select count(idx) from boardReply where boardIdx=b.idx) as replyCnt"
					+ " from board b order by idx desc limit ?,?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startIndexNo);
			pstmt.setInt(2, pageSize);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				vo = new BoardVO(); // 생성을 해야함
				vo.setIdx(rs.getInt("idx"));
				vo.setMid(rs.getString("mid"));
				vo.setNickName(rs.getString("nickName"));
				vo.setTitle(rs.getString("title"));
				
				//vo.setContent(rs.getString("content"));
				String content = rs.getString("content").replaceAll("\\r?\\n", "<br/>");
				content = content.replace("'", "&#39;").replace("\"", "&#39;");
				vo.setContent(content);
				
				vo.setHostIp(rs.getString("hostIp"));
				vo.setOpenSw(rs.getString("openSw"));
				vo.setReadNum(rs.getInt("readNum"));
				vo.setGood(rs.getInt("good"));
				vo.setwDate(rs.getString("wDate"));
				vo.setClaim(rs.getString("claim"));
				
				vo.setDate_diff(rs.getInt("date_diff"));
				vo.setTime_diff(rs.getInt("time_diff"));
				vo.setReplyCnt(rs.getInt("replyCnt"));
				
				vos.add(vo);
			}
			
		} catch (SQLException e) {
			System.out.println("sql오류(getBoardList) "+e.getMessage());
		} finally {
			rsClose();
		}
		
		return vos;
	}

	//게시글 작성 처리
	public int setBoardInputOk(BoardVO vo) {
		int res = 0;	
		try {
			sql = "insert into board values (default, ?, ?, ?, ?, ?, ?,default,default,default,default)"; //s를 생략해도 값은 들어가지만 필수로 넣어야 한다 공통 sQL
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getMid());
			pstmt.setString(2, vo.getNickName());
			pstmt.setString(3, vo.getTitle());
			pstmt.setString(4, vo.getContent());
			pstmt.setString(5, vo.getHostIp());
			pstmt.setString(6, vo.getOpenSw());
			
			res = pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("sql오류(setBoardInputOk) "+e.getMessage());
		} finally {
			pstmtClose();
		}
		return res;
	}

	//게시글 1개 내용 가져오기
	public BoardVO getBoardContent(int idx) {
		
		BoardVO vo = new BoardVO();
		try {
			sql = "select *  from board where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();
			
			rs.next();
			
			vo.setIdx(rs.getInt("idx"));
			vo.setMid(rs.getString("mid"));
			vo.setNickName(rs.getString("nickName"));
			vo.setTitle(rs.getString("title"));
			vo.setContent(rs.getString("content"));
			vo.setHostIp(rs.getString("hostIp"));
			vo.setOpenSw(rs.getString("openSw"));
			vo.setReadNum(rs.getInt("readNum"));
			vo.setGood(rs.getInt("good"));
			vo.setwDate(rs.getString("wDate"));
			vo.setClaim(rs.getString("claim"));
			
		} catch (Exception e) {
			System.out.println("sql오류(getBoardContent) "+e.getMessage());
		} finally {
			rsClose();
		}
		
		return vo;
	}
	
	//글조회수 1씩 증가시키기
	public void setContentReadNumPlus(int idx) {
		
		try {
			sql = "update board set readNum = readNum+1 where idx =?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("sql오류(setContentReadNumPlus) "+e.getMessage());
		} finally {
			pstmtClose();
		}
	}
	
	//게시글 삭제 처리
	public int BoardDelete(int idx) {
		int res = 0;
		
		try {
			sql = "delete from board where idx =?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			res = pstmt.executeUpdate();
			/*
			 * pstmtClose();
			 * 
			 * sql = "delete from claim where part='board' and idx = ?"; pstmt =
			 * conn.prepareStatement(sql); pstmt.setInt(1, idx); res =
			 * pstmt.executeUpdate();
			 *///선언문이 없으면 자동완성 안됨 앞에 res가 있으면 자동으로 완성한다
			
		} catch (Exception e) {
			System.out.println("sql오류(BoardDelete) "+e.getMessage());
		} finally {
			pstmtClose();
		}
		
		return res;
	}
	
	//게시판 글의 총 수 구하기
	public int getTotRecCnt() {
		int totRecCnt = 0; //그냥 res 써도됨
		try {
				sql = "select count(*) as totRecCnt from board";//as 뒤는 변수명이라 마음대로 줘도 됨
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
			
				rs.next();
				totRecCnt = rs.getInt("totRecCnt");
		} catch (Exception e) {
			System.out.println("sql오류(getTotRecCnt) "+e.getMessage());
		}finally {
			rsClose();
		}
		return totRecCnt;
	}

	//게시글 수정 처리
	public int setBoardUpdateOk(BoardVO vo) {
		int res = 0;
		try {
			sql="update board set nickName=?, title=?, content=?, hostIp=?, openSw=?, wDate=now() where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getNickName());
			pstmt.setString(2, vo.getTitle());
			pstmt.setString(3, vo.getContent());
			pstmt.setString(4, vo.getHostIp());
			pstmt.setString(5, vo.getOpenSw());
			pstmt.setInt(6, vo.getIdx());
			
			res = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println("sql오류(setBoardUpdateOk) "+e.getMessage());
		} finally {
			pstmtClose();
		}
		return res;
	}
	
//좋아요 수/싫어요 수 증가 처리 중복 가능
	public int setBoardGoodCheck(int idx, int goodCnt) {
		int res = 0;
		try {
			sql="update board set good=good + ? where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, goodCnt);
			pstmt.setInt(2, idx);
			
			res = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("sql오류(setBoardGoodCheck) "+e.getMessage());
		} finally {
			pstmtClose();
		}
		return res;
	}
	
	//검색된 게시글 리스트
	public List<BoardVO> getBoardSearchList(String search, String searchString) {
		List<BoardVO> vos = new ArrayList<BoardVO>();
		try {
			sql = "select *, datediff(wDate, now()) as date_diff, timestampdiff(hour, wDate, now()) as time_diff from board where "+search+"  like ?";//where부분에 ?로 해서 넣으면 안된다
			//값을 그냥 넣으면 String으로 들어가게 되는데 그러면 그냥 값이 아니라 '값' 이 들어가게 된다 ''가 붙기 때문에
			//위와 같은 방식으로 변수 자체를 넣으면 값을 그대로 넣을수 있다
			//단 이 같은 방식은 제대로 설계를 했기 때문에 가능 select같은 곳에서 밸류 이름을 필드값과 똑같이 정했기 때문이다 
			//만약 그러지 못했다면 if(asd.equl("값")) 이런식으로 해서 sql을 여러개 만들어야 한다
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%"+searchString+"%");
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				vo = new BoardVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setMid(rs.getString("mid"));
				vo.setNickName(rs.getString("nickName"));
				vo.setTitle(rs.getString("title"));
				vo.setContent(rs.getString("content"));
				vo.setHostIp(rs.getString("hostIp"));
				vo.setOpenSw(rs.getString("openSw"));
				vo.setReadNum(rs.getInt("readNum"));
				vo.setGood(rs.getInt("good"));
				vo.setwDate(rs.getString("wDate"));
				vo.setClaim(rs.getString("claim"));
				
				vo.setDate_diff(rs.getInt("date_diff"));
				vo.setTime_diff(rs.getInt("time_diff"));
				
				vos.add(vo);
			}
			
		} catch (Exception e) {
			System.out.println("sql오류(getBoardSearchList) "+e.getMessage());
		}finally {
			rsClose();
		}
		
		return vos;
	}

	// 이전글/다음글 처리하기(idx, title 가져오기)
	public BoardVO getPreNextSearch(int idx, String str) {
		BoardVO vo = new BoardVO();
		try {
			if(str.equals("pre")) sql = " select idx, title from board where idx < ? order by idx desc limit 1";
			else sql = " select idx, title from board where idx > ? order by idx limit 1";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();
			
			//제일 처음 글이거나 마지막 글이면 다음글 이전글이 없기 때문에 rs.next() 를 꼭 써야한다
			if(rs.next()) {
				vo.setIdx(rs.getInt("idx"));
				vo.setTitle(rs.getString("title"));
			}
			
		} catch (SQLException e) {
			System.out.println("sql오류(getPreNextSearch) "+e.getMessage());
		}finally {
			rsClose();
		}
		
		return vo;
	}

	//댓글 리스트
	public ArrayList<BoardReplyVO> getBoardReply(int idx) {
		ArrayList<BoardReplyVO> vos = new ArrayList<BoardReplyVO>();
		try {
			sql = "select * from boardReply where boardIdx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				BoardReplyVO vo = new BoardReplyVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setBoardIdx(rs.getInt("boardIdx"));
				vo.setMid(rs.getString("mid"));
				vo.setNickName(rs.getString("nickName"));
				vo.setHostIp(rs.getString("hostIp"));
				vo.setContent(rs.getString("content"));
				vo.setwDate(rs.getString("wDate"));
				
				vos.add(vo);
			}
			
		} catch (SQLException e) {
			System.out.println("sql오류(getBoardReply) "+e.getMessage());
		}finally {
			rsClose();
		}
		
		return vos;
	}

	//댓글 입력처리
	public int setBoardReplyInput(BoardReplyVO vo) {
		int res = 0;
		try {
			sql = "insert into boardReply values (default, ?, ?, ?, ?, ?, default)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, vo.getBoardIdx());
			pstmt.setString(2, vo.getMid());
			pstmt.setString(3, vo.getNickName());
			pstmt.setString(4, vo.getContent());
			pstmt.setString(5, vo.getHostIp());
			
			res = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println("sql오류(setBoardReplyInput) "+e.getMessage());
		} finally {
			pstmtClose();
		}
		return res;
	}
	
	//댓글삭제
	public int setBoardReplyDelete(int idx) {
		int res = 0;
		try {
			sql = "delete from boardReply where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			
			res = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("sql오류(setBoardReplyDelete) "+e.getMessage());
		}
		return res;
	}

	//댓글 수정
	public int setBoardReplyUpdate(BoardReplyVO vo) {
		int res = 0;
		try {
			sql = "update boardReply set content = ?, hostIp = ? where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getContent());
			pstmt.setString(2, vo.getHostIp());
			pstmt.setInt(3, vo.getIdx());
			
			res = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println("sql오류(setBoardReplyUpdate) "+e.getMessage());
		}finally {
			pstmtClose();
		}
		return res;
	}
	
}

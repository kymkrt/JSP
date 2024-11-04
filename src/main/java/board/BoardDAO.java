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
	
	//게시판 리스트
	public List<BoardVO> getBoardList(int startIndexNo, int pageSize) {
		
		List<BoardVO> vos = new ArrayList<BoardVO>();
		try {
			sql = "select * from board order by idx desc limit ?,?";
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
				vo.setContent(rs.getString("content"));
				vo.setHostIp(rs.getString("hostIp"));
				vo.setOpenSw(rs.getString("openSw"));
				vo.setReadNum(rs.getInt("readNum"));
				vo.setGood(rs.getInt("good"));
				vo.setwDate(rs.getString("wDate"));
				vo.setClaim(rs.getString("claim"));
				
				vos.add(vo);
			}
			
		} catch (SQLException e) {
			System.out.println("sql오류 "+e.getMessage());
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
			System.out.println("sql오류 "+e.getMessage());
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
			System.out.println("sql오류 "+e.getMessage());
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
			System.out.println("sql오류 "+e.getMessage());
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
			
		} catch (Exception e) {
			System.out.println("sql오류 "+e.getMessage());
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
			System.out.println("sql오류(setMemberLevelChange) "+e.getMessage());
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
	
}

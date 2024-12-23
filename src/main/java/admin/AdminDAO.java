package admin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import admin.claim.ClaimVO;
import admin.review.ReviewVO;
import common.GetConn;
import member.MemberVO;

public class AdminDAO {
	
	
	private Connection conn = GetConn.getConn();
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	String sql = "";
	
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
	
	//member 테이블의 아이디 검색후 성명 돌려 보내기
	public String getIdSearch(String mid) {
		String name = "";
		try {
			sql = "select name from member where mid = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			rs = pstmt.executeQuery();
			
			//if나 while을 상황에 맞게 꼭 써야한다
			if(rs.next()) {
				name = rs.getString("name");
			}
		} catch (SQLException e) {
			System.out.println("sql오류(getIdSearch) "+e.getMessage());
		} finally {
			rsClose();
		}
		
		return name;
	}
	
	//가장 많은 포인트
	public MemberVO getMostPoint() {
		MemberVO vo = new MemberVO();
		try {
			sql = "select point name from member where ";
			
		} catch (Exception e) {
			System.out.println("sql오류(getMostPoint) "+e.getMessage());
		}
		
		
		return vo;
	}
	
	//포인트가 최대인 회원 검색
	public MemberVO getAjaxPointCheck() {
		MemberVO vo = new MemberVO(); //무조건 생성
		try {
			sql = "select max(point) as point, mid, name from member";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			//if나 while을 상황에 맞게 꼭 써야한다
			if(rs.next()) {
				vo.setName(rs.getString("name"));
				vo.setMid(rs.getString("mid"));
				vo.setPoint(rs.getInt("point"));
			}
		} catch (Exception e) {
			System.out.println("sql오류(getAjaxPointCheck) "+e.getMessage());
		} finally {
			rsClose();
		}
		return vo;
	}

	//
	public int setBoardClaimInput(ClaimVO vo) {
		int res = 0;
		try {
			sql="insert into claim values (default, ?, ?, ?, ?, default)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getPart());
			pstmt.setInt(2, vo.getPartIdx());
			pstmt.setString(3, vo.getClaimMid());
			pstmt.setString(4, vo.getClaimContent());
			res = pstmt.executeUpdate();
	
			pstmtClose();// 재사용 하려면 반납해야한다
			
			sql="update "+vo.getPart()+" board set claim = 'OK' where idx =?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, vo.getPartIdx());
			
			res = pstmt.executeUpdate();
			
			
		} catch (Exception e) {
			System.out.println("sql오류(setBoardClaimInput) "+e.getMessage());
		} finally {
			pstmtClose();
		}
		return res;
	}
	
	//신고 내역 전체 리스트
	public List<ClaimVO> getClaimList(int startIndexNo, int pageSize) {
		List<ClaimVO> vos = new ArrayList<ClaimVO>();
		try {
			//sql = "select c.*, b.title as title, b.nickName as nickName, b.mid as mid, b.claim as claim from claim c, board b where c.partIdx = b.idx order by idx desc";
			sql = "select c.*, b.title as title, b.nickName as nickName, b.mid as mid, b.claim as claim from claim c, board b where c.partIdx = b.idx order by idx desc limit ?, ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startIndexNo);
			pstmt.setInt(2, pageSize);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ClaimVO vo = new ClaimVO();
				//테이블 필드명
				vo.setIdx(rs.getInt("idx"));
				vo.setPart(rs.getString("part"));
				vo.setPartIdx(rs.getInt("partIdx"));
				vo.setClaimMid(rs.getString("claimMid"));
				vo.setClaimContent(rs.getString("claimContent"));
				vo.setClaimDate(rs.getString("claimDate"));
				//VO에 추가한 필드명
				vo.setTitle(rs.getString("title"));
				vo.setNickName(rs.getString("nickName"));
				vo.setMid(rs.getString("mid"));
				vo.setClaim(rs.getString("claim"));
				
				vos.add(vo);
			}
			
		} catch (SQLException e) {
			System.out.println("sql오류(getClaimList) "+e.getMessage());
		} finally {
			rsClose();
		}
		
		return vos;
	}

	//신고항목 표시하기(NO)/감추기(OK)
	public int setClaimViewCheck(String flag, int idx) {
		int res = 0;
		try {
			sql = "update board set claim = ? where idx=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, flag);
			pstmt.setInt(2, idx);
			res = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println("sql오류(setClaimViewCheck) "+e.getMessage());
		} finally {
			pstmtClose();
		}
		return res;
	}
	
	//신고글과 원본글 삭제하기
	public int setClaimDeleteOk(String part, int idx) {
		int res = 0;
		try {
			sql = "delete from board where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			res = pstmt.executeUpdate(); 
			pstmtClose();
			
			sql = "delete from claim where part=? and partIdx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, part);
			pstmt.setInt(2, idx);
			res = pstmt.executeUpdate(); 
			
		} catch (SQLException e) {
			System.out.println("sql오류(ClaimDeleteOk) "+e.getMessage());
		} finally {
			pstmtClose();
		}
		return res;
	}
	
	//선택된 게시물들 삭제하기(이때 선택 게시물이 신고된 글이라면 함께 신고글도 함께 삭제처리한다)
	public void setBoardSelectDelete(int idx) {
		
		try {
			sql = "delete from board where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.executeUpdate(); //선언문이 없으면 자동완성 안됨 앞에 res가 있으면 자동으로 완성한다
			/*
			 * pstmtClose();
			 * 
			 * sql = "delete from claim where part='board' and idx = ?"; pstmt =
			 * conn.prepareStatement(sql); pstmt.setInt(1, idx); pstmt.executeUpdate();
			 * //선언문이 없으면 자동완성 안됨 앞에 res가 있으면 자동으로 완성한다
			 */			
		} catch (SQLException e) {
			System.out.println("sql오류(setBoardSelectDelete) "+e.getMessage());
		}finally {
			pstmtClose();
		}
		
	}
	
	//총수 구하는거 변경 (게시글만 지우면 신고리스트에서 안지워져서 자리만 차지한다 그걸 해결하기 위한것)
	public int getTotRecCnt() {
		int totRecCnt = 0;
		try {
			//sql = "select count(idx) as totRecCnt from claim";
			sql = "select count(*) as totRecCnt from claim c, board b where c.partIdx=b.idx";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			rs.next();
			totRecCnt = rs.getInt("totRecCnt");
		} catch (SQLException e) {
			System.out.println("SQL 오류: "+e.getMessage());
		}finally {
			rsClose();
		}
		return totRecCnt;
	}
	
//리뷰를 작성했는지에 대한 여부 체크하기
	public int getReviewSearch(ReviewVO vo) {
		int res = 0;
		try {
			sql = "select * from review where part = ? and partIdx = ? and mid = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getPart());
			pstmt.setInt(2, vo.getPartIdx());
			pstmt.setString(3, vo.getMid());
			rs = pstmt.executeQuery();
			if(rs.next()) res = 1;
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			rsClose();
		}
		return res;
	}

	// 리뷰 작성 처리하기
	public int getReviewInputOk(ReviewVO vo) {
		int res = 0;
		try {
			sql = "insert into review values (default,?,?,?,?,?,?,default)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getPart());
			pstmt.setInt(2, vo.getPartIdx());
			pstmt.setString(3, vo.getMid());
			pstmt.setString(4, vo.getNickName());
			pstmt.setString(5, vo.getContent());
			pstmt.setInt(6, vo.getStar());
			res = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			pstmtClose();
		}
		return res;
	}

	// 리뷰 전체 리스트 가져오기
	public ArrayList<ReviewVO> getReviewList(int idx, String part) {
		ArrayList<ReviewVO> rVos = new ArrayList<ReviewVO>();
		try {
			//sql = "select * from review where part = ? and partIdx = ? order by idx desc";
			sql = "select * from (select * from review where part=? and partIdx=?) as v left join reviewReply r "
					+ "on v.partIdx=? and v.idx=r.reviewIdx order by v.idx desc, r.replyIdx desc";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, part);
			pstmt.setInt(2, idx);
			pstmt.setInt(3, idx);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ReviewVO vo = new ReviewVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setPart(rs.getString("part"));
				vo.setPartIdx(rs.getInt("partIdx"));
				vo.setMid(rs.getString("mid"));
				vo.setNickName(rs.getString("nickName"));
				vo.setContent(rs.getString("content"));
				vo.setStar(rs.getInt("star"));
				vo.setReviewDate(rs.getString("reviewDate"));
				
				vo.setReplyIdx(rs.getInt("replyIdx"));
				vo.setReplyMid(rs.getString("replyMid"));
				vo.setReplyNickName(rs.getString("replyNickName"));
				vo.setReplyContent(rs.getString("replyContent"));
				vo.setReplyDate(rs.getString("replyDate"));
				
				rVos.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			rsClose();
		}
		return rVos;
	}

	// 리뷰에 댓글달기
	public int setReviewReplyInputOk(ReviewVO vo) {
		int res = 0;
		try {
			sql = "insert into reviewReply values (default,?,?,?,?,default)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, vo.getIdx());
			pstmt.setString(2, vo.getReplyMid());
			pstmt.setString(3, vo.getReplyNickName());
			pstmt.setString(4, vo.getReplyContent());
			res = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			pstmtClose();
		}
		return res;
	}

	// 리뷰 댓글 삭제하기
	public int setReviewReplyDelete(int replyIdx) {
		int res = 0;
		try {
			sql = "delete from reviewReply where replyIdx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, replyIdx);
			res = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			pstmtClose();
		}
		return res;
	}

	public int setReviewDelete(int idx) {
		int res = 0;
		try {
			sql = "delete from review where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			res = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			pstmtClose();			
		}
		return res;
	}

}

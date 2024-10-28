package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import common.GetConn;

public class MemberDAO {
	
	//둘다 가능 단 하나만 가능
	//객체를 호출할때 필드개념으로
	private Connection conn = GetConn.getConn();
//	private Connection conn2 = GetConn.getConn();
	
	//우리는 이거 사용 지금은 못씀
	//private GetConn conn = GetConn.getInstance();
//	private GetConn conn2 = GetConn.getInstance();
//	
//	public MemberDAO() {
//		if(conn == conn2) System.out.println("같다");
//		else System.out.println("다르다");
//	}

		private PreparedStatement pstmt = null;
		private ResultSet rs = null;
		
		String sql = "";
		MemberVO vo = null;
		
		//여기 싱글톤에서는 connClose가 있으면 안된다 내가 닫으면 다른 사람들도 다닫히기 때문
		
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

		//Member테이블에서 아이디 검색하기
		public MemberVO MemberIdCheck(String mid) {
			MemberVO vo = new MemberVO();
			try {
				sql = "select * from member where mid = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, mid);
				rs = pstmt.executeQuery();
				
				if(rs.next()) { //동명이인 허용안해서 1건이라 if
					vo.setIdx(rs.getInt("idx"));
					vo.setMid(rs.getString("mid"));
					vo.setPwd(rs.getString("pwd"));
					vo.setNickNickname(rs.getString("nickName"));
					vo.setName(rs.getString("name"));
					vo.setGender(rs.getString("gender"));
					vo.setBirthday(rs.getString("birthday"));
					vo.setTel(rs.getString("tel"));
					vo.setAddress(rs.getString("address"));
					vo.setEmail(rs.getString("email"));
					vo.setContent(rs.getString("content"));
					vo.setPhoto(rs.getString("photo"));
					vo.setLevel(rs.getInt("level"));
					vo.setUserInfo(rs.getString("userInfo"));
					vo.setUserDel(rs.getString("userDel"));
					vo.setPoint(rs.getInt("point"));
					vo.setVisitCnt(rs.getInt("visitCnt"));
					vo.setTodayCnt(rs.getInt("todayCnt"));
					vo.setStartDate(rs.getString("startDate"));
					vo.setLastDate(rs.getString("lastDate"));
					vo.setSalt(rs.getString("salt"));
				}
			} catch (SQLException e) {
				System.out.println("sql오류 "+e.getMessage());
			} finally {
				rsClose();
			}
			return vo;
		}

		//방문포인트 10씩 증가시켜주기
		public void setPointPlus(String mid) {//void라 리턴없이 예외처리만
			try {
				//sql = "update set member point = point + 10 where mid = ?"; //여기서는 sql명령어라 += 안됨
				//업데이트를 한번에 해줌 ,로 나눠준다
				sql = "update member set point=point+10, visitCnt=visitCnt+1, todayCnt=todayCnt+1, lastDate=now() where mid = ?"; //여기서는 sql명령어라 += 안됨
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, mid);
				pstmt.executeUpdate();
				
			} catch (SQLException e) {
				System.out.println("sql오류 "+e.getMessage());
			} finally {
				pstmtClose();
			}
		}
		
}

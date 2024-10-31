package admin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

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
			System.out.println("sql오류 "+e.getMessage());
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
			System.out.println("sql오류 "+e.getMessage());
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
			System.out.println("sql오류 "+e.getMessage());
		} finally {
			rsClose();
		}
		return vo;
	}

}

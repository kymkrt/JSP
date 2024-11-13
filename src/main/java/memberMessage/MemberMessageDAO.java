package memberMessage;

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

public class MemberMessageDAO {
	
	
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
	
	//메세지 내용 저장
	public int setMemberMessageInput(MemberMessageVO vo) {
		int res = 0;
		try {
			sql = "insert into memberMessage values(default,?,?,?,default)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getSenderId());
			pstmt.setString(2, vo.getReceiverId());
			pstmt.setString(3, vo.getContent());
			res = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println("SQL 오류(setMemberMessageInput) : " + e.getMessage());
		} finally {
			pstmtClose();			
		}
		return res;
	}

	//받은메세지 보낸메세지 검색처리
	public ArrayList<MemberMessageVO> getMemberMessageSearch(String msgFlag, String mid) {
		ArrayList<MemberMessageVO> vos = new ArrayList<MemberMessageVO>();
		try {
			if(msgFlag.equals("r")) {
				sql = "select * from memberMessage where receiverId = ?";
			}
			else {
				sql = "select * from memberMessage where senderId = ?";
			}
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				MemberMessageVO vo = new MemberMessageVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setSenderId(rs.getString("senderId"));
				vo.setReceiverId(rs.getString("receiverId"));
				vo.setMsgDate(rs.getString("msgDate"));
				vo.setContent(rs.getString("content"));
				
				vos.add(vo);
			}
				
		} catch (SQLException e) {
			System.out.println("sql오류(getMemberMessageSearch) "+e.getMessage());
		}finally {
			rsClose();
		}
		return vos;
	}

	
	//받은 메세지 한건 가져오기
	public MemberMessageVO getMemberMessageContent(int idx) {
		MemberMessageVO vo = new MemberMessageVO();
		try {
			sql="select * from memberMessage where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				vo.setIdx(rs.getInt("idx"));
				vo.setSenderId(rs.getString("senderId"));
				vo.setReceiverId(rs.getString("receiverId"));
				vo.setMsgDate(rs.getString("msgDate"));
				vo.setContent(rs.getString("content"));
			}
			
		} catch (SQLException e) {
			System.out.println("sql오류(getMemberMessageContent) : "+e.getMessage());
		}finally {
			rsClose();
		}
		return vo;
	}
	
}

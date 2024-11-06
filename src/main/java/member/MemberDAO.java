package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

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
		public MemberVO getMemberIdCheck(String mid) {
			MemberVO vo = new MemberVO();
			try { //홍장군_nickName
				int sw = 0;
				
				if (mid.indexOf("_nickName") != -1) {
					mid = mid.substring(0, mid.indexOf("_nickName"));
					sw = 1;
				}
				
				if(sw == 0) {
					sql = "select * from member where mid = ? and userDel != 'Ok'";
				}
				else {
					sql = "select * from member where nickName = ?";
				}
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, mid);
				rs = pstmt.executeQuery();
				
				if(rs.next()) { //동명이인 허용안해서 1건이라 if
					vo.setIdx(rs.getInt("idx"));
					vo.setMid(rs.getString("mid"));
					vo.setPwd(rs.getString("pwd"));
					vo.setNickName(rs.getString("nickName"));
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
					//vo.setSalt(rs.getString("salt"));
				}
			} catch (SQLException e) {
				System.out.println("sql오류(getMemberIdCheck) "+e.getMessage());
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
				System.out.println("sql오류(setPointPlus) "+e.getMessage());
			} finally {
				pstmtClose();
			}
		}
		
		//회원가입 처리
		public int setMemberJoinOk(MemberVO vo) {
			int res = 0;
			try {
				sql = "insert into member values(default,?,?,?,?,?,?,?,?,?,?,?,?,default,default,default,default,default,default,default)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, vo.getMid());
				pstmt.setString(2, vo.getPwd());
				pstmt.setString(3, vo.getNickName());
				pstmt.setString(4, vo.getName());
				pstmt.setString(5, vo.getGender());
				pstmt.setString(6, vo.getBirthday());
				pstmt.setString(7, vo.getTel());
				pstmt.setString(8, vo.getAddress());
				pstmt.setString(9, vo.getEmail());
				pstmt.setString(10, vo.getContent());
				pstmt.setString(11, vo.getPhoto());
				pstmt.setString(12, vo.getUserInfo());
				res = pstmt.executeUpdate();
				
			} catch (SQLException e) {
				System.out.println("sql 오류(setMemberJoinOk) " +e.getMessage());
			}finally {
				pstmtClose();
			}
			
			return res;
		}
		
		//멤버 닉네임 체크
		public MemberVO getMemberNickNameCheck(String nickName) {
			MemberVO vo = new MemberVO();
			try {
				sql = "select * from member where nickName = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, nickName);
				rs = pstmt.executeQuery();
				
				if(rs.next()) { //동명이인 허용안해서 1건이라 if
					vo.setIdx(rs.getInt("idx"));
					vo.setMid(rs.getString("mid"));
					vo.setPwd(rs.getString("pwd"));
					vo.setNickName(rs.getString("nickName"));
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
					//vo.setSalt(rs.getString("salt"));
				}
			} catch (SQLException e) {
				System.out.println("sql오류(getMemberNickNameCheck) "+e.getMessage());
			} finally {
				rsClose();
			}
			return vo;
		}
		
		//방문시 Update처리할 내용들 기술한다
		public void setMemberInforUpdate(MemberVO vo) {
			try {
				sql = "update member set point=?, visitCnt=visitCnt+1, todayCnt=?, lastDate=now() where mid = ?"; //여기서는 sql명령어라 += 안됨
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, vo.getPoint());
				pstmt.setInt(2, vo.getTodayCnt());
				pstmt.setString(3, vo.getMid());
				pstmt.executeUpdate();
				
			} catch (SQLException e) {
				System.out.println("sql오류(setMemberInforUpdate) "+e.getMessage());
			} finally {
				pstmtClose();
			}
		}
		
		//전체 회원 리스트 처리
		public ArrayList<MemberVO> getMemberList(int startIndexNo, int pageSize, int level) {
			ArrayList<MemberVO> vos = new ArrayList<MemberVO>();
			try {
				if(level == 999) {
					sql = "select * , datediff(now(),lastDate) as elapsed_date from member order by idx desc limit ?,?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, startIndexNo);
					pstmt.setInt(2, pageSize);
				}
				else {
					sql = "select * , datediff(now(),lastDate) as elapsed_date from member where level=? order by idx desc limit ?,?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, level);
					pstmt.setInt(2, startIndexNo);
					pstmt.setInt(3, pageSize);
				}
				
				rs = pstmt.executeQuery();
				
				while (rs.next()) {
					MemberVO vo = new MemberVO();
					vo.setIdx(rs.getInt("idx"));
					vo.setMid(rs.getString("mid"));
					vo.setPwd(rs.getString("pwd"));
					vo.setNickName(rs.getString("nickName"));
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
					vo.setElapsed_date(rs.getInt("elapsed_date"));
					
					vos.add(vo);
				}
				
			} catch (Exception e) {
				System.out.println("sql(getMemberList) 오류 "+e.getMessage());
			} finally {
				rsClose();
			}
			
			return vos;
		}
		
		//멤버 레벨 수정
		public void setMemberLevelUpdate(int idx, int level) {
			try {
				sql = "update member set level = ? where idx = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, level);
				pstmt.setInt(2, idx);
				pstmt.executeUpdate();
			} catch (SQLException e) {
				System.out.println("SQL 오류(setMemberLevelUpdate) : " + e.getMessage());
			}	finally {
				pstmtClose();
			}
		}

		//회원정보 수정
		public int setMemberUpdateOk(MemberVO vo) {
			int res = 0;
			try {
				sql = "update member set name=?, nickName=?, gender=?, birthday=?, tel=?, address=?,"
						+ " email=?, content=?, photo=?, userInfo=? where mid = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, vo.getName());
				pstmt.setString(2, vo.getNickName());
				pstmt.setString(3, vo.getGender());
				pstmt.setString(4, vo.getBirthday());
				pstmt.setString(5, vo.getTel());
				pstmt.setString(6, vo.getAddress());
				pstmt.setString(7, vo.getEmail());
				pstmt.setString(8, vo.getContent());
				pstmt.setString(9, vo.getPhoto());
				pstmt.setString(10, vo.getUserInfo());
				pstmt.setString(11, vo.getMid());
				
				res = pstmt.executeUpdate();
			} catch (Exception e) {
				System.out.println("sql오류(setMemberUpdateOk) "+e.getMessage());
			}finally {
				pstmtClose();
			}
			return res;
		}

		public int setMemberPwdCheckAjaxOk(String mid, String pwd) {
			int res = 0;
			try {
				sql = "update member set pwd=? where mid=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, pwd);
				pstmt.setString(2, mid);
				res = pstmt.executeUpdate();
			} catch (Exception e) {
				System.out.println("sql오류(setMemberPwdCheckAjaxOk) "+e.getMessage());
			}finally {
				pstmtClose();
			}
			return res;
		}

		//회원 탈퇴 신청처리(userDel 의 NO를 OK로 바꾸기
		public int setMemberDeleteCheckOk(String mid) {
			int res = 0;
			try {
				sql = "update member set userDel='OK', level='99' where mid=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, mid);
				res = pstmt.executeUpdate();
				
			} catch (Exception e) {
				System.out.println("sql오류(setMemberDeleteCheckOk) "+e.getMessage());
			}finally {
				pstmtClose();
			}
			return res;
		}

		//회원등급 변경(관리자가 처리)
		public int setMemberLevelChange(int level, int idx) {
			int res = 0;
			try {
				sql = "update member set level=? where idx=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, level);
				pstmt.setInt(2, idx);
				
				res = pstmt.executeUpdate();
			} catch (Exception e) {
				System.out.println("sql오류(setMemberLevelChange) "+e.getMessage());
			}finally {
				pstmtClose();
			}
			return res;
		}

		//회원의 총인원수 구하기
		public int getTotRecCnt(int level) {
			int totRecCnt = 0; //그냥 res 써도됨
			try {
				if(level == 999) {
					sql = "select count(idx) as totRecCnt from member";//as 뒤는 변수명이라 마음대로 줘도 됨
					pstmt = conn.prepareStatement(sql);
				}
				else {
					sql = "select count(idx) as totRecCnt from member where level=?";//as 뒤는 변수명이라 마음대로 줘도 됨
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, level);
				}
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
		
		//회원 상세정보 가져오기
		public MemberVO getMemberIdxCheck(int idx) {
			MemberVO vo = new MemberVO();
			try { //홍장군_nickName
				sql = "select * from member where idx = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, idx);
				rs = pstmt.executeQuery();
				
				if(rs.next()) { //동명이인 허용안해서 1건이라 if
					vo.setIdx(rs.getInt("idx"));
					vo.setMid(rs.getString("mid"));
					vo.setPwd(rs.getString("pwd"));
					vo.setNickName(rs.getString("nickName"));
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
					//vo.setSalt(rs.getString("salt"));
				}
			} catch (SQLException e) {
				System.out.println("sql오류 "+e.getMessage());
			} finally {
				rsClose();
			}
			return vo;
		}

		public int setMemberDeleteOk(String midDelete) {
			int res = 0;
			try {
				sql = "delete from member where mid = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, midDelete);
				
				res = pstmt.executeUpdate();
				
			} catch (SQLException e) {
				System.out.println("sql오류(setMemberDeleteOk) "+e.getMessage());
			} finally {
				pstmtClose();
			}
			return res;
		}

}

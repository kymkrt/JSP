package guest;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class GuestDAO {
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	String sql = "";
	GuestVO vo = null;
	
	public GuestDAO() {
		//포트번호는 늘 :
		String url = "jdbc:mysql://localhost:3306/javagroup";
		String user = "root";
		String password = "1234";
		
		//I/O, 데이터베이스, 스레드 전부 예외처리 해야한다
		try {
			//거꾸로 들어감 도메인
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(url, user, password);
		} catch (ClassNotFoundException e) {
			System.out.println("드라이버 검색 실패 "+e.getMessage());
			e.printStackTrace();
		} catch (SQLException e) {
			System.out.println("DB 연동 실패 "+e.getMessage());
			e.printStackTrace();
		}
	}
	
	public void connClose() {
		if(conn != null) {
			try {
				conn.close();
			} catch (Exception e) {} //닫는데 오류가 나진 않는다
		}
	}
	public void pstmeClose() {
		if(pstmt != null) {
			try {
				pstmt.close();
			} catch (Exception e) {} //닫는데 오류가 나진 않는다
		}
	}
	public void rsClose() {
		if(rs != null) {
			try {
				rs.close();
				pstmeClose();
			} catch (Exception e) {} //닫는데 오류가 나진 않는다
		}
	}
	
	//방명록 전체 자료 가져오기
	public List<GuestVO> getGuestList(int startIndexNo, int pageSize) {
		List<GuestVO> vos = new ArrayList<GuestVO>();//인터페이스는 생성안됨 어레이리스트로?
		try {
			sql = "select * from guest order by idx desc limit ?, ?"; //시작페이지 분량 만큼 한페이지 
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startIndexNo);
			pstmt.setInt(2, pageSize);
			//select는 무조건 rs
			rs  = pstmt.executeQuery();
			
			while (rs.next()) {
				vo = new GuestVO(); //사용할때는 생성해라
				vo.setIdx(rs.getInt("idx"));
				vo.setName(rs.getString("name"));
				vo.setContent(rs.getString("content"));
				vo.setEmail(rs.getString("email"));
				vo.setHomePage(rs.getString("homePage"));
				vo.setVisitDate(rs.getString("visitDate"));
				vo.setHostIp(rs.getString("hostIp"));
				
				vos.add(vo);
			}
			
		} catch (SQLException e) {
			System.out.println("데이터 가져오기 실패 "+e.getMessage());
		} finally {
			rsClose();//select는 rsClose
		}
		return vos;
	}
	
	//방명록에 작성한 글을 DB에 저장시키기
	public int setGuestInputOk(GuestVO vo) {
		
		int res = 0;
		try {
			sql = "insert into guest values (default, ?,?,?,?,default,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getName());
			pstmt.setString(2, vo.getContent());
			pstmt.setString(3, vo.getEmail());
			pstmt.setString(4, vo.getHomePage());
			pstmt.setString(5, vo.getHostIp());
			
			res = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println("sql오류 " +e.getMessage());
		}finally {
			pstmeClose();
		}
		return res;
	}

	//방명록 글 삭제처리
	public int setGuestDeleteOk(int idx) {
		int res = 0;
		
		try {
			sql = "delete from guest where idx=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			
			res = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println("sql오류 " +e.getMessage());
		}finally {
			pstmeClose();
		}
		
		return res;
	}

	//현재 방명록의 전체 글의 갯수
	public int getTotRecCnt() {
		int totRecCnt = 0;
		
		try {
			sql = "select count(*) as cnt from guest";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			rs.next();
			totRecCnt = rs.getInt("cnt");//필드명 모르면 숫자(1로 시작) 혹은 sql에 as로 별명 주기
			
		} catch (SQLException e) {
			System.out.println("sql오류 " +e.getMessage());
		}finally {
			rsClose(); //select임
		}
		return totRecCnt;
	}
}

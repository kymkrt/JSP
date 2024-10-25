package study2.database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import guest.GuestVO;

public class DbTestDAO {
	//여기서만 쓸거니까 프라이베이트
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	//sql 매번쓰기 귀찮아서 하나 만들어줌
	String sql = "";
	DbTestVO vo = null;
	
	//계속 데이터베이스와 연결이 되어있어야 하기 때문에 생성할때 데이터 베이스 연결
	public DbTestDAO() {
		String url = "jdbc:mysql://localhost:3306/javagroup";
		String user = "root";
		String password = "1234";

		//데이터베이스 관련 무조건 트라이 에러
		try {
			//거꾸로 들어감 드라이버도 대문자
			Class.forName("com.mysql.jdbc.Driver");
			//System.out.println("드라이버 검색 성공");
			//이것도 데이터베이스 관련 서라운딩으로 해서 이중 캐치 해야함
			conn = DriverManager.getConnection(url, user, password);
			//System.out.println("Database 연결 성공");
		} catch (ClassNotFoundException e) {
			System.out.println("드라이버 검색 실패 "+ e.getMessage());
			//e.printStackTrace(); 이게 원래것 엄청 길게 나옴
		} catch (SQLException e) {
			System.out.println("Database 연동 실패 : "+ e.getMessage());
			//e.printStackTrace(); 이게 원래것 엄청 길게 나옴
		}
	}
	
	//사용하지 않는 객체 반납(conn, pstmt,rs)
	public void connClose() {
		if(conn != null) {
			try {
				//외부관련이라 트라이 캐치
				conn.close();
				//닫는건 오류가 안나서 그냥 닫아둔다
			} catch (SQLException e) {}
		}
	}
	public void pstmtClose() {
		if(pstmt != null) {
			//외부관련이라 트라이 캐치
			try {
				pstmt.close();
				//닫는건 오류가 안나서 그냥 닫아둔다
			} catch (SQLException e) {}
		}
	}
	public void rsClose() {
		//외부관련이라 트라이 캐치
		if(rs != null) {
			try {
				rs.close();
				//rs가 닫힐때는 pstmt도 닫힌다 
				pstmtClose();
				//닫는건 오류가 안나서 그냥 닫아둔다
			} catch (SQLException e) {}
		}
	}

	//개별 자료 검색 1건 검색
	public DbTestVO getDbTestSearch(int idx) {
		
		try {
			sql = "select * from hoewon where idx = ?"; //limit 1,10 인덱스 번호 1번부터 10번. 10 10개가져오기
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();
			
			//bof가 있기 때문에 rs.next()로 넘겨줘야함 있으면 true 없으면 false
			//동명이인이 없으면 if도 되고 while도 된다
			if(rs.next()) {
				vo = new DbTestVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setName(rs.getString("name"));
				vo.setAge(rs.getInt("age"));
				vo.setGender(rs.getString("gender"));
				vo.setAddress(rs.getString("address"));
			}
		} catch (SQLException e) {
			System.out.println("SQL 오류 "+e.getMessage());
		}finally {
			//데이터를 지우기 보다는 메모리 관리를 위해 지운다
			rsClose();
		}
		
		return vo;
	}

	//전체 자료 출력
	public ArrayList<DbTestVO> getDbTestList(String name) {
		ArrayList<DbTestVO> vos = new ArrayList<DbTestVO>();
		
		try {
			if(name.equals("")) {
				sql = "select * from hoewon order by idx desc";
				pstmt = conn.prepareStatement(sql);
			}
			else {
				sql = "select * from hoewon where name = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, name);
			}
			//레코드단위로 가져온다
			//레코드 단위로 담는것
			rs = pstmt.executeQuery();
			
			//여러개라 if가 아니라 while
		//bof가 있기 때문에 rs.next()로 넘겨줘야함 있으면 true 없으면 false
			while(rs.next()) {
				vo = new DbTestVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setName(rs.getString("name"));
				vo.setAge(rs.getInt("age"));
				vo.setGender(rs.getString("gender"));
				vo.setAddress(rs.getString("address"));
				
				vos.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("SQL 오류 "+e.getMessage());
		}finally {
			//데이터를 지우기 보다는 메모리 관리를 위해 지운다
			rsClose();
		}
		
		return vos;
	}

	//회원자료 등록 메소드
	public int setDbInputOk(DbTestVO vo) {
		int res = 0;
		//데이터베이스라 무조건 예외처리 나옴
		try {
			
			sql = "insert into hoewon values (default,?,?,?,? )";//입력받는건데 뭐인지 몰라서 ? pstmt만
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getName());
			pstmt.setInt(2, vo.getAge());
			pstmt.setString(3, vo.getGender());
			pstmt.setString(4, vo.getAddress());
			res = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println("SQL 오류 "+e.getMessage());
		}finally {
			//데이터를 지우기 보다는 메모리 관리를 위해 지운다
			//select가 아니면 전부 pstmt
			pstmtClose();
		}
		return res;
	}

	//회원 개인정보 수정처리
	public int setDbUpdateOk(DbTestVO vo) {
		int res = 0;
		try {
			//뭘 수정했는지 알수 없기 때문에 다 넣어어햐 한다
			sql="update hoewon set name=?, age=?, gender=?, address=? where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getName());
			pstmt.setInt(2, vo.getAge());
			pstmt.setString(3, vo.getGender());
			pstmt.setString(4, vo.getAddress());
			pstmt.setInt(5, vo.getIdx());
		//select가 아니면 전부 pstmt
			res = pstmt.executeUpdate();
			
		}catch (SQLException e) {
			System.out.println("SQL 오류 "+e.getMessage());
		}finally {
			//데이터를 지우기 보다는 메모리 관리를 위해 지운다
			//select가 아니면 전부 pstmt
			pstmtClose();
		}
		return res;
	}

	//회원 정보 삭제 하기 처리
	public int setDbDeleteOk(int idx) {
		int res = 0;
		try {
			sql = "delete from hoewon where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			res = pstmt.executeUpdate();
		}catch (SQLException e) {
			System.out.println("SQL 오류 "+e.getMessage());
		}finally {
			//데이터를 지우기 보다는 메모리 관리를 위해 지운다
			//select가 아니면 전부 pstmt
			pstmtClose();
		}
		return res;
	}
	
}

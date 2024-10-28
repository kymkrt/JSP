package common;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
//싱글톤 객체
public class GetConn {
	private static Connection conn = null; //얘가 있어야 아래 드라이버매니저 사용가능
	
	private String driver = "com.mysql.jdbc.Driver"; //드라이버는 클래스명이라 첫글자가 대문자
	private String url = "jdbc:mysql://localhost:3306/javagroup"; 
	private String user = "root";
	private String password = "1234";
	
	//보통 싱글톤에 이거 씀
	//얘가 메모리에 올라갈때만든다 
	private static GetConn instance = new GetConn();
	
	//외부에서 생성불가
	private GetConn() {
		try {
			Class.forName(driver);
			conn = DriverManager.getConnection(url, user, password); //위에 없앨거면 Connection conn 으로 아예 여기서 만들어야 한다
		} catch (ClassNotFoundException e) {
			System.out.println("드라이버 검색 실패 "+ e.getMessage());
		} catch (SQLException e) {
			System.out.println("sql 연동 실패 "+ e.getMessage());
		}
	}
	
	//부를때 이걸로 부른다 
	public static GetConn getInstance() { //게터 
		return instance;
	}
	
	//호출하려면 static 필요 위방식 아래 방식 원하는대로 단 타입주의 
	public static Connection getConn() { //위에서 커넥션을 생성자안에 넣어서 메소드에서 사용불가
		return conn;
	}	
}

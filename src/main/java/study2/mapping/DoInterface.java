package study2.mapping;

import java.io.IOException;
import java.rmi.ServerException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface DoInterface {
	
	//작업지시할 추상메소드를 만들어준다 
	//리턴타입을 알수 없으므로 void를 준다
	//실행한다는 의미로 execute를 주로 쓴다 
	//인터페이스는 구현객체가 아니라? 뒤에 {}가 아니라 ;로 끊어준다
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServerException, IOException;
	
}

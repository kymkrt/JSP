package guest;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface GuestInterface {

	//인터페이스에는 실행블록이 없어서 {}넣으면 안됨
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;// ;으로 마무리
	
}

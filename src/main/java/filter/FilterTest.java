package filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

//http서블릿은 추상메소드
//인터페이스임
public class FilterTest implements Filter{

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)	throws IOException, ServletException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		
		//전과 후를 쪼개서 처리 할수 있게 해주는게 필터체인
		System.out.println("1.필터수행 전 입니다");
		
		//필터 전
		chain.doFilter(request, response);
		//필터 후
		
		System.out.println("2.필터수행 후 입니다\n");
		
		
		
	}
	
}

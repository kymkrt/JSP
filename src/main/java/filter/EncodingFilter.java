package filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;

//모든게 다 통과함
@WebFilter("/*")
public class EncodingFilter implements Filter{

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		
		//System.out.println("11.필터수행 전 입니다");
		
		//전과 후를 쪼개서 처리 할수 있게 해주는게 필터체인
		//필터 전
		chain.doFilter(request, response);
		//필터 후
		
		//System.out.println("22.필터수행 후 입니다\n");
	}
	
}

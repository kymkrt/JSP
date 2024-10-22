package practice;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpFilter;

@WebFilter(urlPatterns = {"/Prac"})
public class PracFilter extends HttpFilter implements Filter {
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		System.out.println("필터전");
		chain.doFilter(request, response);
		System.out.println("필터후");
		
	}
	
	@Override
	public void init() throws ServletException {
	}
	
	@Override
	public void destroy() {
	}
	
	
}

package com.mySpringMvc.utils;

import java.io.IOException;  
import javax.servlet.Filter;  
import javax.servlet.FilterChain;  
import javax.servlet.FilterConfig;  
import javax.servlet.ServletException;  
import javax.servlet.ServletRequest;  
import javax.servlet.ServletResponse;  
import javax.servlet.http.HttpServlet;  
import javax.servlet.http.HttpServletRequest;  
import javax.servlet.http.HttpServletResponse;  
import javax.servlet.http.HttpSession;   
  
/** 
 * Filter 登录拦截器 
 * @author 
 * @date 
 */  
public class SecurityServlet extends HttpServlet implements Filter{  
  
    /** 
     *  
     */  
    private static final long serialVersionUID = 1L;  
  
    public void init(FilterConfig filterConfig) throws ServletException {  
    }

	@Override
	public void doFilter(ServletRequest arg0, ServletResponse arg1, FilterChain arg2)
			throws IOException, ServletException {
		// TODO Auto-generated method stub
		
	}  
  
    
  
} 
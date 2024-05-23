package com.syau.filter;

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

public class SecurityServletFilter extends HttpServlet implements Filter {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	public void destroy() {
		// TODO Auto-generated method stub

	}

	@Override
	public void doFilter(ServletRequest req, ServletResponse respon,
			FilterChain filter) throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest) req;
		HttpServletResponse response = (HttpServletResponse) respon;
		HttpSession session = request.getSession(true);
		// String usercode = (String) request.getRemoteUser();// 登录人
		String user_role = (String) session.getAttribute("userName");// 登录人角色
		String url = request.getRequestURI();
		/*
		 * if (usercode == null || "".equals(usercode) ||user_role == null ||
		 * "".equals(user_role)) {
		 */
		if (url != null && !url.equals("") && url.indexOf("Admin") > 0) {
			if (user_role != null && !"".equals(user_role)) {
				filter.doFilter(req, respon);
				return;
			} else {
				response.sendRedirect(request.getContextPath()
						+ "/login/ManagerLogin.jsp");
				return;
			}
		}
		filter.doFilter(req, respon);
		return;
	}

	@Override
	public void init(FilterConfig req) throws ServletException {
		// TODO Auto-generated method stub

	}

}

package com.syau.interceptor;

import java.io.File;
import java.text.SimpleDateFormat;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;
import org.springframework.core.NamedThreadLocal;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

public class logfilter implements HandlerInterceptor {
	private final Logger log = Logger.getLogger(getClass().getName());
	private static final ThreadLocal<Long> startTimeThreadLocal = new NamedThreadLocal<Long>(
			"ThreadLocal StartTime");

	@Resource
	private ServletContext servletContext;

	public void setServletContext(ServletContext context) {
		this.servletContext = context;
	}
	/*log文件的路径*/
    File logFolder=new File("C:/log");
	/*
	 * 预处理
	 */
	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {
		//如果log的文件路径不村在就创建
		if(!logFolder.exists()){
			logFolder.mkdirs();
		}
		PropertyConfigurator.configure(servletContext.getRealPath("/")
				+ "WEB-INF/Log4j.properties");
		long beginTime = System.currentTimeMillis(); // 开始时间
		startTimeThreadLocal.set(beginTime); // 线程绑定变量（该数据只有当前请求的线程可见）
		log.error("★★★开始★★★");
		System.out.println("执行时间："
				+ new SimpleDateFormat("yyyy-MM-dd hh:mm:ss.SSS")
						.format(beginTime));

		return true;
	}

	/*
	 * 返回处理
	 */
	@Override
	public void postHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		if (modelAndView != null) {
			log.error("ViewName: " + modelAndView.getViewName());
		}
	}

	/*
	 * 后处理
	 */
	@Override
	public void afterCompletion(HttpServletRequest request,
			HttpServletResponse response, Object handler, Exception ex)
			throws Exception {

		// 保存日志
		//LogUtils.saveLog(request, handler, ex, null);

		// 输出日志信息
		log.error("访问地址：" + request.getRequestURI() + ",执行方式："
				+ request.getMethod()+",执行的方法：method="+request.getParameter("method"),ex);
		//long beginTime = startTimeThreadLocal.get(); // 得到线程绑定的局部变量（开始时间）
		//long endTime = System.currentTimeMillis(); // 结束时间
		log.error("★★★结束★★★");
		System.out.println("执行的方法：method="+request.getParameter("method"));
	}
}

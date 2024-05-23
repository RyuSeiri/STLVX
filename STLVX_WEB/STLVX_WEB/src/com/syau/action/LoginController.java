package com.syau.action;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.syau.po.SystemControlBean;
import com.syau.service.SystemControlService;

@Controller
@RequestMapping("login.do")
public class LoginController {
	@Resource
	private SystemControlService systemControlService;

	public SystemControlService getSystemControlService() {
		return systemControlService;
	}

	public void setSystemControlService(SystemControlService systemControlService) {
		this.systemControlService = systemControlService;
	}

	@RequestMapping(params = "method=login", method = RequestMethod.POST)
	public  String login(@RequestParam (value="username") String name,@RequestParam (value="password")  String password,@RequestParam(value="code") String codeImg, HttpSession httpSession,HttpServletRequest request)
			throws Exception {
		if(codeImg.equalsIgnoreCase((String) httpSession.getAttribute("code"))){
			 List<SystemControlBean> teacherList = systemControlService.select(name);
				if (teacherList != null && teacherList.size() > 0) {
					SystemControlBean teacher = teacherList.get(0);
					String realPassword = teacher.getsValue();
					if (realPassword.equals(password)) {
						httpSession.setAttribute("userName", "教师");
						httpSession.setAttribute("userAuthority", "teacher");
						return "redirect:/Admin/index.jsp";
					}
				}else{
					httpSession.setAttribute("message", "用户名或密码错误");
				}
		}else{
			httpSession.setAttribute("message", "验证码错误");
		}
		return  "redirect:login/ManagerLogin.jsp";
	}
}

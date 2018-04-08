package com.taiji.user.controller;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.DisabledAccountException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.taiji.core.base.controller.BaseController;
import com.taiji.core.logback.LOG;
import com.taiji.core.utils.DesUtils;
import com.taiji.core.utils.StringUtils;
import com.taiji.user.model.SysUser;
import com.taiji.user.service.SysUserService;
import com.taiji.user.service.SysUserServiceImpl;

/**
 * @description：登录退出
 * @author：admin @date：2015/10/1 14:51
 */
@Component
@Controller
public class LoginController extends BaseController {
	@Autowired
	private SysUserService userService;

	private static final Logger LOGGER = LogManager.getLogger(LoginController.class);

	/**
	 * 首页
	 * @return
	 * 
	 */
	@GetMapping("/")
	public String index(HttpServletRequest request) {
		return "redirect:/index";
	}

	/**
	 * 首页
	 *
	 * @param model
	 * @return
	 */
	@GetMapping("/index")
	public String index(Model model,HttpServletRequest request) {
		LOG.info(LOGGER, request, getLoginName()+" 登录成功！");
		return "main/login/index";
	}

	/**
	 * GET 登录
	 * 
	 * @return {String}
	 */
	@GetMapping("/login")
	public String login(HttpServletRequest request) {
		LOG.info(LOGGER, request, "访问系统登录页！");
		if (SecurityUtils.getSubject().isAuthenticated()) {
			return "redirect:/index";
		}
		return "main/login/Login";
	}

	/**
	 * POST 登录 shiro 写法
	 *
	 * @param username
	 *            用户名
	 * @param password
	 *            密码
	 * @return
	 */
	@PostMapping("/login")
	@ResponseBody
	public Object loginPost(String username, String password) {
		LOGGER.info("请求登录："+username);
		if (StringUtils.isBlank(username.trim())||username.equals("请输入你的用户名")) {
			return renderError("用户名不能为空");
		}
		if (StringUtils.isBlank(password.trim())) {
			return renderError("密码不能为空");
		}
		SysUser sessionUser = null;
		try {
			sessionUser =  userService.selectByLoginName(username.trim());
			if (sessionUser.getUsingState().equals("20256")) {
				return renderError("用户已停用");
			}
		} catch (Exception e1) {
			LOGGER.info("操作失败！：请求登录："+username+"("+e1+")");
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}		
		Subject user = SecurityUtils.getSubject();
		try {
			
			UsernamePasswordToken token = new UsernamePasswordToken(username.trim(), DesUtils.encrypt(password.trim(), DesUtils.KEY_XW));
			// 默认设置为记住密码，你可以自己在表单中加一个参数来控制
			token.setRememberMe(true);
			user.login(token);
			//设置session共享
		} catch (UnknownAccountException e) {
			LOGGER.error("账号不存在！", e);
			return renderError("账号不存在");
		} catch (DisabledAccountException e) {
			LOGGER.error("账号未启用！", e);
			return renderError("账号未启用");
		} catch (Exception e) {
			LOGGER.error("账号或密码错误！", e);
			return renderError("账号或密码错误");
		} 
		
		
		return renderSuccess();
	}

	/**
	 * 未授权
	 * 
	 * @return {String}
	 */
	@GetMapping("/unauth")
	public String unauth() {
		if (SecurityUtils.getSubject().isAuthenticated() == false) {
			return "redirect:/login";
		}
		return "adminModule/login/unauth";
	}

	/**
	 * 退出
	 * 
	 * @return {Result}
	 */
	@GetMapping("/logout")
	public Object logout() {
		LOGGER.info("退出！:"+getLoginName());
		Subject subject = SecurityUtils.getSubject();
		subject.logout();
		return "redirect:/login";
	}
	
	/**
	 * 设置共享对象
	 * @return
	 */
	public static HttpSession getSession() { 
		HttpSession session = null; 
		try { 
			session = getRequest().getSession(); 
		} catch (Exception e) {} 
			return session; 
	} 
		
	public static HttpServletRequest getRequest() { 
		ServletRequestAttributes attrs =(ServletRequestAttributes) RequestContextHolder.getRequestAttributes(); 
		return attrs.getRequest(); 
	}

}

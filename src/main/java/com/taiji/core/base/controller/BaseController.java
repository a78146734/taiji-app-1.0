package com.taiji.core.base.controller;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.InitBinder;

import com.taiji.core.base.result.Result;
import com.taiji.core.shiro.ShiroUser;
import com.taiji.core.utils.StringEscapeEditor;
import com.taiji.user.model.SysUser;
import com.taiji.user.service.SysUserServiceImpl;

/**
 * 
 * @author 赵国超
 * 
 * 所有的Controller需要继承他
 *
 * 2018年2月27日
 */
public abstract class BaseController {
	@Autowired
	private SysUserServiceImpl sysUserService;

	@InitBinder
	public void initBinder(ServletRequestDataBinder binder) {
		/**
		 * 自动转换日期类型的字段格式
		 */
		binder.registerCustomEditor(Date.class,
				new CustomDateEditor(new SimpleDateFormat("yyyy-MM-dd"), true));

		/**
		 * 防止XSS攻击
		 */
		binder.registerCustomEditor(String.class, new StringEscapeEditor());
	}

	/**
	 * 获取当前登录用户对象
	 * 
	 * @return
	 */
	public SysUser getCurrentUser() {
		SysUser sysUser = null;
		try {
			sysUser = sysUserService.selectByUserId(getShiroUser().getUserId());
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return sysUser;
	}

	public ShiroUser getShiroUser() {
		ShiroUser user = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
		return user;
	}

	

	/**
	 * 获取当前登录用户id
	 * 
	 * @return
	 */
	public String getUserId() {
		return this.getCurrentUser().getUserId();
	}
	
	
	/**
	 *获取当前登录用户
	 * @author anjl
	 * 
	 */
	public String getLoginName(){
		return this.getCurrentUser().getLoginName();
	}
	
	/**
	 * 获取当前登录用户名
	 * 
	 * @return
	 */
	public String getStaffName() {
		return this.getCurrentUser().getUsername();
	}

	/**
	 * ajax失败
	 * 
	 * @param msg
	 *            失败的消息
	 * @return {Object}
	 */
	public Result renderError(String msg) {
		Result result = new Result();
		result.setMsg(msg);
		return result;
	}

	/**
	 * ajax失败
	 * 
	 * @param msg
	 *            失败的消息
	 * @return {Object}
	 */
	public Result renderError() {
		Result result = new Result();
		return result;
	}

	/**
	 * ajax成功
	 * 
	 * @return {Object}
	 */
	public Result renderSuccess() {
		Result result = new Result();
		result.setSuccess(true);
		return result;
	}

	/**
	 * ajax成功
	 * 
	 * @param msg
	 *            消息
	 * @return {Object}
	 */
	public Result renderSuccess(String msg) {
		Result result = new Result();
		result.setSuccess(true);
		result.setMsg(msg);
		return result;
	}

	/**
	 * ajax成功
	 * 
	 * @param obj
	 *            成功时的对象
	 * @return {Object}
	 */
	public Result renderSuccess(Object obj) {
		Result result = new Result();
		result.setSuccess(true);
		result.setObj(obj);
		return result;
	}

}

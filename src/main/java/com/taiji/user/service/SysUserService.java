package com.taiji.user.service;

import java.util.List;

import com.taiji.core.base.service.BaseService;
import com.taiji.core.utils.PageInfo;
import com.taiji.user.model.SysUser;

public interface SysUserService extends BaseService<SysUser, String> {

	public SysUser selectByLoginName(String loginName) throws Exception;

	public void deleteUserById(String id) throws Exception;

	public SysUser selectByUserId(String userId) throws Exception;
	
	public List<SysUser> selectByCertId(String certId) throws Exception;
	
	/**
	 * 根据用户名或登录名 查询用户
	 * 
	 * @param loginName
	 * @param username
	 * @return
	 */
	List<SysUser> selectByLoginNameOrUsername(String loginName, String username) throws Exception;
	
	/**
	 * 根据 userid 更新 密码
	 * 
	 * @param sysUser
	 * @return 
	 */
	SysUser updateUserPassword(String userId,String password) throws Exception;

	/**
	 * 选择更新，不更新null字段
	 * 
	 * @param entity
	 * @return 
	 */
	public SysUser updateUserSelective(SysUser entity) throws Exception;
	
	/**
	 * 插入用户
	 * 
	 * @param sysUser
	 */
	int insert(SysUser sysUser,List<String> organIds,List<String> roleIds,String staffName) throws Exception;

	/**
	 * 根据 userid 更新数据
	 * 
	 * @param sysUser
	 * @return 
	 */
	int updateUser(SysUser sysUser,List<String> organIds,List<String> roleIds,String staffName) throws Exception;
	/**
	 * 某部门用户列表
	 * 
	 * @param pageInfo
	 */
	PageInfo<SysUser> selectUserOrganPage(PageInfo<SysUser> pageInfo, String organId) throws Exception;

}
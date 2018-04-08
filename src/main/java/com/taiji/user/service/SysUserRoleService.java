package com.taiji.user.service;

import java.util.List;
import java.util.Map;

import com.taiji.core.base.service.BaseService;
import com.taiji.user.model.SysRole;
import com.taiji.user.model.SysUser;
import com.taiji.user.model.SysUserRole;

/**
 *
 * 用户-角色 表数据服务层接口
 *
 */
public interface SysUserRoleService extends BaseService<SysUserRole, String>{
	/**
	 * 根据用户id查询 角色id
	 * 
	 * @param userId
	 * @return
	 */
	List<String> selectRoleIdListByUserId(String userId) throws Exception;

	/**
	 * 删除用户的应有角色
	 * 
	 * @param roleIds
	 * @param userId
	 * @param staffName
	 */
	int deleteByUser( String userId) throws Exception;
}
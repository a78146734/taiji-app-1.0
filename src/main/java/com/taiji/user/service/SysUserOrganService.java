package com.taiji.user.service;

import java.util.List;

import com.taiji.user.model.SysUserOrgan;

/**
 *
 * 用户-部门 表数据服务层接口
 *
 */
public interface SysUserOrganService {
	/**
	 * 根据用户id查询 组织机构id 组织机构递归
	 * 
	 * @param userId
	 * @return
	 */
	List<String> selectOrganIdListByUserId(String userId) throws Exception;
	
	/**
	 * 根据用户id查询 权限id
	 * 
	 * @param userId
	 * @return
	 */
	List<String> selectRecursiveBelowOrganIdListByUserId(String userId) throws Exception;

	/**
	 * 删除用户的应有部门
	 * 
	 * @param userId
	 */
	int deleteByUser(String userId) throws Exception;

}
package com.taiji.user.service;

import java.util.List;

import com.taiji.core.base.service.BaseService;
import com.taiji.user.model.SysRole;

public interface SysRoleService extends BaseService<SysRole, String> {


	/**
	 * 插入角色
	 * 
	 * @param sysRole
	 * @return 
	 */
	int insert(SysRole sysRole) throws Exception;

	/**
	 * 根据id查询
	 * 
	 * @param id
	 * @return
	 */
	SysRole selectById(String id) throws Exception;

	/**
	 * 根据id更新
	 * 
	 * @param role
	 * @return 
	 */
	public SysRole updateRole(SysRole role) throws Exception;

	/**
	 * 查询角色
	 * 
	 * @return
	 */
	List<SysRole> selectAll() throws Exception;

	/**
	 * 根据id删除数据
	 * 
	 * @param id
	 */
	void deleteById(String id) throws Exception;



	/**
	 * 根绝用户查询角色
	 * 
	 * @param userId
	 * @return
	 */
	List<SysRole> selectByUser(String userId) throws Exception;

	/**
	 * 根据code查询角色
	 * 
	 * @param userId
	 * @return
	 */
	SysRole selectByCode(String code) throws Exception;
	
	/**
	 * 根据角色名称查询是否存在
	 */
	SysRole selectRoleByRoleName(String roleName) throws Exception;
	
	/**
	 * 根据角色标示查询是否存在
	 */
	SysRole selectRoleByCode(String code) throws Exception;

}
/*package com.taiji.user.service;

import java.util.List;

import com.taiji.core.base.service.BaseService;
import com.taiji.core.utils.PageInfo;
import com.taiji.user.model.SysRole;

*//**
 *
 * 角色 表数据服务层接口
 *
 *//*
public interface SysRoleService extends BaseService<SysRole, String>{
	*//**
	 * 分页查询角色
	 * 
	 * @param pageInfo
	 *//*
	PageInfo<SysRole> selectByPage(PageInfo<SysRole> pageInfo) throws Exception;
	PageInfo<SysRole> selectRoleByPage(PageInfo<SysRole> pageInfo) throws Exception;

	*//**
	 * 插入角色
	 * 
	 * @param sysRole
	 *//*
	void insert(SysRole sysRole) throws Exception;

	*//**
	 * 根据id查询
	 * 
	 * @param id
	 * @return
	 *//*
	SysRole selectById(String id) throws Exception;

	*//**
	 * 根据id更新
	 * 
	 * @param role
	 *//*
	void updateRole(SysRole role) throws Exception;

	*//**
	 * 查询角色
	 * 
	 * @return
	 *//*
	List<SysRole> selectAll() throws Exception;

	*//**
	 * 根据id删除数据
	 * 
	 * @param id
	 *//*
	void deleteById(String id) throws Exception;

	*//**
	 * 检查用户是否拥有该角色
	 * 
	 * @param userid
	 * @param code
	 * @return
	 *//*
	boolean checkRoleByUser(String userid, String code) throws Exception;

	*//**
	 * 根绝用户查询角色
	 * 
	 * @param userId
	 * @return
	 *//*
	List<SysRole> selectByUser(String userId) throws Exception;

	*//**
	 * 根据code查询角色
	 * 
	 * @param userId
	 * @return
	 *//*
	SysRole selectByCode(String code) throws Exception;
	
	*//**
	 * 根据角色名称查询是否存在
	 *//*
	SysRole selectRoleByRoleName(String roleName) throws Exception;
	
	*//**
	 * 根据角色标示查询是否存在
	 *//*
	SysRole selectRoleByCode(String code) throws Exception;
}*/
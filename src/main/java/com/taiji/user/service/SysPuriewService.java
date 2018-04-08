package com.taiji.user.service;

import java.util.List;
import java.util.Map;

import com.taiji.core.base.service.BaseService;
import com.taiji.core.utils.PageInfo;
import com.taiji.user.model.SysDictionaryData;
import com.taiji.user.model.SysPuriew;

/**
 * 权限 表数据服务层接口
 * 
 * @author guochao
 *
 */
public interface SysPuriewService extends BaseService<SysPuriew, String>{
	/**
	 * 查询所有数据
	 * 
	 * @return
	 */
	List<SysPuriew> selectAll() throws Exception;


	/**
	 * 查询
	 * 
	 * @param id
	 * @return
	 */
	SysPuriew selectById(String id) throws Exception;

	/**
	 * 全局权限配置
	 * 
	 * @return URLS EXPRESSION
	 */
	List<Map<String, Object>> globalConfig() throws Exception;

	/**
	 * 根据 角色id 或者 组织机构 查询 权限id
	 * 
	 * @param roleIds
	 * @param organIds
	 * @return
	 */
	List<String> selectPuriewIdList(List<String> roleIds, List<String> organIds) throws Exception;

	/**
	 * 插入
	 * 
	 * @param sysPuriew
	 */
	int insert(SysPuriew sysPuriew) throws Exception;

	/**
	 * 更新
	 * 
	 * @param sysPuriew
	 */
	int updateSysPuriew(SysPuriew sysPuriew) throws Exception;

	/**
	 * 删除
	 * 
	 * @param id
	 */
	int deleteById(String id) throws Exception;

	/**
	 * 检测用户是否有权限
	 * 
	 * @param userid
	 * @param code
	 * @return
	 */
	boolean checkPuriewByUser(String userid, String code) throws Exception;

	/**
	 * 根据用户id查询
	 * 
	 * @param valueOf
	 * @return
	 */
	List<SysPuriew> selectByUser(String userId) throws Exception;

	/**
	 * 根据code 查询
	 * 
	 * @param code
	 * @return
	 */
	SysPuriew selectByCode(String code) throws Exception;

	/**
	 * 根据角色code查询权限
	 * @param code
	 * @return
	 * @throws Exception 
	 */
	List<SysPuriew> selectByRoleCode(String roleCode) throws Exception;
	
	/**
	 * 根据组织机构查询权限
	 * @param organId
	 * @return
	 */
	List<SysPuriew> selectByOrgan(String organId);
	/**
	 * 权限列表
	 * @param pageInfo
	 * @throws Exception 
	 */
	PageInfo<SysPuriew> selectByPage(PageInfo pageInfo) throws Exception;

	/**
	 * 查询 所有权限数据 转树形
	 * @return
	 */
	List<Map<String, Object>> selectAllPurToTree() throws Exception;
}
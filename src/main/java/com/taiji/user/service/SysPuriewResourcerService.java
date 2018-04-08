package com.taiji.user.service;

import java.util.List;
import java.util.Map;

import com.taiji.core.base.service.BaseService;
import com.taiji.user.model.SysPuriewResource;
import com.taiji.user.model.SysRole;

/**
 * 权限-资源 表数据服务层接口
 * 
 * @author guochao
 *
 */
public interface SysPuriewResourcerService extends BaseService<SysPuriewResource, String>{
	/**
	 * 根据 角色id或者部门id 查询资源id列表 两个参数至少一个不为null
	 * 
	 * @param roleList
	 * @param organList
	 * @return
	 */
	List<String> selectResourceIdList(List<String> roles,List<String> organs) throws Exception;

	/**
	 * 根据 权限id 查询资源id列表
	 * 
	 * @param puriewId
	 * @return
	 */
	List<String> selectResourceIdListByPuriewId(String puriewId) throws Exception;

	/**
	 * 更新 资源-权限 中间表数据 【先删除再插入】
	 * 
	 * @param resourceIds
	 * @param id
	 * @param staffName
	 */
	void updateByPuriew(String resourceIds, String id, String staffName) throws Exception;

	/**
	 * 插入
	 * 
	 * @param sysPuriewResource
	 */
	void insert(SysPuriewResource sysPuriewResource) throws Exception;
	
	/**
	 * 全局权限配置
	 * 
	 * @return URLS EXPRESSION
	 */
	List<Map<String, Object>> globalConfig() throws Exception;
	
	List<String> selectResourceIdTreeList(List<String> organs) throws Exception;
	
}
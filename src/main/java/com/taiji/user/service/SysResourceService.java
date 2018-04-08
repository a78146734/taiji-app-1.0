package com.taiji.user.service;

import java.util.List;
import java.util.Map;

import com.taiji.core.base.service.BaseService;
import com.taiji.core.shiro.ShiroUser;
import com.taiji.core.utils.PageInfo;
import com.taiji.user.model.SysDictionary;
import com.taiji.user.model.SysResource;
import com.taiji.user.model.SysRole;
import com.taiji.user.model.SysUser;

/**
 * 资源 表数据服务层接口
 * 
 * @author guochao
 *
 */
public interface SysResourceService extends BaseService<SysResource, String> {
	/**
	 * 根据用户id 查询菜单 转树形
	 * @param shiroUser
	 * @return
	 * @throws Exception 
	 */
	List<Map<String, Object>> selectTree(ShiroUser shiroUser) throws Exception;

	/**
	 * 查询 所有资源数据 转树形
	 * @return
	 * @throws Exception 
	 */
	List<Map<String, Object>> selectAllToTree() throws Exception;

	/**
	 * 通过资源id查询资源数据 转树形
	 */
	List<Map<String, Object>> getTreeByResourceIds(String resourceIds) throws Exception;
	
	/**
	 * 查询 菜单类型资源 转树形
	 * @return
	 * @throws Exception 
	 */
	List<Map<String, Object>> selectMenuToTree() throws Exception;

	/**
	 * 根据 id IN 查询 资源url 
	 * @param resourceList
	 * @return
	 */
	List<String> selectUrlInId(List<String> resourceList);

	/**
	 * 查询所有数据
	 * @return
	 * @throws Exception 
	 */
	List<SysResource> selectAll() throws Exception;

	/**
	 * 查询所有数据
	 * @return
	 * @throws Exception 
	 */
	List<SysResource> selectUserMenu(ShiroUser shiroUser) throws Exception;
	
	/**
	 * 插入数据
	 * @param resource
	 */
	int insert(SysResource resource) throws Exception;
	
	/**
	 * 插入数据
	 * @param resource
	 */
	void updateRelate(SysResource resource) throws Exception;

	/**
	 * 根据id查询
	 * @param id
	 * @return
	 * @throws Exception 
	 */
	SysResource selectById(String id) throws Exception;

	/**
	 * 根绝id删除
	 * @param id
	 * @throws Exception 
	 */
	int deleteById(String id) throws Exception;
	
	/**
	 * 根据id 递归查询id
	 * @param id
	 * @return
	 * @throws Exception 
	 */
	List<String> selectRecursiveDownIdList(String id) throws Exception;
	
	/**
	 * 查询列表
	 * @param pageInfo
	 * @throws Exception 
	 */
	PageInfo<SysResource> selectByPage(PageInfo<SysResource> pageInfo) throws Exception;
	/**
	 * @author anjl
	 * 2017-6-1
	 * 生成代码时插入权限信息
	 */
	int insertGenPur(String path,String tabName,String author)throws Exception;
	
	/**
	 * 根据 权限id 查询资源id列表
	 * 
	 * @param puriewId
	 * @return
	 */
	List<String> selectResourceIdListByPuriewId(String puriewId) throws Exception;
	
	/**
	 * 选择更新，不更新null字段
	 * 
	 * @param entity
	 * @return 
	 */
	public SysResource updateSelective(SysResource entity) throws Exception;
}
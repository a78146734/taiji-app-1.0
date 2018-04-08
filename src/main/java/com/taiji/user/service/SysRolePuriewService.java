package com.taiji.user.service;

import java.util.List;

import com.taiji.core.base.service.BaseService;
import com.taiji.user.model.SysPuriewResource;
import com.taiji.user.model.SysRolePuriew;

public interface SysRolePuriewService extends BaseService<SysRolePuriew, String>{
	/**
	 * 根据 角色id 更新资源
	 * 
	 * @param resourceIds
	 * @param id
	 * @param staffName
	 */
	void updateByRole(String resourceIds, String id, String purIds, String staffName) throws Exception;
	List<String> selectPuriewIdListByRoleIds(List<String> rolelist) throws Exception;

}

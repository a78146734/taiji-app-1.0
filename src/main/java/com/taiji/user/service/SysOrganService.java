package com.taiji.user.service;

import java.util.List;
import java.util.Map;

import com.taiji.core.base.service.BaseService;
import com.taiji.user.model.SysDictionary;
import com.taiji.user.model.SysOrgan;

public interface SysOrganService extends BaseService<SysOrgan, String> {
	List<String> selectIdList(String organId) throws Exception;
	List<Map<String, Object>> selectTree() throws Exception;
	String selectByCode(String parentId) throws Exception;
	/**
	 * 选择更新，不更新null字段
	 * 
	 * @param entity
	 * @return 
	 */
	public SysOrgan updateSelective(SysOrgan entity) throws Exception;
	
	public int deleteById(String id) throws Exception;
}

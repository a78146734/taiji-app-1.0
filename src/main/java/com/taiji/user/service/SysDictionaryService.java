package com.taiji.user.service;

import java.util.List;

import com.taiji.core.base.service.BaseService;
import com.taiji.user.model.SysDictionary;
import com.taiji.user.model.SysDictionaryData;
import com.taiji.user.model.SysPuriewResource;
import com.taiji.user.model.SysRole;
import com.taiji.user.model.SysUser;

/**
 * 权限-资源 表数据服务层接口
 * 
 * @author guochao
 *
 */
public interface SysDictionaryService extends BaseService<SysDictionary, String>{
	 
	/**
	 * 根据dictionaryId查询 SysDictionary
	 * 
	 * @param nodeId
	 * @return
	 */
	SysDictionary findByDictionaryId(String dictionaryId)  throws Exception;
	/**
	 * 根据SysDictionary nodeId查询 SysDictionaryData
	 * 
	 * @param nodeId
	 * @return
	 */
	List<SysDictionary> findByNodeId(String nodeId)  throws Exception;
	
	/**
	 * 选择更新，不更新null字段
	 * 
	 * @param entity
	 * @return 
	 */
	public SysDictionary updateSelective(SysDictionary entity) throws Exception;
	
	/**
	 * 删除
	 * 
	 * @param dictionaryId
	 */
	void deleteByDictionaryId(String dictionaryId) throws Exception;
}
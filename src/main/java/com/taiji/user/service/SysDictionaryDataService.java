package com.taiji.user.service;

import java.util.List;

import com.taiji.core.base.service.BaseService;
import com.taiji.user.model.SysDictionary;
import com.taiji.user.model.SysDictionaryData;
import com.taiji.user.model.SysPuriewResource;
import com.taiji.user.model.SysRole;

/**
 * 权限-资源 表数据服务层接口
 * 
 * @author guochao
 *
 */
public interface SysDictionaryDataService extends BaseService<SysDictionaryData, String>{
	 
	/**
	 * 根据dictionaryDataId查询 SysDictionaryData
	 * 
	 * @param nodeId
	 * @return
	 */
	SysDictionaryData findByDictionaryDataId(String dictionaryDataId)  throws Exception;
	/**
	 * 根据SysDictionary nodeId查询 SysDictionaryData
	 * 
	 * @param nodeId
	 * @return
	 */
	List<SysDictionaryData> findByNodeId(String nodeId)  throws Exception;
	
	/**
	 * 选择更新，不更新null字段
	 * 
	 * @param entity
	 * @return 
	 */
	public SysDictionaryData updateSelective(SysDictionaryData entity) throws Exception;
	
	/**
	 * 根据dictionaryId删除
	 * 
	 * @param dictionaryId
	 */
	void deleteByDictionaryId(String dictionaryId) throws Exception;
	/**
	 * 根据dictionaryDataId删除
	 * 
	 * @param dictionaryDataId
	 */
	void deleteByDictionaryDataId(String dictionaryDataId) throws Exception;
	
	/**
	 * 通过dictionaryDataId 获得对应param1的值
	 * @return
	 */
	public String findParam1ById(String id);
}
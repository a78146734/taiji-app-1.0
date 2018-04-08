package com.taiji.core.quartz.service;

import java.util.List;

import com.taiji.core.base.service.BaseService;
import com.taiji.core.quartz.entity.ScheduleJob;
import com.taiji.core.utils.BeanUtils;
import com.taiji.user.model.SysDictionary;
/** 
	 * 模块名称：taiji 功能名称：quartz
	 * @author anjl
	 * 创建时间：2017-07-11 10:51:15
	 */
/** 
	 * 模块名称：taiji 功能名称：quartz
	 * @author anjl
	 * 创建时间：2017-07-11 10:51:15
	 */
public interface SysJobService extends BaseService<ScheduleJob, String>{

	
	
	/**
	 * 获取所有job任务
	 * @return
	 * @throws Exception 
	 */
	public List<ScheduleJob> listAll() throws Exception;
	
	/***
	 * 删除所有旧数据
	 * 
	 */
	public int deleteOldQuartz() throws Exception;
	
	/**
	 * 选择更新，不更新null字段
	 * 
	 * @param entity
	 * @return 
	 */
	public ScheduleJob updateSelective(ScheduleJob entity) throws Exception;
	
	/**
	 * 删除
	 * 
	 * @param jobId
	 */
	void deleteByjobId(String jobId) throws Exception;
	
}

package com.taiji.core.quartz.service;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import com.taiji.core.base.service.BaseServiceImpl;
import com.taiji.core.quartz.entity.ScheduleJob;
import com.taiji.core.quartz.repository.SysJobRepository;
import com.taiji.core.utils.BeanUtils;
	/** 
	 * 模块名称：taiji 功能名称：quartz
	 * @author anjl
	 * @version 1.0
	 * @date 2017-07-11 10:51:15
	 */
@Service
public class SysJobServiceImpl extends BaseServiceImpl<ScheduleJob, String> implements SysJobService {
	@Autowired
	private SysJobRepository sysJobRepository;
	@Autowired
	private JdbcTemplate jdbcTemplate;
	/**
	 * 获取所有job任务
	 * @author anjl
	 * @version
	 * @see
	 * @param 
	 * @return  
	 * @exception
	 * @date
	 * 
	 */
	public List<ScheduleJob> listAll() throws Exception{
		return sysJobRepository.findAll();
	}

	public int deleteOldQuartz() throws Exception {
		int[] i = jdbcTemplate.batchUpdate("delete  from qrtz_simprop_triggers",
										   "delete  from qrtz_simple_triggers",
										   "delete  from qrtz_scheduler_state",
										   "delete  from qrtz_paused_trigger_grps",
										   "delete  from qrtz_locks",
										   "delete  from qrtz_fired_triggers",
										   "delete  from qrtz_calendars",
										   "delete  from qrtz_blob_triggers",
										   "delete  from qrtz_cron_triggers",
										   "delete from qrtz_triggers",
										   "delete  from qrtz_job_details"
										   );
		return i[0];
	}
	
	public ScheduleJob updateSelective(ScheduleJob entity) throws Exception{
		ScheduleJob scheduleJob = null;
		if(entity.getJobId() != null){
			scheduleJob = sysJobRepository.findOne(entity.getJobId());
			BeanUtils.copyPropertiesIgnoreNull(entity,scheduleJob);
			return super.update(scheduleJob);
		}
		return scheduleJob;
	}

	@Override
	public void deleteByjobId(String jobId) throws Exception {
		sysJobRepository.deleteByJobId(jobId);
	}
	
}

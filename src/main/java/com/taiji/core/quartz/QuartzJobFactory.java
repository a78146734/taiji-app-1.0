package com.taiji.core.quartz;

import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import com.taiji.core.quartz.entity.ScheduleJob;

/** 
 *  
 * @Description: 计划任务执行处 无状态 
 * @author snailxr 
 * @date 2014年4月24日 下午5:05:47 
 */  
public class QuartzJobFactory implements Job {  
  
    public void execute(JobExecutionContext context) throws JobExecutionException {  
    	ScheduleJob scheduleJob = (ScheduleJob) context.getMergedJobDataMap().get("scheduleJob");  
        TaskUtils.invokMethod(scheduleJob);  
    }  
}  
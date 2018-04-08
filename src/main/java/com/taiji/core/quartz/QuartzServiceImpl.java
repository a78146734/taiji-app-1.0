package com.taiji.core.quartz;


import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.quartz.CronScheduleBuilder;
import org.quartz.CronTrigger;
import org.quartz.JobBuilder;
import org.quartz.JobDetail;
import org.quartz.JobExecutionContext;
import org.quartz.JobKey;
import org.quartz.Scheduler;
import org.quartz.SchedulerException;
import org.quartz.Trigger;
import org.quartz.TriggerBuilder;
import org.quartz.TriggerKey;
import org.quartz.impl.matchers.GroupMatcher;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.quartz.SchedulerFactoryBean;
import org.springframework.stereotype.Service;

import com.taiji.core.quartz.controller.SysJobController;
import com.taiji.core.quartz.entity.ScheduleJob;
import com.taiji.core.quartz.service.SysJobService;
 

/**
 * quartz示例定时器类
 * 
 * @author Administrator
 * 
 */
@Service
public class QuartzServiceImpl implements QuartzService{
	
	private static final Logger LOGGER = LogManager.getLogger(SysJobController.class);
	
	
	@Autowired
	private SchedulerFactoryBean schedulerFactoryBean;
	
	@Autowired
	private SysJobService sysJobService;
	
	
	public void init() throws Exception {  
		//删除所有旧数据
		sysJobService.deleteOldQuartz();  
        // 这里从数据库中获取任务信息数据  
        List<ScheduleJob> jobList = sysJobService.listAll();  
        
        //如果job状态为启动，则添加启动
        for (ScheduleJob job : jobList) {  
        	if(job.getJobStatus().equals(ScheduleJob.STATUS_RUNNING)){
        		addAndStartJob(job);  
        	}else{
        		addAndStartJob(job);
        		//由于刚刚添加，所将启动的任务为不启动
    		    pauseJob(job);
        	}
        }  
    }  
	
	/** 
     * 添加任务 
     *  
     * @param scheduleJob 
     * @throws SchedulerException 
     */  
    public void addJob(ScheduleJob job) throws SchedulerException {  
    	 if (job == null) {  
             throw new NullPointerException("任务对象为空");  
         }  
  
        Scheduler scheduler = schedulerFactoryBean.getScheduler();  
        System.out.println(scheduler + ".......................................................................................add");  
        TriggerKey triggerKey = TriggerKey.triggerKey(job.getJobId(), job.getJobGroup());  
  
        CronTrigger trigger = (CronTrigger) scheduler.getTrigger(triggerKey);  
  
        // 不存在，创建一个  
        if (null == trigger) {  
            Class clazz = ScheduleJob.CONCURRENT_IS.equals(job.getIsconcurrent()) ? QuartzJobFactory.class : QuartzJobFactoryDisallowConcurrentExecution.class;  
  
            JobDetail jobDetail = JobBuilder.newJob(clazz).withIdentity(job.getJobId(), job.getJobGroup()).build();  
  
            jobDetail.getJobDataMap().put("scheduleJob", job);  
  
            CronScheduleBuilder scheduleBuilder = CronScheduleBuilder.cronSchedule(job.getCronExpression());  
  
            trigger = TriggerBuilder.newTrigger().withIdentity(job.getJobId(), job.getJobGroup()).withSchedule(scheduleBuilder).build();  
  
            //scheduler.scheduleJob(jobDetail, trigger);  
        } else {  
            // Trigger已存在，那么更新相应的定时设置  
            CronScheduleBuilder scheduleBuilder = CronScheduleBuilder.cronSchedule(job.getCronExpression());  
  
            // 按新的cronExpression表达式重新构建trigger  
            trigger = trigger.getTriggerBuilder().withIdentity(triggerKey).withSchedule(scheduleBuilder).build();  
  
            // 按新的trigger重新设置job执行  
            //scheduler.rescheduleJob(triggerKey, trigger);  
        }  
    }  
	
    
    /** 
     * 添加任务 然后启动
     *  
     * @param scheduleJob 
     * @throws SchedulerException 
     */  
    public void addAndStartJob(ScheduleJob job) throws SchedulerException {  
        if (job == null) {  
            throw new NullPointerException("任务对象为空");  
        }  
  
        Scheduler scheduler = schedulerFactoryBean.getScheduler();  
        System.out.println(scheduler + ".......................................................................................add");  
        TriggerKey triggerKey = TriggerKey.triggerKey(job.getJobId(), job.getJobGroup());  
  
        CronTrigger trigger = (CronTrigger) scheduler.getTrigger(triggerKey);  
  
        // 不存在，创建一个  
        if (null == trigger) {  
            Class clazz = ScheduleJob.CONCURRENT_IS.equals(job.getIsconcurrent()) ? QuartzJobFactory.class : QuartzJobFactoryDisallowConcurrentExecution.class;  
  
            JobDetail jobDetail = JobBuilder.newJob(clazz).withIdentity(job.getJobId(), job.getJobGroup()).build();  
  
            jobDetail.getJobDataMap().put("scheduleJob", job);  
  
            CronScheduleBuilder scheduleBuilder = CronScheduleBuilder.cronSchedule(job.getCronExpression());  
  
            trigger = TriggerBuilder.newTrigger().withIdentity(job.getJobId(), job.getJobGroup()).withSchedule(scheduleBuilder).build();  
  
            scheduler.scheduleJob(jobDetail, trigger);  
            
            scheduler.start();
        } else {  
            // Trigger已存在，那么更新相应的定时设置  
            CronScheduleBuilder scheduleBuilder = CronScheduleBuilder.cronSchedule(job.getCronExpression());  
  
            // 按新的cronExpression表达式重新构建trigger  
            trigger = trigger.getTriggerBuilder().withIdentity(triggerKey).withSchedule(scheduleBuilder).build();  
  
            // 按新的trigger重新设置job执行  
            scheduler.rescheduleJob(triggerKey, trigger);  
        }  
    }  
	
    /**  
    * 获取所有计划中的任务列表  
    *   
    * @return  
    * @throws SchedulerException  
    */  
   public List<ScheduleJob> getAllJob() throws SchedulerException {  
       Scheduler scheduler = schedulerFactoryBean.getScheduler();  
       GroupMatcher<JobKey> matcher = GroupMatcher.anyJobGroup();  
       Set<JobKey> jobKeys = scheduler.getJobKeys(matcher);  
       List<ScheduleJob> jobList = new ArrayList<ScheduleJob>();  
       for (JobKey jobKey : jobKeys) {  
           List<? extends Trigger> triggers = scheduler.getTriggersOfJob(jobKey);  
           for (Trigger trigger : triggers) {  
               ScheduleJob job = new ScheduleJob();  
               job.setJobName(jobKey.getName());  
               job.setJobGroup(jobKey.getGroup());  
               job.setDescription("触发器:" + trigger.getKey());  
               Trigger.TriggerState triggerState = scheduler.getTriggerState(trigger.getKey());  
               job.setJobStatus(triggerState.name());  
               if (trigger instanceof CronTrigger) {  
                   CronTrigger cronTrigger = (CronTrigger) trigger;  
                   String cronExpression = cronTrigger.getCronExpression();  
                   job.setCronExpression(cronExpression);  
               }  
               jobList.add(job);  
           }  
       }  
       return jobList;  
   }  
 
   /** 
    * 所有正在运行的job 
    *  
    * @return 
    * @throws SchedulerException 
    */  
   public List<ScheduleJob> getRunningJob() throws SchedulerException {  
       Scheduler scheduler = schedulerFactoryBean.getScheduler();  
       List<JobExecutionContext> executingJobs = scheduler.getCurrentlyExecutingJobs();  
       List<ScheduleJob> jobList = new ArrayList<ScheduleJob>(executingJobs.size());  
       for (JobExecutionContext executingJob : executingJobs) {  
           ScheduleJob job = new ScheduleJob();  
           JobDetail jobDetail = executingJob.getJobDetail();  
           JobKey jobKey = jobDetail.getKey();  
           Trigger trigger = executingJob.getTrigger();  
           job.setJobName(jobKey.getName());  
           job.setJobGroup(jobKey.getGroup());  
           job.setDescription("触发器:" + trigger.getKey());  
           Trigger.TriggerState triggerState = scheduler.getTriggerState(trigger.getKey());  
           job.setJobStatus(triggerState.name());  
           if (trigger instanceof CronTrigger) {  
               CronTrigger cronTrigger = (CronTrigger) trigger;  
               String cronExpression = cronTrigger.getCronExpression();  
               job.setCronExpression(cronExpression);  
           }  
           jobList.add(job);  
       }  
       return jobList;  
   }  
 
   /** 
    * 暂停一个job 
    *  
    * @param scheduleJob 
    * @throws SchedulerException 
    */  
   public void pauseJob(ScheduleJob scheduleJob) throws SchedulerException {  
       Scheduler scheduler = schedulerFactoryBean.getScheduler();  
       JobKey jobKey = JobKey.jobKey(scheduleJob.getJobId(), scheduleJob.getJobGroup());  
       scheduler.pauseJob(jobKey);  
   }  
 
   /** 
    * 恢复一个job 
    *  
    * @param scheduleJob 
    * @throws SchedulerException 
    */  
   public void resumeJob(ScheduleJob scheduleJob) throws SchedulerException {  
       Scheduler scheduler = schedulerFactoryBean.getScheduler();  
       JobKey jobKey = JobKey.jobKey(scheduleJob.getJobId(), scheduleJob.getJobGroup());  
       scheduler.resumeJob(jobKey); 
       scheduler.start();
   }  
 
   /** 
    * 删除一个job 
    *  
    * @param scheduleJob 
    * @throws SchedulerException 
    */  
   public void deleteJob(ScheduleJob scheduleJob) throws SchedulerException {  
       Scheduler scheduler = schedulerFactoryBean.getScheduler();  
       JobKey jobKey = JobKey.jobKey(scheduleJob.getJobId(), scheduleJob.getJobGroup());  
       scheduler.deleteJob(jobKey);  
 
   }  
 
   /** 
    * 立即执行job 
    *  
    * @param scheduleJob 
    * @throws SchedulerException 
    */  
   public void runAJobNow(ScheduleJob scheduleJob) throws SchedulerException {  
       Scheduler scheduler = schedulerFactoryBean.getScheduler();  
       JobKey jobKey = JobKey.jobKey(scheduleJob.getJobId(), scheduleJob.getJobGroup());  
       scheduler.triggerJob(jobKey);  
   }  
 
   /** 
    * 更新job时间表达式 
    * @param scheduleJob 
    * @throws SchedulerException 
    */  
   public void updateJobCron(ScheduleJob scheduleJob) throws SchedulerException {  
       Scheduler scheduler = schedulerFactoryBean.getScheduler();  
 
       TriggerKey triggerKey = TriggerKey.triggerKey(scheduleJob.getJobId(), scheduleJob.getJobGroup());  
 
       CronTrigger trigger = (CronTrigger) scheduler.getTrigger(triggerKey);  
 
       CronScheduleBuilder scheduleBuilder = CronScheduleBuilder.cronSchedule(scheduleJob.getCronExpression());  
 
       trigger = trigger.getTriggerBuilder().withIdentity(triggerKey).withSchedule(scheduleBuilder).build();  
 
       scheduler.rescheduleJob(triggerKey, trigger);  
   }  
	
}
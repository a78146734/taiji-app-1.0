package com.taiji.core.quartz.controller;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.quartz.CronExpression;
import org.quartz.CronScheduleBuilder;
import org.quartz.CronTrigger;
import org.quartz.TriggerBuilder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.taiji.core.base.controller.BaseController;
import com.taiji.core.base.result.Result;
import com.taiji.core.utils.PageInfo;
import com.taiji.core.utils.StringUtils;
import com.taiji.user.model.SysDictionary;
import com.taiji.core.quartz.QuartzService;
import com.taiji.core.quartz.entity.ScheduleJob;
import com.taiji.core.quartz.service.SysJobService;
/** 
 * 模块名称：taiji 功能名称：quartz
 * @author anjl
 * 创建时间：2017-07-11 10:51:15
 */
@RequestMapping("/sysJob")
@Controller
public class SysJobController extends BaseController {

	private static final Logger LOGGER = LogManager.getLogger(SysJobController.class);
	
	
	//自己定义定时任务记录表
	@Autowired
	private SysJobService sysJobService;
	
	//定时任务管理器对象
	@Autowired
	private QuartzService quartzService;

	/**
	 * 保存
	 * @author anjl
	 * @version 1.0
	 * @date 2017-07-11 10:51:15
	 *
	 */
	@RequiresPermissions(value = { "sysJob/save" })
	@PostMapping("/save")
	@ResponseBody
	public Object save(ScheduleJob sysJob,HttpServletRequest request) {
		int i = 1;
		try {
			String method = sysJob.getMethodName();
			//防止方法填写"()"
			if(method.endsWith("()")){
				sysJob.setMethodName(method.substring(0, (method.length()-2)));
			}
			//设置创建和更新时间
			sysJob.setCreateTime(new Date());
			sysJob.setUpdatetime(new Date());
			
			//设置默认分组
			sysJob.setJobGroup(ScheduleJob.DEFAULT);
			
			//设置任务状态默认为不启动
			sysJob.setJobStatus(ScheduleJob.STATUS_NOT_RUNNING);
		    sysJobService.save(sysJob);
//		    i = sysJobService.insert(sysJob);
			
			//添加任务并启动
		    quartzService.addAndStartJob(sysJob);
		    
		    //由于刚刚添加，所将启动的任务为不启动（有些多此一举，弯路实现）
		    quartzService.pauseJob(sysJob);
		    
		    LOGGER.info("[添加任务成功]"+sysJob.toString());
		} catch (Exception e) {
			LOGGER.info("[添加任务失败]"+sysJob.toString());
			e.printStackTrace();
			return renderError("保存失败！");
		}
		return i>0?renderSuccess():renderError("保存失败！");
	}
	





	/**
	 * 查询全部
	 * @author anjl
	 * @version 1.0
	 * @date 2017-07-11 10:51:15
	 */
//	@RequiresPermissions(value = {"/jsp/quartz/sysJobList.jsp","sysJob/list" },logical = Logical.OR)
//	@PostMapping("/list")
//	@ResponseBody
//	public Object list(ScheduleJob sysJob,Integer nowpage,Integer pagesize,HttpServletRequest request){
//		PageInfo<?> pageInfo = new PageInfo<ScheduleJob>(nowpage, pagesize);
//		//查询出list结果
//		try {
//			pageInfo = sysJobService.findPage(pageInfo);
//		} catch (Exception e) {
//			LOGGER.error("[操作失败！：定时任务-列表分页查询，第"+nowpage+"页]");
//			e.printStackTrace();
//		}
//		return renderSuccess(pageInfo);
//	}
	/**
	 * 查询全部
	 * @author anjl
	 * @version 1.0
	 * @date 2017-07-11 10:51:15
	 */
//	@RequiresPermissions(value = {"/jsp/quartz/sysJobList.jsp","sysJob/list" },logical = Logical.OR)
	@PostMapping("/list")
	public @ResponseBody Result dataGrid(@RequestBody PageInfo<ScheduleJob> pageInfo) {
		pageInfo = sysJobService.findPage(pageInfo);
		return renderSuccess(pageInfo);
	}



	/**
	 * 按主键查询
	 * @author anjl
	 * @version 1.0
	 * @date 2017-07-11 10:51:15
	 */
	@RequiresPermissions(value = { "sysJob/selectByPrimaryKey" })
	@GetMapping("/selectByPrimaryKey")
	@ResponseBody
	public Object selectByPrimaryKey(String id,HttpServletRequest request){
		LOGGER.info("[定时任务-详细信息查询]："+id);
		ScheduleJob sysJob = null;
		try {
			if(StringUtils.isNotBlank(id)){
				sysJob = sysJobService.find(id);
			}
		} catch (Exception e) {
			LOGGER.info("[操作失败！：定时任务-详细信息查询]："+id);
			e.printStackTrace();
		}
		return renderSuccess(sysJob);
	}
	
	/**
	 * 按主键更新,只更新对象中不为空的字段
	 * @author anjl
	 * @version 1.0
	 * @date 2017-07-11 10:51:15
	 */
	@RequiresPermissions(value = { "sysJob/update" })
	@PostMapping("/update")
	@ResponseBody
	public Object update(ScheduleJob sysJob,HttpServletRequest request){
		int i = 1;
			try {
				//设置更新时间
				sysJob.setUpdatetime(new Date());
				
				//更新任务管理器
				quartzService.updateJobCron(sysJob);
				
				//更新数据
				sysJobService.updateSelective(sysJob);
				
				//上传信息中不存在任务的启动和关闭状态，故再次查询数据库
				ScheduleJob sysJobFlag = sysJobService.find(sysJob.getJobId());
				
				//由于更新后，会默认启动任务，所以判断任务是否为不启动状态，如果不启用，则关闭任务
				//如果为启用，则不进行处理
				if(sysJobFlag.getJobStatus().equals(ScheduleJob.STATUS_NOT_RUNNING)){
					quartzService.pauseJob(sysJob);
				}
				LOGGER.info("[定时任务更新成功]"+sysJob.toString());
			} catch (Exception e) {
				LOGGER.info("[定时任务更新失败]"+sysJob.toString());
				e.printStackTrace();
				return renderError();
			}
		return i>0?renderSuccess():renderError();
	}


	/**
	 * 按主键删除
	 * @author anjl
	 * @version 1.0
	 * @date 2017-07-11 10:51:15
	 */
	@RequiresPermissions(value = { "sysJob/delete" })
	@GetMapping("/delete")
	@ResponseBody
	public Object delete(String id,HttpServletRequest request){
		ScheduleJob sysJob = null;
		int i = 1;
		try {
			if(StringUtils.isNotBlank(id)){
				
				//获取定时任务对象信息
				sysJob = sysJobService.find(id);
				
				//从任务管理器中删除
				quartzService.deleteJob(sysJob);
				
				//从任务表中删除
				sysJobService.deleteByjobId(id);
				LOGGER.info("[定时任务删除成功]"+sysJob.toString());
			}
		} catch (Exception e) {
			LOGGER.info("[定时任务删除失败]"+sysJob.toString());
			e.printStackTrace();
			return renderError("[定时任务删除失败]");
		}
		return i>0?renderSuccess():renderError("[定时任务删除失败]");
	}
	/**
	 * 运行任务一次（无论任务是否启动）
	 * @author anjl
	 * @version 1.0
	 * @date 2017-07-11 10:51:15
	 */
	@RequiresPermissions(value = { "sysJob/runAJobNow" })
	@GetMapping("/runAJobNow")
	@ResponseBody
	public Object runAJobNow(String id,HttpServletRequest request){
		ScheduleJob sysJob = null;
		int i = 0;
		try {
			if(StringUtils.isNotBlank(id)){
				//获取定时任务信息
				sysJob = sysJobService.find(id);
				
				//执行一次
				quartzService.runAJobNow(sysJob);
				LOGGER.info("[运行任务一次成功]"+sysJob.toString());
			}
		} catch (Exception e) {
			LOGGER.info("[运行任务失败]"+sysJob.toString());
			e.printStackTrace();
			return renderError("[运行任务失败]");
		}
		return renderSuccess();
	}
	/**
	 * 按主键删除
	 * @author anjl
	 * @version 1.0
	 * @date 2017-07-11 10:51:15
	 */
	@RequiresPermissions(value = { "sysJob/startJob" })
	@GetMapping("/startJob")
	@ResponseBody
	public Object startJob(String id,HttpServletRequest request){
		int i = 1;
		ScheduleJob sysJob = null;
		try {
			if(StringUtils.isNotBlank(id)){
				sysJob = sysJobService.find(id);
				
				//启动或停止JOB
				if(sysJob.getJobStatus().equals(ScheduleJob.STATUS_RUNNING)){
					sysJob.setJobStatus(ScheduleJob.STATUS_NOT_RUNNING);
					quartzService.pauseJob(sysJob);
					//更新任务状态
				}else{
					sysJob.setJobStatus(ScheduleJob.STATUS_RUNNING);
					quartzService.resumeJob(sysJob);
					//更新任务状态
				}
				sysJobService.updateSelective(sysJob);
				
			}
		} catch (Exception e) {
			if(sysJob.getJobStatus().equals(ScheduleJob.STATUS_RUNNING)){
				LOGGER.info("[停止任务失败]"+sysJob.toString());
			}else{
				LOGGER.info("[启动任务失败]"+sysJob.toString());
			}
			e.printStackTrace();
			return renderError("操作失败！");
		}
		return i>0?renderSuccess("启动成功！"):renderError("启动失败！");
	}
	
	@GetMapping("/caclulateDate")
	@ResponseBody
	public Object caclulateDate(String cron){
		String timeSchdule="";
		System.out.println("cron: "+cron);
		if(!CronExpression.isValidExpression(cron)){
			return renderError("Cron 格式不合法!");
		}
		try {
			
			CronScheduleBuilder scheduleBuilder = CronScheduleBuilder.cronSchedule(cron);  
		CronTrigger trigger = TriggerBuilder.newTrigger().withIdentity("Caclulate Date").withSchedule(scheduleBuilder).build(); 
		Date time0 = trigger.getStartTime();
		Date time1 = trigger.getFireTimeAfter(time0);
		Date time2 = trigger.getFireTimeAfter(time1);
		Date time3 = trigger.getFireTimeAfter(time2);
		Date time4 = trigger.getFireTimeAfter(time3);
		Date time5 = trigger.getFireTimeAfter(time4);
		SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		StringBuilder timeBuilder=new StringBuilder();
		timeBuilder
		.append(format.format(time1))
		.append(",")
		.append(format.format(time2))
		.append(",")
		.append(format.format(time3))
		.append(",")
		.append(format.format(time4))
		.append(",")
		.append(format.format(time5));
		timeSchdule=timeBuilder.toString();
		} catch (Exception e) {
		timeSchdule="unKnow Time!";
		}
		System.out.println("timeSchdule: "+timeSchdule);
		return renderSuccess(timeSchdule);
//		return timeSchdule;
		}
}

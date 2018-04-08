package com.taiji.core.quartz;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextRefreshedEvent;

public class InstantiationTracingBeanPostProcessor implements ApplicationListener<ContextRefreshedEvent> {
	
	private static final Logger LOGGER = LogManager.getLogger(InstantiationTracingBeanPostProcessor.class);
	
	@Autowired
	private QuartzService quartzService;
	
	@Override
	public void onApplicationEvent(ContextRefreshedEvent event) {
		if(event.getApplicationContext().getParent() == null){//root application context 没有parent，他就是老大.
			try {
				LOGGER.info("[信息]项目启动，初始化定时任务管理器...");
				
				quartzService.init();

			} catch (Exception e) {
				LOGGER.info("[错误]项目启动，初始化定时任务管理器失败...");
				e.printStackTrace();
			}
		}
	}
}
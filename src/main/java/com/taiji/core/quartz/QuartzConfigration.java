package com.taiji.core.quartz;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.quartz.SchedulerFactoryBean;

@Configuration
public class QuartzConfigration {

	/** 
     * attention: 
     * Details：定义quartz调度工厂 
     */  
    @Bean(name = "schedulerFactoryBean")  
    public SchedulerFactoryBean schedulerFactory() {  
        SchedulerFactoryBean schedulerFactoryBean = new SchedulerFactoryBean();  
        return schedulerFactoryBean;  
    }  
}

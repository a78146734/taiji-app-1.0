package com.taiji.core.quartz;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.taiji.core.spring.SpringContextHolder;
import com.taiji.core.utils.StringUtils;
import com.taiji.core.quartz.entity.ScheduleJob;

public class TaskUtils {  
	
	private static final Logger LOGGER = LogManager.getLogger(TaskUtils.class);
  
    /** 
     * 通过反射调用scheduleJob中定义的方法 
     *  
     * @param scheduleJob 
     */  
    public static void invokMethod(ScheduleJob scheduleJob) {  
        Object object = null;  
        Class clazz = null;  
                //springId不为空先按springId查找bean  
        
        
        if (StringUtils.isNotBlank(scheduleJob.getSpringId())) {  
            object = SpringContextHolder.getBean(scheduleJob.getSpringId());  
        } else if (StringUtils.isNotBlank(scheduleJob.getBeanClass())) {  
            try {  
                clazz = Class.forName(scheduleJob.getBeanClass());  
                object = clazz.newInstance();  
            } catch (Exception e) {  
                // TODO Auto-generated catch block  
                e.printStackTrace();  
            }  
  
        }  
        if (object == null) {  
        	LOGGER.info("任务名称 = [" + scheduleJob.getJobName() + "]---------------未启动成功，请检查是否配置正确！！！"); 
            return;  
        }  
        clazz = object.getClass();  
        Method method = null;  
        try {  
            method = clazz.getDeclaredMethod(scheduleJob.getMethodName());  
        } catch (NoSuchMethodException e) {  
        	LOGGER.info("任务名称 = [" + scheduleJob.getJobName() + "]---------------未启动成功，方法名设置错误！！！");  
        } catch (SecurityException e) {  
            // TODO Auto-generated catch block  
            e.printStackTrace();  
        }  
        if (method != null) {  
            try {  
                method.invoke(object);  
            } catch (IllegalAccessException e) {  
                // TODO Auto-generated catch block  
                e.printStackTrace();  
            } catch (IllegalArgumentException e) {  
                // TODO Auto-generated catch block  
                e.printStackTrace();  
            } catch (InvocationTargetException e) {  
                // TODO Auto-generated catch block  
                e.printStackTrace();  
            }  
        }  
          
    }  
}  
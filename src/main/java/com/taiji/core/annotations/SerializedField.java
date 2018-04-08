package com.taiji.core.annotations;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * 
 * @author: 赵国超
 * @date: 2016年7月14日 下午3:32:00
 * 
 * @Desc: 异步接口返回字段控制
 *
 */
@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
public @interface SerializedField {
	String explain() default "";
	int sort() default Integer.MAX_VALUE;
	Class<?> resultClass() default SerializedField.class;
    String[] includes() default {};
    String[] excludes() default {};
}

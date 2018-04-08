package com.taiji.core.utils;
import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
public class ReflectionUtil {
	public static final Integer ARRAY_FRIST_INDEX = 0;  
	  
	public static final String PATTERN_MAPPER = "";  
	  
	public static Class<?> getArgumentType(Class<?> cls) {  
	    Type[] types = ((ParameterizedType) cls.getGenericSuperclass()).getActualTypeArguments();  
	    return (Class<?>) types[ARRAY_FRIST_INDEX];  
	}  
	  
	public static Class<?> getMatcherMapper(Class<?> cls) {  
	    return getArgumentType(cls);
	}  
}

package com.taiji.core.utils;


import org.springframework.beans.BeanWrapper;
import org.springframework.beans.BeanWrapperImpl;
import org.springframework.cglib.beans.BeanCopier;
import org.springframework.cglib.beans.BeanMap;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * 基于CGlib
 * 实体工具类，目前copy不支持map、list
 * @author L.cm
 * email: 596392912@qq.com
 * site:http://www.dreamlu.net
 * @date 2015年4月26日下午5:10:42
 */
public final class BeanUtils extends org.springframework.beans.BeanUtils {
	private BeanUtils(){}

	/**
	 * 实例化对象
	 * @param clazz 类
	 * @return 对象
	 */
	@SuppressWarnings("unchecked")
	public static <T> T newInstance(Class<?> clazz) {
		try {
			return (T) clazz.newInstance();
		} catch (InstantiationException e) {
			throw new RuntimeException(e);
		} catch (IllegalAccessException e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * 实例化对象
	 * @param clazzStr 类名
	 * @return 对象
	 */
	public static <T> T newInstance(String clazzStr) {
		try {
			Class<?> clazz = Class.forName(clazzStr);
			return newInstance(clazz);
		} catch (ClassNotFoundException e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * copy 对象属性到另一个对象，默认不使用Convert
	 * @param src
	 * @param clazz 类名
	 * @return T
	 */
	public static <T> T copy(Object src, Class<T> clazz) {
		BeanCopier copier = BeanCopier.create(src.getClass(), clazz, false);

		T to = newInstance(clazz);
		copier.copy(src, to, null);
		return to;
	}

	/**
	 * 拷贝对象
	 * @param src 源对象
	 * @param dist 需要赋值的对象
	 */
	public static void copy(Object src, Object dist) {
		BeanCopier copier = BeanCopier
				.create(src.getClass(), dist.getClass(), false);

		copier.copy(src, dist, null);
	}

	/**
	 * 拷贝对象，如果src属性为null则跳过
	 * @param src 源对象
	 * @param dist 需要赋值的对象
	 */
    public static void copyPropertiesIgnoreNull(Object src, Object target){
        BeanUtils.copyProperties(src, target, getNullPropertyNames(src));
    }

	/**
	 * 获取属性为null的 属性名称
	 * @param source 源对象
	 * @return String[] 属性为null的属性名称
	 */
    public static String[] getNullPropertyNames (Object source) {
        final BeanWrapper src = new BeanWrapperImpl(source);
        java.beans.PropertyDescriptor[] pds = src.getPropertyDescriptors();

        Set<String> emptyNames = new HashSet<String>();
        for(java.beans.PropertyDescriptor pd : pds) {
            Object srcValue = src.getPropertyValue(pd.getName());
            if (srcValue == null) emptyNames.add(pd.getName());
        }
        String[] result = new String[emptyNames.size()];
        return emptyNames.toArray(result);
    }
    
	/**
	 * 将对象装成map形式
	 * @param src
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public static Map toMap(Object src) {
		return BeanMap.create(src);
	}
	
	/**
	 * 将 List<Object> 转为 List<Long>
	 * @param objList
	 * @return
	 */
	public static List<Long> objectToLong(List<Object> objList){
		List<Long> resultList = new ArrayList<Long>();
		for(Object result : objList){
			resultList.add(  ((Number) result).longValue());
		}
		return resultList;
	}
}

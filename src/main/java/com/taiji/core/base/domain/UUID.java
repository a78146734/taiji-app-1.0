package com.taiji.core.base.domain;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.MappedSuperclass;

import org.hibernate.annotations.GenericGenerator;

import com.taiji.core.annotations.ModelComment;

/**
 * Mysql数据库的主键生成定义:系统自动生成32位不同的字符序列
 * 需要其他数据库其他类型主键，请自定义类，修改BaseDomain继承类
 * 
 * @author 赵国超
 * @since 2015-12-09
 */
@MappedSuperclass
public class UUID {

	@Id
	@GeneratedValue(generator = "uuid")
	@GenericGenerator(name = "uuid", strategy = "uuid")
	@ModelComment("主键")
	@Column(length = 32, nullable = true)
	protected String id;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
	
	


}

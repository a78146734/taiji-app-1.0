package com.stu.info.entity;

import javax.persistence.Entity;
import javax.persistence.Table;

import com.taiji.core.base.domain.BaseDomain;
@Entity
@Table
public class Student extends BaseDomain{
	/**
	 * 示例
	 */
	private static final long serialVersionUID = 1L;
	private String name;
	private String sex;
	private String year;
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	
}

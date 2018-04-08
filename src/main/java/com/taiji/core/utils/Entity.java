package com.taiji.core.utils;

import java.io.Serializable;

public class Entity implements Serializable{
	/**
	 * 容器类基类
	 */
	private static final long serialVersionUID = 1L;
	private String sortType;//排序 升序or降序
	private String sortColumn;//排序字段
	
	public String getSortType() {
		return sortType;
	}
	public void setSortType(String sortType) {
		this.sortType = sortType;
	}
	public String getSortColumn() {
		return sortColumn;
	}
	public void setSortColumn(String sortColumn) {
		this.sortColumn = sortColumn;
	}
	

}

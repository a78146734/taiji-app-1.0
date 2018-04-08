package com.taiji.core.utils;

import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * @description：分页实体类 (结合jquery )
 * @author：anjl
 * @date：2015年4月23日 上午1:41:46
 */
public class PageInfo<T> {

	private final static Integer PAGESIZE = 10;

	private Integer total; // 总记录数
	private List<?> rows; // 显示的记录

	private Integer totalpage;// 总页数

	private Integer nowpage; // 当前页

	private Integer pagesize=PAGESIZE;

	private LinkedList<String> desc;
	private LinkedList<String> asc;
	private List<Retrieval> retrievals;
	 @JsonIgnore
	private Map<String, Object> condition; //查询条件
	public PageInfo(){
		
	}
	public PageInfo(Integer nowpage, Integer pagesize) {
		  //计算当前页  
        if (nowpage <= 0) {
            this.nowpage = 1;
        } else {
            //当前页
            this.nowpage = nowpage;
        }
        //记录每页显示的记录数  
        if (pagesize < 0) {
            this.pagesize = PAGESIZE;
        } else if(pagesize>10000){
        	pagesize = 10000;
        } else {
            this.pagesize = pagesize;
        }
	}
	public void addDesc(String desc) {
		if (this.desc == null) {
			this.desc = new LinkedList<String>();
		}
		this.desc.add(desc);
	}
	public void addAsc(String asc) {
		if (this.asc == null) {
			this.asc = new LinkedList<String>();
		}
		this.asc.add(asc);
	}
	
	/**  
	 * 获取desc  
	 * @return desc desc  
	 */
	public LinkedList<String> getDesc() {
		return desc;
	}
	

	/**  
	 * 设置desc  
	 * @param desc desc  
	 */
	public void setDesc(LinkedList<String> desc) {
		this.desc = desc;
	}
	

	/**  
	 * 获取asc  
	 * @return asc asc  
	 */
	public LinkedList<String> getAsc() {
		return asc;
	}
	

	/**  
	 * 设置asc  
	 * @param asc asc  
	 */
	public void setAsc(LinkedList<String> asc) {
		this.asc = asc;
	}
	

	/**  
	 * 获取retrievals  
	 * @return retrievals retrievals  
	 */
	public List<Retrieval> getRetrievals() {
		return retrievals;
	}
	

	/**  
	 * 设置retrievals  
	 * @param retrievals retrievals  
	 */
	public void setRetrievals(List<Retrieval> retrievals) {
		this.retrievals = retrievals;
	}
	

	public Integer getTotal() {
		return total;
	}

	public void setTotal(Integer total) {
		this.total = total;
	}

	public List<?> getRows() {
		return rows;
	}

	public void setRows(List<?> rows) {
		this.rows = rows;
	}

	public Integer getTotalpage() {
		return totalpage;
	}

	public void setTotalpage(Integer totalpage) {
		this.totalpage = totalpage;
	}

	public Integer getNowpage() {
		return nowpage;
	}

	public void setNowpage(Integer nowpage) {
		this.nowpage = nowpage;
	}

	public Integer getPagesize() {
		return pagesize;
	}

	public void setPagesize(Integer pagesize) {
		this.pagesize = pagesize;
	}
	public Map<String, Object> getCondition() {
		return condition;
	}
	public void setCondition(Map<String, Object> condition) {
		this.condition = condition;
	}
	public static enum Condition {
		gt, gte, lt, lte, eq, like
	}

	public static class Retrieval {
		private String name;
		private String condition;
		private String value;

		/**
		 * 获取name
		 * 
		 * @return name name
		 */
		public String getName() {
			return name;
		}

		/**
		 * 设置name
		 * 
		 * @param name
		 *            name
		 */
		public void setName(String name) {
			this.name = name;
		}

		/**
		 * 获取condition
		 * 
		 * @return condition condition
		 */
		public String getCondition() {
			return condition;
		}

		/**
		 * 设置condition
		 * 
		 * @param condition
		 *            condition
		 */
		public void setCondition(String condition) {
			this.condition = condition;
		}

		/**
		 * 获取value
		 * 
		 * @return value value
		 */
		public String getValue() {
			return value;
		}

		/**
		 * 设置value
		 * 
		 * @param value
		 *            value
		 */
		public void setValue(String value) {
			this.value = value;
		}

	}
}

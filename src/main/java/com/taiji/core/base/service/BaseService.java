package com.taiji.core.base.service;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Order;
import org.springframework.data.jpa.domain.Specification;

import com.taiji.core.utils.PageInfo;
import com.taiji.core.utils.PageInfo.Condition;
import com.taiji.core.utils.PageInfo.Retrieval;

public interface BaseService <E, ID extends Serializable>{
	/**
	 * 根据ID获取某个Entity
	 * 
	 * @param id
	 * @return
	 */
	public E find(ID id);
	/**
	 * 获取所有的Entity列表
	 * 
	 * @return
	 */
	public List<E> getAll() ;

	/**
	 * 获取Entity的总数
	 * 
	 * @return
	 */
	public Long getTotalCount() ;

	/**
	 * 保存Entity
	 * 
	 * @param entity
	 * @return
	 */
	public E save(E entity) ;

	/**
	 * 修改Entity
	 * 
	 * @param entity
	 * @return
	 */
	public E update(E entity) ;

	/**
	 * 删除Entity
	 * 
	 * @param entity
	 */
	public void delete(E entity) ;

	/**
	 * 根据Id删除某个Entity
	 * 
	 * @param id
	 */
	public void delete(ID id) ;
	/**
	 * 删除Entity
	 */
	public void deleteAll() ;

	/**
	 * 清空缓存，提交持久化
	 */
	public void flush() ;

	/**
	 * 根据查询信息获取某个Entity的列表
	 * 
	 * @param spec
	 * @return
	 */
	public List<E> findAll(Specification<E> spec) ;

	public List<E> findAll() ;

	/**
	 * 获取Entity的分页信息
	 * 
	 * @param pageable
	 * @return
	 */
	public Page<E> findAll(Pageable pageable) ;

	/**
	 * 根据查询条件和分页信息获取某个结果的分页信息
	 * 
	 * @param spec
	 * @param pageable
	 * @return
	 */
	public Page<E> findAll(Specification<E> spec, Pageable pageable) ;

	/**
	 * 根据查询条件和排序条件获取某个结果集列表
	 * 
	 * @param spec
	 * @param sort
	 * @return
	 */
	public List<E> findAll(Specification<E> spec, Sort sort);

	/**
	 * 查询某个条件的结果数集
	 * 
	 * @param spec
	 * @return
	 */
	public long count(Specification<E> spec) ;

	public PageInfo<E> findPage(PageInfo<E> pageFrom, Specification<E> specification) ;

	
	public PageInfo<E> findPage(PageInfo<E> pageFrom) ;
}

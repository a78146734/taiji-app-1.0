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

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Order;
import org.springframework.data.jpa.domain.Specification;

import com.taiji.core.base.repository.BaseRepository;
import com.taiji.core.utils.PageInfo;
import com.taiji.core.utils.PageInfo.Condition;
import com.taiji.core.utils.PageInfo.Retrieval;

/**
 * 
 * @author 赵国超
 * 基础Service
 *
 *         2017年8月23日
 */
public abstract class BaseServiceImpl<E, ID extends Serializable> implements BaseService<E, ID > {
	@Autowired
	private BaseRepository<E, ID> baseRepository;

	public void setBaseRepository(BaseRepository<E, ID> baseRepository) {
		this.baseRepository = baseRepository;
	}

	public BaseRepository<E, ID> getBaseRepository() {
		return baseRepository;
	}

	/**
	 * 根据ID获取某个Entity
	 * 
	 * @param id
	 * @return
	 */
	public E find(ID id) {
		return baseRepository.findOne(id);
	}

	/**
	 * 获取所有的Entity列表
	 * 
	 * @return
	 */
	public List<E> getAll() {
		return baseRepository.findAll();
	}

	/**
	 * 获取Entity的总数
	 * 
	 * @return
	 */
	public Long getTotalCount() {
		return baseRepository.count();
	}

	/**
	 * 保存Entity
	 * 
	 * @param entity
	 * @return
	 */
	public E save(E entity) {
		return baseRepository.save(entity);
	}

	/**
	 * 修改Entity
	 * 
	 * @param entity
	 * @return
	 */
	public E update(E entity) {
		return baseRepository.save(entity);
	}

	/**
	 * 删除Entity
	 * 
	 * @param entity
	 */
	public void delete(E entity) {
		baseRepository.delete(entity);
	}

	/**
	 * 根据Id删除某个Entity
	 * 
	 * @param id
	 */
	public void delete(ID id) {
		baseRepository.delete(id);
	}

	/**
	 * 删除Entity
	 */
	public void deleteAll() {
		baseRepository.deleteAll();
	}

	/**
	 * 清空缓存，提交持久化
	 */
	public void flush() {
		baseRepository.flush();
	}

	/**
	 * 根据查询信息获取某个Entity的列表
	 * 
	 * @param spec
	 * @return
	 */
	public List<E> findAll(Specification<E> spec) {
		return baseRepository.findAll(spec);
	}

	public List<E> findAll() {
		return baseRepository.findAll();
	}

	/**
	 * 获取Entity的分页信息
	 * 
	 * @param pageable
	 * @return
	 */
	public Page<E> findAll(Pageable pageable) {
		return baseRepository.findAll(pageable);
	}

	/**
	 * 根据查询条件和分页信息获取某个结果的分页信息
	 * 
	 * @param spec
	 * @param pageable
	 * @return
	 */
	public Page<E> findAll(Specification<E> spec, Pageable pageable) {
		return baseRepository.findAll(spec, pageable);
	}

	/**
	 * 根据查询条件和排序条件获取某个结果集列表
	 * 
	 * @param spec
	 * @param sort
	 * @return
	 */
	public List<E> findAll(Specification<E> spec, Sort sort) {
		return baseRepository.findAll(spec);
	}

	/**
	 * 查询某个条件的结果数集
	 * 
	 * @param spec
	 * @return
	 */
	public long count(Specification<E> spec) {
		return baseRepository.count(spec);
	}

	public PageInfo<E> findPage(PageInfo<E> pageFrom, Specification<E> specification) {
		Pageable pageable = bulidPageable(pageFrom);
		Page<E> bookPage = baseRepository.findAll(specification, pageable);
		return bulidPageFrom(bookPage);
	}

	protected  Sort bulidSort(PageInfo<?> pageFrom) {
		if (pageFrom == null) {
			return null;
		}
		Sort result = null;
		LinkedList<String> ascList = pageFrom.getAsc();
		if (ascList != null) {
			for (String asc : ascList) {
				if (result == null) {
					result = new Sort(Sort.Direction.ASC, asc);
				} else {
					result = result.and(new Sort(Sort.Direction.ASC, asc));
				}
			}
		}
		LinkedList<String> descList = pageFrom.getDesc();
		if (descList != null) {
			for (String desc : descList) {
				if (result == null) {
					result = new Sort(Sort.Direction.DESC, desc);
				} else {
					result = result.and(new Sort(Sort.Direction.DESC, desc));
				}
			}
		}
		return result;
	}

	protected  Pageable bulidPageable(PageInfo<?> pageFrom) {
		if (pageFrom == null) {
			return null;
		}
		Pageable pageable = new PageRequest(pageFrom.getNowpage() - 1, pageFrom.getPagesize(), bulidSort(pageFrom));
		return pageable;
	}

	public  <E> PageInfo<E> bulidPageFrom(Page<E> page) {
		PageInfo<E> from = new PageInfo<E>();
		from.setRows(page.getContent());
		from.setNowpage(page.getNumber() + 1);
		from.setTotal(Integer.valueOf(page.getTotalElements() + ""));
		from.setTotalpage(page.getTotalPages());
		from.setPagesize(page.getSize());
		if (page.getSort() != null) {
			Iterator<Order> iteratorasc = page.getSort().iterator();
			while (iteratorasc.hasNext()) {
				from.addAsc(iteratorasc.next().getProperty());
			}
			Iterator<Order> iteratordesc = page.getSort().iterator();
			while (iteratordesc.hasNext()) {
				from.addDesc(iteratordesc.next().getProperty());
			}
			Collections.reverse(from.getDesc());
		}
		return from;
	}

	public PageInfo<E> findPage(PageInfo<E> pageFrom) {
		return findPage(pageFrom, new Specification<E>() {

			/**
			 * 
			 */

			@Override
			public Predicate toPredicate(Root<E> root, CriteriaQuery<?> query, CriteriaBuilder criteriaBuilder) {
				List<Predicate> list = new ArrayList<>();
				if (pageFrom.getRetrievals()== null) {
					return criteriaBuilder.conjunction();
				}
				for (Retrieval retrieval : pageFrom.getRetrievals()) {
					String javaType = root.get(retrieval.getName()).type().getJavaType().getName();
					if (javaType.equals(Date.class.getName())) {
//						if (retrieval.getCondition().equals(Condition.gt.name())) {
//							list.add(criteriaBuilder.greaterThan(root.get(retrieval.getName()),
//									DateUtil.parseString(retrieval.getValue())));
//						} else if (retrieval.getCondition().equals(Condition.gte.name())) {
//							list.add(criteriaBuilder.greaterThanOrEqualTo(root.get(retrieval.getName()),
//									DateUtil.parseString(retrieval.getValue())));
//						} else if (retrieval.getCondition().equals(Condition.lt.name())) {
//							list.add(criteriaBuilder.lessThan(root.get(retrieval.getName()),
//									DateUtil.parseString(retrieval.getValue())));
//						} else if (retrieval.getCondition().equals(Condition.lte.name())) {
//							list.add(criteriaBuilder.lessThanOrEqualTo(root.get(retrieval.getName()),
//									DateUtil.parseString(retrieval.getValue())));
//						} else if (retrieval.getCondition().equals(Condition.eq.name())) {
//							list.add(criteriaBuilder.equal(root.get(retrieval.getName()),
//									DateUtil.parseString(retrieval.getValue())));
//						}
					} else if (javaType.equals(Long.class.getName()) || javaType.equals(Integer.class.getName()) || javaType.equals(Short.class.getName()) ) {
						if (retrieval.getCondition().equals(Condition.gt.name())) {
							list.add(criteriaBuilder.gt(root.get(retrieval.getName()),
									Integer.valueOf(retrieval.getValue())));
						} else if (retrieval.getCondition().equals(Condition.gte.name())) {
							list.add(criteriaBuilder.ge(root.get(retrieval.getName()),
									Integer.valueOf(retrieval.getValue())));
						} else if (retrieval.getCondition().equals(Condition.lt.name())) {
							list.add(criteriaBuilder.lt(root.get(retrieval.getName()),
									Integer.valueOf(retrieval.getValue())));
						} else if (retrieval.getCondition().equals(Condition.lte.name())) {
							list.add(criteriaBuilder.le(root.get(retrieval.getName()),
									Integer.valueOf(retrieval.getValue())));
						} else if (retrieval.getCondition().equals(Condition.eq.name())) {
							list.add(criteriaBuilder.equal(root.get(retrieval.getName()),
									Integer.valueOf(retrieval.getValue())));
						}
					} else if (javaType.equals(String.class.getName())) {
						if (retrieval.getCondition().equals(Condition.eq.name())) {
							list.add(criteriaBuilder.equal(root.get(retrieval.getName()), retrieval.getValue()));
						} else if (retrieval.getCondition().equals(Condition.like.name())) {
							list.add(criteriaBuilder.like(root.get(retrieval.getName()),
									retrieval.getValue()));
						}
					}
				}
				return criteriaBuilder.and(list.toArray(new Predicate[] {}));
			}
		});
	}
}
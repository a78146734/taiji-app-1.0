package com.taiji.user.repository;

import java.util.List;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.taiji.core.base.repository.BaseRepository;
import com.taiji.user.model.SysDictionary;
import com.taiji.user.model.SysDictionaryData;
import com.taiji.user.model.SysOrgan;

@Repository
public interface SysOrganRepository extends BaseRepository<SysOrgan, String> {
	//查询子部门中organCode的最大值
	@Query("SELECT MAX(o.organCode) FROM SysOrgan o WHERE o.parentId IN (:parentId)")
	String selectByCode(@Param("parentId") String parentId)throws Exception;
	
	SysOrgan findByOrganId(String organId);
	
	@Modifying
	@Transactional
	@Query("delete from SysOrgan t where t.organId in (:delOrganList)")
    int deleteInId(@Param("delOrganList") List<String> delOrganList);
}

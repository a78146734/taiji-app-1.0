package com.taiji.user.repository;

import java.util.List;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.taiji.core.base.repository.BaseRepository;
import com.taiji.user.model.SysUserOrgan;
@Repository
public interface SysUserOrganRepository extends BaseRepository<SysUserOrgan, String>{
	
	@Query("SELECT DISTINCT t.organId FROM SysOrgan t JOIN t.sysUserOrgans s WHERE s.userId = ?")
	List<String> selectOrganIdListByUserId(String userId);
	
    @Transactional
    int deleteByUserId(@Param("userId") String userId);
    
    @Modifying
	@Transactional
    @Query("delete from SysUserOrgan t where t.organId in (:delOrganList)")
    int deleteInOrgan(@Param("delOrganList") List<String> delOrganList);
}
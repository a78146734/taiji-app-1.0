package com.taiji.user.repository;

import java.util.List;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import com.taiji.core.base.repository.BaseRepository;
import com.taiji.user.model.SysOrganPuriew;
import com.taiji.user.model.SysPuriewResource;

/**
 * 
 * @author chenyd
 *
 * @date 2018-03-07 10:20
 */
public interface SysOrganPuriewRepository extends BaseRepository<SysOrganPuriew, String> {
	
	@Transactional
	void deleteByPuriewId(String puriewId);
	
	@Modifying
	@Transactional
	@Query("delete from SysOrganPuriew t where t.saveType='0' and t.organId=:organId")
	void deleteByOrganId(@Param("organId") String organId);
	
	@Modifying
	@Transactional
	@Query("delete from SysOrganPuriew t where t.saveType='1' and t.organId=:organId")
	void deleteByPurIds(@Param("organId") String organId);
	
	@Query("SELECT o_p.puriewId from SysOrganPuriew o_p where o_p.saveType='1' and o_p.organId in(:organList)")
	List<String> selectPuriewIdList (@Param("organList")List<String> organList );
	
	@Modifying
	@Transactional
	@Query("delete from SysOrganPuriew t where t.organId IN (:delOrganList)")
	int deleteInOrgan(@Param("delOrganList") List<String> delOrganList);
}

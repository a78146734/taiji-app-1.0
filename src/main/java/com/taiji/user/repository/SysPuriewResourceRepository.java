package com.taiji.user.repository;

import java.util.List;
import java.util.Map;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.taiji.core.base.repository.BaseRepository;
import com.taiji.user.model.SysPuriewResource;
import com.taiji.user.model.SysResource;

@Repository
public interface SysPuriewResourceRepository extends BaseRepository<SysPuriewResource, String> {
	
	@Query("SELECT p_r.resourceId FROM SysPuriewResource p_r LEFT JOIN p_r.sysPuriew p LEFT JOIN p.sysOrganPuriews o_p LEFT JOIN p.sysRolePuriew r_p WHERE o_p.organId in (:organs) or r_p.roleId in (:roles)")
	List<String> selectResourceIdList(@Param("organs") List<String> organs,@Param("roles") List<String> roles);

	@Query("SELECT  p.expression AS expression,  r.resourceUrl  AS urls FROM SysPuriew p LEFT JOIN p.sysPuriewResources p_r LEFT JOIN p_r.sysResource r ")
	List<Object> globalConfig();
	
	@Query("select DISTINCT t.puriewId from SysPuriewResource t  where t.resourceId IN (:resourceList)")
	List<String> selectPuriewIdInResourceId(@Param("resourceList") List<String> resourceList);
	
	@Transactional
	void deleteByPuriewId(String puriewId);
	
	@Modifying
	@Transactional
	@Query("delete from SysPuriewResource t where t.resourceId IN (:resourceIds)")
	void deleteInResource(@Param("resourceIds")List<String> resourceIds);
	
	@Query("SELECT p_r.resourceId from SysPuriewResource p_r JOIN p_r.sysPuriew p JOIN p.sysOrganPuriews o_p WHERE  o_p.organId in (:organs)")
	List<String> selectResourceIdTreeList(@Param("organs") List<String> organs);

}
package com.taiji.user.repository;
import java.util.List;
import java.util.Set;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.taiji.core.base.repository.BaseRepository;
import com.taiji.user.model.SysResource;
@Repository
public interface SysResourceRepository extends BaseRepository<SysResource, String>{

	List<SysResource> findAllByOrderBySeq();

	SysResource findByResourceId(String rId);
	
	@Query("SELECT t FROM SysResource t WHERE resourceUrl IN (:resourceUrls) AND usingState !=2 AND t.saveType = 0 AND t.usingState = 0 ORDER BY seq")
	List<SysResource> findByResourceUrl(@Param("resourceUrls")Set<String> resourceUrls);
	
	@Query("SELECT DISTINCT t.resourceUrl FROM SysResource t WHERE t.usingState = 0 AND t.resourceUrl IS NOT NULL AND t.resourceId IN (:ids)")
	List<String> selectUrlInId(@Param("ids")List<String> ids);
	
	@Query("select t.resourceId from SysPuriewResource t where t.puriewId = ?")
	public List<String> selectResourceIdListByPuriewId(String puriewId);
	
	@Query("SELECT t FROM SysResource t WHERE t.saveType = 0 AND t.usingState = 0")
	List<SysResource> selectAllMenu();
	
	@Modifying
	@Transactional
	@Query("delete from SysResource t  where t.resourceId IN (:resourceIds)")
	void deleteInId(@Param("resourceIds")List<String> resourceIds);
}
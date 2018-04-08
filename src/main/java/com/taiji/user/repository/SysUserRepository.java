package com.taiji.user.repository;

import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.taiji.core.base.repository.BaseRepository;
import com.taiji.user.model.SysUser;

@Repository
public interface SysUserRepository extends BaseRepository<SysUser, String> {

	SysUser findByLoginName(String loginName);

	SysUser findByUserId(String userId);
	
	List<SysUser> findByCertId(String certId);
	
	List<SysUser> findByLoginNameOrUsername(String loginName, String username);
	
	@Query("select DISTINCT u from SysUser u  JOIN u.sysUserOrgans u_o  where u_o.organId=:organId ")
//	@Query(value="select DISTINCT * from SYS_USER_ LEFT JOIN SYS_USER_ORGAN_ ON SYS_USER_.USER_ID_ = SYS_USER_ORGAN_.USER_ID_  where SYS_USER_ORGAN_.Organ_Id_=:organId ORDER BY ?#{#pageable}",nativeQuery = true)
	Page<SysUser> findAllByOrganId(@Param("organId")String organId, Pageable pageRequest);

}
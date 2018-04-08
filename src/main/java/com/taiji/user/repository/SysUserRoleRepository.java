package com.taiji.user.repository;

import java.util.List;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.taiji.core.base.repository.BaseRepository;
import com.taiji.user.model.SysUser;
import com.taiji.user.model.SysUserRole;
@Repository
public interface SysUserRoleRepository extends BaseRepository<SysUserRole, String>{

	
	@Query("select roleId AS roleId from SysUserRole where userId = ?")
	List<String> selectRoleIdListByUserId(String userId);
	
    @Transactional
    int deleteByUserId(@Param("userId") String userId);
	
    @Transactional
	int deleteByRoleId(@Param("id") String id);
}
package com.taiji.user.repository;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.taiji.core.base.repository.BaseRepository;
import com.taiji.user.model.SysDictionary;
import com.taiji.user.model.SysRole;
import com.taiji.user.model.SysRole;

@Repository
public interface SysRoleRepository extends BaseRepository<SysRole, String> {

	SysRole findByRoleName(String roleName);

	SysRole findByCode(String code);

	SysRole findByRoleId(String roleId);
	
	@Transactional
	void deleteByRoleId(@Param("id") String id);
    
	@Query( "SELECT t FROM SysRole t JOIN t.sysUserRoles s WHERE s.userId = ? ORDER BY t.seq" )
	List<SysRole> selectByUser(String userId);
}

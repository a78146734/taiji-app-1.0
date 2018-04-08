package com.taiji.user.repository;

import java.util.List;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import com.taiji.user.model.SysRolePuriew;
import com.taiji.core.base.repository.BaseRepository;

/**
 * 
 * @author chenyd
 *
 * @date 2018-03-07 10:19
 */
public interface SysRolePuriewRepository extends BaseRepository<SysRolePuriew, String> {
	
	@Query("SELECT t.puriewId from SysRolePuriew t where t.saveType = '1' and t.roleId in (:roleList)")
//	@Query(value = "SELECT o_p.PURIEW_ID_ as puriewId from SYS_ROLE_PURIEW_ o_p  where o_p.SAVE_TYPE_ = '1' and o_p.ROLE_ID_ in (:roleList)", nativeQuery = true)
	List<String> selectPuriewIdList(@Param(value="roleList") List<String> roleList);

	@Modifying
	@Transactional
	@Query("delete from SysRolePuriew t where t.saveType='0' AND t.roleId in (:roleId)")
//	@Query(value="delete from SYS_ROLE_PURIEW_ where SAVE_TYPE_='0' AND ROLE_ID_ in (:roleId)", nativeQuery = true)
	int deleteByRoleId(@Param("roleId") String roleId);
	
	@Transactional
	void deleteByPuriewId(@Param("puriewId") String puriewId);
	
	@Modifying
	@Transactional
	@Query("delete from SysRolePuriew t where t.saveType='1' AND t.roleId in (:roleId)")
//	@Query(value="delete from SYS_ROLE_PURIEW_ where SAVE_TYPE_='1' AND ROLE_ID_ in (:roleId)", nativeQuery = true)
	int deleteByPurIds(@Param("roleId") String roleId);

}

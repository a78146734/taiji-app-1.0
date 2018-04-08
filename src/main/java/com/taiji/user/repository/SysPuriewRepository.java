package com.taiji.user.repository;

import java.util.List;
import java.util.Map;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.taiji.core.base.repository.BaseRepository;
import com.taiji.user.model.SysPuriew;
import com.taiji.user.model.SysUserOrgan;

/**
 * 
 * @author chenyd
 *
 * @date 2018-03-07 10:20
 */
public interface SysPuriewRepository extends BaseRepository<SysPuriew, String> {

	//List<SysPuriew> findOrberBySeq();
}
package com.taiji.user.repository;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.taiji.core.base.repository.BaseRepository;
import com.taiji.user.model.SysDictionary;
import com.taiji.user.model.SysDictionaryData;
import com.taiji.user.model.SysUser;

@Repository
public interface SysDictionaryRepository extends BaseRepository<SysDictionary, String> {

	SysDictionary findByDictionaryId(String dictionaryId);
	
	List<SysDictionary> findByNodeId(String nodeId);
 
    @Transactional
    void deleteByDictionaryId(@Param("dictionaryId") String dictionaryId);
}
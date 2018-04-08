package com.taiji.user.repository;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.taiji.core.base.repository.BaseRepository;
import com.taiji.user.model.SysDictionaryData;
import com.taiji.user.model.SysUser;

@Repository
public interface SysDictionaryDataRepository extends BaseRepository<SysDictionaryData, String> {

	SysDictionaryData findByDictionaryDataId(String dictionaryDataId);
	
	@Query("SELECT t FROM SysDictionaryData t JOIN FETCH t.sysDictionary s WHERE s.nodeId = ? ORDER BY t.seq")
	List<SysDictionaryData> findByNodeId(String nodeId);
	
	@Query("select parameter1 from SysDictionaryData where dictionaryDataId = ?")
	String findParam1ById(String id);
	
    @Transactional
    void deleteByDictionaryId(@Param("dictionaryId") String dictionaryId);
    @Transactional
    void deleteByDictionaryDataId(@Param("dictionaryDataId") String dictionaryDataId);
}
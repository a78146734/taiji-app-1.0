package com.taiji.core.quartz.repository;

import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.taiji.core.base.repository.BaseRepository;
import com.taiji.core.quartz.entity.ScheduleJob;

@Repository
public interface SysJobRepository extends BaseRepository<ScheduleJob, String> {

    @Transactional
    void deleteByJobId(@Param("jobId") String jobId);
}

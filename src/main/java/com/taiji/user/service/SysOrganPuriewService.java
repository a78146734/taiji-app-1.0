package com.taiji.user.service;

import java.util.List;

import com.taiji.core.base.service.BaseService;
import com.taiji.user.model.SysOrganPuriew;

public interface SysOrganPuriewService  extends BaseService<SysOrganPuriew, String>{
	void updateByOrgan(String resourceIds, String id, String purIds,String staffName)throws Exception;
	List<String> selectPuriewIdListByOrganIds(List<String> organList) throws Exception;
}

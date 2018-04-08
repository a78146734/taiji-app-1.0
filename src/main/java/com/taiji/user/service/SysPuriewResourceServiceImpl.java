package com.taiji.user.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.taiji.core.base.service.BaseServiceImpl;
import com.taiji.user.model.SysPuriewResource;
import com.taiji.user.model.SysResource;
import com.taiji.user.repository.SysPuriewResourceRepository;
import com.taiji.user.service.SysPuriewResourcerService;

@Service
public class SysPuriewResourceServiceImpl extends BaseServiceImpl<SysPuriewResource, String>  implements SysPuriewResourcerService {

	@Autowired
	private SysPuriewResourceRepository sysPuriewResourceRepository;

	@Override
	public List<String> selectResourceIdList(List<String> roles,List<String> organs) throws Exception{
		return sysPuriewResourceRepository.selectResourceIdList(organs,roles);
	}

	@Override
	public List<String> selectResourceIdListByPuriewId(String puriewId) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
	/**
	 * 1
	 */
	@Override
	public void updateByPuriew(String resourceIds, String id, String staffName) throws Exception {
		sysPuriewResourceRepository.deleteByPuriewId(id);
		if (resourceIds == null || resourceIds.length() == 0) {
			return;
		}
		String[] resourceIdArray = resourceIds.split(",");
		for (String resourceId : resourceIdArray) {
			SysPuriewResource sysPuriewResource = new SysPuriewResource();
			sysPuriewResource.setResourceId(resourceId);
			sysPuriewResource.setPuriewId(id);
			sysPuriewResource.setFounder(staffName);
			sysPuriewResource.setCreateTime(new Date());
			sysPuriewResource.setSaveType("0");
			sysPuriewResource.setUsingState("0");
			sysPuriewResourceRepository.save(sysPuriewResource);
		}
	}

	@Override
	public void insert(SysPuriewResource sysPuriewResource) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<Map<String, Object>> globalConfig() throws Exception {
		List<Object> globlal=sysPuriewResourceRepository.globalConfig();
		List<Map<String, Object>>  listMap=new ArrayList<Map<String, Object>>();
		Map<String, Object> map=null;
		for (int i = 0; i < globlal.size(); i++) {
			Object[] obj = (Object[]) globlal.get(i);
			map=new HashMap<String, Object>();
			map.put("EXPRESSION",  obj[0]);
			map.put("URLS",  obj[1]);
			listMap.add(map);
		}
		return listMap;
	}
	
	@Override
	public List<String> selectResourceIdTreeList(List<String> organs) throws Exception{
		return sysPuriewResourceRepository.selectResourceIdTreeList(organs);
	}
}
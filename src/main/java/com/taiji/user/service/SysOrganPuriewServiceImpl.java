package com.taiji.user.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.taiji.core.base.service.BaseServiceImpl;
import com.taiji.core.utils.StringUtils;
import com.taiji.user.model.SysOrganPuriew;
import com.taiji.user.repository.SysOrganPuriewRepository;
import com.taiji.user.repository.SysPuriewResourceRepository;
@Service
public class SysOrganPuriewServiceImpl extends BaseServiceImpl<SysOrganPuriew, String>  implements SysOrganPuriewService{
	@Autowired
	private SysOrganPuriewRepository sysOrganPuriewMapper;
	@Autowired
	private SysPuriewResourceRepository sysPuriewResourceRepository;
	
	@Override
	public void updateByOrgan(String resourceIds, String organId, String purIds, String staffName) throws Exception{
		if(StringUtils.isNotBlank(resourceIds)){
			sysOrganPuriewMapper.deleteByOrganId(organId);
			List<String> resourceList = new ArrayList<String>();
			String[] strings = resourceIds.split(",");
			for (String string : strings) {
				resourceList.add(string);
			}
			List<String> puriewIds = sysPuriewResourceRepository.selectPuriewIdInResourceId(resourceList);
			for (String puriewId : puriewIds) {
				SysOrganPuriew sysOrganPuriew = new SysOrganPuriew();
				sysOrganPuriew.setOrganId(organId);
				sysOrganPuriew.setPuriewId(puriewId);
				sysOrganPuriew.setFounder(staffName);
				sysOrganPuriew.setCreateTime(new Date());
				sysOrganPuriew.setSaveType("0");
				sysOrganPuriew.setUsingState("0");
				sysOrganPuriewMapper.save(sysOrganPuriew);
			}
		}
 
		List<String> purList = new ArrayList<String>();
		if(StringUtils.isNotBlank(purIds)){
			sysOrganPuriewMapper.deleteByPurIds(organId);
			String[] purStrings = purIds.split(",");
			for (String string : purStrings) {
				purList.add(string);
			}
			for (String puriewId : purList) {
				SysOrganPuriew sysOrganPuriew = new SysOrganPuriew();
				sysOrganPuriew.setOrganId(organId);
				sysOrganPuriew.setPuriewId(puriewId);
				sysOrganPuriew.setFounder(staffName);
				sysOrganPuriew.setCreateTime(new Date());
				sysOrganPuriew.setSaveType("1");
				sysOrganPuriew.setUsingState("0");
				sysOrganPuriewMapper.save(sysOrganPuriew);
			}
		}
		

	}
	@Override
	public List<String> selectPuriewIdListByOrganIds(List<String> organList) throws Exception{
		 return sysOrganPuriewMapper.selectPuriewIdList(organList);
	}
}

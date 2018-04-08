package com.taiji.user.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.taiji.core.base.service.BaseServiceImpl;
import com.taiji.core.utils.BeanUtils;
import com.taiji.core.utils.StringUtils;
import com.taiji.user.model.SysPuriewResource;
import com.taiji.user.model.SysRolePuriew;
import com.taiji.user.repository.SysPuriewResourceRepository;
import com.taiji.user.repository.SysRolePuriewRepository;


@Service
public class SysRolePuriewServiceImpl extends BaseServiceImpl<SysRolePuriew, String> implements SysRolePuriewService {

	@Autowired
	private SysRolePuriewRepository sysRolePuriewMapper;

	@Autowired
	private SysPuriewResourceRepository sysPuriewResourceMapper;

	public void updateByRole(String resourceIds, String roleId, String purIds, String staffName) throws Exception{
		// XXX 根据id删除角色权限表 根据资源id查出对应的权限id 插入数据
		
	
		if(StringUtils.isNotBlank(resourceIds)){
			sysRolePuriewMapper.deleteByRoleId(roleId);
			List<String> resourceList = new ArrayList<String>();
			String[] strings = resourceIds.split(",");
			for (String string : strings) {
				resourceList.add(string);
			}
			List<String> puriewIds = sysPuriewResourceMapper.selectPuriewIdInResourceId(resourceList);
			for (String puriewId : puriewIds) {
				SysRolePuriew sysRolePuriew = new SysRolePuriew();
				sysRolePuriew.setRoleId(roleId);
				sysRolePuriew.setPuriewId(puriewId);
				sysRolePuriew.setFounder(staffName);
				sysRolePuriew.setCreateTime(new Date());
				sysRolePuriew.setSaveType("0");
				sysRolePuriew.setUsingState("0");
				sysRolePuriewMapper.save(sysRolePuriew);
			}
		}
		List<String> purList = new ArrayList<String>();
		if(StringUtils.isNotBlank(purIds)){
			sysRolePuriewMapper.deleteByPurIds(roleId);
			String[] purStrings = purIds.split(",");
			for (String string : purStrings) {
				purList.add(string);
			}
			for (String puriewId : purList) {
				SysRolePuriew sysRolePuriew = new SysRolePuriew();
				sysRolePuriew.setRoleId(roleId);
				sysRolePuriew.setPuriewId(puriewId);
				sysRolePuriew.setFounder(staffName);
				sysRolePuriew.setCreateTime(new Date());
				sysRolePuriew.setSaveType("1");
				sysRolePuriew.setUsingState("0");
				sysRolePuriewMapper.save(sysRolePuriew);
			}
		}
	}

	public List<String> selectPuriewIdListByRoleIds(List<String> rolelist) throws Exception{
		return sysRolePuriewMapper.selectPuriewIdList(rolelist);
		// TODO Auto-generated method stub
	}


}

package com.taiji.user.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.taiji.core.base.service.BaseServiceImpl;
import com.taiji.core.utils.BeanUtils;
import com.taiji.user.model.SysDictionary;
import com.taiji.user.model.SysRole;
import com.taiji.user.repository.SysRolePuriewRepository;
import com.taiji.user.repository.SysRoleRepository;
import com.taiji.user.repository.SysUserRoleRepository;


@Service
public class SysRoleServiceImpl extends BaseServiceImpl<SysRole, String> implements SysRoleService {
	@Autowired
	SysRoleRepository sysRoleRepository;
	@Autowired
	SysUserRoleRepository sysUserRoleRepository;
	@Autowired
	SysRolePuriewRepository sysRolePuriewRepository;
	
	
	@Override
	public int insert(SysRole sysRole) throws Exception {
		sysRoleRepository.save(sysRole);
		return 1;
		
	}

	@Override
	public SysRole selectById(String id) throws Exception {
		return sysRoleRepository.findOne(id);
	}

	@Override
	public SysRole updateRole(SysRole role) throws Exception {
		SysRole sysRole = null;
		if(role.getRoleId() != null){
			sysRole = sysRoleRepository.findByRoleId(role.getRoleId());
			BeanUtils.copyPropertiesIgnoreNull(role,sysRole);
			return super.update(sysRole);
		}
		return sysRole;
		
	}

	@Override
	public List<SysRole> selectAll() throws Exception {
		// TODO Auto-generated method stub
		return sysRoleRepository.findAll();
	}

	@Override
	public void deleteById(String id) throws Exception {
		try {
			sysUserRoleRepository.deleteByRoleId(id);
			sysRolePuriewRepository.deleteByRoleId(id);
			sysRolePuriewRepository.deleteByPurIds(id);
			sysRoleRepository.deleteByRoleId(id);
		} catch (Exception e) {
			throw new RuntimeException("com.taiji.system.user.service.impl.SysRoleServiceImpl.deleteById");
		}
	}

	@Override
	public List<SysRole> selectByUser(String userId) throws Exception {
		// TODO Auto-generated method stub
		return sysRoleRepository.selectByUser(userId);
	}

	@Override
	public SysRole selectByCode(String code) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public SysRole selectRoleByRoleName(String roleName) throws Exception {
		return sysRoleRepository.findByRoleName(roleName);
	}

	@Override
	public SysRole selectRoleByCode(String code) throws Exception {
		return sysRoleRepository.findByCode(code);
	}

}

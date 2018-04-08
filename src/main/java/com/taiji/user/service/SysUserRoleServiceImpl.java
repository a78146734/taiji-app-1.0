package com.taiji.user.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.taiji.core.base.service.BaseServiceImpl;
import com.taiji.user.model.SysUser;
import com.taiji.user.model.SysUserRole;
import com.taiji.user.repository.SysUserRoleRepository;
import com.taiji.user.service.SysUserRoleService;

@Service
public class SysUserRoleServiceImpl extends BaseServiceImpl<SysUserRole, String> implements SysUserRoleService {

	@Autowired
	private SysUserRoleRepository sysUserRoleRepository;

	@Override
	public List<String> selectRoleIdListByUserId(String userId) throws Exception{
		return sysUserRoleRepository.selectRoleIdListByUserId(userId);
	}

	@Override
	public int deleteByUser(String userId) throws Exception {
		return sysUserRoleRepository.deleteByUserId(userId);
	}

	
	

}
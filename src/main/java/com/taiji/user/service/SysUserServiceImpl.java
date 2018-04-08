package com.taiji.user.service;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.taiji.core.base.service.BaseServiceImpl;
import com.taiji.core.utils.BeanUtils;
import com.taiji.core.utils.PageInfo;
import com.taiji.user.model.SysUser;
import com.taiji.user.model.SysUserOrgan;
import com.taiji.user.model.SysUserRole;
import com.taiji.user.repository.SysUserOrganRepository;
import com.taiji.user.repository.SysUserRepository;
import com.taiji.user.repository.SysUserRoleRepository;
import ch.qos.logback.core.joran.util.beans.BeanUtil;

@Service
public class SysUserServiceImpl extends BaseServiceImpl<SysUser, String> implements SysUserService {
	@Autowired
	SysUserRepository sysUserRepository;
	@Autowired
	SysUserRoleRepository sysUserRoleRepository;
	@Autowired
	SysUserOrganRepository sysUserOrganRepository;

	public SysUser selectByLoginName(String loginName) {
		return sysUserRepository.findByLoginName(loginName);
	}

	public void deleteUserById(String id) throws Exception {
		sysUserRepository.delete(id);
	}

	public SysUser selectByUserId(String userId) throws Exception {
		return sysUserRepository.findByUserId(userId);
	}
	
	public List<SysUser> selectByCertId(String certId) throws Exception {
		return sysUserRepository.findByCertId(certId);
	}

	@Override
	public List<SysUser> selectByLoginNameOrUsername(String loginName, String username) throws Exception{
		return sysUserRepository.findByLoginNameOrUsername(loginName, username);
	}
	
	@Override
	public SysUser updateUserPassword(String userId, String password) throws Exception {
		SysUser sysUser=new SysUser();
		sysUser = sysUserRepository.getOne(userId);
		sysUser.setLoginPassword(password);
		return sysUserRepository.saveAndFlush(sysUser);
	}

	public SysUser updateUserSelective(SysUser entity) {
		SysUser sysUser = null;
		if(entity.getUserId() != null){
			sysUser = sysUserRepository.findByUserId(entity.getUserId());
			BeanUtils.copyPropertiesIgnoreNull(entity,sysUser);
			return super.update(sysUser);
		}
		return sysUser;
		
	}

	@Override
	public int insert(SysUser sysUser,List<String> organIds,List<String> roleIds,String staffName) throws Exception{
		int k = 1;
		sysUserRepository.save(sysUser);
		k += insertOrganByUser(organIds, sysUser.getUserId(), staffName);
		k += insertRoleByUser(roleIds, sysUser.getUserId(), staffName);
		return k;
	}
	
	@Transactional
	public int updateUser(SysUser sysUser,List<String> organIds,List<String> roleIds,String staffName) throws Exception{
		int k = 1;
		k += updateOrganByUser(organIds, sysUser.getUserId(), staffName);
		k += updateRoleByUser(roleIds, sysUser.getUserId(), staffName);
		updateUserSelective(sysUser);
		return k;
	}
	
	@Transactional
	public int updateOrganByUser(List<String> organIds, String userId, String staffName) throws Exception{
		int k = 1;
		sysUserOrganRepository.deleteByUserId(userId);
		k += insertOrganByUser(organIds, userId, staffName);
		return k;
	}
	
	@Transactional
	public int insertOrganByUser(List<String> organIds, String userId, String staffName) throws Exception{
		int k = 1;
		if (organIds != null) {
			for (String organId : organIds) {
				if(organId != null && !organId.equals("")){
					SysUserOrgan organ = new SysUserOrgan();
					organ.setUserId(userId);
					organ.setOrganId(organId);
					organ.setFounder(staffName);
					organ.setCreateTime(new Date());
					organ.setSaveType("0");
					organ.setUsingState("0");
					organ.setDescribe("");
					sysUserOrganRepository.save(organ);
				}
			}
		}
		return k;
	}
	
	@Transactional
	public int updateRoleByUser(List<String> roleIds, String userId, String staffName) throws Exception{
		int k = 1;
		sysUserRoleRepository.deleteByUserId(userId);
		k += insertRoleByUser(roleIds, userId, staffName);
		return k;
	}
	
	@Transactional
	public int insertRoleByUser(List<String> roleIds, String userId, String staffName) throws Exception{
		int k = 1;
		if (roleIds != null) {
			for (String roleId : roleIds) {
				if(roleId != null && !roleId.equals("")){
					SysUserRole role = new SysUserRole();
					role.setUserId(userId);
					role.setRoleId(roleId);
					role.setFounder(staffName);
					role.setCreateTime(new Date());
					role.setSaveType("0");
					role.setUsingState("0");
					role.setDescribe("");
					sysUserRoleRepository.save(role);
				}
			}
		}
		return k;
	}
	
	public PageInfo<SysUser> findPage(String organId, PageInfo<SysUser> pageFrom) {
		Pageable pageable = bulidPageable(pageFrom);
		Page<SysUser> bookPage = sysUserRepository.findAllByOrganId(organId, pageable);
		return bulidPageFrom(bookPage);
	}

	@Override
	public PageInfo<SysUser> selectUserOrganPage(PageInfo<SysUser> pageInfo, String organId) throws Exception {
		return findPage(organId,pageInfo);
	}
}

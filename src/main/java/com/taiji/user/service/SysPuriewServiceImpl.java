package com.taiji.user.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.domain.Sort.Order;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.taiji.core.base.service.BaseServiceImpl;
import com.taiji.core.utils.BeanUtils;
import com.taiji.core.utils.PageInfo;
import com.taiji.user.model.SysDictionary;
import com.taiji.user.model.SysPuriew;
import com.taiji.user.repository.SysOrganPuriewRepository;
import com.taiji.user.repository.SysPuriewRepository;
import com.taiji.user.repository.SysPuriewResourceRepository;
import com.taiji.user.repository.SysRolePuriewRepository;
/**
 * 
 * @author chenyd
 *
 * @date 2018-03-07 10:20
 */
@Service
public class SysPuriewServiceImpl extends BaseServiceImpl<SysPuriew, String>  implements SysPuriewService {
	
	
	@Autowired
	private SysPuriewRepository sysPuriewRepository;
	
	//组织机构和权限关联dao
	@Autowired
	private SysOrganPuriewRepository sysOrganPuriewRepository;
	
	//资源和权限关联dao
	@Autowired
	private SysPuriewResourceRepository sysPuriewResourceRepository;
	
	//角色和权限关联dao
	@Autowired
	private SysRolePuriewRepository sysRolePuriewRepository;
	

	
	/**
	 * 
	 */
	@Override
	public int insert(SysPuriew sysPuriew) throws Exception{
		sysPuriewRepository.save(sysPuriew);
		return 1;
	}
	
	/**
	 * 
	 */
	@Override
	public SysPuriew selectById(String id) throws Exception{
		return sysPuriewRepository.findOne(id);
	}

	/**
	 * 
	 */
	public int updateSysPuriew(SysPuriew sysPuriew) throws Exception{
		SysPuriew src=sysPuriewRepository.findOne(sysPuriew.getPuriewId());
		BeanUtils.copyPropertiesIgnoreNull(sysPuriew,src);
		sysPuriewRepository.save(src);
		return 1;
	}

	
	/**
	 * 权限删除时要关联删除和权限绑定的所有表
	 * 
	 */
	@Transactional
	public int deleteById(String puriewId) throws Exception{
		int i = 0;
		sysRolePuriewRepository.deleteByPuriewId(puriewId);
		sysPuriewResourceRepository.deleteByPuriewId(puriewId);
		sysOrganPuriewRepository.deleteByPuriewId(puriewId);
		sysPuriewRepository.delete(puriewId);
		i=1;
		return i;
				
	}
	
	/**
	 * 1
	 */
	@Override
	public List<Map<String, Object>> selectAllPurToTree() throws Exception{
		return buildListToTreeUserMenu(sysPuriewRepository.findAll(new Sort(new Order(Direction.ASC, "seq"))));
	}
	
	/**
	 * 构建菜单 PurMenu
	 * 
	 * @param list
	 * @return
	 */
	private List<Map<String, Object>> buildListToTreeUserMenu(List<SysPuriew> list) throws Exception{
		List<Map<String, Object>> treelist = new ArrayList<Map<String, Object>>();

		for(int i=0;i<list.size();i++){
			if(list.get(i).getSaveType().equals("0")){
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("id", list.get(i).getPuriewId());
				map.put("pid", 0);
				map.put("name", list.get(i).getPuriewName());
				treelist.add(map);
			}
		}
		
		return treelist;
	}

	@Override
	public List<SysPuriew> selectAll() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Map<String, Object>> globalConfig() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<String> selectPuriewIdList(List<String> roleIds, List<String> organIds) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean checkPuriewByUser(String userid, String code) throws Exception {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public List<SysPuriew> selectByUser(String userId) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public SysPuriew selectByCode(String code) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<SysPuriew> selectByRoleCode(String roleCode) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<SysPuriew> selectByOrgan(String organId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public PageInfo<SysPuriew> selectByPage(PageInfo pageInfo) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

}
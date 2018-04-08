package com.taiji.user.service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.taiji.core.base.service.BaseServiceImpl;
import com.taiji.core.shiro.ShiroUser;
import com.taiji.core.utils.BeanUtils;
import com.taiji.core.utils.PageInfo;
import com.taiji.user.model.SysDictionary;
import com.taiji.user.model.SysPuriew;
import com.taiji.user.model.SysPuriewResource;
import com.taiji.user.model.SysResource;
import com.taiji.user.model.SysUser;
import com.taiji.user.repository.SysPuriewRepository;
import com.taiji.user.repository.SysPuriewResourceRepository;
import com.taiji.user.repository.SysResourceRepository;
import com.taiji.user.service.SysResourceService;

@Service
public class SysResourceServiceImpl extends BaseServiceImpl<SysResource, String> implements SysResourceService {
	
	@Autowired
	private SysResourceRepository sysResourceRepository;
	@Autowired
	private SysPuriewResourceRepository sysPuriewResourceRepository;
	@Autowired
	private SysPuriewRepository sysPuriewRepository;
	@Autowired
	private SysPuriewService puriewService;

	@Override
	public List<String> selectUrlInId(List<String> puriewList) {
		return sysResourceRepository.selectUrlInId(puriewList);
	}

	@Override
	public List<Map<String, Object>> selectTree(ShiroUser shiroUser) throws Exception{
		Set<String> urlSet = null;
		if (shiroUser.getUrlSet() == null || shiroUser.getUrlSet().size() == 0) {
			return new ArrayList<Map<String, Object>>();
		} else {
			urlSet = shiroUser.getUrlSet();
		}
		List<SysResource> list = sysResourceRepository.findByResourceUrl(urlSet);
		return buildListToTreeUserMenu(list);
	}

	@Override
	public List<Map<String, Object>> selectAllToTree() throws Exception {
		return buildListToTreeUserMenu(sysResourceRepository.findAllByOrderBySeq());
	}

	@Override
	public List<Map<String, Object>> getTreeByResourceIds(String resourceIds) throws Exception {
		String[] resourceId=resourceIds.split(",");
		List<SysResource> listShow=new ArrayList<SysResource>();
		for(int i=0;i<resourceId.length;i++){
			String rId=resourceId[i];
			SysResource sysResource=sysResourceRepository.findOne(rId);
			System.out.println(sysResource.getResourceName());
			try {
				boolean b=listShow.add(sysResource);
				System.out.println(b);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}		
		return buildListToTreeUserMenu(listShow);
	}

	@Override
	public List<Map<String, Object>> selectMenuToTree() throws Exception {
		return buildListToTreeUserMenu(sysResourceRepository.selectAllMenu());
	}

	@Override
	public List<SysResource> selectAll() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<SysResource> selectUserMenu(ShiroUser shiroUser) throws Exception {
		Set<String> urlSet = null;
		if (shiroUser.getUrlSet() == null || shiroUser.getUrlSet().size() == 0) {
			return new ArrayList<SysResource>();
		} else {
			urlSet = shiroUser.getUrlSet();
		}
		
		List<SysResource> userMenus = sysResourceRepository.findByResourceUrl(urlSet);
		return buildListToTree(userMenus);
	}

	@Override
	@Transactional
	public int insert(SysResource resource) throws Exception {
		int k = 1;
		sysResourceRepository.save(resource);
		insertPuriewByRes(resource);
		return k;
	}

	/**
	 * @author anjl
	 * @param resource
	 * 根据资源添加与资源相关的权限信息
	 * @return
	 */
	public int insertPuriewByRes(SysResource resource){
		
		//插入权限信息
		int k = 1;
		SysPuriew puriew = new SysPuriew();
		puriew.setCode((int)((Math.random()*9+1)*100000)+"");
		puriew.setExpression(resource.getResourceUrl());
		puriew.setPuriewName(resource.getResourceName() + "权限");
		puriew.setSeq(resource.getSeq());
		puriew.setCreateTime(new Date());
		puriew.setSaveType("1");
		puriew.setUsingState("0");
		puriew.setFounder(resource.getFounder());
		sysPuriewRepository.save(puriew);
		
		//封装插入权限和资源绑定关联信息
		SysPuriewResource sysPuriewResource = new SysPuriewResource();
		sysPuriewResource.setResourceId(resource.getResourceId());
		sysPuriewResource.setPuriewId(puriew.getPuriewId());
		sysPuriewResource.setFounder(resource.getFounder());
		sysPuriewResource.setCreateTime(new Date());
		sysPuriewResource.setSaveType("1");
		sysPuriewResource.setUsingState("0");
		sysPuriewResourceRepository.save(sysPuriewResource);
		return k;
	}
	@Override
	public SysResource selectById(String id) throws Exception {
		return sysResourceRepository.findOne(id);
	}

	

	@Override
	@Transactional
	public void updateRelate(SysResource resource) throws Exception {
		//更新资源信息
		updateSelective(resource);
		List<String> resourceList = new ArrayList<String>();
		resourceList.add(resource.getResourceId());
		List<String> puriewList = sysPuriewResourceRepository.selectPuriewIdInResourceId(resourceList);
		
		//判断与资源关联的权限是否存在，如果不存在说明已经丢失，重新补加；存在则进行更新
		if(puriewList.isEmpty()){
			 insertPuriewByRes(resource);
		}else{
			for (String puriewId : puriewList) {
				SysPuriew puriew = new SysPuriew();
				puriew.setPuriewName(resource.getResourceName()+"权限");
				puriew.setPuriewId(puriewId);
				puriew.setExpression(resource.getResourceUrl());
				puriewService.updateSysPuriew(puriew);
			}
		}
	}

	@Override
	@Transactional
	public int deleteById(String id) throws Exception {
		int k = 0;
		//查询是否有子节点
		List<String> newresourceList = recursiveBelowList(sysResourceRepository.findAll(),Arrays.asList(id));
//		List<Long> newresourceList = BeanUtils.objectToLong(sysResourceRepository.selectIdList(id));
		if (newresourceList.size()!=0) {
			List<String> puriewList = sysPuriewResourceRepository.selectPuriewIdInResourceId(newresourceList);
			//删除子节点资源表
			sysPuriewResourceRepository.deleteInResource(newresourceList);
			sysResourceRepository.deleteInId(newresourceList);
			
			//删除权限时要关联删除权限和角色，组织机构的绑定关系
			if(puriewList.size()!=0){
				for (String purId : puriewList) {
					k += puriewService.deleteById(purId);
				}
			}
		}
		return k;
	}

	@Override
	public List<String> selectRecursiveDownIdList(String id) throws Exception {
		return recursiveBelowList(sysResourceRepository.findAll(),Arrays.asList(id));
//		return sysResourceRepository.selectIdList(id);
	}

	@Override
	public PageInfo<SysResource> selectByPage(PageInfo<SysResource> pageInfo) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int insertGenPur(String path, String tabName, String author) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}
	
	@Override
	public List<String> selectResourceIdListByPuriewId(String puriewId) throws Exception{
		return sysResourceRepository.selectResourceIdListByPuriewId(puriewId);
	}
	
	@Override
	public SysResource updateSelective(SysResource entity) throws Exception {
		SysResource sysResource = null;
		if(entity.getResourceId() != null){
			sysResource = sysResourceRepository.findOne(entity.getResourceId());
			BeanUtils.copyPropertiesIgnoreNull(entity,sysResource);
			return super.update(sysResource);
		}
		return sysResource;
	}
	
	/**
	 * 构建菜单 UserMenu
	 * 
	 * @param list
	 * @return
	 */
	private List<Map<String, Object>> buildListToTreeUserMenu(List<SysResource> list) throws Exception{
		List<Map<String, Object>> treelist = new ArrayList<Map<String, Object>>();

		for(int i=0;i<list.size();i++){

				Map<String, Object> map = new HashMap<String, Object>();
				map.put("id", list.get(i).getResourceId());
				map.put("pid", list.get(i).getParentId());
				map.put("name", list.get(i).getResourceName());
				treelist.add(map);

		}
		
		return treelist;
	}
	/**
	 * 构建菜单
	 * 
	 * @param dirs
	 * @return
	 */
	private List<SysResource> buildListToTree(List<SysResource> dirs) throws Exception{
		List<SysResource> returnList = new ArrayList<SysResource>();
		List<SysResource> roots = findRoots(dirs);
		for (SysResource resource : roots) {
			resource.setChildren(findChildren(resource, dirs));
			returnList.add(resource);
		}
		return returnList;
	}
	/**
	 * 查找一级菜单
	 * 
	 * @param allNodes
	 * @return
	 */
	public List<SysResource> findRoots(List<SysResource> allNodes) throws Exception{
		List<SysResource> results = new ArrayList<SysResource>();
		for (SysResource node : allNodes) {
			if (node.getParentId() == null || node.getParentId().equals("0")) {
				results.add(node);
			}
		}
		allNodes.removeAll(results);
		return results;
	}
	/**
	 * 查找子菜单
	 * 
	 * @param root
	 * @param allNodes
	 * @return
	 */
	private List<SysResource> findChildren(SysResource root, List<SysResource> allNodes) throws Exception{
		List<SysResource> children = new ArrayList<SysResource>();
		for (SysResource comparedOne : allNodes) {
			if (comparedOne.getParentId().equals(root.getResourceId())) {
				children.add(comparedOne);
			}
		}
		allNodes.removeAll(children);
		for (SysResource child : children) {
			List<SysResource> tmpChildren = findChildren(child, allNodes);
			child.setChildren(tmpChildren);
		}
		return children;
	}
	
	
	/** 
     * 反向递归
     * 获取某个子节点上面的所有父节点 
     * @param menuList 
     * @param pid 
     * @return 
     */  
    public static List<SysResource> recursiveAbove( List<SysResource> resourceList, String id, List<SysResource> returnList){  
        for(SysResource resource: resourceList){  
            //遍历出父id等于参数的id，add进父节点集合  
            if(resource.getResourceId().equals(id)){  
                //递归遍历上一级  
            	recursiveAbove(resourceList,resource.getParentId(),returnList);  
                returnList.add(resource);  
            }  
        }  
    return returnList;  
    }  
	
    public static List<SysResource> recursiveAboveList(List<SysResource> allResourceList, List<String> resourceIdList){
    	List<SysResource> parentNode = new ArrayList<SysResource>();
    	//遍历出父id等于参数的id，add进父节点集合  
        for(String id : resourceIdList){
        	parentNode = recursiveAbove(allResourceList, id, parentNode);
        }
        return parentNode;
    }

    
    /** 
     * 递归查询
     * 获取某个父节点下面的所有子节点 
     * @param menuList 
     * @param pid 
     * @return 
     */  
    public static List<String> recursiveBelow( List<SysResource> resourceList, String pid , List<String> returnList){  
        for(SysResource resource: resourceList){  
            //遍历出父id等于参数的id，add进子节点集合  
        	if(resource.getParentId() != null){
        		if(resource.getParentId().equals(pid)){  
        			//递归遍历下一级  
        			returnList.add(resource.getResourceId() );
        			recursiveBelow(resourceList, resource.getResourceId(),returnList );  
        			
        		}  
        	}
        }  
    return returnList;  
    }  
    
    public static List<String> recursiveBelowList(List<SysResource> resourceList, List<String> pidList){
    	List<String> childNode = new ArrayList<String>();
        //遍历出父id等于参数的id，add进子节点集合  
        for(String pid : pidList){
        	childNode = recursiveBelow(resourceList, pid, childNode);
        }
        childNode.addAll(pidList);
        return childNode;
    }
}
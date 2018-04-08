package com.taiji.user.service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Service;
import com.taiji.core.base.service.BaseServiceImpl;
import com.taiji.core.utils.BeanUtils;
import com.taiji.core.utils.PageInfo;
import com.taiji.user.model.SysDictionary;
import com.taiji.user.model.SysOrgan;
import com.taiji.user.model.SysOrgan;
import com.taiji.user.model.SysUser;
import com.taiji.user.repository.SysOrganPuriewRepository;
import com.taiji.user.repository.SysOrganRepository;
import com.taiji.user.repository.SysUserOrganRepository;

import ch.qos.logback.core.joran.util.beans.BeanUtil;


@Service
public class SysOrganServiceImpl extends BaseServiceImpl<SysOrgan, String> implements SysOrganService {
	@Autowired
	SysOrganRepository sysOrganRepository;
	
	@Autowired
	SysOrganPuriewRepository sysOrganPuriewRepositoryRepository;
	
	@Autowired
	SysUserOrganRepository sysUserOrganRepository;
	
	public List<String> selectIdList(String organId) throws Exception{
		return recursiveBelowList(sysOrganRepository.findAll(),Arrays.asList(organId));
//		return sysOrganRepository.selectIdList(organId);
	}
	@Override
	public List<Map<String, Object>> selectTree() throws Exception{
		List<SysOrgan> organs = sysOrganRepository.findAll();
		return buildListToTree(organs);
	}
	/**
	 * 构建菜单
	 * 
	 * @param dirs
	 * @return
	 */
	private List<Map<String, Object>> buildListToTree(List<SysOrgan> list) throws Exception{
		List<Map<String, Object>> treelist = new ArrayList<Map<String, Object>>();
		for(int i=0;i<list.size();i++){
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("id", list.get(i).getOrganId());
			map.put("pid", list.get(i).getParentId());
			map.put("name", list.get(i).getOrganName());
			treelist.add(map);
		}
		return treelist;
	}
	@Override
	public String selectByCode(String parentId) throws Exception{
		return sysOrganRepository.selectByCode(parentId);
	}
	
	@Override
	public SysOrgan updateSelective(SysOrgan entity) throws Exception {
		SysOrgan sysOrgan = null;
		if(entity.getOrganId() != null){
			sysOrgan = sysOrganRepository.findByOrganId(entity.getOrganId());
			BeanUtils.copyPropertiesIgnoreNull(entity,sysOrgan);
			return super.update(sysOrgan);
		}
		return sysOrgan;
	}
	
	/** 
     * 反向递归
     * 获取某个子节点上面的所有父节点 
     * @param menuList 
     * @param pid 
     * @return 
     */  
    public static List<SysOrgan> recursiveAbove( List<SysOrgan> organList, String id, List<SysOrgan> returnList){  
        for(SysOrgan organ: organList){  
            //遍历出父id等于参数的id，add进父节点集合  
            if(organ.getOrganId().equals(id)){  
                //递归遍历上一级  
            	recursiveAbove(organList,organ.getParentId(),returnList);  
                returnList.add(organ);  
            }  
        }  
    return returnList;  
    }  
	
    public static List<SysOrgan> recursiveAboveList(List<SysOrgan> allResourceList, List<String> organIdList){
    	List<SysOrgan> parentNode = new ArrayList<SysOrgan>();
    	//遍历出父id等于参数的id，add进父节点集合  
        for(String id : organIdList){
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
    public static List<String> recursiveBelow( List<SysOrgan> organList, String pid , List<String> returnList){  
        for(SysOrgan organ: organList){  
            //遍历出父id等于参数的id，add进子节点集合  
        	if(organ.getParentId() != null){
        		if(organ.getParentId().equals(pid)){  
        			//递归遍历下一级  
        			returnList.add(organ.getOrganId() );
        			recursiveBelow(organList, organ.getOrganId(),returnList );  
        			
        		}  
        	}
        }  
    return returnList;  
    }  
    
    public static List<String> recursiveBelowList(List<SysOrgan> organList, List<String> pidList){
    	List<String> childNode = new ArrayList<String>();
        //遍历出父id等于参数的id，add进子节点集合  
        for(String pid : pidList){
        	childNode = recursiveBelow(organList, pid, childNode);
        }
        childNode.addAll(pidList);
        return childNode;
    }
    @Override
	public int deleteById(String id) throws Exception{
		int k = 0;
		List<String> delOrganList = recursiveBelowList(sysOrganRepository.findAll(),Arrays.asList(id));
		if (delOrganList.size()!=0) {
			k += sysOrganPuriewRepositoryRepository.deleteInOrgan(delOrganList);
			k += sysUserOrganRepository.deleteInOrgan(delOrganList);
			k += sysOrganRepository.deleteInId(delOrganList);
		}
		return k;
	}
}

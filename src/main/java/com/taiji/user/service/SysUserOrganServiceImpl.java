package com.taiji.user.service;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.taiji.core.utils.BeanUtils;
import com.taiji.user.model.SysOrgan;
import com.taiji.user.model.SysUserOrgan;
import com.taiji.user.repository.SysOrganRepository;
import com.taiji.user.repository.SysUserOrganRepository;
import com.taiji.user.service.SysUserOrganService;

@Service
public class SysUserOrganServiceImpl implements SysUserOrganService {

	@Autowired
	private SysUserOrganRepository sysUserOrganMapper;
	@Autowired
	private SysOrganRepository sysOrganMapper;

	@Override
	public List<String> selectOrganIdListByUserId(String userId) throws Exception{
		return  sysUserOrganMapper.selectOrganIdListByUserId(userId);
	}

	@Override
	public List<String> selectRecursiveBelowOrganIdListByUserId(String userId) throws Exception {
		List<String> organList = sysUserOrganMapper.selectOrganIdListByUserId(userId);
		return recursiveBelowList(sysOrganMapper.findAll(),organList);
	}

	@Override
	public int deleteByUser(String userId) throws Exception {
		return sysUserOrganMapper.deleteByUserId(userId);
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
        HashSet<String> tmpSet = new HashSet<>(childNode);
        childNode.clear();
        childNode.addAll(tmpSet);
        return childNode;
    }
}
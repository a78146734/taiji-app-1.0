package com.taiji.user.service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.taiji.core.base.service.BaseServiceImpl;
import com.taiji.core.utils.BeanUtils;
import com.taiji.user.model.SysDictionary;
import com.taiji.user.model.SysDictionaryData;
import com.taiji.user.model.SysPuriewResource;
import com.taiji.user.model.SysResource;
import com.taiji.user.repository.SysDictionaryDataRepository;
import com.taiji.user.repository.SysPuriewResourceRepository;
import com.taiji.user.service.SysPuriewResourcerService;

@Service
public class SysDictionaryDataServiceImpl extends BaseServiceImpl<SysDictionaryData, String>  implements SysDictionaryDataService {

	@Autowired
	private SysDictionaryDataRepository sysDictionaryDataRepository;

	 

	@Override
	public List<SysDictionaryData> findByNodeId(String nodeId)  throws Exception{
		return sysDictionaryDataRepository.findByNodeId(nodeId);
	}

	@Override
	public SysDictionaryData findByDictionaryDataId(String dictionaryDataId) throws Exception {
		return sysDictionaryDataRepository.findByDictionaryDataId(dictionaryDataId);
	}

	@Override
	public SysDictionaryData updateSelective(SysDictionaryData entity) throws Exception {
		SysDictionaryData sysDictionaryData = null;
		if(entity.getDictionaryDataId() != null){
			sysDictionaryData = sysDictionaryDataRepository.findByDictionaryDataId(entity.getDictionaryDataId());
			BeanUtils.copyPropertiesIgnoreNull(entity,sysDictionaryData);
			return super.update(sysDictionaryData);
		}
		return sysDictionaryData;
	}
	
	@Override
	public void deleteByDictionaryId(String dictionaryId) throws Exception {
		sysDictionaryDataRepository.deleteByDictionaryId(dictionaryId);
	}
	@Override
	public void deleteByDictionaryDataId(String dictionaryDataId) throws Exception {
		sysDictionaryDataRepository.deleteByDictionaryDataId(dictionaryDataId);
	}

	@Override
	public String findParam1ById(String id) {
		return sysDictionaryDataRepository.findParam1ById(id);
	}

	
	
}
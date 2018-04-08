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
import com.taiji.user.repository.SysDictionaryRepository;
import com.taiji.user.repository.SysPuriewResourceRepository;
import com.taiji.user.service.SysPuriewResourcerService;

@Service
public class SysDictionaryServiceImpl extends BaseServiceImpl<SysDictionary, String>  implements SysDictionaryService {

	@Autowired
	private SysDictionaryRepository sysDictionaryRepository;
	@Autowired
	private SysDictionaryDataRepository sysDictionaryDataRepository;

	@Override
	public SysDictionary findByDictionaryId(String dictionaryId) throws Exception {
		return sysDictionaryRepository.findByDictionaryId(dictionaryId);
	}

	@Override
	public List<SysDictionary> findByNodeId(String nodeId) throws Exception {
		return sysDictionaryRepository.findByNodeId(nodeId);
	}

	@Override
	public SysDictionary updateSelective(SysDictionary entity) throws Exception {
		SysDictionary sysDictionary = null;
		if(entity.getDictionaryId() != null){
			sysDictionary = sysDictionaryRepository.findByDictionaryId(entity.getDictionaryId());
			BeanUtils.copyPropertiesIgnoreNull(entity,sysDictionary);
			return super.update(sysDictionary);
		}
		return sysDictionary;
	}

	@Override
	public void deleteByDictionaryId(String dictionaryId) throws Exception {
		sysDictionaryDataRepository.deleteByDictionaryId(dictionaryId);
		sysDictionaryRepository.deleteByDictionaryId(dictionaryId);
	}
}
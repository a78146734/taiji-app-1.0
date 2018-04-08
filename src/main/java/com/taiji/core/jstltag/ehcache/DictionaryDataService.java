package com.taiji.core.jstltag.ehcache;

import java.util.List;

import com.taiji.user.model.SysDictionaryData;

public interface DictionaryDataService {
	public void reloadDicHtml() ;
	public void reloadDicEscape();
	public void reloadDicEscape(String dicDataId);
	public String getDicEscape(String dicDataId);
	public List<SysDictionaryData> getDictionaryDataByNodeId(String nodeId) ;
	public String getDicHtml(String nodeId, String type, String name);
	
}

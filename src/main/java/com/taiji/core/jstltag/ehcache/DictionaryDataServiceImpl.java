package com.taiji.core.jstltag.ehcache;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import com.google.gson.JsonObject;
import com.taiji.user.model.SysDictionaryData;
import com.taiji.user.repository.SysDictionaryDataRepository;
import com.taiji.user.service.SysDictionaryDataService;

@Service
public class DictionaryDataServiceImpl implements DictionaryDataService{


//	@Autowired
//	private ISysDictionaryDataService dictionaryDataService;
	@Autowired
	private SysDictionaryDataService dictionaryDataService;

	@CacheEvict(value = "dicHtml", allEntries = true)
	public void reloadDicHtml() {
	}

//	@CacheEvict(value = "dicHtml", key = "#dicId")
//	public void reloadDicHtml(Long dicId) {
//		System.err.println("清除\t" + dicId);
//	}

	@CacheEvict(value = { "dicEscape" }, allEntries = true)
	public void reloadDicEscape() {

	}

	@CacheEvict(value = { "dicEscape" }, key = "#dicDataId")
	public void reloadDicEscape(String dicDataId) {

	}

	@Cacheable(value = "dicEscape", key = "#dicDataId")
	public String getDicEscape(String dicDataId) {
		SysDictionaryData data = null;
		try {
			data = dictionaryDataService.findByDictionaryDataId(dicDataId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		if (data == null) {
			return "id不存在";
		} else {
			return data.getDictionaryDataName();
		}
	}

	public List<SysDictionaryData> getDictionaryDataByNodeId(String nodeId) {
		List<SysDictionaryData> datas = null;
		datas=new ArrayList<SysDictionaryData>();
		try {
			datas = dictionaryDataService.findByNodeId(nodeId);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return datas;
	}

	/**
	 * 查询
	 * 
	 * @param nodeId
	 *            字典标识符
	 * @param type
	 *            类型
	 * @param name
	 *            控件名称
	 * @param value
	 * @return
	 */
	@Cacheable(value = "dicHtml", key = "#nodeId+#type+#name")
	public String getDicHtml(String nodeId, String type, String name) {
		System.err.println("缓存\t" + nodeId);
		List<SysDictionaryData> datas = getDictionaryDataByNodeId(nodeId);
		if (type.equals("select")) {
			
			return dealToSelect(datas, name);
			
		}else if(type.equals("selectJson")){
			
			return dealToSelectJson(datas, name);
			
		} else if (type.equals("checkbox")) {
			
			return dealToCheckbox(datas, name);
			
		} else if(type.equals("redio")){
			
			return dealToRedio(datas, name);
					
		}else if (type.equals("json")) {
			
			return dealToJson(datas, name);
			
		}else if(type.equals("jsonByParam1")){
			return dealToJsonByParam1(datas, name);
		}else if(type.equals("selectByParam1")){
			return dealToSelectByParam1(datas, name);
		}
		return "类型type错误";
	}
	
	/**
	 * 将字典数据处理为select标签
	 * @param datas
	 * @param name
	 * @return
	 */
	public String dealToSelect(List<SysDictionaryData> datas,String name){
		StringBuffer buffer = new StringBuffer();
		buffer.append("<select name=\"");
		buffer.append(name);
		buffer.append("\" id=\"");
		buffer.append(name);
		buffer.append("\" class=\"input\">");
		buffer.append("<option value=\"\">--请选择--</option>");
		for (SysDictionaryData sysDictionaryData : datas) {
			buffer.append("<option value=\"");
			buffer.append(sysDictionaryData.getDictionaryDataId());
			buffer.append("\">");
			buffer.append(sysDictionaryData.getDictionaryDataName());
			buffer.append("</option>");
		}
		buffer.append("</select>");
		String html = buffer.toString();
		buffer = null;
		return html;
	}
	/**
	 * 将字典数据处理为select标签value为param1
	 * @param datas
	 * @param name
	 * @return
	 */
	public String dealToSelectByParam1(List<SysDictionaryData> datas,String name){
		StringBuffer buffer = new StringBuffer();
		buffer.append("<select name=\"");
		buffer.append(name);
		buffer.append("\" id=\"");
		buffer.append(name);
		buffer.append("\" class=\"input\">");
		buffer.append("<option value=\"\">--请选择--</option>");
		for (SysDictionaryData sysDictionaryData : datas) {
			buffer.append("<option value=\"");
			buffer.append(sysDictionaryData.getParameter1());
			buffer.append("\">");
			buffer.append(sysDictionaryData.getDictionaryDataName());
			buffer.append("</option>");
		}
		buffer.append("</select>");
		String html = buffer.toString();
		buffer = null;
		return html;
	}
	
	/**
	 * 将字典数据处理为select json
	 * @param datas
	 * @param name
	 * @return
	 */
	public String dealToSelectJson(List<SysDictionaryData> datas,String name){
		StringBuffer buffer = new StringBuffer();
	
		for (SysDictionaryData sysDictionaryData : datas) {
			buffer.append("<option value=\"");
			buffer.append(sysDictionaryData.getDictionaryDataId());
			buffer.append("\">");
			buffer.append(sysDictionaryData.getDictionaryDataName());
			buffer.append("</option>");
		}
		
		JsonObject jsonObject = new JsonObject();
		String html = buffer.toString();
		jsonObject.addProperty("", html);
		
		buffer = null;
		return jsonObject.toString();
	}
	/**
	 * 将字典数据处理为checkbox标签
	 * @param datas
	 * @param name
	 * @return
	 */
	public String dealToCheckbox(List<SysDictionaryData> datas,String name){
		StringBuffer buffer = new StringBuffer();
		for (SysDictionaryData sysDictionaryData : datas) {
			buffer.append("<input type=\"checkbox\" name=\"");
			buffer.append(name);
			buffer.append("\" id=\"");
			buffer.append(sysDictionaryData.getDictionaryDataId());
			buffer.append("\" value=\"");
			buffer.append(sysDictionaryData.getDictionaryDataId());
			buffer.append("\">");
			buffer.append("<label for=\"");
			buffer.append(sysDictionaryData.getDictionaryDataId());
			buffer.append("\">");
			buffer.append(sysDictionaryData.getDictionaryDataName());
			buffer.append("</label>");
		}
		String html = buffer.toString();
		buffer = null;
		return html;
	}
	
	
	public String dealToRedio(List<SysDictionaryData> datas,String name){
		StringBuffer buffer = new StringBuffer();
		for (SysDictionaryData sysDictionaryData : datas) {
			buffer.append("<input type=\"redio\" name=\"");
			buffer.append(name);
			buffer.append("\" id=\"");
			buffer.append(sysDictionaryData.getDictionaryDataId());
			buffer.append("\" value=\"");
			buffer.append(sysDictionaryData.getDictionaryDataId());
			buffer.append("\">");
			buffer.append("<label for=\"");
			buffer.append(sysDictionaryData.getDictionaryDataId());
			buffer.append("\">");
			buffer.append(sysDictionaryData.getDictionaryDataName());
			buffer.append("</label>");
		}
		String html = buffer.toString();
		buffer = null;
		return html;
	}
	
	
	/**
	 * 将字典数据处理成json数据
	 * @param datas
	 * @param name
	 * @return
	 */
	public String dealToJson(List<SysDictionaryData> datas,String name){
		JsonObject jsonObject = new JsonObject();
		for (SysDictionaryData sysDictionaryData : datas) {
			jsonObject.addProperty(String.valueOf(sysDictionaryData.getDictionaryDataId()),
					sysDictionaryData.getDictionaryDataName());
		}
		return jsonObject.toString();
	}
	/**
	 * 根据param1将字典数据处理成json数据
	 * @param datas
	 * @param name
	 * @return
	 */
	public String dealToJsonByParam1(List<SysDictionaryData> datas,String name){
		JsonObject jsonObject = new JsonObject();
		for (SysDictionaryData sysDictionaryData : datas) {
			jsonObject.addProperty(String.valueOf(sysDictionaryData.getParameter1()),
					sysDictionaryData.getDictionaryDataName());
		}
		return jsonObject.toString();
	}
}

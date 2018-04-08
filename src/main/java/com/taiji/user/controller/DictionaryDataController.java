package com.taiji.user.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.taiji.core.base.controller.BaseController;
import com.taiji.core.base.result.Result;
import com.taiji.core.config.spring.SpringContextHolder;
import com.taiji.core.jstltag.ehcache.DictionaryDataService;
import com.taiji.core.utils.PageInfo;
import com.taiji.user.model.SysDictionary;
import com.taiji.user.model.SysDictionaryData;
import com.taiji.user.service.SysDictionaryDataService;
import com.taiji.user.service.SysDictionaryService;

/**
 * @description：字典数据管理
 * @author：admin @date：2015/10/1 14:51
 */
@Controller
@RequestMapping("/dictionaryData")
public class DictionaryDataController extends BaseController {
	// private static final Logger LOGGER =
	// LogManager.getLogger(DictionaryDataController.class);
	@Autowired
	private SysDictionaryService dictionaryService;
	@Autowired
	private SysDictionaryDataService dictionaryDataService;

	@Autowired
	private static DictionaryDataService dictionaryData;
	/**
	 * 部门管理主页
	 *
	 * @return
	 */
	@GetMapping(value = "/manager")
	public String manager(@RequestParam(required = false) String id, HttpServletRequest request) {
		if (id != null) {
			request.setAttribute("id", id);
		}
		return "admin/dictionaryData";
	}
	@PostMapping("/dataGrid")
//	@SerializedFields({ @SerializedField(resultClass = SysUser.class, excludes = {  }) })
	public @ResponseBody Result dataGrid(@RequestBody PageInfo<SysDictionaryData> pageInfo) {
		pageInfo = dictionaryDataService.findPage(pageInfo);
		return renderSuccess(pageInfo);
	}

	@RequestMapping("/addPage")
	public String addPage(@RequestParam(required = false) String id, HttpServletRequest request) {
		try {
			if (id != null) {
			SysDictionary dictionary;
			
				dictionary = dictionaryService.findByDictionaryId(id);
			
			request.setAttribute("dictionaryName", dictionary.getNodeName());
			request.setAttribute("dictionaryId", dictionary.getDictionaryId());
		} else {
			List<SysDictionary> dictionaries = dictionaryService.findAll();
			request.setAttribute("dictionaries", dictionaries);
		}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "admin/dictionaryDataAdd";
	}

	@PostMapping("/add")
	@ResponseBody
	public Object add(SysDictionaryData sysDictionaryData) {
		sysDictionaryData.setFounder(getStaffName());
		sysDictionaryData.setCreateTime(new Date());
		try {
			dictionaryDataService.save(sysDictionaryData);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		DictionaryDataService	dictionaryData = (DictionaryDataService) SpringContextHolder.getBean(DictionaryDataService.class);
		dictionaryData.reloadDicHtml();
		return renderSuccess("添加成功！");
	}

	/**
	 * 编辑用户页
	 *
	 * @param id
	 * @param model
	 * @return
	 */
	@GetMapping("/editPage")
	public String editPage(String id, HttpServletRequest request) {
		SysDictionary dictionary;
		try {
			SysDictionaryData dictionaryData = dictionaryDataService.findByDictionaryDataId(id);
			dictionary = dictionaryService.findByDictionaryId(dictionaryData.getDictionaryId());
			request.setAttribute("dictionaryName", dictionary.getNodeName());
			request.setAttribute("dictionaryData", dictionaryData);
			request.setAttribute("dictionaryId", dictionaryData.getDictionaryId());
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "admin/dictionaryDataEdit";
	}

	/**
	 * 编辑用户
	 *
	 * @param userVo
	 * @return
	 */
	@RequestMapping("/edit")
	@ResponseBody
	public Object edit(SysDictionaryData dictionary) {
		try {
			dictionaryDataService.updateSelective(dictionary);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		DictionaryDataService dictionaryData = (DictionaryDataService) SpringContextHolder.getBean(DictionaryDataService.class);
		dictionaryData.reloadDicHtml();
		dictionaryData.reloadDicEscape(dictionary.getDictionaryDataId());
		return renderSuccess("修改成功！");
	}

	/**
	 * 删除用户
	 *
	 * @param id
	 * @return
	 */
	@RequestMapping("/delete")
	@ResponseBody
	public Object delete(String id) {
		DictionaryDataService dictionaryData = (DictionaryDataService) SpringContextHolder.getBean(DictionaryDataService.class);
		dictionaryData.reloadDicHtml();
		try {
			dictionaryDataService.deleteByDictionaryDataId(id);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return renderSuccess("删除成功！");
	}
	
	
	/**
	 * 查询是否存在
	 */
	@PostMapping("/existCheck")
	@ResponseBody
	public Object existCheck(SysDictionaryData sysDictionaryData) {
		sysDictionaryData.setFounder(getStaffName());
		sysDictionaryData.setCreateTime(new Date());
		try {
			SysDictionaryData sysDictionaryDataNew=new SysDictionaryData();
			sysDictionaryDataNew.setDictionaryId(sysDictionaryData.getDictionaryId());
			dictionaryDataService.save(sysDictionaryDataNew);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		DictionaryDataService	dictionaryData = (DictionaryDataService) SpringContextHolder.getBean(DictionaryDataService.class);
		dictionaryData.reloadDicHtml();
		return renderSuccess("添加成功！");
	}
	
	/**
	 * 根据nodeId查询
	 * @return Json String {param1:name}
	 */
	@PostMapping("/selectDicByNodeId")
	@ResponseBody
	public Object selectDicByNodeId(String nodeId) {
		String jsonString = dictionaryData.getDicHtml(nodeId, "jsonByParam1","");
		System.out.println("jsonString: "+jsonString);
		return jsonString;
	}
}

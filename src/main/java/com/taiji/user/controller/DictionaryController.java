package com.taiji.user.controller;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.taiji.core.annotations.SerializedField;
import com.taiji.core.annotations.SerializedFields;
import com.taiji.core.base.controller.BaseController;
import com.taiji.core.base.result.Result;
import com.taiji.core.utils.PageInfo;
import com.taiji.user.model.SysDictionary;
import com.taiji.user.model.SysUser;
import com.taiji.user.service.SysDictionaryService;

/**
 * @description：字典表管理
 * @author：admin @date：2015/10/1 14:51
 */
@Controller
@RequestMapping("/dictionary")
public class DictionaryController extends BaseController {
	
	private static final Logger LOGGER = LogManager.getLogger(DictionaryController.class);
	@Autowired
	private SysDictionaryService dictionaryService;

	/**
	 * 部门管理主页
	 *
	 * @return
	 */
	@GetMapping(value = "/manager")
	public String manager() {
		return "admin/dictionary";
	}
	
	@PostMapping("/dataGrid")
//	@SerializedFields({ @SerializedField(resultClass = SysUser.class, excludes = {  }) })
	public @ResponseBody Result dataGrid(@RequestBody PageInfo<SysDictionary> pageInfo) {
		pageInfo = dictionaryService.findPage(pageInfo);
		return renderSuccess(pageInfo);
	}

	@RequestMapping("/addPage")
	public String addPage(String name, String address, String icon, Long pid, Long seq) {
		return "admin/dictionaryAdd";
	}
	
//	@RequiresPermissions(value = { "dictionary/add" })
	@PostMapping("/add")
	@ResponseBody
	public Object add(String nodeNames, SysDictionary dictionary,HttpServletRequest request) {
//		LOG.info(LOGGER, request, "数据字典-新建字典信息:"+nodeNames);
		dictionary.setNodeName(nodeNames);
		dictionary.setFounder(getStaffName());
		dictionary.setCreateTime(new Date());
		try {
			dictionaryService.save(dictionary);
		} catch (Exception e) {
//			LOG.error(LOGGER, request, "操作失败！：数据字典-新建字典信息:"+nodeNames+"("+e+")");
			e.printStackTrace();
		}
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
//		LOG.info(LOGGER, request, "数据字典-编辑页面查询:"+id);
		SysDictionary dictionary = null;
		try {
			dictionary = dictionaryService.findByDictionaryId(id);
		} catch (Exception e) {
//			LOG.error(LOGGER, request, "操作失败！：数据字典-编辑页面查询:"+id+"("+e+")");
			e.printStackTrace();
		}
		request.setAttribute("dictionary", dictionary);
		return "admin/dictionaryEdit";
	}

	/**
	 * 编辑用户
	 *
	 * @param userVo
	 * @return
	 */
//	@RequiresPermissions(value = { "dictionary/edit" })
	@RequestMapping("/edit")
	@ResponseBody
	public Object edit(String nodeNames, SysDictionary dictionary,HttpServletRequest request) {
//		LOG.info(LOGGER, request, "数据字典-修改信息:"+nodeNames+":"+dictionary.getDictionaryId());
		dictionary.setNodeName(nodeNames);
		try {
			dictionaryService.updateSelective(dictionary);
		} catch (Exception e) {
			// TODO Auto-generated catch block
//			LOG.error(LOGGER, request, "操作失败！：数据字典-修改信息:"+nodeNames+":"+dictionary.getDictionaryId()+"("+e+")");
			e.printStackTrace();
		}
		return renderSuccess("修改成功！");
	}

	/**
	 * 删除用户
	 *
	 * @param id
	 * @return
	 */
	@RequiresPermissions(value = { "dictionary/delete" })
	@RequestMapping("/delete")
	@ResponseBody
	public Object delete(String id,Integer isnowpage,HttpServletRequest request) {
//		LOG.info(LOGGER, request, "数据字典-删除字典信息:"+id);
		Map<String,Object> map = new HashMap<String,Object>();
		try {
			dictionaryService.deleteByDictionaryId(id);
			
			map.put("msg", "删除成功！");
			map.put("isnowpage", isnowpage);
		} catch (Exception e) {
//			LOG.error(LOGGER, request, "数据字典-删除字典信息:"+id+"("+e+")");
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return renderSuccess(map);
	}
	
	
	/**
	 * 查询是否存在
	 */
	@PostMapping("/existCheck")
	@ResponseBody
	public Object existCheck(String nodeId) {
		boolean  boo=true;
		List<SysDictionary> sysDictionaryList=null;
		try {
			sysDictionaryList=dictionaryService.findByNodeId(nodeId);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if (sysDictionaryList.size()>0) {
			boo=true;
		} else {
			boo=false;
		}
		return boo;
	}
	
//	@RequiresPermissions(value = { "dictionary/checkDetails" })
	@GetMapping("/selectByPrimaryKey")
	@ResponseBody
	public Object selectByPrimaryKey(String id,HttpServletRequest request){
//		LOG.info(LOGGER, request, "数据字典-查询字典信息:"+id);
		SysDictionary sysDictionary = null;
		try {
			sysDictionary = dictionaryService.findByDictionaryId(id);
		} catch (Exception e) {
//			LOG.error(LOGGER, request, "数据字典-查询字典信息:"+id+"("+e+")");
			e.printStackTrace();
		}
		return renderSuccess(sysDictionary);
	}
}

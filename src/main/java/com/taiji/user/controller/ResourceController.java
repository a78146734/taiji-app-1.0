package com.taiji.user.controller;
import java.util.ArrayList;
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
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.taiji.core.base.controller.BaseController;
import com.taiji.core.base.result.Result;
import com.taiji.core.shiro.ShiroUser;
import com.taiji.core.utils.BeanUtils;
import com.taiji.core.utils.PageInfo;
import com.taiji.core.utils.PageInfo.Retrieval;
import com.taiji.user.model.SysResource;
import com.taiji.user.model.SysUser;
import com.taiji.user.service.SysResourceService;

/**
 * @description：资源管理
 * @author：admin @date：2015/10/1 14:51
 */
@Controller
@RequestMapping("/resource")
public class ResourceController extends BaseController {

	private static final Logger LOGGER = LogManager.getLogger(ResourceController.class);
	@Autowired
	private SysResourceService resourceService;


	/**
	 * 菜单树
	 *
	 * @return
	 */
	@PostMapping("/tree")
	@ResponseBody
	public Object tree() {
		ShiroUser shiroUser = getShiroUser();
		try {
			return resourceService.selectTree(shiroUser);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

	@RequestMapping("/userMenu")
	@ResponseBody
	public Object selectUserMenu() {
		ShiroUser shiroUser = getShiroUser();
		try {
			return resourceService.selectUserMenu(shiroUser);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 资源管理列表
	 *
	 * @return
	 */
	@RequiresPermissions(value = {"/jsp/admin/resource.jsp","resource/treeGrid" },logical = Logical.OR)
	@PostMapping("/treeGrid")
	public @ResponseBody Result treeGrid(@RequestBody PageInfo<SysResource> pageInfo) {
		pageInfo = resourceService.findPage(pageInfo);
		return renderSuccess(pageInfo);
	}
	@PostMapping("/back")
	public @ResponseBody Result back(@RequestBody PageInfo<SysResource> pageInfo) {
		String resourceId = null;
		for(Retrieval retrieval: pageInfo.getRetrievals()){
			if(retrieval.getName().equals("parentId")){
				resourceId = retrieval.getValue();
			}
		}
		
		SysResource sysResource = new SysResource();
		sysResource = resourceService.find(resourceId); 
		for(Retrieval retrieval: pageInfo.getRetrievals()){
			if(retrieval.getName().equals("parentId")){
				retrieval.setValue(sysResource.getParentId().toString());
			}
		}
		pageInfo = resourceService.findPage(pageInfo);
		return renderSuccess(pageInfo);
	}
	
	@RequestMapping("/resourceIds")
	@ResponseBody
	public Object resourceIds(String puriewId) {
		List<String> puriewList = null;
		try {
			puriewList = resourceService.selectResourceIdListByPuriewId(puriewId);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return renderSuccess(puriewList);

	}
	
	/**
	 * 资源管理页
	 *
	 * @return
	 */
	@GetMapping("/manager")
	public String manager() {
		return "admin/resource";
	}
	
	@RequestMapping("/allTree")
	@ResponseBody
	public Object allTree() {
		try {
			return resourceService.selectAllToTree();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	//获取要展示的资源列表
	@RequestMapping("/getTreeByResourceIds")
	@ResponseBody
	public Object getTreeByResourceIds(String resourceIds) {
		try {
			return resourceService.getTreeByResourceIds(resourceIds);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	@RequestMapping("/treeByMenu")
	@ResponseBody
	public Object treeByMune() {
		try {
			return resourceService.selectMenuToTree();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 添加资源页
	 *
	 * @return
	 */
	@GetMapping("/addPage")
	public String addPage() {
		return "admin/resourceAdd";
	}
	/**
	 * 添加资源
	 *
	 * @param resource
	 * @return
	 */
	@RequiresPermissions(value = { "resource/add" })
	@RequestMapping("/add")
	@ResponseBody
	public Object add(String name, String url, String description, String icon, String pid, Long seq, String status,
			String resourceType,String pic,HttpServletRequest request) {
//		LOG.info(LOGGER, request, "资源管理-新建资源信息:"+name);
		if(pid == null || pid.equals("")){
			pid = "0";
		}
		Date date = new Date();
		SysResource resource = new SysResource();
		resource.setIcon(icon);
		resource.setResourceName(name);
		resource.setResourceUrl(url);
		resource.setDescribe(description);
		resource.setIcon(icon);
		resource.setParentId(pid);
		resource.setSeq(seq);
		resource.setFounder(getLoginName());
		resource.setCreateTime(date);
		resource.setSaveType(resourceType);
		resource.setUsingState(status);
		resource.setPic(pic);
		int i = 1;
		try {
			resourceService.insert(resource);
			if (i > 0) {
				return renderSuccess("操作成功！");
			} else {
				return renderError("操作失败！");
			}
		} catch (Exception e) {
//			LOG.error(LOGGER, request, "操作失败！：资源管理-新建资源信息:"+name+"("+e+")");
			e.printStackTrace();
			return renderError("操作失败！");
		}
	}
	
	/**
	 * 编辑资源页
	 *
	 * @param model
	 * @param id
	 * @return
	 */
	@RequestMapping("/editPage")
	public String editPage(Model model, String id) {
		SysResource resource = null;
		try {
			resource = resourceService.selectById(id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("resource", resource);
		return "admin/resourceEdit";
	}
	/**
	 * 编辑资源
	 *
	 * @param resource
	 * @return
	 */
	@RequiresPermissions(value = { "resource/edit" })
	@RequestMapping("/edit")
	@ResponseBody
	public Object edit(String name, String url, String description, String icon, String pid, Long seq, String status,
			String resourceType, String id,String pic,HttpServletRequest request) {
		ModelAndView modelAndView = new ModelAndView();
//		LOG.info(LOGGER, request, "资源管理-修改资源信息:"+name);
		if (id.equals(pid)) {
//			modelAndView.addObject("msg", "无法与本身建立关系！");
//			modelAndView.setViewName("admin/failure_gen_close");
			System.out.println("无法与本身建立关系！");
			return renderError("无法与本身建立关系！");
//			return modelAndView;
		}
		List<String> list = null;
		try {
			list = resourceService.selectRecursiveDownIdList(id);
//			list = BeanUtils.objectToLong(resourceService.selectRecursiveDownIdList(id));
		} catch (Exception e) {
//			LOG.info(LOGGER, request, "操作失败！：资源管理-修改资源信息:"+name+"("+e+")");
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		for (String long1 : list) {
			if (long1.equals(pid)) {
//				modelAndView.addObject("msg", "无法与子部门建立关系！");
//				modelAndView.setViewName("admin/failure_gen_close");
				System.out.println("无法与子部门建立关系！");
//				return modelAndView;
				return renderError("无法与子部门建立关系！");
			}
		}
		
		SysResource resource = new SysResource();
		resource.setResourceId(id);
		resource.setIcon(icon);
		resource.setResourceName(name);
		resource.setResourceUrl(url);
		resource.setDescribe(description);
		resource.setIcon(icon);
		resource.setParentId(pid);
		resource.setSeq(seq);
		resource.setSaveType(resourceType);
		resource.setUsingState(status);
		resource.setFounder(getLoginName());
		resource.setPic(pic);
		int i = 1;
		try {
			resourceService.updateRelate(resource);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return renderError("操作失败！");
		}
		if (i > 0) {
			return renderSuccess("操作成功！");
//			modelAndView.addObject("msg", "操作成功！");
//			modelAndView.setViewName("admin/success_gen_close");
		} else {
			return renderError("操作失败！");
//			modelAndView.addObject("msg", "操作失败！");
//			modelAndView.setViewName("admin/failure_gen_close");
		}
	}
	
	/**
	 * 删除资源
	 *
	 * @param id
	 * @return
	 */
	@RequiresPermissions(value = { "resource/delete" })
	@RequestMapping("/delete")
	@ResponseBody
	public Object delete(String id,HttpServletRequest request) {
//		LOG.info(LOGGER, request, "资源管理-删除资源信息:"+id);
		try {
			resourceService.deleteById(id);
		} catch (Exception e) {
			// TODO Auto-generated catch block
//			LOG.error(LOGGER, request, "操作失败！：资源管理-删除资源信息:"+id+"("+e+")");
			e.printStackTrace();
		}
		return renderSuccess("删除成功！");
	}
	
	@RequiresPermissions(value = { "resource/checkDetails" })
	@GetMapping("/selectByPrimaryKey")
	@ResponseBody
	public Object selectByPrimaryKey(String id,HttpServletRequest request){
//		LOG.info(LOGGER, request, "资源管理-查询资源信息:"+id);
		SysResource sysResource = null;
		try {
			sysResource = resourceService.selectById(id);
		} catch (Exception e) {
//			LOG.error(LOGGER, request, "操作失败！：资源管理-查询资源信息:"+id+"("+e+")");
			e.printStackTrace();
		}
		return renderSuccess(sysResource);
	}
	

}

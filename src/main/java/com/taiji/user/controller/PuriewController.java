package com.taiji.user.controller;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.taiji.core.base.controller.BaseController;
import com.taiji.core.base.result.Result;
import com.taiji.core.logback.LOG;
import com.taiji.core.utils.PageInfo;
import com.taiji.user.model.SysPuriew;
import com.taiji.user.model.SysUser;
import com.taiji.user.service.SysPuriewService;
import com.taiji.user.service.SysPuriewResourcerService;

/**
 * @description：权限管理
 * @author：admin @date：2015/10/1 14:51
 */
@Controller
@RequestMapping("/puriew")
public class PuriewController extends BaseController {
	private static final Logger LOGGER = LogManager.getLogger(PuriewController.class);
	@Autowired
	private SysPuriewService puriewService;

	@Autowired
	private SysPuriewResourcerService puriewResourcerService;

	/**
	 * 删除权限
	 *
	 * @param id
	 * @return
	 * @throws Exception
	 */
	@RequiresPermissions(value = { "puriew/delete" })
	@RequestMapping("/delete")
	@ResponseBody
	public Object delete(String id, HttpServletRequest request) throws Exception {
		int k = 0;
		k += puriewService.deleteById(id);
		return k > 0 ? renderSuccess("删除成功！") : renderError("删除失败！");
	}

	@RequestMapping("/grant")
	@ResponseBody
	public Object resourceGrant(String resourceIds, String id) throws Exception {
		puriewResourcerService.updateByPuriew(resourceIds, id, getStaffName());
		return renderSuccess("授权成功");
	}

	/**
	 * 权限管理主页
	 *
	 * @return
	 */
	@GetMapping(value = "/manager")
	public String manager() {
		return "admin/puriew";
	}

	@GetMapping("/grantPage")
	public String grantPage(String id, Model model) {
		model.addAttribute("id", id);
		return "admin/puriewGrant";
	}

	/**
	 * 部门列表
	 *
	 * @return
	 */
	@RequiresPermissions(value = { "/jsp/admin/puriew.jsp", "puriew/treeGrid" }, logical = Logical.OR)
	@RequestMapping("/treeGrid")
	public @ResponseBody Result treeGrid(@RequestBody PageInfo<SysPuriew> pageInfo) {
		pageInfo = puriewService.findPage(pageInfo);
		return renderSuccess(pageInfo);
	}

	/**
	 * 部门列表
	 *
	 * @return
	 */
	@RequiresPermissions(value = { "/jsp/admin/puriewMenu.jsp", "puriew/listMenuPurs" }, logical = Logical.OR)
	@RequestMapping("/listMenuPurs")
	public @ResponseBody Result listMenuPurs(@RequestBody PageInfo<SysPuriew> pageInfo) {
		pageInfo = puriewService.findPage(pageInfo);
		return renderSuccess(pageInfo);
	}

	/**
	 * 添加部门页
	 *
	 * @return
	 */
	@RequestMapping("/addPage")
	public String addPage() {
		return "admin/puriewAdd";
	}

	/**
	 * 添加部门
	 *
	 * @param organization
	 * @return
	 * @throws Exception 
	 */
	@RequiresPermissions(value = { "puriew/add" })
	@RequestMapping("/add")
	@ResponseBody
	public Object add(SysPuriew sysPuriew, HttpServletRequest request) throws Exception {
		sysPuriew.setFounder(getStaffName());
		sysPuriew.setCreateTime(new Date());
		sysPuriew.setUsingState("0");
		sysPuriew.setSaveType("0");
		int i = 0;
		i = puriewService.insert(sysPuriew);
		return i > 0 ? renderSuccess("添加成功！") : renderError("添加失败！");
	}

	/**
	 * 编辑部门页
	 *
	 * @param request
	 * @param id
	 * @return
	 * @throws Exception 
	 */
	@GetMapping("/editPage")
	public String editPage(HttpServletRequest request, String id) throws Exception {
		SysPuriew puriew = null;
		puriew = puriewService.selectById(id);
		request.setAttribute("puriew", puriew);
		return "admin/puriewEdit";
	}

	/**
	 * 编辑部门
	 *
	 * @param organization
	 * @return
	 * @throws Exception 
	 */
	@RequiresPermissions(value = { "puriew/edit" })
	@RequestMapping(value = "/edit")
	@ResponseBody
	/*
	 * results={
	 * 
	 * @Result(name = "success", location = "/utility/massages/success.jsp"),
	 * 
	 * @Result(name = "failure", location = "/utility/massages/failure.jsp") }
	 */
	public Object edit(SysPuriew sysPuriew, HttpServletRequest request) throws Exception {
		LOG.info(LOGGER, request, "权限管理-修改权限信息:" + sysPuriew.getPuriewName());
		int i = 0;
		i = puriewService.updateSysPuriew(sysPuriew);
		return i > 0 ? renderSuccess("添加成功！") : renderError("添加失败！");
	}

	@RequestMapping("/allPurTree")
	@ResponseBody
	public Object allPurTree() throws Exception {
		return puriewService.selectAllPurToTree();
	}

	@RequiresPermissions(value = { "puriew/checkDetails" })
	@GetMapping("/selectByPrimaryKey")
	@ResponseBody
	public Object selectByPrimaryKey(String id, HttpServletRequest request) throws Exception {
		SysPuriew sysPuriew = null;
		sysPuriew = puriewService.selectById(id);
		return renderSuccess(sysPuriew);
	}
}
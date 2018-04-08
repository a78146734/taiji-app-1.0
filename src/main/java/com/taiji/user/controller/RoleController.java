package com.taiji.user.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
import com.taiji.user.model.SysRole;
import com.taiji.user.model.SysUser;
import com.taiji.user.service.SysPuriewResourcerService;
import com.taiji.user.service.SysRolePuriewService;
import com.taiji.user.service.SysRoleService;
import com.taiji.user.service.SysUserService;
/**
 * @description：角色管理
 * @author：admin @date：2015/10/1 14:51
 */
@Controller
@RequestMapping("/role")
public class RoleController extends BaseController {
	@Autowired
	private SysRoleService roleService;
	@Autowired
	private SysPuriewResourcerService puriewResourcerService;
	@Autowired
	private SysRolePuriewService rolePuriewService;
	

	/**
	 * 角色管理列表
	 * 
	 * @return
	 */
	@PostMapping("/dataSelect")
	//@SerializedFields({ @SerializedField(resultClass = SysRole.class) })
	public @ResponseBody Result dataGrid(@RequestBody PageInfo<SysRole> pageInfo) {
		pageInfo = roleService.findPage(pageInfo);
		return renderSuccess(pageInfo);
	}



/**
 * 新增角色
 *
 * @return
 */
@GetMapping("/openAddPage")
public String openAddPage(Model model) {
	return "admin/roleAdd";
}
/**
 * 编辑权限页
 *
 * @param model
 * @param id
 * @return
 */
@RequestMapping("/editPage")
public String editPage(Model model, String id) {
	SysRole role = null;
	try {
		role = roleService.selectById(id);
	} catch (Exception e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	model.addAttribute("role", role);
	return "admin/roleEditOld";
}


/**
 * 将角色构建为树结构
 * anjl
 * 2017-5-18
 * @param
 * @return
 */
private List<Map<String, Object>> buildListToTree(List<SysRole> list) {
	List<Map<String, Object>> treelist = new ArrayList<Map<String, Object>>();
	for(int i=0;i<list.size();i++){
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", list.get(i).getRoleId());
		/*map.put("pid", list.get(i).getParentId());*/
		map.put("name", list.get(i).getRoleName());
		treelist.add(map);
	}

	return treelist;
}

/**
 * 添加权限页
 *
 * @return
 */
@GetMapping("/addPage")
public String addPage() {
	return "admin/roleAddOld";
}


@RequestMapping("/resourceIds")
@ResponseBody
public Object puriewIds(String roleId) {
	List<String> roleIds = new ArrayList<String>();
	roleIds.add(roleId);
	List<String> resourceList = null;
	try {
		resourceList = puriewResourcerService.selectResourceIdList(roleIds, Arrays.asList(""));
	} catch (Exception e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	return renderSuccess(resourceList);
}
@RequestMapping("/roIds")
@ResponseBody
public Object roIds(String roleId) {
	List<String> roleIds = new ArrayList<String>();
	roleIds.add(roleId);
	List<String> roList = null;
	try {
		roList = puriewResourcerService.selectResourceIdListByPuriewId(roleId);
	} catch (Exception e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	return renderSuccess(roList);
}
@RequestMapping("/purIds")
@ResponseBody
public Object purIds(String roleId) {
	List<String> roleIds = new ArrayList<String>();
	roleIds.add(roleId);
	List<String> purList = null;
	try {
		purList = rolePuriewService.selectPuriewIdListByRoleIds(roleIds);
	} catch (Exception e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	return renderSuccess(purList);
}

//@RequiresPermissions(value = { "role/grant" })
@RequestMapping("/grant")
@ResponseBody
public Object roleGrant(String resourceIds, String id,String purIds,HttpServletRequest request) {
	//LOG.info(LOGGER, request, "角色管理-修改角色信息"+id);
	try {
		rolePuriewService.updateByRole(resourceIds, id, purIds, getStaffName());
	} catch (Exception e) {
		// TODO Auto-generated catch block
	//	LOG.error(LOGGER, request, "操作失败！：角色管理-修改角色信息:"+id+"("+e+")");
		e.printStackTrace();
	}
	return renderSuccess("授权成功");
}

/**
 * 添加角色
 *
 * @param role
 * @return
 */
//@RequiresPermissions(value = { "role/add" })
@PostMapping("/add")
@ResponseBody
public Object add(String name, Long seq, String code, String description,HttpServletRequest request) {
	//LOG.info(LOGGER, request, "角色管理-新建角色:"+name);
	SysRole role = new SysRole();
	role.setCreateTime(new Date());
	role.setDescribe(description);
	role.setSeq(seq);
	role.setRoleName(name);
	role.setCode(code);
	role.setUsingState("0");
	role.setFounder(getStaffName());
	role.setSaveType("0");
	try {
		roleService.save(role);
	} catch (Exception e) {
		//LOG.error(LOGGER, request, "操作失败！：角色管理-新建角色信息:"+name+"("+e+")");
		e.printStackTrace();
		return renderError("添加失败");
	}
	return renderSuccess("添加成功！");
}

/**
 * 删除角色
 *
 * @param id
 * @return
 */
@RequiresPermissions(value = { "role/delete" })
@RequestMapping("/delete")
@ResponseBody
public Object delete(String id,HttpServletRequest request) {
	//LOG.info(LOGGER, request, "角色管理-删除角色信息:"+id);
	try {
		roleService.deleteById(id);
	} catch (Exception e) {
		//LOG.error(LOGGER, request, "操作失败！：角色管理-删除角色信息:"+id+"("+e+")");
		return renderError("删除失败");
	}
	return renderSuccess("删除成功！！");
}


@RequestMapping("/openEditPage")
public String openEditPage(Model model, String id) {
	SysRole role = null;
	try {
		role = roleService.selectById(id);
	} catch (Exception e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	model.addAttribute("role", role);
	return "admin/roleEdit";
}

/**
 * 删除权限
 *
 * @param role
 * @return
 */
//@RequiresPermissions(value = { "role/edit" })
@RequestMapping("/edit")
@ResponseBody
public Object edit(String id, String name, String code, Long seq, String description,HttpServletRequest request) {
	//LOG.info(LOGGER, request, "角色管理-修改角色信息:"+name+":"+id);
	SysRole role = new SysRole();
	role.setRoleId(id);
	role.setDescribe(description);
	role.setSeq(seq);
	role.setCode(code);
	role.setRoleName(name);
	role.setUsingState("0");
	try {
		roleService.updateRole(role);
	} catch (Exception e) {
		// TODO Auto-generated catch block
		//LOG.error(LOGGER, request, "操作失败！：角色管理-修改角色信息:"+name+":"+id+"("+e+")");
		e.printStackTrace();
	}
	return renderSuccess("编辑成功！");
}

/**
 * 授权页面
 *
 * @param id
 * @param model
 * @return
 */
@GetMapping("/grantPage")
public String grantPage(String id, Model model) {
	model.addAttribute("id", id);
	return "admin/roleGrant";
}
/**
 * 自定义授权页面
 * 
 * @param id
 * @param model
 * @return
 */
@GetMapping("/grantPagePersonal")
public String grantPagePersonal(String id, Model model) {
	model.addAttribute("id", id);
	return "admin/roleGrantPersonal";
}
/**
 * 授权页面
 *
 * @param id
 * @param model
 * @return
 */
@GetMapping("/grantPageOld")
public String grantPageOld(String id, Model model) {
	model.addAttribute("id", id);
	return "admin/roleGrantOld";
}

/**
 * 验证角色名称是否可用
 * @param roleName
 * @return
 */
@PostMapping("/judgeRoleName")
@ResponseBody
public Object judgeRoleName(String roleName) {
	SysRole role = null;
	try {
		role = roleService.selectRoleByRoleName(roleName);
	} catch (Exception e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	boolean b=false;
	if(role!=null){
		b=true;
	}
	return renderSuccess(b);
}

/**
 * 验证角标示称是否可用
 * @param roleName
 * @return
 */
@PostMapping("/judgeCode")
@ResponseBody
public Object judgeCode(String code) {
	SysRole role = null;
	try {
		role = roleService.selectRoleByCode(code);
	} catch (Exception e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	boolean b=false;
	if(role!=null){
		b=true;
	}
	return renderSuccess(b);
}

//@RequiresPermissions(value = { "role/checkDetails" })
@GetMapping("/selectByPrimaryKey")
@ResponseBody
public Object selectByPrimaryKey(String id,HttpServletRequest request){
	//LOG.info(LOGGER, request, "角色管理-查询角色信息:"+id);
	SysRole sysRole = null;
	try {
		sysRole = roleService.selectById(id);
	} catch (Exception e) {
		//LOG.error(LOGGER, request, "操作失败！：角色管理-查询角色信息:"+id+"("+e+")");
		e.printStackTrace();
	}
	return renderSuccess(sysRole);
}

/**
 * 角色树
 *
 * @return
 */
@PostMapping("/tree")
@ResponseBody
public Object tree() {
	try {
		return buildListToTree(roleService.selectAll());
	} catch (Exception e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	return null;
}
}


package com.taiji.user.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.taiji.core.annotations.SerializedField;
import com.taiji.core.annotations.SerializedFields;
import com.taiji.core.base.controller.BaseController;
import com.taiji.core.base.result.Result;
import com.taiji.core.utils.DesUtils;
import com.taiji.core.utils.PageInfo;
import com.taiji.core.utils.StringUtils;
import com.taiji.core.utils.PageInfo.Retrieval;
import com.taiji.user.model.SysUser;
import com.taiji.user.service.SysUserOrganService;
import com.taiji.user.service.SysUserRoleService;
import com.taiji.user.service.SysUserService;
import com.taiji.user.service.SysUserServiceImpl;

/**
 * @description：用户管理
 * @author：admin @date：2015/10/1 14:51
 */
@Controller
@RequestMapping("/user")
public class UserController extends BaseController {
	@Autowired
	private SysUserService userService;
	
	@Autowired
	private SysUserRoleService userRoleService;
	@Autowired
	private SysUserOrganService userOrganService;

	/**
	 * 用户管理列表
	 * 
	 * @return
	 */
	@PostMapping("/dataGrid")
	@SerializedFields({ @SerializedField(resultClass = SysUser.class, excludes = { "loginPassword", "sysUserRoles",
			"sysUserOrgans" }) })
	public @ResponseBody Result dataGrid(@RequestBody PageInfo<SysUser> pageInfo) {
		pageInfo = userService.findPage(pageInfo);
		return renderSuccess(pageInfo);
	}
	
	@GetMapping("/selectByPrimaryKey")
	@ResponseBody
	public Object selectByPrimaryKey(String id,HttpServletRequest request){
//		LOG.info(LOGGER, request, "用户管理-查询用户信息:"+id);
		SysUser sysUser = null;
		try {
				sysUser = userService.selectByUserId(id);
		} catch (Exception e) {
//			LOG.error(LOGGER, request, "操作失败！：用户管理-查询用户信息:"+id+"("+e+")");
			e.printStackTrace();
		}
		return renderSuccess(sysUser);
	}

	/**
	 * 编辑用户页
	 *
	 * @param id
	 * @param model
	 * @return
	 */
	@GetMapping("/editPage")
	public String editPage(String id, Model model) {
		SysUser sysUser = null;
		String workCode = "";
		String birthCode = "";
		try {
			sysUser = userService.selectByUserId(id);
			SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");  
			if(sysUser.getBirthDate()!=null){
				birthCode = sdf.format(sysUser.getBirthDate());  
			}
			
			if(sysUser.getWorkDate()!=null){
				workCode = sdf.format(sysUser.getWorkDate());
			}
			
			List<String> roleList = userRoleService.selectRoleIdListByUserId(sysUser.getUserId());
			List<String> organList = userOrganService.selectOrganIdListByUserId(sysUser.getUserId());
	//		toJson
			Gson  gson = new Gson();
			gson.toJson(roleList);
			model.addAttribute("roleIds", gson.toJson(roleList));
			model.addAttribute("organIds", gson.toJson(organList));
			model.addAttribute("user", sysUser);
			System.out.println(sysUser.getCertId()+"www");
			model.addAttribute("birthCode", birthCode);
			model.addAttribute("workCode", workCode);
			String certId=sysUser.getCertId();
			model.addAttribute("certId", certId);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "admin/userEdit";
	}
	
	/**
	 * 用户验证密码
	 *
	 * @return
	 */
	@PostMapping(value = "/checkPassword")
	@ResponseBody
	public Object checkPassword() {
		SysUser sysUser=null;
		try {
			sysUser=userService.selectByUserId(getUserId());
			sysUser.setLoginPassword(DesUtils.decrypt(sysUser.getLoginPassword(), DesUtils.KEY_XW));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return sysUser;
	}
	/**
	 * 用户修改密码
	 *
	 * @return
	 */
	@PostMapping(value = "/editPassword")
	@ResponseBody
	public Object editPassword(String newPassWord,String validatePassWord,HttpServletRequest request) {
		SysUser sysUser=new SysUser();
//		LOG.info(LOGGER, request, "用户管理-修改密码:"+sysUser.getLoginName());
		
		try {
			sysUser = userService.updateUserPassword(getUserId(), DesUtils.encrypt(newPassWord, DesUtils.KEY_XW));
		} catch (Exception e) {
			// TODO Auto-generated catch block
//			LOG.error(LOGGER, request, "操作失败！：用户管理-修改密码:"+sysUser.getLoginName()+"("+e+")");
			e.printStackTrace();
		}
		return sysUser;
	}
	/**
	 * 编辑用户
	 *
	 * @param userVo
	 * @return
	 * @throws Exception 
	 */
//	@RequiresPermissions(value = { "user/edit" })
	@RequestMapping("/edit")
	@ResponseBody
	public Object edit(String sex,String certId,String username, String userpassword, String loginName, String status, String userType, String id, Long isXw, String publicCode, String email,
			@RequestParam(required = false) List<String> roleIds, @RequestParam(required = false) List<String> organIds,long sort,String phone,HttpServletRequest request) throws Exception {
//		LOG.info(LOGGER, request, "用户管理-修改用户信息:"+username);
		List<SysUser> list = null;
		try {
			list = userService.selectByLoginNameOrUsername(loginName, username);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if(list.size()==0){
			renderError("修改的用户不存在");
		}
		if(certId == null){
			certId="000000";
		}
		List<SysUser> sys=null;
		if(!certId.equals("000000")){
			sys=userService.selectByCertId(certId);
			if(sys!=null&&sys.size()>1&&id!=sys.get(0).getUserId()){
				return  renderError("员工号已存在");
			}
		}
		
		SysUser sysUser = new SysUser();
		sysUser.setUserId(id);
		sysUser.setLoginName(loginName);
		sysUser.setUsername(username);
		sysUser.setUsingState(status);
		sysUser.setSaveType(userType);
		sysUser.setSex(sex);
		sysUser.setIsXw(isXw);
		sysUser.setSort(sort);
		sysUser.setPhone(phone);
		sysUser.setPublicCode(publicCode);
		sysUser.setEmail(email);
		sysUser.setUpdateTime(new Date());

		sysUser.setCertId(certId);
		if (StringUtils.isNotBlank(userpassword)) {
			sysUser.setLoginPassword(DesUtils.encrypt(userpassword, DesUtils.KEY_XW));
		}else{
			sysUser.setLoginPassword(list.get(0).getLoginPassword());
		}
		String staffName = getStaffName();
		int k = 0;
		try {
			k = userService.updateUser(sysUser, organIds, roleIds, staffName);
		} catch (Exception e) {
			// TODO Auto-generated catch block
//			LOG.error(LOGGER, request, "操作失败！：用户管理-修改用户信息:"+username+"("+e+")");
			e.printStackTrace();
		}
		return k>0?renderSuccess("修改成功！"):renderError("修改失败！");
	}
	
	/**
	 * 添加用户页
	 *
	 * @return
	 */
	@GetMapping("/addPage")
	public String addPage(Model model) {
		String priCode = "0000";
		try {
//			priCode = userService.selectMaxPrivateCode();
			model.addAttribute("priCode", priCode);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "admin/userAdd";
	}
	
	/**
	 * 添加用户
	 *
	 * @param userVo
	 * @return
	 * @throws Exception 
	 */
//	@RequiresPermissions(value = { "user/add" })
	@PostMapping("/add")
	@ResponseBody
	public Object add(SysUser sysUserAdd,String username, String userpassword, String loginName, String status, String userType,
			@RequestParam(required = false) List<String> roleIds, @RequestParam(required = false) List<String> organIds,long sort,String phone,HttpServletRequest request) throws Exception {
//		LOG.info(LOGGER, request, "用户管理-新增用户信息:"+username);
		List<SysUser> user = null;
		try {
			user = userService.selectByLoginNameOrUsername(loginName, username);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if (user != null && user.size() > 0) {
			return renderError("用户名已存在!");
		}
		String birthCode="";
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd"); 
		if(sysUserAdd.getBirthDate()!=null){
			 birthCode=sdf.format(sysUserAdd.getBirthDate()).substring(2, 4);  
			
		}
		String workCode="";
		if(sysUserAdd.getWorkDate()!=null){
		 workCode=sdf.format(sysUserAdd.getWorkDate()).substring(2, 4);  
		
		}
		String staffName = getStaffName();
		SysUser sysUser = new SysUser();
		sysUser.setLoginName(loginName);
		sysUser.setUsername(username);
		sysUser.setLoginPassword(DesUtils.encrypt(userpassword, DesUtils.KEY_XW));
		sysUser.setFounder(staffName);
		sysUser.setCreateTime(new Date());
		sysUser.setUpdateTime(new Date());
		sysUser.setSaveType(userType);
		sysUser.setUsingState(status);
		
		sysUser.setSort(sort);
		sysUser.setPhone(phone);
		sysUser.setBirthDate(sysUserAdd.getBirthDate());
		sysUser.setSex(sysUserAdd.getSex());
		sysUser.setWorkDate(sysUserAdd.getWorkDate());
		sysUser.setIsXw(sysUserAdd.getIsXw());
		sysUser.setPrivateCode(sysUserAdd.getPrivateCode());
		sysUser.setPublicCode(sysUserAdd.getPublicCode());
		sysUser.setPersonCode(birthCode+workCode+sysUserAdd.getSex()+sysUserAdd.getIsXw()+sysUserAdd.getPrivateCode()+sysUserAdd.getPublicCode());
		
		if(sysUserAdd.getCertId()==null||sysUserAdd.getCertId().equals("")){
			sysUser.setCertId("000000");
		}else{
			sysUser.setCertId(sysUserAdd.getCertId());
		}
		
		int k = 0;
		try {
			k = userService.insert(sysUser, organIds, roleIds, staffName);
		} catch (Exception e) {
			// TODO Auto-generated catch block
//			LOG.error(LOGGER, request, "操作失败！：用户管理-新增用户信息"+username+"("+e+")");
			e.printStackTrace();
		}
		return k>0?renderSuccess("添加成功！"):renderError("添加失败！");
	}
	
	@PostMapping("/check")
	@ResponseBody
	public Object check(String loginName){
		SysUser user = null;
		try {
			user = userService.selectByLoginName(loginName);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		boolean isRepeat = true;
		if (user!=null&&user.getLoginName().equals(loginName)){
			isRepeat=false;
		}
		return renderSuccess(isRepeat);
	}
	
	/**
	 * 删除用户
	 *
	 * @param id
	 * @return
	 */
//	@RequiresPermissions(value = { "user/delete" })
	@RequestMapping("/delete")
	@ResponseBody
	public Object delete(String id,HttpServletRequest request) {
//		LOG.info(LOGGER, request, "用户管理-删除用户信息:"+id);
		SysUser sysUser = new SysUser();
		sysUser.setUserId(id);
		sysUser.setIsDelete((long)1);
		try {
//			userService.updateUserSelective(sysUser);
			userOrganService.deleteByUser(id);
			userRoleService.deleteByUser(id);
			userService.deleteUserById(id);
		} catch (Exception e) {
			// TODO Auto-generated catch block
//			LOG.info(LOGGER, request, "操作失败！：用户管理-删除用户信息:"+id+"("+e+")");
			e.printStackTrace();
		}
		return renderSuccess("删除成功！");
	}
	/**
	 * 用户列表
	 * 
	 * @return
	 */
	@PostMapping("/dataOrganGrid")
	public @ResponseBody Result dataOrganGrid(@RequestBody PageInfo<SysUser> pageInfo) {
		String organId = null;
		for(Retrieval retrieval: pageInfo.getRetrievals()){
			if(retrieval.getName().equals("organIds")){
				organId = retrieval.getValue();
			}
		}
		try {
			pageInfo = userService.selectUserOrganPage(pageInfo,organId);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return renderSuccess(pageInfo);
	}
}

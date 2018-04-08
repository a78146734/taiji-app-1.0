package com.taiji.user.controller;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.taiji.core.annotations.SerializedField;
import com.taiji.core.annotations.SerializedFields;
import com.taiji.core.base.controller.BaseController;
import com.taiji.core.base.result.Result;
import com.taiji.core.logback.LOG;
import com.taiji.core.utils.PageInfo;
import com.taiji.user.model.SysOrgan;
import com.taiji.user.model.SysUser;
import com.taiji.user.service.SysOrganPuriewService;
import com.taiji.user.service.SysOrganService;
import com.taiji.user.service.SysPuriewResourcerService;
import com.taiji.user.service.SysUserOrganService;
import com.taiji.user.service.SysUserService;
/**
 * @description：部门管理
 * @author：admin @date：2015/10/1 14:51
 */
@Controller
@RequestMapping("/organization")
public class OrganController extends BaseController {
	@Autowired
	private SysOrganService organService;
	@Autowired
	private SysUserOrganService userOrganService;
	@Autowired
	private SysPuriewResourcerService puriewResourcerService;
	@Autowired
	private SysOrganPuriewService organPuriewService;
	/**
	 * 部门管理列表
	 * 
	 * @return
	 */
	@PostMapping("/treeGrid")
	//@SerializedFields({ @SerializedField(resultClass = SysUser.class) })
	public @ResponseBody Result treeGrid(@RequestBody PageInfo<SysOrgan> pageInfo) {
		pageInfo = organService.findPage(pageInfo);
		return renderSuccess(pageInfo);
	}
	/**
	 * 部门管理主页
	 * 
	 * @return
	 */
	@GetMapping(value = "/manager")
	public String manager() {
		return "admin/organization";
	}
	/**
	 * 部门添加-上级部门管理列表
	 * 
	 * @return
	 */
	@PostMapping("/tree")
	public  @ResponseBody Object tree() {
		List<Map<String,Object>> list=null;
		try {
			list=organService.selectTree();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return renderSuccess(list);
	}
	@RequestMapping("/resourceIds")
	@ResponseBody
	public Object puriewIds(String organId) {
		List<String> organIds = new ArrayList<String>();
		organIds.add(organId);
		List<String> resourceList = null;
		try {
			resourceList = puriewResourcerService.selectResourceIdTreeList(organIds);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return renderSuccess(resourceList);
	}

	@RequestMapping("/purIds")
	@ResponseBody
	public Object purIds(String organId) {
		List<String> organIds = new ArrayList<String>();
		organIds.add(organId);
		List<String> purList = null;
		try {
			purList = organPuriewService.selectPuriewIdListByOrganIds(organIds);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return renderSuccess(purList);
	}

	@RequestMapping("/grant")
	@ResponseBody
	public Object organGrant(String resourceIds, String id, String purIds) {
		try {
			organPuriewService.updateByOrgan(resourceIds, id, purIds,getStaffName());
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return renderSuccess("授权成功");
	}

	/**
	 * 部门列表
	 * 
	 * @return
	 */
	/*@RequiresPermissions(value = {"/jsp/admin/organization.jsp","organization/treeGrid" },logical = Logical.OR)
	@RequestMapping("/treeGrid")
	@ResponseBody
	public Object treeGrid(SysOrgan sysOrgan, Integer nowpage, Integer pagesize,HttpServletRequest request) {
		LOG.info(LOGGER, request, "部门管理-部门列表分页查询，第"+nowpage+"页");
		PageInfo pageInfo = new PageInfo(nowpage, pagesize);
		Map<String, Object> condition = new HashMap<String, Object>();
		if (StringUtils.isNotBlank(sysOrgan.getOrganName())) {
			condition.put("organName", sysOrgan.getOrganName());
		}
		if (sysOrgan.getOrganId() != null) {
			condition.put("organId", sysOrgan.getOrganId());
		}

		pageInfo.setCondition(condition);

		try {
			pageInfo = organizationService.selectByPage(pageInfo);
		} catch (Exception e) {
			LOG.error(LOGGER, request, "操作失败！：部门管理-部门列表分页查询，第"+nowpage+"页"+"("+e+")");
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return pageInfo;
	}*/

	/**
	 * 人员信息页面
	 * 
	 * @param id
	 * @param model
	 * @return
	 */
	@RequiresPermissions(value = { "organization/userPage" })
	@GetMapping("/userPage")
	public String userPage(String id, HttpServletRequest request) {
		List<String> organList;
		try {
//			organList = organService.selectIdList(id);
//			List<String> userIdList = userOrganService.selectUserIdListByOrganIdList(organList);
//			StringBuilder sb = new StringBuilder();
//			for(int i=0;i<userIdList.size();i++) {
//				sb.append(userIdList.get(i)+",");
//			}
			/*for (String ids : userIdList) {
				sb.append(ids + ",");
			}*/
			request.setAttribute("organId", id);
//			request.setAttribute("userIds", sb.toString());
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return "admin/organizationUser";
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
		return "admin/organizationGrant";
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
		return "admin/organizationGrantPersonal";
	}

	/**
	 * 添加部门页
	 * 
	 * @return
	 */
	@RequestMapping("/addPage")
	public String addPage() {
		return "admin/organizationAdd";
	}

	/**
	 * 添加部门
	 * 
	 * @param organization
	 * @return
	 */
	@RequiresPermissions(value = { "organization/add" })
	@RequestMapping("/add")
	public @ResponseBody Object add(SysOrgan organ,HttpServletRequest request) {
		//LOG.info(LOGGER, request, "部门管理-添加部门信息:"+organ.getOrganName());
		SysOrgan sysOrgan = new SysOrgan();
		sysOrgan.setAddress(organ.getAddress());
		sysOrgan.setIcon(organ.getIcon());
		sysOrgan.setSeq(organ.getSeq());
		sysOrgan.setOrganName(organ.getOrganName());
		sysOrgan.setDescribe(organ.getDescribe());
		sysOrgan.setFounder(getStaffName());
		sysOrgan.setCreateTime(new Date());
		sysOrgan.setSaveType(organ.getSaveType());
		sysOrgan.setUsingState("1");
		String code=null;
		Long s = null;
		if(organ.getParentId()==null || organ.getParentId().equals("")) {
			sysOrgan.setParentId("0");
			 try {
				code=organService.selectByCode(sysOrgan.getParentId());//查询上一条添加记录的organCode
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			if(code!=null){
				s = Long.parseLong(code);
			}else{
				s=(long) 32078101;
			}
		}else {
			sysOrgan.setParentId(organ.getParentId());
			try {
				 code=organService.selectByCode(organ.getParentId());//查询上一条添加记录的organCode
			} catch (Exception e1) {
				//LOG.error(LOGGER, request, "操作失败！：部门管理-添加部门:"+organ.getOrganName()+"("+e1+")");
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			if(code!=null){
				s = Long.parseLong(code);
			}else{
				SysOrgan so=organService.find(organ.getParentId());//该部门没有下级部门时查询上级部门的organCode
				s = Long.parseLong(so.getOrganCode());
				s=s*10000;
			}
		}
		/*Random random = new Random();
		s+=random.nextInt(9)+1; 
		for (int i = 0; i < 18-1; i++) {
			s+=random.nextInt(10); 
		}*/
		sysOrgan.setOrganCode(Long.toString(++s));
		try {
			organService.save(sysOrgan);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "admin/organizationAdd";
	}

	/**
	 * 编辑部门页
	 * 
	 * @param request
	 * @param id
	 * @return
	 */
	@GetMapping("/editPage")
	public String editPage(HttpServletRequest request, String id) {
		SysOrgan organization = null;
		try {
			organization = organService.find(id);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		request.setAttribute("organization", organization);
		return "admin/organizationEdit";
	}

	/**
	 * 编辑部门
	 * 
	 * @param organization
	 * @return
	 */
	@RequiresPermissions(value = { "organization/edit" })
	@RequestMapping("/edit")
	@ResponseBody
	public Object edit(String name, String address, String describe, String icon, String pid,
			Long seq, String id, String saveType,HttpServletRequest request) {
		//LOG.info(LOGGER, request, "部门管理-修改部门信息信息:"+name);
		if (id.equals(pid)) {
			return renderError("无法与本身建立关系");
		}
		try {
			List<String> list = organService.selectIdList(id);
			for(int i=0;i<list.size();i++) {
				String v = list.get(i);
				if(v.equals(pid)) {
					return renderError("无法与子部门建立关系");
				}
			}
			/*for (Long long1 : list) {
				if (long1.equals(pid)) {
					return renderError("无法与子部门建立关系");
				}
			}*/
			SysOrgan sysOrgan = new SysOrgan();
			sysOrgan.setOrganId(id);
			sysOrgan.setAddress(address);
			sysOrgan.setIcon(icon);
			sysOrgan.setSeq(seq);
			sysOrgan.setOrganName(name);
			if(pid!=null || pid.equals("")) {
				sysOrgan.setParentId(pid);
			}else {
				sysOrgan.setParentId("0");
			}
			sysOrgan.setSaveType(saveType);
			sysOrgan.setDescribe(describe);
			organService.updateSelective(sysOrgan);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			//LOG.error(LOGGER, request, "操作失败！：部门管理-部门信息修改:"+name+"("+e+")");
			e.printStackTrace();
		}
		return renderSuccess("编辑成功！");
	}

	/**
	 * 删除部门
	 * 
	 * @param id
	 * @return
	 */
	@RequiresPermissions(value = { "organization/delete" })
	@RequestMapping("/delete")
	@ResponseBody
	public Object delete(String id,HttpServletRequest request) {
		//LOG.info(LOGGER, request, "部门管理-删除部门信息:"+id);
		int k = 0;
		try {
			k += organService.deleteById(id);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			//LOG.error(LOGGER, request, "操作失败！：部门管理-删除部门信息:"+id+"("+e+")");
			e.printStackTrace();
		}
		return k>0?renderSuccess("删除成功！"):renderError("删除失败！");
	}

	/**
	 * 返回上一级
	 * 
	 * @return
	 */
	@RequestMapping("/back")
	public @ResponseBody Object back(String parentId) {
		SysOrgan sysOrgan=null;
		try {
			sysOrgan=organService.find(parentId);
			/*sysOrgan1 = organService.get(sysOrgan.getOrganId());
			Map<String, Object> condition = new HashMap<String, Object>();
			if (sysOrgan.getOrganName() != null) {
				condition.put("organName", sysOrgan.getOrganName());
			}
			if (sysOrgan1.getOrganId() != null) {
				condition.put("organId", sysOrgan1.getParentId());
			}

			pageInfo.setCondition(condition);
*/
			//pageInfo = organService.findPage(pageInfo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return renderSuccess(sysOrgan);
	}
	/*public @ResponseBody Result back(@RequestBody PageInfo<SysOrgan> pageInfo) {
		PageInfo pageInfo = new PageInfo(nowpage, pagesize);
		SysOrgan sysOrgan1 = null;
		try {
			sysOrgan1 = organService.find(sysOrgan.getOrganId());
			Map<String, Object> condition = new HashMap<String, Object>();
			if (sysOrgan.getOrganName() != null) {
				condition.put("organName", sysOrgan.getOrganName());
			}
			if (sysOrgan1.getOrganId() != null) {
				condition.put("organId", sysOrgan1.getParentId());
			}

			pageInfo.setCondition(condition);

			pageInfo = organService.findPage(pageInfo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return renderSuccess(pageInfo);
	}
	*/
/*	@RequiresPermissions(value = { "organization/checkDetails" })
	@GetMapping("/selectByPrimaryKey")
	@ResponseBody
	public Object selectByPrimaryKey(String id,HttpServletRequest request){
		LOG.info(LOGGER, request, "部门管理-查询部门信息:"+id);
		SysOrgan sysOrgan = null;
		try {
				sysOrgan = organizationService.selectById(id);
		} catch (Exception e) {
			LOG.error(LOGGER, request, "操作失败！：部门管理-查询部门信息:"+id+"("+e+")");
			e.printStackTrace();
		}
		return renderSuccess(sysOrgan);
	}*/
	/**
	 * 部门数据查询
	 * @author wangcf
	 * @version 1.0
	 * @date 2017-05-05 10:47:17
	 */
	/*@PostMapping("/selectOrganUser")
	@ResponseBody
	public Object selectOrganUser(HttpServletRequest request, Integer nowpage,
			Integer pagesize,WdRmpAppLog wdRmpAppLog){
		LOG.info(LOGGER, request, "部门人员统计-部门人员统计统计查询");
		Map<String,List<Map<String, Object>>> map=new HashMap<String, List<Map<String, Object>>>();
		List<Map<String, Object>> list=null;
		try {
			list=organizationService.selectOrganUser();
				
		} catch (Exception e) {
			LOG.error(LOGGER, request, "部门人员统计-部门人员统计统计查询"+"("+e+")");
			e.printStackTrace();
		}
		return renderSuccess(list);  
	}*/
}

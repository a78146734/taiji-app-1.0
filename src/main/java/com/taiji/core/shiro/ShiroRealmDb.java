package com.taiji.core.shiro;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.DisabledAccountException;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.taiji.user.model.SysPuriewResource;
import com.taiji.user.model.SysUser;
import com.taiji.user.service.SysPuriewResourcerService;
import com.taiji.user.service.SysResourceService;
import com.taiji.user.service.SysUserOrganService;
import com.taiji.user.service.SysUserRoleService;
import com.taiji.user.service.SysUserService;
import com.taiji.user.service.SysUserServiceImpl;

/**
 * shiro 自定义用户认证
 * 
 * @author guochao
 *
 */
@Service
public class ShiroRealmDb extends AuthorizingRealm {
	@Autowired
	private SysUserService sysUserService;
	@Autowired
	private SysUserRoleService userRoleService;
	@Autowired
	private SysUserOrganService userOrganService;
	@Autowired
	private SysPuriewResourcerService puriewResourcerService;
	@Autowired
	private SysResourceService sysResourceService;
	//private static final Logger LOGGER =
	 //LogManager.getLogger(ShiroRealmDb.class);

	/**
	 * Shiro登录认证(认证 密码 状态 )
	 */
	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authcToken)
			throws AuthenticationException {
		UsernamePasswordToken token = (UsernamePasswordToken) authcToken;
		SysUser user = new SysUser();
		try {
			user = sysUserService.selectByLoginName(token.getUsername());
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		// 账号不存在
		if (user == null) {
			throw new UnknownAccountException("账号不存在");
		}
		// 账号未启用
		if (user.getUsingState().equals("1")) {
			throw new DisabledAccountException("账号未启用");
		}
		Set<String> urlSet = getSysUserUrl(user.getUserId());
		ShiroUser shiroUser = new ShiroUser(user.getUserId(), user.getLoginName(), user.getUsername(), urlSet);
		// 认证缓存信息
		return new SimpleAuthenticationInfo(shiroUser, user.getLoginPassword().toCharArray(), getName());

	}

	/**
	 * Shiro权限认证（添加用户所拥有的权限）
	 */
	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
		ShiroUser shiroUser = (ShiroUser) principals.getPrimaryPrincipal();
		SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
		info.addStringPermissions(shiroUser.getUrlSet());
		return info;
	}

	public void updateRole() throws Exception {
		PrincipalCollection principals = SecurityUtils.getSubject().getPrincipals();
		ShiroUser shiroUser = (ShiroUser) principals.getPrimaryPrincipal();
		super.clearCachedAuthorizationInfo(principals);
		if (shiroUser != null) {
			shiroUser.setUrlSet(getSysUserUrl(shiroUser.getUserId()));
		}
	}

	private Set<String> getSysUserUrl(String userId)  {
		Set<String> urlSet = new HashSet<String>();
		// TODO 查询用户拥有权限的URl
		try {
			List<String> roles = userRoleService.selectRoleIdListByUserId(userId);
			List<String> organs = userOrganService.selectRecursiveBelowOrganIdListByUserId(userId);
			if(roles.size()<=0 || roles == null){
				roles = Arrays.asList("");
			}
			if(organs.size()<=0 || organs == null){
				organs = Arrays.asList("");
			}
			if ((roles != null && roles.size() > 0) || (organs != null && organs.size() > 0)) {
				List<String> puriewResources = puriewResourcerService.selectResourceIdList(roles,organs);
				if (puriewResources != null && puriewResources.size() > 0) {
					List<String> resource = sysResourceService.selectUrlInId(puriewResources);
					for (String string : resource) {
						urlSet.add(string);
					}
				}
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return urlSet;
	}
}

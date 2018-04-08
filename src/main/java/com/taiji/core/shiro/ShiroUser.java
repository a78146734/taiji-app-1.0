/**
 *
 */
package com.taiji.core.shiro;

import java.io.Serializable;
import java.util.Set;

/**
 * shiro用户对象，使得Subject除了携带用户的登录名外还可以携带更多信息
 * 
 * @author guochao
 *
 */
public class ShiroUser implements Serializable {

	private static final long serialVersionUID = -1373760761780840081L;
	private String userId;
	private String loginName;
	private String username;
	private Set<String> urlSet;

	public ShiroUser(String userId, String loginName, String username, Set<String> urlSet) {
		super();
		this.userId = userId;
		this.loginName = loginName;
		this.username = username;
		this.urlSet = urlSet;
	}

	/**  
	 * 获取userId  
	 * @return userId userId  
	 */
	public String getUserId() {
		return userId;
	}
	

	/**  
	 * 设置userId  
	 * @param userId userId  
	 */
	public void setUserId(String userId) {
		this.userId = userId;
	}
	

	/**  
	 * 获取username  
	 * @return username username  
	 */
	public String getUsername() {
		return username;
	}
	

	/**  
	 * 设置username  
	 * @param username username  
	 */
	public void setUsername(String username) {
		this.username = username;
	}
	

	/**  
	 * 设置loginName  
	 * @param loginName loginName  
	 */
	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}
	

	/**  
	 * 获取urlSet  
	 * @return urlSet urlSet  
	 */
	public Set<String> getUrlSet() {
		return urlSet;
	}
	

	/**  
	 * 设置urlSet  
	 * @param urlSet urlSet  
	 */
	public void setUrlSet(Set<String> urlSet) {
		this.urlSet = urlSet;
	}
	

	public String getName() {
		return username;
	}

	public String getLoginName() {
		return loginName;
	}

	/**
	 * 本函数输出将作为默认的<shiro:principal/>输出.
	 */
	@Override
	public String toString() {
		return username;
		// return loginName;
	}
}
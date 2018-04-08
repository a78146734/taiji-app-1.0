package com.taiji.user.model;

import java.util.Date;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table
public class SysRole {

	@Id
	@GeneratedValue(generator = "system-uuid")
	@GenericGenerator(name = "system-uuid", strategy = "uuid")
	private String roleId;

	private String roleName;

	private Long seq;

	private String code;

	private String founder;

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private Date createTime;

	private String saveType;

	private String describe;

	private String usingState;

	@JsonIgnore
	@OneToMany(mappedBy="sysRole", targetEntity = SysUserRole.class, cascade = CascadeType.REMOVE, fetch = FetchType.LAZY)
	private Set<SysUserRole> sysUserRoles;
	
	@JsonIgnore
	@OneToMany(mappedBy="sysRole", targetEntity = SysRolePuriew.class, cascade = CascadeType.REMOVE, fetch = FetchType.LAZY)
	private Set<SysRolePuriew> sysRolePuriew;

	/**  
	 * 获取sysUserRoles  
	 * @return sysUserRoles sysUserRoles  
	 */
	public Set<SysUserRole> getSysUserRoles() {
		return sysUserRoles;
	}
	

	/**  
	 * 设置sysUserRoles  
	 * @param sysUserRoles sysUserRoles  
	 */
	public void setSysUserRoles(Set<SysUserRole> sysUserRoles) {
		this.sysUserRoles = sysUserRoles;
	}
	

	public String getRoleId() {
		return roleId;
	}

	public void setRoleId(String roleId) {
		this.roleId = roleId;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getRoleName() {
		return roleName;
	}

	public void setRoleName(String roleName) {
		this.roleName = roleName == null ? null : roleName.trim();
	}

	public Long getSeq() {
		return seq;
	}

	public void setSeq(Long seq) {
		this.seq = seq;
	}

	public String getFounder() {
		return founder;
	}

	public void setFounder(String founder) {
		this.founder = founder == null ? null : founder.trim();
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public String getSaveType() {
		return saveType;
	}

	public void setSaveType(String saveType) {
		this.saveType = saveType;
	}

	public String getDescribe() {
		return describe;
	}

	public void setDescribe(String describe) {
		this.describe = describe == null ? null : describe.trim();
	}

	public String getUsingState() {
		return usingState;
	}

	public void setUsingState(String usingState) {
		this.usingState = usingState;
	}

	public Set<SysRolePuriew> getSysRolePuriew() {
		return sysRolePuriew;
	}

	public void setSysRolePuriew(Set<SysRolePuriew> sysRolePuriew) {
		this.sysRolePuriew = sysRolePuriew;
	}
	
}
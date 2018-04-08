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
public class SysUser {

	@Id
	@GeneratedValue(generator = "system-uuid")
	@GenericGenerator(name = "system-uuid", strategy = "uuid")
	private String userId;

	private Long sort;

	private String username;

	private String loginPassword;

	private String founder;

	private String loginName;

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private Date createTime;

	private String describe;

	private String saveType;

	private String usingState;

	private String sex;

	private String certType;

	private String certId;

	private String officePhone;

	private String phone;

	private String email;

	// @DateTimeFormat(pattern = "yyyy-MM-dd")//存日期时使用
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private Date workDate;

	private String digitalCertId;

	private String offerInDate;

	private Long isDelete;

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private Date effectiveDate;

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private Date updateTime;

	private Long isXw;

	private String privateCode;

	private String publicCode;

	private String personCode;

	@JsonIgnore
	@OneToMany(mappedBy="sysUser", targetEntity = SysUserRole.class, cascade = CascadeType.REMOVE, fetch = FetchType.LAZY)
	private Set<SysUserRole> sysUserRoles;
	
	@JsonIgnore
	@OneToMany(mappedBy="sysUser", targetEntity = SysUserOrgan.class, cascade = CascadeType.REMOVE, fetch = FetchType.LAZY)
	private Set<SysUserOrgan> sysUserOrgans;

	/**  
	 * 获取sysUserOrgans  
	 * @return sysUserOrgans sysUserOrgans  
	 */
	public Set<SysUserOrgan> getSysUserOrgans() {
		return sysUserOrgans;
	}
	

	/**  
	 * 设置sysUserOrgans  
	 * @param sysUserOrgans sysUserOrgans  
	 */
	public void setSysUserOrgans(Set<SysUserOrgan> sysUserOrgans) {
		this.sysUserOrgans = sysUserOrgans;
	}
	

	/**
	 * 获取sysUserRoles
	 * 
	 * @return sysUserRoles sysUserRoles
	 */
	public Set<SysUserRole> getSysUserRoles() {
		return sysUserRoles;
	}

	/**
	 * 设置sysUserRoles
	 * 
	 * @param sysUserRoles
	 *            sysUserRoles
	 */
	public void setSysUserRoles(Set<SysUserRole> sysUserRoles) {
		this.sysUserRoles = sysUserRoles;
	}

	public Long getSort() {
		return sort;
	}

	public void setSort(Long sort) {
		this.sort = sort;
	}

	// @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone="GMT+8") //取日期时使用
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private Date birthDate;

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username == null ? null : username.trim();
	}

	public String getLoginPassword() {
		return loginPassword;
	}

	public void setLoginPassword(String loginPassword) {
		this.loginPassword = loginPassword == null ? null : loginPassword.trim();
	}

	public String getFounder() {
		return founder;
	}

	public void setFounder(String founder) {
		this.founder = founder == null ? null : founder.trim();
	}

	public String getLoginName() {
		return loginName;
	}

	public void setLoginName(String loginName) {
		this.loginName = loginName == null ? null : loginName.trim();
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public String getDescribe() {
		return describe;
	}

	public void setDescribe(String describe) {
		this.describe = describe == null ? null : describe.trim();
	}

	public String getSaveType() {
		return saveType;
	}

	public void setSaveType(String saveType) {
		this.saveType = saveType;
	}

	public String getUsingState() {
		return usingState;
	}

	public void setUsingState(String usingState) {
		this.usingState = usingState;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getCertType() {
		return certType;
	}

	public void setCertType(String certType) {
		this.certType = certType;
	}

	public String getCertId() {
		return certId;
	}

	public void setCertId(String certId) {
		this.certId = certId;
	}

	public String getOfficePhone() {
		return officePhone;
	}

	public void setOfficePhone(String officePhone) {
		this.officePhone = officePhone;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Date getWorkDate() {
		return workDate;
	}

	public void setWorkDate(Date workDate) {
		this.workDate = workDate;
	}

	public String getDigitalCertId() {
		return digitalCertId;
	}

	public void setDigitalCertId(String digitalCertId) {
		this.digitalCertId = digitalCertId;
	}

	public String getOfferInDate() {
		return offerInDate;
	}

	public void setOfferInDate(String offerInDate) {
		this.offerInDate = offerInDate;
	}

	public Long getIsDelete() {
		return isDelete;
	}

	public void setIsDelete(Long isDelete) {
		this.isDelete = isDelete;
	}

	public Date getEffectiveDate() {
		return effectiveDate;
	}

	public void setEffectiveDate(Date effectiveDate) {
		this.effectiveDate = effectiveDate;
	}

	public Date getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}

	public Long getIsXw() {
		return isXw;
	}

	public void setIsXw(Long isXw) {
		this.isXw = isXw;
	}

	public String getPrivateCode() {
		return privateCode;
	}

	public void setPrivateCode(String privateCode) {
		this.privateCode = privateCode;
	}

	public String getPublicCode() {
		return publicCode;
	}

	public void setPublicCode(String publicCode) {
		this.publicCode = publicCode;
	}

	public String getPersonCode() {
		return personCode;
	}

	public void setPersonCode(String personCode) {
		this.personCode = personCode;
	}

	public Date getBirthDate() {
		return birthDate;
	}

	public void setBirthDate(Date birthDate) {
		this.birthDate = birthDate;
	}

}
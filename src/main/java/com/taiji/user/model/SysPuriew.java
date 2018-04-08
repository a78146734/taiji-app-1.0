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
public class SysPuriew {

	@Id
	@GeneratedValue(generator = "system-uuid")
	@GenericGenerator(name = "system-uuid", strategy = "uuid")
	private String puriewId;

	private String puriewName;

	private Long seq;
	
	private String code;
	
	private String expression;

	private String founder;

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private Date createTime;

	private String saveType;

	private String describe;

	private String usingState;
	
	@JsonIgnore
	@OneToMany(mappedBy="sysPuriew", targetEntity = SysOrganPuriew.class, cascade = CascadeType.REMOVE, fetch = FetchType.LAZY)
	private Set<SysOrganPuriew> sysOrganPuriews;
	
	@JsonIgnore
	@OneToMany(mappedBy="sysPuriew", targetEntity = SysPuriewResource.class, cascade = CascadeType.REMOVE, fetch = FetchType.LAZY)
	private Set<SysPuriewResource> sysPuriewResources;
	
	@JsonIgnore
	@OneToMany(mappedBy="sysPuriew", targetEntity = SysRolePuriew.class, cascade = CascadeType.REMOVE, fetch = FetchType.LAZY)
	private Set<SysRolePuriew> sysRolePuriew;
	
	public String getPuriewId() {
		return puriewId;
	}

	public void setPuriewId(String puriewId) {
		this.puriewId = puriewId;
	}

	public String getPuriewName() {
		return puriewName;
	}

	public void setPuriewName(String puriewName) {
		this.puriewName = puriewName;
	}

	public Long getSeq() {
		return seq;
	}

	public void setSeq(Long seq) {
		this.seq = seq;
	}

	public String getExpression() {
		return expression;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public void setExpression(String expression) {
		this.expression = expression == null ? null : expression.trim();
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

}
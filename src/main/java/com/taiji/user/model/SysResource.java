package com.taiji.user.model;

import java.util.Date;
import java.util.List;
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
import javax.persistence.Transient;

import org.hibernate.annotations.GenericGenerator;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;

@Entity
@Table
@JsonIgnoreProperties(value={"hibernateLazyInitializer","handler","fieldHandler"}) 
public class SysResource {

	@Id
	@GeneratedValue(generator = "system-uuid")
	@GenericGenerator(name = "system-uuid", strategy = "uuid")
	private String resourceId;

	private String resourceName;

	@JsonProperty("iconCls")
	private String icon;

	private Long seq;

	private String resourceUrl;

	private String parentId;

	private String founder;

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private Date createTime;

	private String saveType;

	private String describe;

	private String usingState;

	private String pic;

	@Transient
	private List<SysResource> children;

	@JsonIgnore
	@OneToMany(mappedBy="sysResource", targetEntity = SysPuriewResource.class, cascade = CascadeType.REMOVE, fetch = FetchType.LAZY)
	private Set<SysPuriewResource> sysPuriewResources;

	public SysResource() {
		super();
	}

	public SysResource(String resourceName, String icon, Long seq, String resourceUrl, String founder, Date createTime,
			String saveType, String describe, String usingState) {
		super();
		this.resourceName = resourceName;
		this.icon = icon;
		this.seq = seq;
		this.resourceUrl = resourceUrl;
		this.founder = founder;
		this.createTime = createTime;
		this.saveType = saveType;
		this.describe = describe;
		this.usingState = usingState;
	}

	public SysResource(String resourceName, String icon, Long seq, String resourceUrl, String founder, Date createTime,
			String saveType, String describe, String usingState, String pic) {
		super();
		this.resourceName = resourceName;
		this.icon = icon;
		this.seq = seq;
		this.resourceUrl = resourceUrl;
		this.founder = founder;
		this.createTime = createTime;
		this.saveType = saveType;
		this.describe = describe;
		this.usingState = usingState;
		this.pic = pic;
	}

	public SysResource(String resourceName, String icon, Long seq, String resourceUrl, String parentId, String founder,
			Date createTime, String saveType, String describe, String usingState) {
		super();
		this.resourceName = resourceName;
		this.icon = icon;
		this.seq = seq;
		this.resourceUrl = resourceUrl;
		this.parentId = parentId;
		this.founder = founder;
		this.createTime = createTime;
		this.saveType = saveType;
		this.describe = describe;
		this.usingState = usingState;
	}

	public List<SysResource> getChildren() {
		return children;
	}

	public void setChildren(List<SysResource> children) {
		this.children = children;
	}

	public String getResourceId() {
		return resourceId;
	}

	public void setResourceId(String resourceId) {
		this.resourceId = resourceId;
	}

	public String getResourceName() {
		return resourceName;
	}

	public void setResourceName(String resourceName) {
		this.resourceName = resourceName == null ? null : resourceName.trim();
	}

	public String getIcon() {
		return icon;
	}

	public void setIcon(String icon) {
		this.icon = icon == null ? null : icon.trim();
	}

	public Long getSeq() {
		return seq;
	}

	public void setSeq(Long seq) {
		this.seq = seq;
	}

	public String getResourceUrl() {
		return resourceUrl;
	}

	public void setResourceUrl(String resourceUrl) {
		this.resourceUrl = resourceUrl == null ? null : resourceUrl.trim();
	}

	public String getParentId() {
		return parentId;
	}

	public void setParentId(String parentId) {
		this.parentId = parentId;
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

	public String getPic() {
		return pic;
	}

	public void setPic(String pic) {
		this.pic = pic;
	}

	public Set<SysPuriewResource> getSysPuriewResources() {
		return sysPuriewResources;
	}

	public void setSysPuriewResources(Set<SysPuriewResource> sysPuriewResources) {
		this.sysPuriewResources = sysPuriewResources;
	}

}
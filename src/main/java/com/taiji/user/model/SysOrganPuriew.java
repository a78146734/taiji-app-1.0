package com.taiji.user.model;

import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;
@Entity
@Table
public class SysOrganPuriew {

	@Id
	@GeneratedValue(generator = "system-uuid")
	@GenericGenerator(name = "system-uuid", strategy = "uuid")
    private String id;

    private String organId;

    private String puriewId;

    private String founder;

    private Date createTime;

    private String saveType;

    private String describe;

    private String usingState;

    @ManyToOne(targetEntity = SysOrgan.class, cascade = CascadeType.REMOVE, fetch = FetchType.LAZY)
    @JoinColumn(name = "organId", updatable = false, insertable= false)
    private SysOrgan sysOrgan;
    
	@ManyToOne(targetEntity = SysPuriew.class, cascade = CascadeType.REMOVE, fetch = FetchType.LAZY)
	@JoinColumn(name = "puriewId", updatable = false, insertable= false)
	private SysPuriew sysPuriew;
	
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getOrganId() {
        return organId;
    }

    public void setOrganId(String organId) {
        this.organId = organId;
    }

    public String getPuriewId() {
        return puriewId;
    }

    public void setPuriewId(String puriewId) {
        this.puriewId = puriewId;
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

	public SysOrgan getSysOrgan() {
		return sysOrgan;
	}

	public void setSysOrgan(SysOrgan sysOrgan) {
		this.sysOrgan = sysOrgan;
	}

	public SysPuriew getSysPuriew() {
		return sysPuriew;
	}

	public void setSysPuriew(SysPuriew sysPuriew) {
		this.sysPuriew = sysPuriew;
	}
    
}
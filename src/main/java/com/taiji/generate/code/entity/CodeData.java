package com.taiji.generate.code.entity;

public class CodeData {
	private String tableName;//表名
	private String projectPath;//项目路径
	private String sysname;//名称
	private String basePackage;//基础包
	private String schema;//
	private String module;//模块名
	private String function;//功能名
	private String author;//创建者
	private String genfile;//生成文件
	private boolean genPur = false;//是否生成权限数据
	
	public String getTableName() {
		return tableName;
	}
	public void setTableName(String tableName) {
		this.tableName = tableName;
	}
	public String getProjectPath() {
		return projectPath;
	}
	public void setProjectPath(String projectPath) {
		this.projectPath = projectPath;
	}
	
	public String getSysname() {
		return sysname;
	}
	public void setSysname(String sysname) {
		this.sysname = sysname;
	}
	public String getBasePackage() {
		return basePackage;
	}
	public void setBasePackage(String basePackage) {
		this.basePackage = basePackage;
	}
	public String getModule() {
		return module;
	}
	public void setModule(String module) {
		this.module = module;
	}
	public String getFunction() {
		return function;
	}
	public void setFunction(String function) {
		this.function = function;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public String getGenfile() {
		return genfile;
	}
	public void setGenfile(String genfile) {
		this.genfile = genfile;
	}
	public String getSchema() {
		return schema;
	}
	public void setSchema(String schema) {
		this.schema = schema;
	}
	public boolean isGenPur() {
		return genPur;
	}
	public void setGenPur(boolean genPur) {
		this.genPur = genPur;
	}
	
}

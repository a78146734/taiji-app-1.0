package com.taiji.core.jstltag;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import com.taiji.core.config.spring.SpringContextHolder;
import com.taiji.core.jstltag.ehcache.DictionaryDataService;
import com.taiji.core.jstltag.ehcache.DictionaryDataServiceImpl;

public class DictionaryEscape extends TagSupport {
	public DictionaryEscape() {
		initService();
	}

	private static DictionaryDataService jstlTagData;

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	public int doStartTag() throws JspException {
		JspWriter out = this.pageContext.getOut();
		try {
			if (dicDataId != null) {
				out.print(jstlTagData.getDicEscape(dicDataId));
			}
			// else{
			// out.print(jstlTagData.getDicEscape(dicDataName));
			// }
		} catch (IOException e) {
			throw new RuntimeException(e);
		}
		return super.doStartTag();
	}

	private void initService() {
		if (jstlTagData == null) {
			jstlTagData = (DictionaryDataService) SpringContextHolder.getBean(DictionaryDataService.class);
		}
	}

	@Override
	public void release() {
		dicDataId = null;
		// dicDataName = null;
		super.release();
	}

	private String dicDataId;
	// private String dicDataName;

	public String getDicDataId() {
		return dicDataId;
	}

	public void setDicDataId(String dicDataId) {
		this.dicDataId = dicDataId;
	}

	// public String getDicDataName() {
	// return dicDataName;
	// }
	//
	// public void setDicDataName(String dicDataName) {
	// this.dicDataName = dicDataName;
	// }

}

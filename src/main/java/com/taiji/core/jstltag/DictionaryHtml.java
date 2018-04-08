package com.taiji.core.jstltag;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import com.taiji.core.config.spring.SpringContextHolder;
import com.taiji.core.jstltag.ehcache.DictionaryDataService;
import com.taiji.core.jstltag.ehcache.DictionaryDataServiceImpl;

public class DictionaryHtml extends TagSupport {
	public DictionaryHtml() {
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
			String html = jstlTagData.getDicHtml(nodeId, type, name);
			if (type.equals("select")) {
				if (value != null && html.lastIndexOf("value=\"" + value + "\"") > -1) {
					html = html.replaceAll("value=\"" + value + "\"", "value=\"" + value + "\" selected=\"selected\"");
				}
			} else if (type.equals("checkbox")) {
				if (value != null) {
					List<String> strings = Arrays.asList(value.split(","));
					for (String string : strings) {
						if (value != null && html.lastIndexOf("value=\"" + string + "\"") > -1) {
							html = html.replaceAll("value=\"" + string + "\"",
									"value=\"" + string + "\" checked=\"checked\"");
						}
					}
				}
			}
			out.print(html);
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
		nodeId = null;
		type = null;
		name = null;
		value = null;
		super.release();
	}

	private String nodeId;
	private String type;
	private String name;
	private String value;

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getNodeId() {
		return nodeId;
	}

	public void setNodeId(String nodeId) {
		this.nodeId = nodeId;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

}

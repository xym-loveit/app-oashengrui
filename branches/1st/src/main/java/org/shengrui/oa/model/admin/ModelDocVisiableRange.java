package org.shengrui.oa.model.admin;

import java.util.HashSet;
import java.util.Set;

import cn.trymore.core.model.ModelBase;

/**
 * Model: 文档范围
 * 
 * @author Tang
 * 
 */
public class ModelDocVisiableRange 
extends ModelBase {

	private static final long serialVersionUID = 7284853738522606597L;

	// Fields

	private String visiableName;
	@SuppressWarnings("rawtypes")
	private Set docs = new HashSet(0);

	public String getVisiableName() {
		return visiableName;
	}
	public void setVisiableName(String visiableName) {
		this.visiableName = visiableName;
	}
	@SuppressWarnings("rawtypes")
	public Set getDocs() {
		return docs;
	}
	@SuppressWarnings("rawtypes")
	public void setDocs(Set docs) {
		this.docs = docs;
	}
	
}

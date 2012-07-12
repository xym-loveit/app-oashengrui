package org.shengrui.oa.model.admin;

import java.util.HashSet;
import java.util.Set;

import cn.trymore.core.model.ModelBase;

/**
 * Model: 文档级别
 * 
 * @author Tang
 * 
 */
public class ModelDocLevel 
extends ModelBase {

	private static final long serialVersionUID = -174190863429705464L;
	
	// Fields
	private String levelName;
	@SuppressWarnings("rawtypes")
	private Set docs = new HashSet(0);
	
	
	public String getLevelName() {
		return levelName;
	}
	public void setLevelName(String levelName) {
		this.levelName = levelName;
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

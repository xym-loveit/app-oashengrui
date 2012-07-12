package org.shengrui.oa.model.admin;

import cn.trymore.core.model.ModelBase;

/**
 * Model: 文档附件
 * 
 * @author Tang
 * 
 */
public class ModelDocFile 
extends ModelBase {
	
	// Fields

	private static final long serialVersionUID = 777263096968029840L;
	private ModelDoc doc;
	private Long fileId;
	
	
	public ModelDoc getDoc() {
		return doc;
	}
	public void setDoc(ModelDoc doc) {
		this.doc = doc;
	}
	public Long getFileId() {
		return fileId;
	}
	public void setFileId(Long fileId) {
		this.fileId = fileId;
	}


}

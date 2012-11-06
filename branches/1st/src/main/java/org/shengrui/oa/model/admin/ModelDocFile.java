package org.shengrui.oa.model.admin;


import cn.trymore.core.model.ModelBase;
import cn.trymore.oa.model.system.ModelFileAttach;

/**
 * Model: 文档附件
 * 
 * @author Tang
 * 
 */
public class ModelDocFile 
extends ModelBase {
	
	// Fields

	public ModelDocFile(){

	}
	
	private static final long serialVersionUID = 777263096968029840L;
	private ModelDoc doc=new ModelDoc();
	private ModelFileAttach file=new ModelFileAttach();
	
	
	public ModelDoc getDoc() {
		return doc;
	}
	public void setDoc(ModelDoc doc) {
		this.doc = doc;
	}
	public ModelFileAttach getFile() {
		return file;
	}
	public void setFile(ModelFileAttach file) {
		this.file = file;
	}


}

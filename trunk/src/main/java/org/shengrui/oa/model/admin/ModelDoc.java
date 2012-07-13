package org.shengrui.oa.model.admin;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import org.shengrui.oa.model.system.ModelAppUser;
import org.shengrui.oa.model.system.ModelSchoolDepartment;
import org.shengrui.oa.model.system.ModelSchoolDistrict;

import com.google.gson.annotations.Expose;

import cn.trymore.core.model.ModelBase;

/**
 * Model: 文档信息
 * 
 * @author Tang
 * 
 */
public class ModelDoc 
extends ModelBase {

	/**
	 * 
	 */
	private static final long serialVersionUID = 6590268185904116069L;
	
	@Expose
	protected ModelDocVisiableRange docVisiableRange;
	
	@Expose
	protected ModelSchoolDistrict district;
	
	@Expose
	protected ModelSchoolDepartment department;
	
	@Expose
	protected ModelDocLevel docLevel;
	
	@Expose
	protected ModelAppUser author;
	
	@Expose
	protected Integer typeDicid;
	
	@Expose
	protected String docName;
	
	@Expose
	protected String docUserNames;
	
	@Expose
	protected String docUserIds;
	
	@Expose
	protected Date createTime;
	
	@SuppressWarnings("rawtypes")
	private Set docFiles = new HashSet(0);

	public ModelDocVisiableRange getDocVisiableRange() {
		return docVisiableRange;
	}

	public void setDocVisiableRange(ModelDocVisiableRange docVisiableRange) {
		this.docVisiableRange = docVisiableRange;
	}

	public ModelSchoolDistrict getDistrict() {
		return district;
	}

	public void setDistrict(ModelSchoolDistrict district) {
		this.district = district;
	}

	public ModelSchoolDepartment getDepartment() {
		return department;
	}

	public void setDepartment(ModelSchoolDepartment department) {
		this.department = department;
	}

	public ModelDocLevel getDocLevel() {
		return docLevel;
	}

	public void setDocLevel(ModelDocLevel docLevel) {
		this.docLevel = docLevel;
	}

	public ModelAppUser getAuthor() {
		return author;
	}

	public void setAuthor(ModelAppUser author) {
		this.author = author;
	}

	public Integer getTypeDicid() {
		return typeDicid;
	}

	public void setTypeDicid(Integer typeDicid) {
		this.typeDicid = typeDicid;
	}

	public String getDocName() {
		return docName;
	}

	public void setDocName(String docName) {
		this.docName = docName;
	}

	public String getDocUserNames() {
		return docUserNames;
	}

	public void setDocUserNames(String docUserNames) {
		this.docUserNames = docUserNames;
	}

	public String getDocUserIds() {
		return docUserIds;
	}

	public void setDocUserIds(String docUserIds) {
		this.docUserIds = docUserIds;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	@SuppressWarnings("rawtypes")
	public Set getDocFiles() {
		return docFiles;
	}

	@SuppressWarnings("rawtypes")
	public void setDocFiles(Set docFiles) {
		this.docFiles = docFiles;
	}

}

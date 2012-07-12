package org.shengrui.oa.model.admin;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import org.shengrui.oa.model.system.ModelAppUser;
import org.shengrui.oa.model.system.ModelSchoolDepartment;
import org.shengrui.oa.model.system.ModelSchoolDistrict;

import cn.trymore.core.model.ModelBase;

/**
 * Model: 员工工作安排
 * 
 * @author Tang
 * 
 */
public class ModelDoc 
extends ModelBase {

	private static final long serialVersionUID = 1994576396269785788L;

	private ModelDocVisiableRange docVisiableRange;
	private ModelSchoolDistrict district;
	private ModelSchoolDepartment department;
	private ModelDocLevel docLevel;
	private ModelAppUser author;
	
	private Long typeDicid;
	
	private String docName;
	private String docUserNames;
	private String docUserIds;
	
	private Date createTime;
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
	public Long getTypeDicid() {
		return typeDicid;
	}
	public void setTypeDicid(Long typeDicid) {
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

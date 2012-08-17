package org.shengrui.oa.model.admin;

import java.util.Date;

import org.shengrui.oa.model.system.ModelAppDictionary;
import org.shengrui.oa.model.system.ModelAppUser;
import org.shengrui.oa.model.system.ModelSchoolDepartment;
import org.shengrui.oa.model.system.ModelSchoolDistrict;

import cn.trymore.core.model.ModelBase;
import cn.trymore.oa.model.system.ModelFileAttach;

import com.google.gson.annotations.Expose;

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
	
	/**
	 * 文档范围
	 */
	private Integer docVisiableRange;
	
	@Expose
	protected ModelSchoolDistrict district = new ModelSchoolDistrict();
	
	@Expose
	protected ModelSchoolDepartment department = new ModelSchoolDepartment();
	
	@Expose
	protected ModelDocLevel docLevel =new ModelDocLevel();
	
	@Expose
	protected ModelAppUser author =new ModelAppUser();
	
	@Expose
	protected ModelAppDictionary type =new ModelAppDictionary();
	
	@Expose
	protected String docName;
	
	@Expose
	protected String docUserNames;
	
	@Expose
	protected String docUserIds;
	
	@Expose
	protected ModelFileAttach file;
	
	@Expose
	protected Date createTime;
	
	/**
	 * The document range
	 * 
	 * @author Jeccy.Zhao
	 *
	 */
	public static enum EDocVisibleRange
	{
		ALL (-1, "all"),								// 所有校区
		PERSONALS (0, "personals");			// 个人所见
		
		private Integer value;
		private String text;
		
		EDocVisibleRange (Integer value, String text)
		{
			this.value = value;
			this.text = text;
		}
		
		public Integer getValue(){
			return value;
		}
		
		public String getText()
		{
			return this.text;
		}
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


	public ModelAppDictionary getType() {
		return type;
	}

	public void setType(ModelAppDictionary type) {
		this.type = type;
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

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((author == null) ? 0 : author.hashCode());
		result = prime * result
				+ ((createTime == null) ? 0 : createTime.hashCode());
		result = prime * result
				+ ((department == null) ? 0 : department.hashCode());
		result = prime * result
				+ ((district == null) ? 0 : district.hashCode());
		result = prime * result
				+ ((docLevel == null) ? 0 : docLevel.hashCode());
		result = prime * result + ((docName == null) ? 0 : docName.hashCode());
		result = prime * result
				+ ((docUserIds == null) ? 0 : docUserIds.hashCode());
		result = prime * result
				+ ((docUserNames == null) ? 0 : docUserNames.hashCode());
		result = prime
				* result
				+ ((docVisiableRange == null) ? 0 : docVisiableRange.hashCode());
		result = prime * result + ((type == null) ? 0 : type.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		ModelDoc other = (ModelDoc) obj;
		if (author == null) {
			if (other.author != null)
				return false;
		} else if (!author.equals(other.author))
			return false;
		
		if (department == null) {
			if (other.department != null)
				return false;
		} else if (!department.equals(other.department))
			return false;
		if (district == null) {
			if (other.district != null)
				return false;
		} else if (!district.equals(other.district))
			return false;
		
		if (docLevel == null) {
			if (other.docLevel != null)
				return false;
		} else if (!docLevel.equals(other.docLevel))
			return false;
		if (docName == null) {
			if (other.docName != null)
				return false;
		} else if (!docName.equals(other.docName))
			return false;
		if (docUserIds == null) {
			if (other.docUserIds != null)
				return false;
		} else if (!docUserIds.equals(other.docUserIds))
			return false;
		if (docUserNames == null) {
			if (other.docUserNames != null)
				return false;
		} else if (!docUserNames.equals(other.docUserNames))
			return false;
		if (docVisiableRange == null) {
			if (other.docVisiableRange != null)
				return false;
		} else if (!docVisiableRange.equals(other.docVisiableRange))
			return false;
		if (type == null) {
			if (other.type != null)
				return false;
		} else if (!type.equals(other.type))
			return false;
		return true;
	}

	public ModelFileAttach getFile() {
		return file;
	}

	public void setFile(ModelFileAttach file) {
		this.file = file;
	}

	public Integer getDocVisiableRange()
	{
		return docVisiableRange;
	}

	public void setDocVisiableRange(Integer docVisiableRange)
	{
		this.docVisiableRange = docVisiableRange;
	}
}

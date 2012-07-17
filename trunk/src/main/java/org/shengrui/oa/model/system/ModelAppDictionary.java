package org.shengrui.oa.model.system;

import java.util.Date;

import cn.trymore.core.model.ModelBase;

import com.google.gson.annotations.Expose;


/**
 * Model: 数据字典
 * 
 * @author Tang
 */
public class ModelAppDictionary 
extends ModelBase 
{

	
	/**
	 * 
	 */
	private static final long serialVersionUID = -3693956879066653L;

	/**
	 * 字典名称
	 */
	@Expose
	protected String name;
	
	/**
	 * 字典值
	 */
	@Expose
	protected String value;
	
	/**
	 * 字典描述
	 */
	@Expose
	protected String type;
	
	/**
	 * 序号
	 */
	@Expose
	protected Integer sn;
	
	/**
	 * 额外值
	 */
	@Expose
	protected String extraValue;
	
	
	/**
	 * 创建时间
	 */
	@Expose
	protected Date createDate;
	
	
	/**
	 * 修改时间
	 */
	@Expose
	protected  Date modifiedDate;


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public String getValue() {
		return value;
	}


	public void setValue(String value) {
		this.value = value;
	}


	public String getType() {
		return type;
	}


	public void setType(String type) {
		this.type = type;
	}


	public Integer getSn() {
		return sn;
	}


	public void setSn(Integer sn) {
		this.sn = sn;
	}


	public String getExtraValue() {
		return extraValue;
	}


	public void setExtraValue(String extraValue) {
		this.extraValue = extraValue;
	}


	public Date getCreateDate() {
		return createDate;
	}


	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}


	public Date getModifiedDate() {
		return modifiedDate;
	}


	public void setModifiedDate(Date modifiedDate) {
		this.modifiedDate = modifiedDate;
	}
	
	
	
}

package org.shengrui.oa.model.system;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.EqualsBuilder;

import cn.trymore.core.model.ModelBase;

import com.google.gson.annotations.Expose;


/**
 * Model: 数据字典
 * 
 * @author Jeccy.Zhao
 */
public class ModelAppDictionary 
extends ModelBase 
{

	private static final long serialVersionUID = -6522853859353390458L;
	
	/**
	 * 字典名称
	 */
	@Expose
	protected String itemName;
	
	/**
	 * 字典值
	 */
	@Expose
	protected String itemValue;
	
	/**
	 * 字典描述
	 */
	@Expose
	protected String itemDesc;
	
	/**
	 * 序号
	 */
	@Expose
	protected Short sn;
	
	@Expose
	protected ModelAppGlobalType globalType;
	
	public ModelAppDictionary () 
	{
		super();
	}
	
	public String getItemName() 
	{
		return this.itemName;
	}
	
	public void setItemName(String aValue) 
	{
		this.itemName = aValue;
	}	

	public String getItemValue() 
	{
		return this.itemValue;
	}
	
	public void setItemValue(String aValue) 
	{
		this.itemValue = aValue;
	}	

	public String getItemDesc() 
	{
		return this.itemDesc;
	}
	
	public void setItemDesc(String itemDesc) 
	{
		this.itemDesc = itemDesc;
	}	
	
	public ModelAppGlobalType getGlobalType()
	{
		return globalType;
	}

	public void setGlobalType(ModelAppGlobalType globalType) 
	{
		this.globalType = globalType;
	}

	public Short getSn() 
	{
		return sn;
	}

	public void setSn(Short sn) 
	{
		this.sn = sn;
	}
	
	@Override
	public boolean equals(Object object)
	{
		if (!(object instanceof ModelAppDictionary)) 
		{
			return false;
		}
		ModelAppDictionary rhs = (ModelAppDictionary) object;
		return new EqualsBuilder()
				.append(this.itemName, rhs.itemName)
				.append(this.itemValue, rhs.itemValue)
				.append(this.itemDesc, rhs.itemDesc)
				.isEquals();
	}
	
	@Override
	public String toString() 
	{
		return new ToStringBuilder(this)
				.append("itemName", this.itemName) 
				.append("itemValue", this.itemValue) 
				.append("descp", this.itemDesc) 
				.toString();
	}
}

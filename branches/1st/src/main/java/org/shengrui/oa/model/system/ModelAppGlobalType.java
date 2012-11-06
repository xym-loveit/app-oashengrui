package org.shengrui.oa.model.system;

import cn.trymore.core.model.ModelBase;

/**
 * Model: 系统总分类，用于显示树层次结构的分类
 * 
 * @author Jeccy.Zhao
 *
 */
public class ModelAppGlobalType
extends ModelBase
{

	private static final long serialVersionUID = 105662072793217253L;
	
	/**
	 * 名称
	 */
	protected String typeName;
	
	/**
	 * 路径
	 */
	protected String typePath;
	
	/**
	 * 层次
	 */
	protected Integer typeDepth;
	
	/**
	 * 父节点
	 */
	protected Long typeParentId;
	
	/**
	 * 节点Key
	 */
	protected String typeNodeKey;
	
	/**
	 * 节点分类Key
	 */
	protected String typeCatKey;
	
	/**
	 * 序号
	 */
	protected Integer typeSN;
	
	/**
	 * 默认构造函数
	 */
	public ModelAppGlobalType()
	{
		
	}
	
	public String getTypeName()
	{
		return typeName;
	}

	public void setTypeName(String typeName)
	{
		this.typeName = typeName;
	}

	public String getTypePath()
	{
		return typePath;
	}

	public void setTypePath(String typePath)
	{
		this.typePath = typePath;
	}

	public Integer getTypeDepth()
	{
		return typeDepth;
	}

	public void setTypeDepth(Integer typeDepth)
	{
		this.typeDepth = typeDepth;
	}

	public Long getTypeParentId()
	{
		return typeParentId;
	}

	public void setTypeParentId(Long typeParentId)
	{
		this.typeParentId = typeParentId;
	}

	public String getTypeNodeKey()
	{
		return typeNodeKey;
	}

	public void setTypeNodeKey(String typeNodeKey)
	{
		this.typeNodeKey = typeNodeKey;
	}

	public String getTypeCatKey()
	{
		return typeCatKey;
	}

	public void setTypeCatKey(String typeCatKey)
	{
		this.typeCatKey = typeCatKey;
	}

	public Integer getTypeSN()
	{
		return typeSN;
	}

	public void setTypeSN(Integer typeSN)
	{
		this.typeSN = typeSN;
	}
	
}

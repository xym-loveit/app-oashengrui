package org.shengrui.oa.model.flow;

import java.util.Set;

import com.google.gson.annotations.Expose;

import cn.trymore.core.model.ModelBase;

/**
 * Model: 工作流类型
 * 
 * @author Jeccy.Zhao
 *
 */
public class ModelProcessType
extends ModelBase
{
	
	private static final long serialVersionUID = 8044837347696639463L;

	private String id;
	
	/**
	 *  流程分类名称
	 */
	@Expose
	private String processTypeName;
	
	/**
	 * 流程分类KEY
	 */
	@Expose
	private String processTypeKey;
	
	/**
	 * 流程分类归类
	 */
	@Expose
	private String processTypeSlug;
	
	/**
	 * 流程分类描述
	 */
	@Expose
	private String processTypeDesc;
	
	/**
	 * 流程分类父分类
	 */
	private ModelProcessType processTypeParent;
	
	/**
	 * 流程类别子分类
	 */
	private Set<ModelProcessType> processTypeChildren;
	
	/**
	 * 流程分类拥有的工作流集合
	 */
	private Set<ModelProcessDefinition> processDefinitions;
	
	/**
	 * 流程类别可见范围 (全部, 总部, 校区)
	 */
	private Integer processTypeVisibility;
	
	/**
	 * The enumeration of process type visibility
	 * 
	 * @author Jeccy.Zhao
	 *
	 */
	public static enum EProcessTypeVisibility
	{
		ALL(null, "all"),						// 全部
		MASTER(1, "master"),					// 总部
		SLAVER (2, "slaver");					// 校区
		
		private Integer value;
		private String text;
		
		EProcessTypeVisibility (Integer value, String text)
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
	
	public String getProcessTypeName()
	{
		return processTypeName;
	}

	public void setProcessTypeName(String processTypeName)
	{
		this.processTypeName = processTypeName;
	}

	public String getProcessTypeKey()
	{
		return processTypeKey;
	}

	public void setProcessTypeKey(String processTypeKey)
	{
		this.processTypeKey = processTypeKey;
	}

	public String getProcessTypeDesc()
	{
		return processTypeDesc;
	}

	public void setProcessTypeDesc(String processTypeDesc)
	{
		this.processTypeDesc = processTypeDesc;
	}

	public String getProcessTypeSlug()
	{
		return processTypeSlug;
	}

	public void setProcessTypeSlug(String processTypeSlug)
	{
		this.processTypeSlug = processTypeSlug;
	}

	public ModelProcessType getProcessTypeParent()
	{
		return processTypeParent;
	}

	public void setProcessTypeParent(ModelProcessType processTypeParent)
	{
		this.processTypeParent = processTypeParent;
	}

	public Set<ModelProcessType> getProcessTypeChildren()
	{
		return processTypeChildren;
	}

	public void setProcessTypeChildren(Set<ModelProcessType> processTypeChildren)
	{
		this.processTypeChildren = processTypeChildren;
	}

	public Set<ModelProcessDefinition> getProcessDefinitions()
	{
		return processDefinitions;
	}

	public void setProcessDefinitions(Set<ModelProcessDefinition> processDefinitions)
	{
		this.processDefinitions = processDefinitions;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public void setProcessTypeVisibility(Integer processTypeVisibility)
	{
		if (processTypeVisibility != null && processTypeVisibility < 0) 
		{
			processTypeVisibility = null;
		}
		this.processTypeVisibility = processTypeVisibility;
	}

	public Integer getProcessTypeVisibility()
	{
		return processTypeVisibility;
	}
}

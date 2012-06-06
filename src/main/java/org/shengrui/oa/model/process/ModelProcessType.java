package org.shengrui.oa.model.process;

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
	
	@Expose
	private String processTypeName;
	
	@Expose
	private String processTypeKey;
	
	@Expose
	private String processTypeDesc;
	
	@Expose
	private ModelProcessType processParent;

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

	public ModelProcessType getProcessParent()
	{
		return processParent;
	}

	public void setProcessParent(ModelProcessType processParent)
	{
		this.processParent = processParent;
	}
}

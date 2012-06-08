package org.shengrui.oa.model.hrm;

import cn.trymore.core.model.ModelBase;

public class ModelHrmEntry
extends ModelBase
{

	private static final long serialVersionUID = 6907070615463442502L;
	
	private ModelHrmResume resume;
	
	private Integer status;

	public void setResume(ModelHrmResume resume)
	{
		this.resume = resume;
	}

	public ModelHrmResume getResume()
	{
		return resume;
	}

	public void setStatus(Integer status)
	{
		this.status = status;
	}

	public Integer getStatus()
	{
		return status;
	}
	
}

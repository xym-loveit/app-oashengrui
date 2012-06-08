package org.shengrui.oa.model.hrm;

import java.util.Set;

import org.shengrui.oa.model.system.ModelFileAttach;

import cn.trymore.core.model.ModelBase;

public class ModelHrmResume
extends ModelBase
{

	private static final long serialVersionUID = -3713433577264362635L;
	
	private Set<ModelFileAttach> attachFiles;

	public void setAttachFiles(Set<ModelFileAttach> attachFiles)
	{
		this.attachFiles = attachFiles;
	}

	public Set<ModelFileAttach> getAttachFiles()
	{
		return attachFiles;
	}
	
}

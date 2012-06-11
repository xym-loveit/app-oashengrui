package org.shengrui.oa.model.hrm;

import java.util.Set;

import cn.trymore.core.model.ModelBase;

public class ModelHrmEmployee
extends ModelBase
{

	private static final long serialVersionUID = -8811440104989696140L;
	
	/**
	 * 员工档案
	 */
	private ModelHrmEmployeeProfile profile;
	
	/**
	 * 员工履历
	 */
	private Set<ModelHrmEmployeeRoadMap> roadMaps;

	public void setProfile(ModelHrmEmployeeProfile profile)
	{
		this.profile = profile;
	}

	public ModelHrmEmployeeProfile getProfile()
	{
		return profile;
	}

	public void setRoadMaps(Set<ModelHrmEmployeeRoadMap> roadMaps)
	{
		this.roadMaps = roadMaps;
	}

	public Set<ModelHrmEmployeeRoadMap> getRoadMaps()
	{
		return roadMaps;
	}

}

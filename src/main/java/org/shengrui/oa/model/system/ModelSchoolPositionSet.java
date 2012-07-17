package org.shengrui.oa.model.system;

import java.util.Set;

import cn.trymore.core.model.ModelBase;

/**
 * Model: 职位
 * 
 * @author Jeccy.Zhao
 *
 */
public class ModelSchoolPositionSet
extends ModelBase
{

	/**
	 * The serial UID
	 */
	private static final long serialVersionUID = -6087255615703248486L;
	
	/**
	 * 职位名称
	 */
	private String posetName;
	
	/**
	 * 职位对应的岗位集合
	 */
	private Set<ModelSchoolDepartmentPosition> positions;
	
	public String getPosetName()
	{
		return posetName;
	}

	public void setPosetName(String posetName)
	{
		this.posetName = posetName;
	}

	public void setPositions(Set<ModelSchoolDepartmentPosition> positions)
	{
		this.positions = positions;
	}

	public Set<ModelSchoolDepartmentPosition> getPositions()
	{
		return positions;
	}
	
}

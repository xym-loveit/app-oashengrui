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
	
	/**
	 * 员工编号
	 */
	private String empNo;
	
	/**
	 * 部门ID
	 */
	private int depId;
	
	/**
	 * 校区ID
	 */
	private int districtId;
	
	/**
	 * 员工全名
	 */
	private String empName;
	
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

	public String getEmpNo() {
		return empNo;
	}

	public void setEmpNo(String empNo) {
		this.empNo = empNo;
	}

	public int getDepId() {
		return depId;
	}

	public void setDepId(int depId) {
		this.depId = depId;
	}

	public int getDistrictId() {
		return districtId;
	}

	public void setDistrictId(int districtId) {
		this.districtId = districtId;
	}

	public String getEmpName() {
		return empName;
	}

	public void setEmpName(String empName) {
		this.empName = empName;
	}
	
}

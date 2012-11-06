package org.shengrui.oa.model.system;

import org.shengrui.oa.util.AppUtil;

import cn.trymore.core.acl.AclFilterAnnotation;
import cn.trymore.core.model.ModelBase;

/**
 * Model: 校区设置
 * 
 * @author Jeccy.Zhao
 *
 */
public class ModelSchoolDistrict
extends ModelBase
{

	private static final long serialVersionUID = 1206326112546284444L;
	
	/**
	 * 校区编号
	 */
	private String districtNo;
	
	/**
	 * 校区名称
	 */
	private String districtName;
	
	/**
	 * 校区地址
	 */
	private String districtAddress;
	
	/**
	 * 校区电话
	 */
	private String districtPhone;
	
	/**
	 * 校区类型
	 */
	private Integer districtType;
	
	/**
	 * 校区上级
	 */
	private transient ModelSchoolDistrict districtParent;
	
	/**
	 * 数据权限过滤
	 */
	@AclFilterAnnotation(
		fieldNames ={"district_id"}, 
		fieldTypes ={AppUtil.DATA_POLICY_DISTRICT}
	)
	private String aclFilterFields;
	
	public String getDistrictNo()
	{
		return districtNo;
	}

	public void setDistrictNo(String districtNo)
	{
		this.districtNo = districtNo;
	}

	public String getDistrictAddress()
	{
		return districtAddress;
	}

	public void setDistrictAddress(String districtAddress)
	{
		this.districtAddress = districtAddress;
	}

	public String getDistrictPhone()
	{
		return districtPhone;
	}

	public void setDistrictPhone(String districtPhone)
	{
		this.districtPhone = districtPhone;
	}

	public Integer getDistrictType()
	{
		return districtType;
	}

	public void setDistrictType(Integer districtType)
	{
		this.districtType = districtType;
	}

	public ModelSchoolDistrict getDistrictParent()
	{
		return districtParent;
	}

	public void setDistrictParent(ModelSchoolDistrict districtParent)
	{
		this.districtParent = districtParent;
	}

	public String getDistrictName()
	{
		return districtName;
	}

	public void setDistrictName(String districtName)
	{
		this.districtName = districtName;
	}

	public void setAclFilterFields(String aclFilterFields)
	{
		this.aclFilterFields = aclFilterFields;
	}

	public String getAclFilterFields()
	{
		return aclFilterFields;
	}
	
}

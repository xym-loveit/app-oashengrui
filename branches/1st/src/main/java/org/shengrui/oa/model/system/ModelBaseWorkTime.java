/**
 * 
 */
package org.shengrui.oa.model.system;

import java.util.Date;


import cn.trymore.core.model.ModelBase;

/**
 * @author Tank.L
 *
 */
public class ModelBaseWorkTime extends ModelBase {
   private static final long serialVersionUID = 4833781344724547911L;
   protected String itemName;
   protected String workStime;
   protected String workEtime;
   protected String meto;
   protected String adjustDays;
   protected String templateId;
   protected Date updateTime;
   /**
     * 校区ID
     */
   private ModelSchoolDistrict baseTimeDistrict = new ModelSchoolDistrict();
public String getItemName() {
	return itemName;
}
public void setItemName(String itemName) {
	this.itemName = itemName;
}
public String getMeto() {
	return meto;
}
/**
 * @return the workStime
 */
public String getWorkStime() {
	return workStime;
}
/**
 * @param workStime the workStime to set
 */
public void setWorkStime(String workStime) {
	this.workStime = workStime;
}
/**
 * @return the workEtime
 */
public String getWorkEtime() {
	return workEtime;
}
/**
 * @param workEtime the workEtime to set
 */
public void setWorkEtime(String workEtime) {
	this.workEtime = workEtime;
}
public void setMeto(String meto) {
	this.meto = meto;
}
public String getAdjustDays() {
	return adjustDays;
}
public void setAdjustDays(String adjustDays) {
	this.adjustDays = adjustDays;
}
public String getTemplateId() {
	return templateId;
}
public void setTemplateId(String templateId) {
	this.templateId = templateId;
}
public Date getUpdateTime() {
	return updateTime;
}
public void setUpdateTime(Date updateTime) {
	this.updateTime = updateTime;
}
public ModelSchoolDistrict getBaseTimeDistrict() {
	return baseTimeDistrict;
}
public void setBaseTimeDistrict(ModelSchoolDistrict baseTimeDistrict) {
	this.baseTimeDistrict = baseTimeDistrict;
}
}

package org.shengrui.oa.model.system;

import java.util.Date;

import cn.trymore.core.model.ModelBase;

/**
 * @author Tank.L
 *
 */
public class ModelBaseWorkContent extends ModelBase {
   private static final long serialVersionUID = 2512679473832637014L;
   protected String itemName;
   protected String itemValue;
   protected String meto;
   protected Date updateTime;
   /**
    * 校区ID
    */
   private ModelSchoolDistrict baseWorkDistrict = new ModelSchoolDistrict();
   /**
    * @return the itemName
    */
   public String getItemName() {
      return itemName;
   }
   /**
    * @param itemName the itemName to set
    */
   public void setItemName(String itemName) {
      this.itemName = itemName;
   }
   /**
    * @return the itemValue
    */
   public String getItemValue() {
      return itemValue;
   }
   /**
    * @param itemValue the itemValue to set
    */
   public void setItemValue(String itemValue) {
      this.itemValue = itemValue;
   }
   /**
    * @return the meto
    */
   public String getMeto() {
      return meto;
   }
   /**
    * @param meto the meto to set
    */
   public void setMeto(String meto) {
      this.meto = meto;
   }
   /**
 * @return the baseWorkDistrict
 */
public ModelSchoolDistrict getBaseWorkDistrict() {
	return baseWorkDistrict;
}
/**
 * @param baseWorkDistrict the baseWorkDistrict to set
 */
public void setBaseWorkDistrict(ModelSchoolDistrict baseWorkDistrict) {
	this.baseWorkDistrict = baseWorkDistrict;
}
/**
    * @return the updateTime
    */
   public Date getUpdateTime() {
      return updateTime;
   }
   /**
    * @param updateTime the updateTime to set
    */
   public void setUpdateTime(Date updateTime) {
      this.updateTime = updateTime;
   }
}

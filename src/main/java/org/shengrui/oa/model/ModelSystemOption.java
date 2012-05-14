package org.shengrui.oa.model;

import java.util.Date;

/**
 * The model of site settings
 * 
 * @author Jeccy.Zhao
 *
 */
public class ModelSystemOption 
extends ModelBase
{
	/**
	 * The serial version UID
	 */
	private static final long serialVersionUID = 3654677555131561182L;
	
	/**
	 * The property name
	 */
	private String optionName;
	
	/**
	 * The property value
	 */
	private String optionValue;
	
	/**
	 * The property slug name
	 */
	private String optionSlug;
	
	/**
	 * The property extra value
	 */
	private String optionExtraValue;
	
	/**
	 * The property visible 
	 */
	private Integer optionVisible = EnumOptionVisible.VISIBLE.getValue();
	
	/**
	 * The property creation time
	 */
	private Date optionCreateTime;
	
	/**
	 *  The enumeration of option visible
	 *  
	 * @author Jeccy.Zhao
	 *
	 */
	public static enum EnumOptionVisible
	{
		HIDDEN (0, "hidden"),
		VISIBLE (1, "visible");
		
		private Integer value;
		private String slug;
		
		EnumOptionVisible (Integer value, String slug)
		{
			this.value = value;
			this.slug = slug;
		}
		
		public Integer getValue()
		{
			return this.value;
		}
		
		public String getSlug()
		{
			return this.slug;
		}
		
	}
	
	/**
	 * The default constructor
	 */
	public ModelSystemOption ()
	{
		
	}
	
	/**
	 * The sole constructor
	 * 
	 * @param optionName
	 *          the property name
	 * @param optionValue
	 *          the property value
	 * @param optionSlug
	 *          the property slug name
	 */
	public ModelSystemOption (String optionName, 
			String optionValue, String optionSlug)
	{
		this.optionName = optionName;
		this.optionValue = optionValue;
		this.optionSlug = optionSlug;
	}
	
	public String getOptionName()
	{
		return optionName;
	}
	
	public void setOptionName(String optionName) 
	{
		this.optionName = optionName;
	}
	
	public String getOptionValue() 
	{
		return optionValue;
	}
	
	public void setOptionValue(String optionValue)
	{
		this.optionValue = optionValue;
	}
	
	public String getOptionSlug() 
	{
		return optionSlug;
	}
	
	public void setOptionSlug(String optionSlug) 
	{
		this.optionSlug = optionSlug;
	}

	public void setOptionExtraValue(String optionExtraValue)
	{
		this.optionExtraValue = optionExtraValue;
	}

	public String getOptionExtraValue()
	{
		return optionExtraValue;
	}
	
	public Integer getOptionVisible()
	{
		return optionVisible;
	}

	public void setOptionVisible(Integer optionVisible) 
	{
		this.optionVisible = optionVisible;
	}

	public Date getOptionCreateTime() {
		return optionCreateTime;
	}

	public void setOptionCreateTime(Date optionCreateTime) {
		this.optionCreateTime = optionCreateTime;
	}
}

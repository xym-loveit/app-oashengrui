package org.shengrui.oa.util;

/**
 * The application utilities
 * 
 * @author Jeccy.Zhao
 *
 */
public class AppUtil
{
	
	/**
	 * The enumeration of application school type
	 * 
	 * @author Jeccy.Zhao
	 *
	 */
	public static enum EAppSchoolType
	{
		HEADQUARTERS (0, "headquarters"),		// 总部
		AREA_CAMPUS(1, "area_camput"),		// 校区
		AREA_SLOT(2, "area_slot");				// 片区
		
		private Integer value;
		private String text;
		
		EAppSchoolType (Integer value, String text)
		{
			this.value = value;
			this.text = text;
		}
		
		public Integer getValue(){
			return value;
		}
		
		public String getText()
		{
			return this.text;
		}
	}
}

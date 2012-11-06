package org.shengrui.oa.util;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import cn.trymore.core.util.UtilDate;

import com.googlecode.aviator.AviatorEvaluator;
import com.googlecode.aviator.Expression;

/**
 * The application utilities
 * 
 * @author Jeccy.Zhao
 *
 */
public class AppUtil
{
	
	private static final String FORM_DATE_PATTERN = "yyyyMMddHHmmss";

	/**
	 * 部门数据权限类型标识符
	 */
	public static final String DATA_POLICY_DEPARTMENT = "V_DEP";
	
	/**
	 * 校区数据权限类型标识符
	 */
	public static final String DATA_POLICY_DISTRICT = "V_DIS";
	
	/**
	 * 个人数据权限类型标识符
	 */
	public static final String DATA_POLICY_PERSONAL = "V_PERSONAL";
	
	/**
	 * The enumeration of application school type
	 * 
	 * @author Jeccy.Zhao
	 *
	 */
	public static enum EAppSchoolType
	{
		HEADQUARTERS (0, "headquarters"),		// 总部
		AREA_CAMPUS(1, "area_camput"),			// 校区
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
	
	/**
	 * The enumeration of data permission
	 * 
	 * @author Jeccy.Zhao
	 *
	 */
	public static enum EDataPermissions
	{
		/**
		 * 个人数据
		 */
		DP_MINE(1, AppUtil.DATA_POLICY_PERSONAL),						
		
		/**
		 * 部门数据
		 */
		DP_DEP_CURRENT(2, AppUtil.DATA_POLICY_DEPARTMENT),		
		
		/**
		 * 大部门数据
		 */
		DP_DEP_WHOLE(3, AppUtil.DATA_POLICY_DEPARTMENT),			
		
		/**
		 * 校区数据
		 */
		DP_DIS_CURRENT(4, AppUtil.DATA_POLICY_DISTRICT),			
		
		/**
		 * 全校数据
		 */
		DP_DIS_WHOLE(5, AppUtil.DATA_POLICY_DISTRICT);				
		
		private Integer value;
		private String type;
		
		EDataPermissions (Integer value, String type)
		{
			this.value = value;
			this.type = type;
		}
		
		public Integer getValue(){
			return value;
		}
		
		public String getType()
		{
			return this.type;
		}
	}
	
	/**
	 * Return true if the given condition expression satisfied.
	 *  
	 * @param expression
	 *           the condition expression
	 * @param paramValue
	 *           the parameter value that will be applied in the expression
	 * @return true if expression satisfied; false otherwise.
	 */
	public static Boolean isCondExprSatisfied (String expression, Object paramValue)
	{
		Expression expr = AviatorEvaluator.compile(expression);
		Map<String, Object> env = new HashMap<String, Object>();
		env.put("x", paramValue);
		return (Boolean)expr.execute(env);
	}
	
	/**
	 * Generates the form no with the specified form key.
	 * 
	 * @param formKey
	 *          the form key.
	 * @return generated form no.
	 */
	public static String genFormNo (String formKey)
	{
		StringBuilder builder = new StringBuilder();
		
		builder.append(formKey);
		builder.append(UtilDate.parseTime(new Date(), FORM_DATE_PATTERN));
		
		return builder.toString();
	}
	
}

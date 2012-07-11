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

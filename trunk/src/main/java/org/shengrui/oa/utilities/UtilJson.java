package org.shengrui.oa.utilities;

import com.google.gson.Gson;

/**
 * The utility of JSON
 * 
 * @author Jeccy.Zhao
 *
 */
public class UtilJson 
{
	/**
	 * The instance of gson.
	 */
	private static final Gson gson = new Gson();
	
	/**
	 * Converts the specified object into JSON string
	 * 
	 * @param src
	 *         the object
	 * @return JSON string
	 */
	public static String toJson (Object obj)
	{
		return gson.toJson(obj);
	}
	
}

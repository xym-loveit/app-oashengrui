package cn.trymore.core.util;

/**
 * The helper class of string operation.
 * 
 * @author  Jeccy.Zhao
 *
 */
public class UtilString 
{
	
	/**
	 * Joins the specified list of strings with defaut separator ","
	 * 
	 * @param strs
	 *          list of strings to be joined
	 * @return the string joined with the separator ","
	 */
	public static String join (Object[] strs) 
	{
		return join (strs, ",");
	}
	
	/**
	 * Joins the specified list of strings 
	 * with provided join separator charactor
	 * 
	 * @param strs
	 *          list of strings to be joined
	 * @param join
	 *          the charactor used to join the strings
	 * @return the string joined with the separator ","
	 */
	public static String join (Object[] strs, String join)
	{
		StringBuilder sb = new StringBuilder();
		if (strs != null) 
		{
			for (int i = 0, size = strs.length; i < size; i++) 
			{
				sb.append(strs[i]);
				if (i < size - 1) 
				{
					sb.append(join);
				}
			}
		}
		return sb.toString();
	}
	
	/**
	 * Returns the specified string is not empty
	 * 
	 * @param text
	 *         the string
	 * @return true if the specified string not empty
	 */
	public static boolean isNotEmpty (final String text) 
	{
		return text != null && !text.trim().isEmpty();
	}
	
	/**
	 * Returns the specified list of strings is not empty
	 * 
	 * @param strings
	 *          the list of strings
	 * @return true if the specified strings not empty
	 */
	public static boolean isNotEmpty (final String... strings)
	{
		if (strings != null && strings.length > 0) 
		{
			for (String string : strings) 
			{
				if (!isNotEmpty(string)) 
				{
					return false;
				}
			}
			return true;
		} 
		else 
		{
			return false;
		}
	}
	
	/**
	 * Only for local test, should be removed after deploy.
	 * 
	 * @param str
	 * @return
	 */
	public static String revertUnicodeChars (String str)
	{
		str = str.replace("%20", " ");
		str = str.replace("%2F", "/");
		return str;
	}
	
}

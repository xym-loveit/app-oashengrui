package cn.trymore.core.util;

import java.security.MessageDigest;
import java.util.HashSet;
import java.util.Set;

import org.apache.commons.codec.binary.Base64;

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
	
	/**
	 * Converts the string list to set collection.
	 * 
	 * @param strs
	 *                the string array list
	 * @return set collection
	 */
	public static Set<String> convertToSet (final String[] strs)
	{
		if (strs != null && strs.length > 0)
		{
			Set<String> sets = new HashSet<String>();
			for (String str : strs)
			{
				sets.add(str);
			}
			
			return sets;
		}
		
		return null;
	}
	
	/**
	 * Converts the quot
	 * 
	 * @param paramString
	 * @return
	 */
	public static String convertQuot(String paramString)
	{
		return paramString.replace("'", "\\'").replace("\"", "\\\"");
	}
	
	/**
	 * Encrypt the specified string to SHA256 encodes.
	 * 
	 * @param paramString
	 * @return
	 */
	public static synchronized String encryptSha256(String paramString)
	{
		try
		{
			MessageDigest localMessageDigest = MessageDigest.getInstance("SHA-256");
			byte[] arrayOfByte = localMessageDigest.digest(paramString.getBytes("UTF-8"));
			return new String(Base64.encodeBase64(arrayOfByte));
		}
		catch (Exception e)
		{
			// do nothing here.
		}
		return null;
	}
	
	/**
	 * 
	 * @param input
	 * @return
	 * @author Zhao.Xiang
	 */
	public static String filter(String input) 
	{
		String tmp = input;
		tmp = tmp.replace("´", "'");
		tmp = tmp.replace("”", "\"");
		tmp = tmp.replace("“", "\"");
		tmp = tmp.replace("‘", "'");
		return tmp;
	}
	
	/**
	 * Returns true if the specified string is numberic
	 * 
	 * @param paramString
	 * @return
	 */
	public static boolean isNumeric(String paramString)
	{
		int i = paramString.length();
		while (true)
		{
			i--;
			if (i < 0)
			{
				break;
			}
			if (!Character.isDigit(paramString.charAt(i)))
			{
				return false;
			}
		}
		return true;
	}
	
}

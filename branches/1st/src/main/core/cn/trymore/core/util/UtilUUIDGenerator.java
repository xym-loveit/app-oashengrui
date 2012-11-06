package cn.trymore.core.util;

import java.util.UUID;

/**
 * The utility of UUID generation.
 * 
 * @author Jeccy.Zhao
 *
 */
public class UtilUUIDGenerator
{
	public static String getUUID()
	{
		String str = UUID.randomUUID().toString();
		return str.substring(0, 8) + str.substring(9, 13)
				+ str.substring(14, 18) + str.substring(19, 23)
				+ str.substring(24);
	}

	public static String[] getUUID(int paramInt)
	{
		if (paramInt < 1)
			return null;
		String[] arrayOfString = new String[paramInt];
		for (int i = 0; i < paramInt; i++)
			arrayOfString[i] = getUUID();
		return arrayOfString;
	}

	public static void main(String[] paramArrayOfString)
	{
		String[] arrayOfString = UUID.randomUUID().toString().split("-");
		for (int i = 0; i < arrayOfString.length; i++)
		{
			System.out.println("ok:" + arrayOfString[i]);
			long l = Long.valueOf(arrayOfString[i], 16).longValue();
			System.out.println("ok:===" + l);
		}
	}
}

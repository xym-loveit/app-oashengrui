package cn.trymore.core.jstl;

import org.shengrui.oa.model.system.ModelAppUser;
import org.shengrui.oa.util.ContextUtil;

import cn.trymore.core.util.UtilString;

/**
 * The JSTL tag to control resources access, i.e. URL access.
 * 
 * @author Jeccy.Zhao
 *
 */
public class JstlTagSecurity
{
	/**
	 * Returns true if the specified menu key granted on
	 * the current user which polled out from session.
	 * 
	 * @param menuKey
	 *          the menu key
	 * @return
	 */
	public static boolean ifMenuGranted (String menuKey)
	{
		ModelAppUser user = ContextUtil.getCurrentUser();
		if (user != null)
		{
			// 管理员角色
			if (user.isSuerUser())
			{
				return true;
			}
			
			return user.getMenuKeys() != null && user.getMenuKeys().contains(menuKey);
		}
		return false;
	}
	
	/**
	 * Returns true if the specified function key granted on
	 * the current user which polled out from session.
	 * 
	 * @param funcKeys
	 *          the function keys, multi function key separated with ,
	 * @return
	 */
	public static boolean ifGranted (String funcKeys)
	{
		ModelAppUser user = ContextUtil.getCurrentUser();
		if (user != null)
		{
			// 管理员角色
			if (user.isSuerUser())
			{
				return true;
			}
			
			if (UtilString.isNotEmpty(user.getFunctionRights()))
			{
				String[] arrayFuncKeys = funcKeys.split(",");
				for (String funcKey : arrayFuncKeys)
				{
					if (JstlTagString.inRange(user.getFunctionRights(), funcKey, ","))
					{
						return true;
					}
				}
			}
		}
		return false;
	}
}

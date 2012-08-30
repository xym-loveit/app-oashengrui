package cn.trymore.core.dwr;

import java.util.Collection;

import javax.servlet.http.HttpSession;

import org.directwebremoting.Browser;
import org.directwebremoting.ScriptSession;
import org.directwebremoting.WebContextFactory;
import org.directwebremoting.event.ScriptSessionEvent;
import org.directwebremoting.event.ScriptSessionListener;
import org.directwebremoting.impl.DefaultScriptSession;
import org.directwebremoting.impl.DefaultScriptSessionManager;

import cn.trymore.core.common.Constants;
import cn.trymore.core.util.UtilString;

/**
 * The session manager for client script, 
 * aims to monitor the script session creation and destroy. 
 * 
 * @author Jeccy.Zhao
 * 
 */
public class ScriptSessionManager 
extends DefaultScriptSessionManager
{
	public static final String SS_ID = "DWR_ScriptSession_Id";
	
	public static final String SS_UID = "DWR_ScriptSession_UID";
	
	/**
	 * The default constructor.
	 */
	public ScriptSessionManager()
	{
		try
		{
			addScriptSessionListener(new ScriptSessionListener() 
			{
				/*
				 * (non-Javadoc)
				 * @see org.directwebremoting.event.ScriptSessionListener#sessionDestroyed(org.directwebremoting.event.ScriptSessionEvent)
				 */
				@Override
				public void sessionDestroyed(ScriptSessionEvent event) 
				{
				}
				
				/*
				 * (non-Javadoc)
				 * @see org.directwebremoting.event.ScriptSessionListener#sessionCreated(org.directwebremoting.event.ScriptSessionEvent)
				 */
				@Override
				public void sessionCreated(ScriptSessionEvent event) 
				{
					//得到新创建的scriptSession
					ScriptSession scriptSession = event.getSession();
					
					//得到产生的httpSession
					HttpSession httpSession = WebContextFactory.get().getSession();
					
					//得到当前用户员工ID
					String uid = (String) httpSession.getAttribute(Constants.SESSION_KEY_USER_EMPID);
					
					//如果当前用户已经退出系统，然后销毁这个Script Session
					if (!UtilString.isNotEmpty(uid))
					{
						scriptSession.invalidate();
						httpSession.invalidate();
						return;
					}
					
					//查找SS_ID
					String ssId = (String) httpSession.getAttribute(SS_ID);
					
					if (ssId!=null)
					{
						//说明已经存在旧的scriptSession.注销这个旧的scriptSession
						DefaultScriptSession oldScriptSession = sessionMap.get(ssId);
						if(oldScriptSession!=null)
						{
							invalidate(oldScriptSession);
						}
					}
					
					httpSession.setAttribute(SS_ID, scriptSession.getId());
					
					//绑定用户ID到ScriptSession上
					scriptSession.setAttribute(SS_UID, uid);
				}
			});
		}
		catch (Exception e) 
		{
			e.printStackTrace();
		}
	}
	
	/**
	 * Invalidates the script session with the specified script session id.
	 * 
	 * @param ssId
	 *         the script session id.
	 */
	public static void invalidate(String ssId)
	{
		Browser.withSession(ssId, new Runnable()
		{
			public void run()
			{
				Collection<ScriptSession> sessions = Browser.getTargetSessions();
				for (ScriptSession session : sessions)
				{
					session.invalidate();
				}
			}
		});
	}
	
}
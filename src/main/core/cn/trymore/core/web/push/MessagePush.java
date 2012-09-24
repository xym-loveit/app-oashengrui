package cn.trymore.core.web.push;

import java.util.Collection;

import org.apache.log4j.Logger;
import org.directwebremoting.Browser;
import org.directwebremoting.ScriptBuffer;
import org.directwebremoting.ScriptSession;
import org.directwebremoting.ScriptSessionFilter;

import cn.trymore.core.dwr.ScriptSessionManager;
import cn.trymore.core.util.UtilString;

/**
 * Push message to client from server once data updated.
 * 
 * @author x36zhao
 *
 */
public class MessagePush
{
	
	/**
	 * The LOGGER
	 */
	private static final Logger LOGGER = Logger.getLogger(MessagePush.class);
	
	/**
	 * Push message to client
	 * 
	 * @param userIds
	 *          the list of user ids
	 * @param scriptMethodName
	 *          the script method name
	 * @param args
	 *          the arguments that applied in the script
	 */
	public void pushMessage (final String[] userIds, 
			final String scriptMethodName, final Object... args)
	{
		for (String userId : userIds)
		{
			pushMessage(userId, scriptMethodName, args);
		}
	}
	
	/**
	 * Push message to browser client
	 * 
	 * @param userId
	 *          the user id
	 * @param scriptMethodName
	 *          the script method name
	 * @param args
	 *          the arguments that applied in the script
	 */
	public void pushMessage (final String userId, 
		final String scriptMethodName, final Object... args)
	{
		final String[] uids = userId.split(",");
		
		for (final String uid : uids)
		{
			if (UtilString.isNotEmpty(uid))
			{
				try
				{
					// script session filter
					Browser.withAllSessionsFiltered (new ScriptSessionFilter()
					{
						public boolean match(ScriptSession session) 
						{
							if (session.getAttribute(ScriptSessionManager.SS_UID) == null)
							{
								return false;
							}
							else
							{
								return (session.getAttribute(ScriptSessionManager.SS_UID)).equals(uid);
							}
						}
					}, new Runnable() {
						
						private ScriptBuffer script = new ScriptBuffer();
						
						public void run() 
						{
							// calls the script that defined in the browser client
							script.appendCall(scriptMethodName, args);
							Collection<ScriptSession> sessions = Browser.getTargetSessions();
							for (ScriptSession scriptSession : sessions) 
							{
								scriptSession.addScript(script);
							}
						}
					});
				}
				catch (Exception e)
				{
					LOGGER.error("Exception raised when pushing message from server to client.", e);
				}
			}
		}
	}

	public static Logger getLogger()
	{
		return LOGGER;
	}
	
}

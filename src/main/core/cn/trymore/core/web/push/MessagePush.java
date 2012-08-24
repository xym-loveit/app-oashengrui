package cn.trymore.core.web.push;

import java.util.Collection;

import org.directwebremoting.Browser;
import org.directwebremoting.ScriptBuffer;
import org.directwebremoting.ScriptSession;
import org.directwebremoting.ScriptSessionFilter;

import cn.trymore.core.dwr.ScriptSessionManager;

/**
 * Push message to client from server once data updated.
 * 
 * @author x36zhao
 *
 */
public class MessagePush
{
	/**
	 * Push message to client
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
					return (session.getAttribute(ScriptSessionManager.SS_UID)).equals(userId);
				}
			}
		}, new Runnable() {
			
			private ScriptBuffer script = new ScriptBuffer();
			
			public void run() 
			{
				script.appendCall(scriptMethodName, args);
				Collection<ScriptSession> sessions = Browser.getTargetSessions();
				for (ScriptSession scriptSession : sessions) 
				{
					scriptSession.addScript(script);
				}
			}
		});
	}
	
}

package cn.trymore.core.web.listener;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import cn.trymore.core.common.Constants;

/**
 * User session listener, 
 * It aims to clear the session keys after session destroyed. 
 * 
 * @author Jeccy.Zhao
 *
 */
public class UserSessionListener
implements HttpSessionListener
{
	/*
	 * (non-Javadoc)
	 * @see javax.servlet.http.HttpSessionListener#sessionCreated(javax.servlet.http.HttpSessionEvent)
	 */
	@Override
	public void sessionCreated(HttpSessionEvent arg0)
	{
		// TODO Auto-generated method stub
		
	}
	
	/*
	 * (non-Javadoc)
	 * @see javax.servlet.http.HttpSessionListener#sessionDestroyed(javax.servlet.http.HttpSessionEvent)
	 */
	@Override
	public void sessionDestroyed(HttpSessionEvent evt)
	{
		HttpSession session = evt.getSession();
		
		session.removeAttribute(Constants.SESSION_KEY_USER_EMPID);
		session.removeAttribute(Constants.SESSION_KEY_USER_FULLNAME);
		session.removeAttribute(Constants.SESSION_KEY_USER_ID);
		session.removeAttribute(Constants.SESSION_KEY_USER_NAME);
		session.removeAttribute(Constants.SESSION_KEY_USER_POSITION);
	}

}

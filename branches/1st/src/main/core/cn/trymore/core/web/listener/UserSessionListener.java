/*
 * Copyright (c) 2010-2012 Zhao.Xiang<z405656232x@163.com> Holding Limited.
 * All rights reserved.
 * 
 * Licensed to the Apache Software Foundation (ASF) under one or more
 * contributor license agreements.  See the NOTICE file distributed with
 * this work for additional information regarding copyright ownership.
 * The ASF licenses this file to You under the Apache License, Version 2.0
 * (the "License"); you may not use this file except in compliance with
 * the License.  You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

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

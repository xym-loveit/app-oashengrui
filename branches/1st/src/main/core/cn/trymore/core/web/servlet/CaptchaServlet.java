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

package cn.trymore.core.web.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import nl.captcha.Captcha;
import nl.captcha.servlet.CaptchaServletUtil;

/**
 * The servlet for simpleCaptcha
 * 
 * @author Jeccy.Zhao
 *
 */
public class CaptchaServlet
extends HttpServlet
{

	private static final long serialVersionUID = 6387714068021116303L;
	
	/**
	 * The LOGGER
	 */
	private static final Logger LOGGER = Logger.getLogger(CaptchaServlet.class);
			
	/**
	 * The parameter for height
	 */
	public static final String PARAM_HEIGHT = "height";
	
	/**
	 * The parameter for width
	 */
	public static final String PARAM_WIDTH = "width";
	
	/**
	 * The default width value
	 */
	protected int _width = 200;
	
	/**
	 * The default height value
	 */
	protected int _height = 50;
	
	/**
	 * Initialization, mainly to set the height & width parameter
	 */
	public void init() throws ServletException
	{
		if (getInitParameter("height") != null)
		{
			this._height = Integer.valueOf(getInitParameter("height")).intValue();
		}
		
		if (getInitParameter("width") != null)
		{
			this._width = Integer.valueOf(getInitParameter("width")).intValue();
		}
	}
	
	/*
	 * (non-Javadoc)
	 * @see javax.servlet.http.HttpServlet#doGet(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
	 */
	@Override
	public void doGet(HttpServletRequest request, 
			HttpServletResponse response) throws ServletException, IOException
	{
		Captcha localCaptcha = new Captcha.Builder(this._width, this._height).addText().addBackground().addNoise().build();
		CaptchaServletUtil.writeImage(response, localCaptcha.getImage());
		
		try
		{
			request.getSession().setAttribute("simpleCaptcha", localCaptcha);
		}
		catch (Exception e)
		{
			LOGGER.error("Captcha code cannot be stored into session...", e);
		}
	}
	
}

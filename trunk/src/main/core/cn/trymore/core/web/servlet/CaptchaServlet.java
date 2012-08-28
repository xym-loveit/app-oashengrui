package cn.trymore.core.web.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
		
		request.getSession().setAttribute("simpleCaptcha", localCaptcha);
	}
	
}

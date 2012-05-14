package org.shengrui.oa.common;

/**
 * 
 * The service Exception
 * 
 * @author JeccyZhao
 * 
 */
public class ServiceException extends Exception 
{

	private static final long serialVersionUID = 5487559132426297430L;
	
	public ServiceException(String message) 
	{
		super(message);
	}

	public ServiceException(Throwable cause) 
	{
		super(cause);
	}

	public ServiceException(String message, Throwable cause) 
	{
		super(message, cause);
	}
	
}

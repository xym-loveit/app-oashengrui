package cn.trymore.core.exception;

/**
 * 
 * The web exception
 * 
 * @author JeccyZhao
 * 
 */
public class WebException extends Exception
{
	
	private static final long serialVersionUID = -6481877134483586070L;
	
	public WebException(String message) 
	{
		super(message);
	}

	public WebException(Throwable cause) 
	{
		super(cause);
	}

	public WebException(String message, Throwable cause) 
	{
		super(message, cause);
	}
	
}

package cn.trymore.core.exception;

/**
 * 
 * The DAO Exception
 * 
 * @author JeccyZhao
 *
 */
public class DAOException extends Exception 
{

	private static final long serialVersionUID = 4079463805805425778L;
	
	public DAOException(String message) 
	{
		super(message);
	}

	public DAOException(Throwable cause) 
	{
		super(cause);
	}

	public DAOException(String message, Throwable cause) 
	{
		super(message, cause);
	}
	
}

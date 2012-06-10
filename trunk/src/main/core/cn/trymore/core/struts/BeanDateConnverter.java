package cn.trymore.core.struts;

import org.apache.commons.beanutils.Converter;
import org.apache.commons.lang.time.DateUtils;
import org.apache.log4j.Logger;

public class BeanDateConnverter
implements Converter
{
	
	/**
	 * The LOGGER
	 */
	private static final Logger logger = Logger.getLogger(BeanDateConnverter.class);
	
	/**
	 * The accepted data format
	 */
	public static final String[] ACCEPT_DATE_FORMATS = { "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd" };
	
	/*
	 * (non-Javadoc)
	 * @see org.apache.commons.beanutils.Converter#convert(java.lang.Class, java.lang.Object)
	 */
	@SuppressWarnings("rawtypes")
	@Override
	public Object convert(Class arg0, Object paramObject)
	{
		logger.debug("conver " + paramObject + " to date object");
		
		String str = paramObject.toString();
		
		try
		{
			return DateUtils.parseDate(str, ACCEPT_DATE_FORMATS);
		}
		catch (Exception localException)
		{
			logger.debug("parse date error:" + localException.getMessage());
		}
		
		return null;
	}
	
}

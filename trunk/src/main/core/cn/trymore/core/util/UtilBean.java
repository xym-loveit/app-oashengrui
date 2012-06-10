package cn.trymore.core.util;

import java.beans.PropertyDescriptor;
import java.lang.reflect.InvocationTargetException;
import java.util.Date;
import java.util.Iterator;
import java.util.Map;

import org.apache.commons.beanutils.BeanUtilsBean;
import org.apache.commons.beanutils.ConvertUtilsBean;
import org.apache.commons.beanutils.DynaBean;
import org.apache.commons.beanutils.DynaProperty;
import org.apache.log4j.Logger;

import cn.trymore.core.struts.BeanDateConnverter;

public class UtilBean
{
	/**
	 * The LOGGER
	 */
	private static final Logger logger = Logger.getLogger(UtilBean.class);
	
	/**
	 * The bean utility converts
	 */
	public static ConvertUtilsBean convertUtilsBean = new ConvertUtilsBean();
	
	static
	{
		convertUtilsBean.register(new BeanDateConnverter(), Date.class);
	}
	
	@SuppressWarnings("rawtypes")
	public static void copyNotNullProperties(Object paramObject1, 
			Object paramObject2) throws IllegalAccessException, InvocationTargetException
	{
		BeanUtilsBean localBeanUtilsBean = BeanUtilsBean.getInstance();
		
		if (paramObject1 == null)
		{
			throw new IllegalArgumentException("No destination bean specified");
		}
		
		if (paramObject2 == null)
		{
			throw new IllegalArgumentException("No origin bean specified");
		}
		
		if (logger.isDebugEnabled())
		{
			logger.debug("BeanUtils.copyProperties(" + paramObject1 + ", " + paramObject2 + ")");
		}
		
		String str;
		Object localObject2;
		
		if ((paramObject2 instanceof DynaBean))
		{
			DynaProperty[] localObject1 = ((DynaBean)paramObject2).getDynaClass().getDynaProperties();
			
			for (int i = 0; i < localObject1.length; i++)
			{
				str = localObject1[i].getName();
				if ((!localBeanUtilsBean.getPropertyUtils().isReadable(paramObject2, str)) || 
						(!localBeanUtilsBean.getPropertyUtils().isWriteable(paramObject1, str)))
				{
					continue;
				}
				
				localObject2 = ((DynaBean)paramObject2).get(str);
				
				localBeanUtilsBean.copyProperty(paramObject1, str, localObject2);
			}
		}
		else if ((paramObject2 instanceof Map))
		{
			Iterator localObject1 = ((Map)paramObject2).entrySet().iterator();
			while (localObject1.hasNext())
			{
				Map.Entry localEntry = (Map.Entry)((Iterator)localObject1).next();
				str = (String)localEntry.getKey();
				if (localBeanUtilsBean.getPropertyUtils().isWriteable(paramObject1, str))
				{
					localBeanUtilsBean.copyProperty(paramObject1, str, localEntry.getValue());
				}
			}
		}
		else
		{
			PropertyDescriptor[] localObject1 = localBeanUtilsBean.getPropertyUtils().getPropertyDescriptors(paramObject2);
			
			for (int j = 0; j < localObject1.length; j++)
			{
				str = localObject1[j].getName();
				
				if (("class".equals(str)) || (!localBeanUtilsBean.getPropertyUtils().isReadable(paramObject2, str)) || 
						(!localBeanUtilsBean.getPropertyUtils().isWriteable(paramObject1, str)))
				{
					continue;
				}
				
				try
				{
					localObject2 = localBeanUtilsBean.getPropertyUtils().getSimpleProperty(paramObject2, str);
					
					/*
					if (localObject2 instanceof Date)
					{
						localObject2 = new Timestamp(((Date) localObject2).getTime());
					}
					*/
					
					if (localObject2 != null)
					{
						localBeanUtilsBean.copyProperty(paramObject1, str, localObject2);
					}
				}
				catch (NoSuchMethodException localNoSuchMethodException)
				{
					
				}
			}
		}
	}
}

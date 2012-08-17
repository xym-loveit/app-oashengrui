package cn.trymore.core.util;

import org.hibernate.cfg.Configuration;
import org.hibernate.mapping.PersistentClass;
import org.shengrui.oa.model.system.ModelAppUser;

public class UtilEntity
{
	private static Configuration hibernateConf;
	
	private static Configuration getHibernateConf() 
	{
		if (hibernateConf == null)
		{
			hibernateConf = new Configuration();
		}
		
		return hibernateConf;
	}
	
	private static PersistentClass getPersistentClass(Class<?> clazz)
	{
		synchronized (UtilEntity.class)
		{
			PersistentClass pc = getHibernateConf().getClassMapping(clazz.getName());
			if (pc == null) 
			{
				hibernateConf = getHibernateConf().addClass(clazz);
				pc = getHibernateConf().getClassMapping(clazz.getName());  
			}
			return pc;
		}
	}
	
	public static String getTableName(Class<?> clazz)
	{
		return getPersistentClass(clazz).getTable().getName();
	}
	
	public static void main (String[] args)
	{
		System.out.println(UtilEntity.getTableName(ModelAppUser.class));
	}
	
}	

package cn.trymore.core.hibernate;

import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Restrictions;

/**
 * The helper class for Hibernate.
 * 
 * @author Jeccy.Zhao
 *
 */
public class HibernateUtils 
{
	
	/**
	 * QBC中多个OR的查询
	 * @param crit1
	 * @param crit2
	 * @return
	 */
	public static Criterion QBC_OR(Criterion crit1, Criterion crit2)
	{
		if (crit1 == null) 
		{
			return crit2;
		}
		
		if (crit2 == null) 
		{
			return crit1;
		}
		
		return Restrictions.or(crit1, crit2);
	}
	
	/**
	 * QBC中多个AND的查询
	 * @param crit1
	 * @param crit2
	 * @return
	 */
	public static Criterion QBC_AND(Criterion crit1, Criterion crit2)
	{
		if (crit1 == null) 
		{
			return crit2;
		}
		
		if (crit2 == null) 
		{
			return crit1;
		}
		
		return Restrictions.and(crit1, crit2);
	}
	
}

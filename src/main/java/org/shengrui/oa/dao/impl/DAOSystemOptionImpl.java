package org.shengrui.oa.dao.impl;

import java.util.List;

import org.apache.log4j.Logger;
import org.shengrui.oa.common.DAOException;
import org.shengrui.oa.dao.DAOSystemOption;
import org.shengrui.oa.model.ModelSystemOption;
import org.shengrui.oa.utilities.UtilString;

/**
 * The implementation of site settings repository
 * 
 * @author Jeccy.Zhao
 *
 */
public class DAOSystemOptionImpl 
extends DAOBaseImpl<ModelSystemOption> implements DAOSystemOption
{
	/**
	 * The LOGGER
	 */
	private static final Logger LOGGER = Logger.getLogger(DAOSystemOptionImpl.class);
	/*
	 * (non-Javadoc)
	 * @see com.lzcp.dao.DAOSystemOption#getOptionsBySlug(java.lang.String, java.lang.String, java.lang.Boolean)
	 */
	@Override
	public List<ModelSystemOption> getOptionsBySlug(String optionSlug,
			String order, Boolean isDesc) throws DAOException
	{
		String hql = "from ModelSystemOption om where om.optionSlug='"+optionSlug+"'";
		
		if (UtilString.isNotEmpty(order))
		{
			hql += " order by om." + order + (isDesc ? " desc" : " asc");
		}
		
		List<ModelSystemOption> result = this.findListByHSQL(hql);
		
		return result != null && result.size() > 0 ? result : null;
	}
	
	public static Logger getLogger() 
	{
		return LOGGER;
	}
	
}

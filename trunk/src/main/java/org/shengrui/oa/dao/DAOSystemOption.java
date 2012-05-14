package org.shengrui.oa.dao;

import java.util.List;

import org.shengrui.oa.common.DAOException;
import org.shengrui.oa.model.ModelSystemOption;

/**
 * The site settings repository 
 * 
 * @author Jeccy.Zhao
 *
 */
public interface DAOSystemOption extends DAOBase<ModelSystemOption> 
{
	/**
	 * Obtains system option value by the specified slug 
	 * 
	 * @param optionSlug
	 *          the option slug name
	 * @param order
	 *          the order field
	 * @param isDesc
	 *          the order sequence
	 * @return list of system option values
	 * @throws DAOException
	 */
	List<ModelSystemOption> getOptionsBySlug(String optionSlug, 
			String order, Boolean isDesc) throws DAOException;
}

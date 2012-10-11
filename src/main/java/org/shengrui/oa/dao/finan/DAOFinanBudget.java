package org.shengrui.oa.dao.finan;

import java.util.Date;

import org.shengrui.oa.model.finan.ModelFinanBudget;

import cn.trymore.core.dao.DAOGeneric;
import cn.trymore.core.exception.DAOException;

/**
 * 财务预算-数据接口层
 * 
 * @author Jeccy.Zhao
 *
 */
public interface DAOFinanBudget
extends DAOGeneric<ModelFinanBudget>
{
	/**
	 * 根据校区和预算月份查找预算
	 * 
	 * @param districtId
	 *          校区ID
	 * @param budgetYearAndMonth
	 *          预算月份 (格式为: yyyy-MM)
	 * @return 预算实体类, 预算不存在时返回null.
	 */
	ModelFinanBudget find (String districtId, 
			Date budgetYearAndMonth) throws DAOException;
	
	/**
	 * 重置预算, 已设置的预算会被清空.
	 * 
	 * @param districtId
	 *          校区ID
	 * @param budgetYearAndMonth
	 *          预算月份 (格式为: yyyy-MM)
	 * @return 重置成功返回true, 否则返回false.
	 */
	boolean resetBudget (String districtId, 
			Date budgetYearAndMonth) throws DAOException;
}

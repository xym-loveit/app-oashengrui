package org.shengrui.oa.service.finan;

import java.util.Date;
import java.util.List;

import org.shengrui.oa.model.finan.ModelFinanBudget;

import cn.trymore.core.exception.ServiceException;

/**
 * 财务预算逻辑接口层
 * 
 * @author Jeccy.Zhao
 *
 */
public interface ServiceFinanBudget
{
	/**
	 * 根据校区及月份获取预算数据, 
	 * 校区ID为空时, 获取所有校区预算数据.
	 * 
	 * @param districtId
	 *          校区ID
	 * @param budgetYearAndMonth
	 *          预算月份
	 * @return 预算数据列表
	 * @throws ServiceException
	 */
	List<ModelFinanBudget> get (String districtId, 
			Date budgetYearAndMonth) throws ServiceException; 
	
	/**
	 * 重置预算, 已设置的预算会被清空.
	 * 
	 * @param districtId
	 *            校区ID
	 * @param budgetYearAndMonth
	 *            预算月份
	 * @return 重置成功后返回true, 否则返回false
	 * @throws ServiceException
	 */
	boolean resetBudget (
			String districtId, Date budgetYearAndMonth) throws ServiceException;
	
	/**
	 * 保存或者更新预算信息
	 * 
	 * @param entity
	 *           预算实体
	 * @return 保存或更新成功返回true, 否则返回false
	 * @throws ServiceException
	 */
	boolean saveOrUpdate (ModelFinanBudget entity) throws ServiceException;
}

package org.shengrui.oa.service.finan;

import org.shengrui.oa.model.finan.ModelFinanExpense;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.ServiceGeneric;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

/**
 * The financial expense service.
 * 
 * @author Jeccy.Zhao
 *
 */
public interface ServiceFinanExpense
extends ServiceGeneric<ModelFinanExpense>
{
	
	/**
	 *根据申请单号 获取财物费用申请数据
	 * 
	 * @param formNo
	 *                申请单号
	 * @return
	 * @throws ServiceException
	 */
	ModelFinanExpense getByFormNo (String formNo) throws ServiceException;
	
	/**
	 * 财务费用查分页数据
	 * 
	 * @param entity
	 * @param pagingBean
	 * @return
	 * @throws ServiceException
	 */
	PaginationSupport<ModelFinanExpense> getFinanExpenseInfoPagination (ModelFinanExpense entity, 
			PagingBean pagingBean) throws ServiceException;

}
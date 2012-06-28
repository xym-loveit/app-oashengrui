package org.shengrui.oa.service.finan;

import org.shengrui.oa.model.finan.ModelFinanExpense;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.ServiceGeneric;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

public interface ServiceFinanExpense
extends ServiceGeneric<ModelFinanExpense>
{
	
	/**
	 * 财务费用查分页数据
	 * 
	 * @param entity
	 * @param pagingBen
	 * @return
	 * @throws ServiceException
	 */
	PaginationSupport<ModelFinanExpense> getFinanExpenseInfoPagination (ModelFinanExpense entity, 
			PagingBean pagingBen) throws ServiceException;

}

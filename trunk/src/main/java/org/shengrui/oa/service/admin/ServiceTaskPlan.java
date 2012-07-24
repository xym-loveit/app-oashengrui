package org.shengrui.oa.service.admin;

import org.shengrui.oa.model.admin.ModelTaskPlan;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.ServiceGeneric;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

/**
 * The service of task
 * 
 * @author Jeccy.Zhao
 *
 */
public interface ServiceTaskPlan
extends ServiceGeneric<ModelTaskPlan>
{	
	
	/**
	 * 根据任务信息查分页数据
	 */
	PaginationSupport<ModelTaskPlan> getPaginationByEntity (ModelTaskPlan entity, 
			PagingBean pagingBean) throws ServiceException;
	
	/**
	 * 根据用户信息查分页数据
	 */
	PaginationSupport<ModelTaskPlan> getPaginationByEntity (ModelTaskPlan entity, String employeeId, 
			Boolean filterByOriginator, PagingBean pagingBean) throws ServiceException;
}

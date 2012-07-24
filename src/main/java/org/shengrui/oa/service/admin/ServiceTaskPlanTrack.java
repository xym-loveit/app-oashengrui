package org.shengrui.oa.service.admin;

import org.shengrui.oa.model.admin.ModelTaskPlanTrack;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.ServiceGeneric;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

/**
 * The task plan service.
 * 
 * @author Jeccy.Zhao
 *
 */
public interface ServiceTaskPlanTrack
extends ServiceGeneric<ModelTaskPlanTrack>
{
	/**
	 * 获取待审批的当前任务申请
	 * 
	 * @param taskId
	 * @return
	 * @throws ServiceException
	 */
	ModelTaskPlanTrack getCurrentTrack (String taskId) throws ServiceException;
	
	/**
	 * 根据任务信息查审批记录
	 */
	PaginationSupport<ModelTaskPlanTrack> getPaginationByTaskId (String taskId, 
			PagingBean pagingBean) throws ServiceException;
	
}

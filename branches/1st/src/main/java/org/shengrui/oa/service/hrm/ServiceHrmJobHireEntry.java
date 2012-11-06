package org.shengrui.oa.service.hrm;

import org.shengrui.oa.model.hrm.ModelHrmJobHireEntry;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.ServiceGeneric;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

public interface ServiceHrmJobHireEntry
extends ServiceGeneric<ModelHrmJobHireEntry>
{
	/**
	 * 
	 * @param jobId
	 * @param pagingBean
	 * @return
	 * @throws ServiceException
	 */
	PaginationSupport<ModelHrmJobHireEntry> getPaginationByJobId (String jobId, 
			PagingBean pagingBean) throws ServiceException;
	
	/**
	 * 
	 * @param entity
	 * @param pagingBean
	 * @return
	 * @throws ServiceException
	 */
	PaginationSupport<ModelHrmJobHireEntry> getPaginationByEntity (ModelHrmJobHireEntry entity, 
			PagingBean pagingBean) throws ServiceException;
}

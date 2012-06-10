package org.shengrui.oa.service.hrm;

import org.shengrui.oa.model.hrm.ModelHrmJobHireIssue;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.ServiceGeneric;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

public interface ServiceHrmJobHireIssue
extends ServiceGeneric<ModelHrmJobHireIssue>
{
	
	/**
	 * 根据招聘岗位ID获取分页应聘数据.
	 *  
	 * @param jobId
	 * @param pagingBean
	 * @return
	 * @throws ServiceException
	 */
	PaginationSupport<ModelHrmJobHireIssue> getPaginationByJobId (String jobId, 
			PagingBean pagingBean) throws ServiceException;
	
}

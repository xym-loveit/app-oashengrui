package org.shengrui.oa.service.hrm;

import org.shengrui.oa.model.hrm.ModelHrmJobHireInterview;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.ServiceGeneric;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

/**
 * The service for hire job interview
 * 
 * @author Jeccy.Zhao
 *
 */
public interface ServiceHrmJobHireInterview
extends ServiceGeneric<ModelHrmJobHireInterview>
{
	/**
	 * 
	 * @param issueId
	 * @param pagingBean
	 * @return
	 * @throws ServiceException
	 */
	PaginationSupport<ModelHrmJobHireInterview> getPaginationByIssueId (
			String issueId, PagingBean pagingBean) throws ServiceException;
	
	/**
	 * 
	 * @param issueId
	 * @param sessionNo
	 * @return
	 * @throws ServiceException
	 */
	ModelHrmJobHireInterview getByIssueAndSessionNo (String issueId,
			Integer sessionNo) throws ServiceException;
	
}

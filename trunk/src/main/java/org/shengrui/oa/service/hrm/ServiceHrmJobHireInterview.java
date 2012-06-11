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
	 * 根据应聘获取面试记录分页信息
	 * 
	 * @param issueId
	 * @param pagingBean
	 * @return
	 * @throws ServiceException
	 */
	PaginationSupport<ModelHrmJobHireInterview> getPaginationByIssueId (
			String issueId, PagingBean pagingBean) throws ServiceException;
	
	/**
	 * 根据应聘和面试环节获取面试记录
	 * 
	 * @param issueId
	 * @param sessionNo
	 * @return
	 * @throws ServiceException
	 */
	ModelHrmJobHireInterview getByIssueAndSessionNo (String issueId,
			Integer sessionNo) throws ServiceException;
	
	/**
	 * 根据面试官及面试状态获取分页面试信息
	 * 
	 * @param interviewId
	 * @param status
	 * @param pagingBean
	 * @return
	 * @throws ServiceException
	 */
	PaginationSupport<ModelHrmJobHireInterview> getPaginationByInterviewerAndStatus (
			String interviewId, Integer[] status, PagingBean pagingBean) throws ServiceException;
	
}

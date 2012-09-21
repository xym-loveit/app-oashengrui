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
	
	/**
	 * 根据用户ID获取分页用户应聘数据
	 * 
	 * @param jobId
	 * @param pagingBean
	 * @return
	 * @throws ServiceException
	 */
	PaginationSupport<ModelHrmJobHireIssue> getPaginationByUser (String userId, 
			PagingBean pagingBean) throws ServiceException;
	
	/**
	 * 获取招聘安排数量
	 * 
	 * @return
	 * @throws ServiceException
	 */
	int getNumHireEntry();
	
	/**
	 * 获取招聘安排数量
	 * 
	 * @param whereCloud
	 * @param accessIfCondEmpty
	 * @return
	 * @throws ServiceException
	 */
	int getNumHireEntry(String whereCloud, boolean accessIfCondEmpty);
	
	/**
	 * 获取入职安排数量
	 * 
	 * @return
	 * @throws ServiceException
	 */
	int getNumHireIssue();
	
	/**
	 * 获取招聘安排数量
	 * 
	 * @param whereCloud
	 * @param accessIfCondEmpty
	 * @return
	 * @throws ServiceException
	 */
	int getNumHireIssue(String whereCloud, boolean accessIfCondEmpty);
}

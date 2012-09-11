package org.shengrui.oa.service.hrm;

import org.shengrui.oa.model.hrm.ModelHrmJobHireInfo;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.ServiceGeneric;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

/**
 * The service for job hire information.
 * 
 * @author Jeccy.Zhao
 *
 */
public interface ServiceHrmJobHireInfo
extends ServiceGeneric<ModelHrmJobHireInfo>
{
	
	/**
	 * 根据岗位信息查分页数据
	 * 
	 * @param entity
	 * @param pagingBean
	 * @return
	 * @throws ServiceException
	 */
	PaginationSupport<ModelHrmJobHireInfo> getPaginationByEntity (ModelHrmJobHireInfo entity, 
			PagingBean pagingBean) throws ServiceException;
	
	/**
	 * 根据岗位信息查分页数据
	 * 
	 * @param entity
	 * @param visibility
	 * @param pagingBean
	 * @return
	 * @throws ServiceException
	 */
	PaginationSupport<ModelHrmJobHireInfo> getPaginationByEntity (ModelHrmJobHireInfo entity, boolean visibility,  
			PagingBean pagingBean) throws ServiceException;
	
	/**
	 * 获取审核中的岗位数量
	 * 
	 * @return
	 * @throws ServiceException
	 */
	int getNumApprovals () throws ServiceException;
	
}

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
	 * @param pagingBen
	 * @return
	 * @throws ServiceException
	 */
	PaginationSupport<ModelHrmJobHireInfo> getHireJobPagination (ModelHrmJobHireInfo entity, 
			PagingBean pagingBen) throws ServiceException;
	
}

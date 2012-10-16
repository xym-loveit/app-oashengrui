package org.shengrui.oa.service.admin;

import org.shengrui.oa.model.admin.ModelConference;

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
public interface ServiceConferenceInfo
extends ServiceGeneric<ModelConference>
{
	
	/**
	 * 根据岗位信息查分页数据
	 * 
	 * @param entity
	 * @param pagingBean
	 * @return
	 * @throws ServiceException
	 */
	PaginationSupport<ModelConference> getPaginationByEntity (ModelConference entity, 
			PagingBean pagingBean) throws ServiceException;
	
	public int getNoSummaryConference(String id) throws ServiceException;
}

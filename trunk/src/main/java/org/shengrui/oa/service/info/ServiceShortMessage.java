package org.shengrui.oa.service.info;

import org.shengrui.oa.model.info.ModelShortMessage;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.ServiceGeneric;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

/**
 * The short message service.
 * 
 * @author Jeccy.Zhao
 *
 */
public interface ServiceShortMessage
extends ServiceGeneric<ModelShortMessage>
{
	/**
	 * 根据用户ID获取发送短信分页数据
	 * 
	 * @param senderId
	 * @param pagingBean
	 * @return
	 * @throws ServiceException
	 */
	PaginationSupport<ModelShortMessage> getPaginationByUser (String senderId, 
			PagingBean pagingBean) throws ServiceException;
}

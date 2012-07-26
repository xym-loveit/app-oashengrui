package org.shengrui.oa.service.info;

import org.shengrui.oa.model.info.ModelInMessage;
import org.shengrui.oa.model.info.ModelShortMessage;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.ServiceGeneric;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

/**
 * The message in service.
 * 
 * @author Jeccy.Zhao
 *
 */
public interface ServiceInMessage
extends ServiceGeneric<ModelInMessage>
{
	/**
	 * 根据用户ID获取发送短信分页数据
	 * 
	 * @param userId
	 * @param pagingBean
	 * @return
	 * @throws ServiceException
	 */
	PaginationSupport<ModelInMessage> getPaginationByUser (String userId, 
			ModelShortMessage entity, String readFlag, PagingBean pagingBean) throws ServiceException;
}

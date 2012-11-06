package org.shengrui.oa.dao.info;

import org.shengrui.oa.model.info.ModelInMessage;
import org.shengrui.oa.model.info.ModelShortMessage;

import cn.trymore.core.dao.DAOGeneric;
import cn.trymore.core.exception.DAOException;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

/**
 * The message in repository
 * 
 * @author Jeccy.Zhao
 *
 */
public interface DAOInMessage
extends DAOGeneric<ModelInMessage>
{
	
	/**
	 * 根据用户ID获取发送短信分页数据
	 * 
	 * @param userId
	 *           用户ID
	 * @param entity
	 *           短消息对象
	 * @param readFlag
	 *           读取标志
	 * @param pagingBean
	 *           分页对象
	 * @return 短信分页数据
	 * @throws DAOException
	 */
	PaginationSupport<ModelInMessage> getPaginationByUser (String userId, 
			ModelShortMessage entity, String readFlag, PagingBean pagingBean) throws DAOException;
	
	/**
	 * 根据用户ID获取未读短信数量
	 * 
	 * @param userId
	 *          用户ID
	 * @return 未读短信数量
	 * @throws DAOException
	 */
	int getUnreadMessageCountByUser (String userId) throws DAOException;
	
}

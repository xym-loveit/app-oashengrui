package org.shengrui.oa.dao.info;

import org.shengrui.oa.model.info.ModelInMessage;

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
	 * @param pagingBean
	 * @return
	 * @throws DAOException
	 */
	PaginationSupport<ModelInMessage> getPaginationByUser (String userId, 
			PagingBean pagingBean) throws DAOException;
	
}

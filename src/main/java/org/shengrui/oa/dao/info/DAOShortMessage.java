package org.shengrui.oa.dao.info;

import org.shengrui.oa.model.info.ModelShortMessage;

import cn.trymore.core.dao.DAOGeneric;
import cn.trymore.core.exception.DAOException;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

/**
 * The short message repository
 * 
 * @author Jeccy.Zhao
 *
 */
public interface DAOShortMessage
extends DAOGeneric<ModelShortMessage>
{
	/**
	 * 根据用户ID获取发送短信分页数据
	 * 
	 * @param senderId
	 * @param pagingBean
	 * @return
	 * @throws DAOException
	 */
	PaginationSupport<ModelShortMessage> getPaginationByUser (String senderId, 
			PagingBean pagingBean) throws DAOException;
}

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
	 *          发送用户ID
	 * @param pagingBean
	 *          分页对象
	 * @return 短信分页数据
	 * @throws DAOException
	 */
	PaginationSupport<ModelShortMessage> getPaginationByUser (String senderId, 
			PagingBean pagingBean) throws DAOException;
}

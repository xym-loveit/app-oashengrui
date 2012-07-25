package org.shengrui.oa.dao.info.impl;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.shengrui.oa.dao.info.DAOInMessage;
import org.shengrui.oa.model.info.ModelInMessage;
import org.shengrui.oa.model.info.ModelShortMessage;

import cn.trymore.core.dao.impl.DAOGenericImpl;
import cn.trymore.core.exception.DAOException;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

/**
 * The message in repository.
 * 
 * @author Jeccy.Zhao
 *
 */
public class DAOInMessageImpl
extends DAOGenericImpl<ModelInMessage> implements DAOInMessage
{
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.dao.info.DAOInMessage#getPaginationByUser(java.lang.String, cn.trymore.core.web.paging.PagingBean)
	 */
	@Override
	public PaginationSupport<ModelInMessage> getPaginationByUser(String userId,
			PagingBean pagingBean) throws DAOException
	{
		DetachedCriteria criteria = DetachedCriteria.forClass(ModelShortMessage.class);
		criteria.add(Restrictions.eq("userId", userId));
		criteria.addOrder(Order.desc("receiveTime"));
		return this.findPageByCriteria(criteria, pagingBean);
	}

}
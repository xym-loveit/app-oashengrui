package org.shengrui.oa.dao.info.impl;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.shengrui.oa.dao.info.DAOShortMessage;
import org.shengrui.oa.model.info.ModelShortMessage;

import cn.trymore.core.dao.impl.DAOGenericImpl;
import cn.trymore.core.exception.DAOException;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

/**
 * The short message repository.
 * 
 * @author Jeccy.Zhao
 *
 */
public class DAOShortMessageImpl
extends DAOGenericImpl<ModelShortMessage> implements DAOShortMessage
{
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.dao.info.DAOShortMessage#getPaginationByUser(java.lang.String, cn.trymore.core.web.paging.PagingBean)
	 */
	@Override
	public PaginationSupport<ModelShortMessage> getPaginationByUser(
			String senderId, PagingBean pagingBean) throws DAOException
	{
		DetachedCriteria criteria = DetachedCriteria.forClass(ModelShortMessage.class);
		criteria.add(Restrictions.eq("senderId", senderId));
		criteria.addOrder(Order.desc("sendTime"));
		return this.findPageByCriteria(criteria, pagingBean);
	}

}

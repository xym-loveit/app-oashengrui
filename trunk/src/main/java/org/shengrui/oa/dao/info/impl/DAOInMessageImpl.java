package org.shengrui.oa.dao.info.impl;

import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.shengrui.oa.dao.info.DAOInMessage;
import org.shengrui.oa.model.info.ModelInMessage;
import org.shengrui.oa.model.info.ModelShortMessage;

import cn.trymore.core.dao.impl.DAOGenericImpl;
import cn.trymore.core.exception.DAOException;
import cn.trymore.core.hibernate.HibernateUtils;
import cn.trymore.core.util.UtilString;
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
			ModelShortMessage entity, String readFlag, PagingBean pagingBean) throws DAOException
	{
		DetachedCriteria criteria = DetachedCriteria.forClass(ModelInMessage.class);
		
		criteria.add(Restrictions.eq("userId", Long.valueOf(userId)));
		criteria.add(Restrictions.ne("delFlag", ModelInMessage.FLAG_DEL));
		
		if (UtilString.isNotEmpty(readFlag) && Integer.valueOf(readFlag) > -1)
		{
			criteria.add(Restrictions.eq("readFlag", Integer.valueOf(readFlag)));
		}
		
		if (entity != null)
		{
			Criterion criterion = null;
			
			if (entity.getMsgType() != null && entity.getMsgType() > -1)
			{
				criterion = HibernateUtils.QBC_AND(criterion, Restrictions.eq("msgType", entity.getMsgType()));
			}
			
			if (UtilString.isNotEmpty(entity.getSender()))
			{
				criterion = HibernateUtils.QBC_AND(criterion, Restrictions.like("sender", entity.getSender(), MatchMode.ANYWHERE));
			}
			
			if (criterion != null)
			{
				criteria.createCriteria("shortMessage").add(criterion);
			}
		}
		
		criteria.addOrder(Order.desc("receiveTime"));
		return this.findPageByCriteria(criteria, pagingBean);
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.dao.info.DAOInMessage#getUnreadMessageCountByUser(java.lang.String)
	 */
	@Override
	public int getUnreadMessageCountByUser (String userId) throws DAOException
	{
		String sql = "SELECT COUNT(*) as count FROM app_message_in WHERE user_id = " + 
						userId + " AND flag_del = " + ModelInMessage.FLAG_UNDEL + 
						" AND flag_read = " + ModelInMessage.FLAG_UNREAD;
		
		return getCountByNativeSQL(sql);
	}
}

package org.shengrui.oa.service.admin.impl;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.shengrui.oa.dao.admin.DAODocManage;
import org.shengrui.oa.model.admin.ModelDoc;
import org.shengrui.oa.model.admin.ModelDocLevel;
import org.shengrui.oa.service.admin.ServiceDocManage;

import cn.trymore.core.exception.DAOException;
import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.impl.ServiceGenericImpl;
import cn.trymore.core.util.UtilString;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

/**
 * The implementation for doc manage
 * 
 * @author Tang
 *
 */
public class ServiceDocManageImpl
extends ServiceGenericImpl<ModelDoc> implements ServiceDocManage
{
	private DAODocManage daoDocManage;
	
	public ServiceDocManageImpl(DAODocManage dao)
	{
		super(dao);
		this.daoDocManage=dao;
	}
	
	
	public List<ModelDoc> getDocsByLevel(ModelDocLevel level)throws ServiceException, DAOException
	{
		DetachedCriteria criteria = DetachedCriteria.forClass(ModelDoc.class);
		if(level!=null)
		{
			criteria.add(Restrictions.eq("docLevel", level));
		}
		criteria.addOrder(Order.desc("createTime"));
		return daoDocManage.getListByCriteria(criteria);

	}
	
	
	
	
	@Override
	public List<ModelDoc> getAllDocInfo() throws ServiceException {
		return super.getAll();
	}
	
	
	@Override
	public PaginationSupport<ModelDoc> getPaginationByEntity(
			ModelDoc entity, PagingBean pagingBean)
			throws ServiceException 
	{
		return this.getAll(this.getCriterias(entity), pagingBean);
	}
	
	/**
	 * Returns the criteria with the specified entity. 
	 * 
	 * @param entity
	 * @return
	 */
	//封装检索条件
	private DetachedCriteria getCriterias(ModelDoc entity)
	{
		DetachedCriteria criteria = DetachedCriteria.forClass(ModelDoc.class);
		
		if (entity != null)
		{
			if(entity.getType().getId()!=null)
			{
				criteria.add(Restrictions.eq("type", entity.getType()));
			}
			
            if(entity.getDocName()!=null && UtilString.isNotEmpty(entity.getDocName()))
            {
            	criteria.add(Restrictions.like("docName", entity.getDocName(), MatchMode.ANYWHERE));
			}
		}
		
		criteria.addOrder(Order.desc("createTime"));
		
		return criteria;
	}
	
	
	public DAODocManage getDaoDocManage() {
		return daoDocManage;
	}

	public void setDaoDocManage(DAODocManage daoDocManage) {
		this.daoDocManage = daoDocManage;
	}
	
}

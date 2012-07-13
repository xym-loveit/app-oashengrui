package org.shengrui.oa.service.admin.impl;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.shengrui.oa.dao.admin.DAODocManage;
import org.shengrui.oa.model.admin.ModelDoc;
import org.shengrui.oa.service.admin.ServiceDocManage;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.impl.ServiceGenericImpl;
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
	
	public ServiceDocManageImpl(DAODocManage dao) {
		super(dao);
		this.daoDocManage=dao;
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
			
		}
		
//		criteria.addOrder(Order.desc("workTime"));
		
		return criteria;
	}
	
	
	public DAODocManage getDaoDocManage() {
		return daoDocManage;
	}

	public void setDaoDocManage(DAODocManage daoDocManage) {
		this.daoDocManage = daoDocManage;
	}
	
}

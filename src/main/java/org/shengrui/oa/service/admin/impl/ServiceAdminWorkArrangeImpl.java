package org.shengrui.oa.service.admin.impl;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.shengrui.oa.dao.admin.DAOWorkArrange;
import org.shengrui.oa.model.admin.ModelAdminWorkArrange;
import org.shengrui.oa.service.admin.ServiceAdminWorkArrange;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.impl.ServiceGenericImpl;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

/**
 * The implementation for work arrange.
 * 
 * @author Tang
 *
 */
public class ServiceAdminWorkArrangeImpl
extends ServiceGenericImpl<ModelAdminWorkArrange> implements ServiceAdminWorkArrange
{
	private DAOWorkArrange daoWorkArrange;
	
	public ServiceAdminWorkArrangeImpl(DAOWorkArrange dao) {
		super(dao);
		this.daoWorkArrange = dao;
	}
	
	/**
	 * 根据id得到一条工作安排记录
	 * @author Tang 
	 */
	public ModelAdminWorkArrange getById(String id)throws ServiceException
	{
		return this.get(id);
	}

	
	
	@Override
	public PaginationSupport<ModelAdminWorkArrange> getPaginationByEntity(
			ModelAdminWorkArrange entity, PagingBean pagingBean)
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
	private DetachedCriteria getCriterias(ModelAdminWorkArrange entity)
	{
		DetachedCriteria criteria = DetachedCriteria.forClass(ModelAdminWorkArrange.class);
		
		if (entity != null)
		{
			if (entity.getStaffName() != null )
			{
				criteria.add(Restrictions.like("staffName", entity.getStaff().getId(),MatchMode.ANYWHERE));
			}

			if (entity.getWorkType() != null && entity.getWorkType().getType()!="")
			{
				criteria.add(Restrictions.eq("workType", entity.getWorkType()));
			}
			
			if (entity.getWorkDate() != null )
			{
				criteria.add(Restrictions.eq("workDate", entity.getWorkDate()));
			}
		}
		System.out.println("entity:"+entity);
		
		criteria.addOrder(Order.desc("workTime"));
		
		return criteria;
	}

	public DAOWorkArrange getDaoWorkArrange() {
		return daoWorkArrange;
	}

	public void setDaoWorkArrange(DAOWorkArrange daoWorkArrange) {
		this.daoWorkArrange = daoWorkArrange;
	}
	

}

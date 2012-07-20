package org.shengrui.oa.service.admin.impl;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.shengrui.oa.dao.admin.DAOStaffAttendance;
import org.shengrui.oa.model.admin.ModelStaffAttendance;
import org.shengrui.oa.service.admin.ServiceStaffAttendance;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.impl.ServiceGenericImpl;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

/**
 * @author tank
 *
 */
public class ServiceStaffAttendanceImpl extends ServiceGenericImpl<ModelStaffAttendance> implements ServiceStaffAttendance {

	private DAOStaffAttendance daoStaffAttendance;
	public ServiceStaffAttendanceImpl(DAOStaffAttendance dao) {
		super(dao);
		this.daoStaffAttendance = dao;
		// TODO Auto-generated constructor stub
	}
	@Override
	public ModelStaffAttendance getById(String id) throws ServiceException {
		// TODO Auto-generated method stub
		return this.get(id);
	}
	@Override
	public PaginationSupport<ModelStaffAttendance> getPaginationByEntity(
			ModelStaffAttendance entity, PagingBean pagingBean)
			throws ServiceException {
		// TODO Auto-generated method stub
		return this.getAll(this.getCriterias(entity), pagingBean);
	}
	public DAOStaffAttendance getDaoStaffAttendance() {
		return daoStaffAttendance;
	}
	public void setDaoStaffAttendance(DAOStaffAttendance daoStaffAttendance) {
		this.daoStaffAttendance = daoStaffAttendance;
	}
	
	/**
	 * Returns the criteria with the specified entity. 
	 * 
	 * @param entity
	 * @return
	 */
	//封装检索条件
	private DetachedCriteria getCriterias(ModelStaffAttendance entity)
	{
		DetachedCriteria criteria = DetachedCriteria.forClass(ModelStaffAttendance.class);
		
		if (entity != null)
		{
			if (entity.getStaffName() != null )
			{
				criteria.add(Restrictions.like("staffName", entity.getStaffName(), MatchMode.ANYWHERE));
			}

			if (entity.getWorkType() != null)
			{
				criteria.add(Restrictions.eq("workType", entity.getWorkType()));
			}
			
			if (entity.getWorkDate() != null )
			{
				criteria.add(Restrictions.eq("workDate", entity.getWorkDate()));
			}
		}
		System.out.println("entity:"+entity.getStaffName()+"\t"+entity.getWorkDate()+"\t"+entity.getWorkType());
		
		criteria.addOrder(Order.desc("workTime"));
		
		return criteria;
	}
}

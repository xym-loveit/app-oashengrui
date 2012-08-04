package org.shengrui.oa.service.admin.impl;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.shengrui.oa.dao.admin.DAOStaffAttendance;
import org.shengrui.oa.model.admin.ModelStaffAttendance;
import org.shengrui.oa.service.admin.ServiceStaffAttendance;

import cn.trymore.core.exception.DAOException;
import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.impl.ServiceGenericImpl;
import cn.trymore.core.util.UtilString;
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

			if (entity.getStaffId() != null)
			{
				criteria.add(Restrictions.eq("staffId", entity.getStaffId()));
			}
			if (entity.getWorkType() != null)
			{
				criteria.add(Restrictions.eq("workType", entity.getWorkType()));
			}
			
			if (entity.getWorkDate() != null )
			{
				criteria.add(Restrictions.eq("workDate", entity.getWorkDate()));
			}
			if(entity.getFilterStart()!=null )
			{
				criteria.add(Restrictions.ge("workDate", entity.getFilterStart()));
			}
			if(entity.getFilterEnd()!=null)
			{
				criteria.add(Restrictions.le("workDate", entity.getFilterEnd()));
			}
			if(entity.getLeaveType()!=null && UtilString.isNotEmpty(entity.getLeaveType())){
				criteria.add(Restrictions.eq("leaveType", entity.getLeaveType()));
			}
		}
		criteria.addOrder(Order.desc("workDate"));
		
		return criteria;
	}
	@Override
	public List<ModelStaffAttendance> getListByCriteria(
			ModelStaffAttendance entity) throws ServiceException {
		// TODO Auto-generated method stub
		try {
			return this.daoStaffAttendance.getListByCriteria(this.getCriterias(entity));
		} catch (DAOException e) {
			// TODO Auto-generated catch block
			throw new ServiceException(e);
		}
	}
}

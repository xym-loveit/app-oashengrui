package org.shengrui.oa.service.admin.impl;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.shengrui.oa.dao.admin.DAOStaffAttendanceView;
import org.shengrui.oa.model.admin.ModelStaffAttendanceView;
import org.shengrui.oa.model.admin.ModelStaffAttendanceViewID;
import org.shengrui.oa.service.admin.ServiceStaffAttendanceView;

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
public class ServiceStaffAttendanceViewImpl extends ServiceGenericImpl<ModelStaffAttendanceView> implements ServiceStaffAttendanceView {

	private DAOStaffAttendanceView daoStaffAttendanceView;
	/**
	 * @return the daoStaffAttendanceView
	 */
	public DAOStaffAttendanceView getDaoStaffAttendanceView() {
		return daoStaffAttendanceView;
	}
	/**
	 * @param daoStaffAttendanceView the daoStaffAttendanceView to set
	 */
	public void setDaoStaffAttendanceView(
			DAOStaffAttendanceView daoStaffAttendanceView) {
		this.daoStaffAttendanceView = daoStaffAttendanceView;
	}
	public ServiceStaffAttendanceViewImpl(DAOStaffAttendanceView dao) {
		super(dao);
		this.daoStaffAttendanceView = dao;
		// TODO Auto-generated constructor stub
	}
	@Override
	public PaginationSupport<ModelStaffAttendanceView> getPaginationByEntity(
			ModelStaffAttendanceView entity, PagingBean pagingBean)
			throws ServiceException {
		// TODO Auto-generated method stub
		return this.getAll(this.getCriterias(entity), pagingBean);
	}
	
	/**
	 * Returns the criteria with the specified entity. 
	 * 
	 * @param entity
	 * @return
	 */
	//封装检索条件
	private DetachedCriteria getCriterias(ModelStaffAttendanceView entity)
	{
		DetachedCriteria criteria = DetachedCriteria.forClass(ModelStaffAttendanceView.class);
		
		if (entity != null)
		{
			if (entity.getStaffName() != null && UtilString.isNotEmpty(entity.getStaffName()) )
			{
				criteria.add(Restrictions.like("staffName", entity.getStaffName(), MatchMode.ANYWHERE));
			}

			if (entity.getWorkType() != null && UtilString.isNotEmpty(entity.getWorkType()))
			{
				criteria.add(Restrictions.eq("workType", entity.getWorkType()));
			}
			
			if (entity.getWorkDate() != null )
			{
				criteria.add(Restrictions.eq("workDate", entity.getWorkDate()));
			}
			if(entity.getFilterStart()!=null)
			{
				criteria.add(Restrictions.ge("workDate", entity.getFilterStart()));
			}
			if(entity.getFilterEnd()!=null)
			{
				criteria.add(Restrictions.le("workDate", entity.getFilterEnd()));
			}
		}
		criteria.addOrder(Order.asc("workDate"));
		criteria.addOrder(Order.asc("workTime"));
		criteria.addOrder(Order.asc("staffName"));
		
		return criteria;
	}
	@Override
	public ModelStaffAttendanceView getById(ModelStaffAttendanceViewID id)
			throws ServiceException {
		// TODO Auto-generated method stub
		String hsql = "from ModelStaffAttendanceView v where v.attendanceViewId.origin='"+id.getOrigin()+"' and v.attendanceViewId.viewId='"+id.getViewId()+"'";
		try {
			List<ModelStaffAttendanceView>  list = this.daoStaffAttendanceView.findListByHSQL(hsql);
			if(list != null && list.size() >0)return list.get(0);
			else return null;
		} catch (DAOException e) {
			// TODO Auto-generated catch block
			throw new ServiceException(e);
		}
	}
}

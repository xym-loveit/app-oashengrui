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
	@Override
	public void insertFromWorkArrangeByDate(String startDay, String endDay,
			String districtId) throws ServiceException {
		// TODO Auto-generated method stub
		String sql = "insert into app_admin_attendance(work_date,work_time,offtime_shour,offtime_ehour,offtime_smin,offtime_emin,staff_id,staff_name,work_type,work_status,leave_type,staff_behalf_name,staff_behalf_id,meto,attendance_result,exception,dep_id,district_id)"
			+ " select work_date,concat(work_stime,'-',work_etime),null,null,null,null,staff_id,staff_name,work_type,'0',null,null,null,null,'1','1',a.dep_id,a.district_id from app_admin_workarrange a join app_system_work_time w where "
			+ " work_time = worktm_id and ISNULL(a.attend_id) and"
			+ " a.district_id="+districtId+" and work_date>='"+startDay+"' and work_date<='"+endDay+"'";
		try {
			this.daoStaffAttendance.execUpdateByNativeSQL(sql);
		} catch (DAOException e) {
			// TODO Auto-generated catch block
			throw new ServiceException(e);
		}
	}
}

package org.shengrui.oa.service.admin.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.shengrui.oa.dao.admin.DAOWorkArrange;
import org.shengrui.oa.model.admin.ModelAdminWorkArrange;
import org.shengrui.oa.service.admin.ServiceAdminWorkArrange;

import cn.trymore.core.exception.DAOException;
import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.impl.ServiceGenericImpl;
import cn.trymore.core.util.UtilString;
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
			if (entity.getStaffName() != null && !"".equals(entity.getStaffName()))
			{
				criteria.add(Restrictions.like("staffName", entity.getStaffName(),MatchMode.ANYWHERE));
			}

			if (entity.getWorkType() != null && entity.getWorkType().getId()!=null && !"".equals(entity.getWorkType().getId()) && !"-1".equals(entity.getWorkType().getId()))
			{
				criteria.createCriteria("workType").add(Restrictions.eq("id", entity.getWorkType().getId()));
			}
			
			if (entity.getWorkDate() != null )
			{
				criteria.add(Restrictions.eq("workDate", entity.getWorkDate()));
			}
			
			if(entity.getWorkContent()!=null && entity.getWorkContent().getId()!=null && !"".equals(entity.getWorkContent().getId())){
				criteria.createCriteria("workContent").add(Restrictions.eq("id", entity.getWorkContent().getId()));
			}
			if(entity.getWorkTime()!=null && entity.getWorkTime().getId()!=null && !"".equals(entity.getWorkTime().getId())){
				criteria.createCriteria("workTime").add(Restrictions.eq("id", entity.getWorkTime().getId()));
			}
			if(entity.getDistrictId()!=null && UtilString.isNotEmpty(entity.getDistrictId())){
				criteria.add(Restrictions.eq("districtId", entity.getDistrictId()));
			}
			
		}
		//System.out.println("entity:"+entity);
		
		criteria.addOrder(Order.asc("workDate"));
		criteria.addOrder(Order.asc("workTime"));
		criteria.addOrder(Order.asc("staffName"));
		
		return criteria;
	}

	public DAOWorkArrange getDaoWorkArrange() {
		return daoWorkArrange;
	}

	public void setDaoWorkArrange(DAOWorkArrange daoWorkArrange) {
		this.daoWorkArrange = daoWorkArrange;
	}

	@Override
	public void batchInsert(List<ModelAdminWorkArrange> list)
			throws ServiceException {
		// TODO Auto-generated method stub
		StringBuffer sql  = new StringBuffer();
		sql.append("insert into app_admin_workarrange(`work_date`, `work_time`, `staff_name`, `staff_id`, `work_type`, `work_content`, `district_id`, `dep_id`) values");
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		for(int i=0;i<list.size();i++){
			ModelAdminWorkArrange entity = list.get(i);
			sql.append("('").append(format.format(entity.getWorkDate())).append("',").append(entity.getWorkTime().getId()).append(",'")
			.append(entity.getStaffName()).append("',").append(entity.getStaff().getId()).append(",").append(entity.getWorkType().getId())
			.append(",").append(entity.getWorkContent().getId()).append(",").append(entity.getDistrictId()).append(",").append(entity.getDepId()).append(")");
			if(i != list.size()-1){
				sql.append(",");
			}
		}
		try {
			this.daoWorkArrange.execUpdateByNativeSQL(sql.toString());
		} catch (DAOException e) {
			// TODO Auto-generated catch block
			throw new ServiceException(e);
		}
	}

	@Override
	public List<ModelAdminWorkArrange> queryByCriteria(
			ModelAdminWorkArrange criteria) throws ServiceException {
		// TODO Auto-generated method stub
		try {
			return this.daoWorkArrange.getListByCriteria(this.getCriterias(criteria));
		} catch (DAOException e) {
			// TODO Auto-generated catch block
			throw new ServiceException(e);
		}
	}

	@Override
	public void batchRemoveByCriteria(ModelAdminWorkArrange criteria,List<String> staffIds)
			throws ServiceException {
		// TODO Auto-generated method stub
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		String sql = "delete from app_admin_workarrange where work_date = '"+format.format(criteria.getWorkDate())+"' and work_time='"+criteria.getWorkTime().getId()+"' and district_id='"+criteria.getDistrictId()+"' and (";
		if(staffIds !=null && staffIds.size()>0)
		{
			for(int i=0;i<staffIds.size();i++){
				sql+="staff_id='"+staffIds.get(i)+"'";
				if(i<staffIds.size()-1){
					sql+=" or ";
				}
			}
		}else{
			sql+="staff_id=''";
		}
		sql+=")";
		try {
			this.daoWorkArrange.execUpdateByNativeSQL(sql);
		} catch (DAOException e) {
			// TODO Auto-generated catch block
			throw new ServiceException(e);
		}
	}

	@Override
	public void batchUpdateByCriteria(ModelAdminWorkArrange criteria,String day,List<String> staffIds)
			throws ServiceException {
		// TODO Auto-generated method stub
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		String sql ="update app_admin_workarrange set work_date='"+day+"',work_time='"+criteria.getWorkTime().getId()+"'"
					+ " where work_date='"+format.format(criteria.getWorkDate())+"' and district_id="+criteria.getDistrictId()+" and (";
		if(staffIds !=null && staffIds.size()>0)
		{
			for(int i=0;i<staffIds.size();i++){
				sql+="staff_id='"+staffIds.get(i)+"'";
				if(i<staffIds.size()-1){
					sql+=" or ";
				}
			}
		}else{
			sql+="staff_id=''";
		}
		sql+=")";
		try {
			this.daoWorkArrange.execUpdateByNativeSQL(sql);
		} catch (DAOException e) {
			// TODO Auto-generated catch block
			throw new ServiceException(e);
		}
	}

	@Override
	public void batchCopyByDay(String day,String date, String districtId) throws ServiceException {
		// TODO Auto-generated method stub
		String sql = "insert into app_admin_workarrange(work_date,work_time,staff_name,staff_id,work_type,work_content,district_id)"
					+ " select '"+date+"',worktm_id,staff_name,staff_id,'1',workcnt_id,district_id from app_system_work_template where enable='1' and district_id="+districtId+" and work_day='"+day+"'";
		try {
			this.daoWorkArrange.execUpdateByNativeSQL(sql);
		} catch (DAOException e) {
			// TODO Auto-generated catch block
			throw new ServiceException(e);
		}
	}

	@Override
	public List<ModelAdminWorkArrange> queryByWeek(Date startDay,
			Date endDay, String districtId) throws ServiceException {
		// TODO Auto-generated method stub
		DetachedCriteria criteria = DetachedCriteria.forClass(ModelAdminWorkArrange.class);
		if (startDay != null )
		{
			criteria.add(Restrictions.ge("workDate", startDay));
		}
			
		if (endDay != null)
		{
			criteria.add(Restrictions.le("workDate", endDay));
		}
		if(districtId!=null && UtilString.isNotEmpty(districtId)){
			criteria.add(Restrictions.eq("districtId", districtId));
		}
		try {
			return this.daoWorkArrange.getListByCriteria(criteria);
		} catch (DAOException e) {
			// TODO Auto-generated catch block
			throw new ServiceException(e);
		}
	}

	@Override
	public List<ModelAdminWorkArrange> queryCurrentYearWorkArrangById(
			String id, Date yearStart, Date yearEnd) throws ServiceException {
		// TODO Auto-generated method stub
		DetachedCriteria criteria = DetachedCriteria.forClass(ModelAdminWorkArrange.class);
		if (id != null && UtilString.isNotEmpty(id))
		{
			criteria.createCriteria("staff").add(Restrictions.eq("id", id));
		}
		if(yearStart != null)
		{
			criteria.add(Restrictions.ge("workDate", yearStart));
		}
		if(yearEnd != null)
		{
			criteria.add(Restrictions.le("workDate", yearEnd));
		}
		criteria.createCriteria("workType").add(Restrictions.eq("id", "2"));
		try {
			return this.daoWorkArrange.getListByCriteria(criteria);
		} catch (DAOException e) {
			// TODO Auto-generated catch block
			throw new ServiceException(e);
		}
	}

}

package org.shengrui.oa.service.system.impl;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.shengrui.oa.dao.system.DAOBaseWorkTime;
import org.shengrui.oa.model.system.ModelBaseWorkTime;
import org.shengrui.oa.service.system.ServiceBaseWorkTime;

import cn.trymore.core.exception.DAOException;
import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.impl.ServiceGenericImpl;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

/**
 * @author Tank.L
 * 
 */
public class ServiceBaseWorkTimeImpl extends
		ServiceGenericImpl<ModelBaseWorkTime> implements ServiceBaseWorkTime {
	private DAOBaseWorkTime daoBaseWorkTime;

	public DAOBaseWorkTime getDaoBaseWorkTime() {
		return daoBaseWorkTime;
	}

	public void setDaoBaseWorkTime(DAOBaseWorkTime daoBaseWorkTime) {
		this.daoBaseWorkTime = daoBaseWorkTime;
	}

	public ServiceBaseWorkTimeImpl(DAOBaseWorkTime dao) {
		super(dao);
		this.daoBaseWorkTime = dao;
		// TODO Auto-generated constructor stub
	}

	@Override
	public ModelBaseWorkTime getById(String id) throws ServiceException {
		// TODO Auto-generated method stub
		return this.get(id);
	}

	@Override
	public PaginationSupport<ModelBaseWorkTime> getPaginationByEntity(
			ModelBaseWorkTime entity, PagingBean pagingBean)
			throws ServiceException {
		// TODO Auto-generated method stub
		DetachedCriteria criteria = DetachedCriteria
				.forClass(ModelBaseWorkTime.class);
		if (entity != null) {
			if (entity.getBaseTimeDistrict() != null
					&& entity.getBaseTimeDistrict().getId() != null
					&& !"".equals(entity.getBaseTimeDistrict().getId())) {
				criteria.createCriteria("baseTimeDistrict").add(
						Restrictions.eq("id", entity.getBaseTimeDistrict()
								.getId()));
			}
			if(entity.getTemplateId() != null && !"".equals(entity.getTemplateId())){
				criteria.add(Restrictions.eq("templateId", entity.getTemplateId()));
			}
		}

		criteria.addOrder(Order.desc("updateTime"));

		return this.getAll(criteria, pagingBean);
	}

	@Override
	public List<ModelBaseWorkTime> getDayWorkTimeByDistrictIdAndTemplateId(String districtId,String templateId)
			throws ServiceException {
		// TODO Auto-generated method stub
		DetachedCriteria criteria = DetachedCriteria
		.forClass(ModelBaseWorkTime.class);
		if(templateId!=null && !"".equals(templateId)){
			criteria.add(Restrictions.eq("templateId", templateId));
			criteria.createCriteria("baseTimeDistrict").add(Restrictions.eq("id", districtId));
		}
		try {
			return this.getDaoBaseWorkTime().getListByCriteria(criteria);
		} catch (DAOException e) {
			// TODO Auto-generated catch block
			throw new ServiceException(e);
		}
	}
}

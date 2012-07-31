package org.shengrui.oa.service.system.impl;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Restrictions;
import org.shengrui.oa.dao.system.DAOSchoolDistrict;
import org.shengrui.oa.model.system.ModelSchoolDistrict;
import org.shengrui.oa.service.system.ServiceSchoolDistrict;

import cn.trymore.core.exception.DAOException;
import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.impl.ServiceGenericImpl;
import cn.trymore.core.util.UtilString;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

/**
 * The implementation of service of school district
 * 
 * @author Jeccy.Zhao
 *
 */
public class ServiceSchoolDistrictImpl
extends ServiceGenericImpl<ModelSchoolDistrict> implements ServiceSchoolDistrict
{
	
	private DAOSchoolDistrict daoSchoolDistrict;
	
	public ServiceSchoolDistrictImpl (DAOSchoolDistrict dao)
	{
		super(dao);
		this.daoSchoolDistrict = dao;
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.system.ServiceSchoolDistrict#getDistrictByNo(java.lang.String)
	 */
	@Override
	public ModelSchoolDistrict getDistrictByNo(String districtNo) 
			throws ServiceException
	{
		try
		{
			return this.daoSchoolDistrict.getDistrictByNo(districtNo);
		} 
		catch (Exception e)
		{
			throw new ServiceException(e);
		}
	}

	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.system.ServiceSchoolDistrict#getSchoolDistrictPagination(org.shengrui.oa.model.system.ModelSchoolDistrict, cn.trymore.core.web.paging.PagingBean)
	 */
	@Override
	public PaginationSupport<ModelSchoolDistrict> getSchoolDistrictPagination(
			ModelSchoolDistrict entity, PagingBean pagingBean)
			throws ServiceException
	{
		return this.getAll(getCriterias(entity), pagingBean);
	}
	
	/**
	 * 
	 * @param entity
	 * @return
	 */
	private DetachedCriteria getCriterias(ModelSchoolDistrict entity)
	{
		DetachedCriteria criteria = DetachedCriteria.forClass(ModelSchoolDistrict.class);
		
		if (entity != null)
		{
			if (UtilString.isNotEmpty(entity.getDistrictNo()))
			{
				criteria.add(Restrictions.eq("districtNo", entity.getDistrictNo()));
			}
			
			if (UtilString.isNotEmpty(entity.getDistrictAddress()))
			{
				criteria.add(Restrictions.like("districtAddress", entity.getDistrictAddress(), MatchMode.ANYWHERE));
			}
			
			if (UtilString.isNotEmpty(entity.getDistrictName()))
			{
				criteria.add(Restrictions.like("districtName", entity.getDistrictName(), MatchMode.ANYWHERE));
			}
			
			if (UtilString.isNotEmpty(entity.getDistrictPhone()))
			{
				criteria.add(Restrictions.like("districtPhone", entity.getDistrictPhone(), MatchMode.ANYWHERE));
			}
			
			if (entity.getDistrictType() != null)
			{
				criteria.add(Restrictions.eq("districtType", entity.getDistrictType()));
			}
		}
		
		return criteria;
	}
	
	public DAOSchoolDistrict getDaoSchoolDistrict()
	{
		return daoSchoolDistrict;
	}

	public void setDaoSchoolDistrict(DAOSchoolDistrict daoSchoolDistrict)
	{
		this.daoSchoolDistrict = daoSchoolDistrict;
	}

	@Override
	public ModelSchoolDistrict getDistrictByName(String districtName)
			throws ServiceException {

		try {
			return this.daoSchoolDistrict.getDistrictByName(districtName);
		} catch (Exception e) {
			throw new ServiceException(e);
		}
	}

}

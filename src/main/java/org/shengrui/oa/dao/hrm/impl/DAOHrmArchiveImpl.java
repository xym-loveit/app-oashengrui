package org.shengrui.oa.dao.hrm.impl;

import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.shengrui.oa.dao.hrm.DAOHrmArchive;
import org.shengrui.oa.model.hrm.ModelHrmArchive;
import org.shengrui.oa.model.hrm.ModelHrmJobHireInfo;
import org.shengrui.oa.model.hrm.ModelHrmResume;

import cn.trymore.core.dao.impl.DAOGenericImpl;
import cn.trymore.core.exception.DAOException;
import cn.trymore.core.hibernate.HibernateUtils;
import cn.trymore.core.util.UtilString;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

public class DAOHrmArchiveImpl
extends DAOGenericImpl<ModelHrmArchive> implements DAOHrmArchive
{
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.dao.hrm.DAOHrmArchive#getPagination(org.shengrui.oa.model.hrm.ModelHrmArchive, cn.trymore.core.web.paging.PagingBean)
	 */
	@Override
	public PaginationSupport<ModelHrmArchive> getPagination (ModelHrmArchive entity, 
			PagingBean pagingBean) throws DAOException
	{
		return this.findPageByCriteria(getCriteria(entity), pagingBean);
	}
	
	/**
	 * Obtains the criteria with the specified entity.
	 * 
	 * @param entity
	 * @return
	 */
	private DetachedCriteria getCriteria (ModelHrmArchive entity)
	{
		DetachedCriteria criteria = DetachedCriteria.forClass(ModelHrmArchive.class);
		
		if (entity != null)
		{
			if (entity.getJobHireInfo() != null)
			{
				Criterion criterion = null;
				DetachedCriteria subCriteria = criteria.createCriteria("jobHireInfo");
				
				ModelHrmJobHireInfo jobHireInfo = entity.getJobHireInfo();
				
				if (UtilString.isNotEmpty(jobHireInfo.getJobHireTitle()))
				{
					criterion = HibernateUtils.QBC_AND(criterion, Restrictions.eq("jobHireTitle", jobHireInfo.getJobHireTitle()));
				}
				
				if (jobHireInfo.getJobHireDistrict() != null && 
						UtilString.isNotEmpty(jobHireInfo.getJobHireDistrict().getId()))
				{
					subCriteria.createCriteria("jobHireDistrict").add(Restrictions.eq("id", jobHireInfo.getJobHireDistrict().getId()));
				}
				
				if (jobHireInfo.getJobHireDepartment() != null && 
						UtilString.isNotEmpty(jobHireInfo.getJobHireDepartment().getId()))
				{
					subCriteria.createCriteria("jobHireDepartment").add(Restrictions.eq("id", jobHireInfo.getJobHireDepartment().getId()));
				}
				
				if (criterion != null)
				{
					subCriteria.add(criterion);
				}
			}
			
			if (entity.getResume() != null)
			{
				Criterion criterion = null;
				DetachedCriteria subCriteria = criteria.createCriteria("resume");
				
				ModelHrmResume resume = entity.getResume();
				
				if (UtilString.isNotEmpty(resume.getEducationCollege()))
				{
					criterion = HibernateUtils.QBC_AND(criterion, Restrictions.eq("educationCollege", resume.getEducationCollege()));
				}
				
				if (UtilString.isNotEmpty(resume.getEducationMajority()))
				{
					criterion = HibernateUtils.QBC_AND(criterion, Restrictions.eq("educationMajority", resume.getEducationMajority()));
				}
				
				if (resume.getEducationDegree() != null && resume.getEducationDegree() >-1)
				{
					criterion = HibernateUtils.QBC_AND(criterion, Restrictions.eq("educationDegree", resume.getEducationDegree()));
				}
				
				if (resume.getTeacherMajority() != null && resume.getTeacherMajority() >-1)
				{
					criterion = HibernateUtils.QBC_AND(criterion, Restrictions.eq("teacherMajority", resume.getTeacherMajority()));
				}
				
				if (resume.getTeacherCertifaciton() != null && resume.getTeacherCertifaciton() >-1)
				{
					criterion = HibernateUtils.QBC_AND(criterion, Restrictions.eq("teacherCertifaciton", resume.getTeacherCertifaciton()));
				}
				
				if (resume.getChineseLevel() != null && resume.getChineseLevel() >-1)
				{
					criterion = HibernateUtils.QBC_AND(criterion, Restrictions.eq("chineseLevel", resume.getChineseLevel()));
				}
				
				if (criterion != null)
				{
					subCriteria.add(criterion);
				}
			}
			
			if (entity.getStarLevel() != null && entity.getStarLevel() > -1)
			{
				criteria.add(Restrictions.eq("starLevel", entity.getStarLevel()));
			}
		}
		
		return criteria;
	}
	
}

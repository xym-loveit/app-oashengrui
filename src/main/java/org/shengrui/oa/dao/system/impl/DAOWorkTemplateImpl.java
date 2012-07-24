package org.shengrui.oa.dao.system.impl;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.shengrui.oa.dao.system.DAOWorkTemplate;
import org.shengrui.oa.model.system.ModelWorkTemplate;

import cn.trymore.core.dao.impl.DAOGenericImpl;
import cn.trymore.core.exception.DAOException;

public class DAOWorkTemplateImpl
extends DAOGenericImpl<ModelWorkTemplate> implements DAOWorkTemplate
{
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.dao.system.DAOWorkTemplate#getWorkArrangesByTemplateIdAndDay(java.lang.String,java.lang.String)
	 */
	@Override
	public List<ModelWorkTemplate> getWorkArrangesByCriteria(
			ModelWorkTemplate entity) throws DAOException
	{
		DetachedCriteria criteria = DetachedCriteria.forClass(ModelWorkTemplate.class);
		
		if (entity != null && entity.getTemplateId()!=null)
		{
			criteria.add(Restrictions.eq("templateId", entity.getTemplateId()));
		}
		if(entity != null && entity.getDistrict().getId()!=null){
			criteria.createCriteria("district").add(Restrictions.eq("id", entity.getDistrict().getId()));
		}
		
		return this.getListByCriteria(criteria);
	}

	@Override
	public int enableTemplate(String id) throws DAOException {
		// TODO Auto-generated method stub
		String sql = "update app_system_work_template set enable='1' where template_id='"+id+"'";
		String sql2 = "update app_system_work_template set enable='0'";
		this.execUpdateByNativeSQL(sql2);
		return this.execUpdateByNativeSQL(sql);
	}

	@Override
	public ModelWorkTemplate getEnabledWorkTemplate(String districtId) throws DAOException {
		// TODO Auto-generated method stub
		DetachedCriteria criteria  = DetachedCriteria.forClass(ModelWorkTemplate.class);
		if(districtId == null){
			districtId = "-1";
		}
		criteria.createCriteria("district").add(Restrictions.eq("id", districtId));
		criteria.add(Restrictions.eq("enable", "1"));
		List<ModelWorkTemplate> list = this.getListByCriteria(criteria);
		return list.size()>0?list.get(0):null;
	}

}

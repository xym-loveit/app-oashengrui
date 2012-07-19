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

}

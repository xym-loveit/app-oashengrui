package org.shengrui.oa.service.system.impl;

import java.util.List;

import org.shengrui.oa.dao.system.DAOWorkTemplate;
import org.shengrui.oa.model.system.ModelWorkTemplate;
import org.shengrui.oa.service.system.ServiceWorkTemplate;

import cn.trymore.core.exception.DAOException;
import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.impl.ServiceGenericImpl;

/**
 * @author tank
 *
 */
public class ServiceWorkTemplateImpl extends ServiceGenericImpl<ModelWorkTemplate> implements ServiceWorkTemplate {
	protected DAOWorkTemplate daoWorkTemplate;
	/**
	 * @return the daoWorkTemplate
	 */
	public DAOWorkTemplate getDaoWorkTemplate() {
		return daoWorkTemplate;
	}

	/**
	 * @param daoWorkTemplate the daoWorkTemplate to set
	 */
	public void setDaoWorkTemplate(DAOWorkTemplate daoWorkTemplate) {
		this.daoWorkTemplate = daoWorkTemplate;
	}

	public ServiceWorkTemplateImpl(DAOWorkTemplate dao) {
		super(dao);
		this.daoWorkTemplate = dao;
		// TODO Auto-generated constructor stub
	}

	@Override
	public List<ModelWorkTemplate> getListByCriteria(ModelWorkTemplate entity) throws ServiceException {
		// TODO Auto-generated method stub
		try {
			return this.daoWorkTemplate.getWorkArrangesByCriteria(entity);
		} catch (DAOException e) {
			// TODO Auto-generated catch block
			throw new ServiceException(e);
		}
	}

	@Override
	public List<ModelWorkTemplate> getListByNativeSQL(ModelWorkTemplate entity)
			throws ServiceException {
		// TODO Auto-generated method stub
		
		return null;
	}

	@Override
	public int enableWorkTemplate(String id) throws ServiceException {
		// TODO Auto-generated method stub
		try {
			return this.daoWorkTemplate.enableTemplate(id);
		} catch (DAOException e) {
			// TODO Auto-generated catch block
			throw new ServiceException(e);
		}
	}

	@Override
	public ModelWorkTemplate getEnabledWorkTemplate(String districtId) throws ServiceException {
		// TODO Auto-generated method stub
		try {
			return this.daoWorkTemplate.getEnabledWorkTemplate(districtId);
		} catch (DAOException e) {
			// TODO Auto-generated catch block
			throw new ServiceException(e);
		}
	}

}

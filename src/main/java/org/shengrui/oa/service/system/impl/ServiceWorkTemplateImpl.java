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

	@Override
	public void batchInsert(List<ModelWorkTemplate> list)
			throws ServiceException {
		// TODO Auto-generated method stub
		StringBuffer sql  = new StringBuffer();
		sql.append("insert into app_system_work_template(`work_day`, `worktm_id`, `district_id`, `staff_id`, `staff_name`, `enable`, `template_id`, `workcnt_id`) values");
		for(int i=0;i<list.size();i++){
			ModelWorkTemplate entity = list.get(i);
			sql.append("('").append(entity.getWorkDay()).append("',").append(entity.getWorkTime().getId()).append(",")
			.append(entity.getDistrict().getId()).append(",").append(entity.getStaff().getId()).append(",'")
			.append(entity.getStaffName()).append("','").append(entity.getEnable()).append("',").append(entity.getTemplateId())
			.append(",").append(entity.getWorkContent().getId()).append(")");
			if(i != list.size()-1){
				sql.append(",");
			}
		}
		try {
			this.daoWorkTemplate.execUpdateByNativeSQL(sql.toString());
		} catch (DAOException e) {
			// TODO Auto-generated catch block
			throw new ServiceException(e);
		}
	}

	
	public void delete(String workDay,String tempId) throws ServiceException {

		String sql_del = "delete from app_system_work_template where template_id='"+tempId+"' and work_day='"+workDay+"'";
		try {
			this.daoWorkTemplate.execUpdateByNativeSQL(sql_del);
		} catch (DAOException e) {
			// TODO Auto-generated catch block
			throw new ServiceException(e);
		}
	}
}

package org.shengrui.oa.service.system;

import java.util.List;

import org.shengrui.oa.model.system.ModelWorkTemplate;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.ServiceGeneric;

/**
 * @author tank
 *
 */
public interface ServiceWorkTemplate extends ServiceGeneric<ModelWorkTemplate> {

	public List<ModelWorkTemplate> getListByCriteria(ModelWorkTemplate entity) throws ServiceException;
	
	public List<ModelWorkTemplate> getListByNativeSQL(ModelWorkTemplate entity) throws ServiceException;
	
	public int enableWorkTemplate(String id) throws ServiceException;
	
	public ModelWorkTemplate getEnabledWorkTemplate(String districtId) throws ServiceException;
	
	/**
	 * 用原生SQL批量插入
	 * @param list
	 * @throws ServiceException
	 */
	public void batchInsert(List<ModelWorkTemplate> list) throws ServiceException;
	
	public void delete(String workDay,String tempId) throws ServiceException;
}

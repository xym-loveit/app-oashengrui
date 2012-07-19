package org.shengrui.oa.service.system;

import java.util.List;

import org.shengrui.oa.model.system.ModelBaseWorkTime;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.ServiceGeneric;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

/**
 * @author Tank.L
 *
 */
public interface ServiceBaseWorkTime extends ServiceGeneric<ModelBaseWorkTime> {
	/**
	 * 根据id得到一条基础工作记录
	 * @author Tang 
	 */
	public ModelBaseWorkTime getById(String id)throws ServiceException;
	
	/**
	 * 根据信息查分页数据
	 * 
	 * @param entity
	 * @param pagingBean
	 * @return
	 * @throws ServiceException
	 */
	PaginationSupport<ModelBaseWorkTime> getPaginationByEntity (ModelBaseWorkTime entity, 
			PagingBean pagingBean) throws ServiceException;
	
	/**
	 * 根据模板号查工作时间分布
	 */
	public List<ModelBaseWorkTime> getDayWorkTimeByTemplateId(String templateId) throws ServiceException;
}

package org.shengrui.oa.service.admin;

import java.util.List;

import org.shengrui.oa.model.admin.ModelStaffAttendance;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.ServiceGeneric;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

/**
 * @author tank
 *
 */
public interface ServiceStaffAttendance extends ServiceGeneric<ModelStaffAttendance> {
	
	/**
	 * 根据id得到一条考勤记录
	 * @author Tang 
	 */
	public ModelStaffAttendance getById(String id)throws ServiceException;
	
	/**
	 * 根据信息查分页数据
	 * 
	 * @param entity
	 * @param pagingBean
	 * @return
	 * @throws ServiceException
	 */
	PaginationSupport<ModelStaffAttendance> getPaginationByEntity (ModelStaffAttendance entity, 
			PagingBean pagingBean) throws ServiceException;
	
	List<ModelStaffAttendance> getListByCriteria(ModelStaffAttendance entity) throws ServiceException;
}

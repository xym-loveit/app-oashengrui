package org.shengrui.oa.service.admin;

import org.shengrui.oa.model.admin.ModelStaffAttendanceView;
import org.shengrui.oa.model.admin.ModelStaffAttendanceViewID;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.ServiceGeneric;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

/**
 * @author tank
 *
 */
public interface ServiceStaffAttendanceView extends ServiceGeneric<ModelStaffAttendanceView> {
	
	ModelStaffAttendanceView getById(ModelStaffAttendanceViewID id) throws ServiceException;
	
	/**
	 * 根据信息查分页数据
	 * 
	 * @param entity
	 * @param pagingBean
	 * @return
	 * @throws ServiceException
	 */
	PaginationSupport<ModelStaffAttendanceView> getPaginationByEntity (ModelStaffAttendanceView entity, 
			PagingBean pagingBean) throws ServiceException;
	
}

package cn.trymore.oa.service.system;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.ServiceGeneric;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;
import cn.trymore.oa.model.system.ModelSystemLog;

public interface ServiceSystemLog
extends ServiceGeneric<ModelSystemLog>
{
	/**
	 * 根据id得到一条基础工作记录
	 * @author Lee
	 */
	public ModelSystemLog getById(String id)throws ServiceException;
	
	/**
	 * 根据信息查分页数据
	 * 
	 * @param entity
	 * @param pagingBean
	 * @return
	 * @throws ServiceException
	 */
	PaginationSupport<ModelSystemLog> getPaginationByEntity (ModelSystemLog entity, 
			PagingBean pagingBean) throws ServiceException;
}

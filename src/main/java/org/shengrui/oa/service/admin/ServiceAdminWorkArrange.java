package org.shengrui.oa.service.admin;

import java.util.Date;
import java.util.List;

import org.shengrui.oa.model.admin.ModelAdminWorkArrange;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.ServiceGeneric;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

/**
 * The service for admin work arrange
 * 
 * @author Tang
 *
 */
public interface ServiceAdminWorkArrange
extends ServiceGeneric<ModelAdminWorkArrange>
{
	
	/**
	 * 根据id得到一条工作安排记录
	 * @author Tang 
	 */
	public ModelAdminWorkArrange getById(String id)throws ServiceException;
	
	/**
	 * 根据信息查分页数据
	 * 
	 * @param entity
	 * @param pagingBean
	 * @return
	 * @throws ServiceException
	 */
	PaginationSupport<ModelAdminWorkArrange> getPaginationByEntity (ModelAdminWorkArrange entity, 
			PagingBean pagingBean) throws ServiceException;
	
	/**
	 * 用原生SQL批量插入
	 * @param list
	 * @throws ServiceException
	 */
	public void batchInsert(List<ModelAdminWorkArrange> list) throws ServiceException;
	
	/**
	 * 多条件查询
	 * @param criteria
	 * @return
	 * @throws ServiceException
	 */
	public List<ModelAdminWorkArrange> queryByCriteria(ModelAdminWorkArrange criteria) throws ServiceException;
	
	/**
	 * 批量删除
	 * @param criteria
	 * @throws ServiceException
	 */
	public void batchRemoveByCriteria(ModelAdminWorkArrange criteria,List<String> staffIds) throws ServiceException;
	
	/**
	 * 批量更新
	 * @param criteria
	 * @throws ServiceException
	 */
	public void batchUpdateByCriteria(ModelAdminWorkArrange criteria,String day,List<String> staffIds) throws ServiceException;
	
	/**
	 * 按校区批量导入模板
	 * @param day
	 * @param date
	 * @param districtId
	 * @throws ServiceException
	 */
	public void batchCopyByDay(String day,String date,String districtId) throws ServiceException;
	
	/**
	 * 按周查询工作内容情况
	 * @param startDay
	 * @param endDay
	 * @param districtId
	 * @return
	 * @throws ServiceException
	 */
	public List<ModelAdminWorkArrange> queryByWeek(Date startDay, Date endDay, String districtId) throws ServiceException;
	
	public List<ModelAdminWorkArrange> queryCurrentYearWorkArrangById(String id,Date yearStart,Date yearEnd) throws ServiceException;
}

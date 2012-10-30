package org.shengrui.oa.service.finan;

import org.shengrui.oa.model.finan.ModelFinanContract;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.ServiceGeneric;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

/**
 * The financial contract service.
 * 
 * @author Jeccy.Zhao
 *
 */
public interface ServiceFinanContract
extends ServiceGeneric<ModelFinanContract>
{
	
	/**
	 *根据申请单号 获取合同用申请数据
	 * 
	 * @param formNo
	 *                申请单号
	 * @return
	 * @throws ServiceException
	 */
	ModelFinanContract getByFormNo (String formNo) throws ServiceException;
	
	/**
	 * 合同申請查分页数据
	 * 
	 * @param entity
	 * @param pagingBen
	 * @return
	 * @throws ServiceException
	 */
	PaginationSupport<ModelFinanContract> getFinanContractInfoPagination (ModelFinanContract entity, 
			PagingBean pagingBean) throws ServiceException;
	
	
	/**
	 * 合同申請查分页数据
	 * 
	 * @param entity
	 * @param pagingBen
	 * @return
	 * @throws ServiceException
	 */
	PaginationSupport<ModelFinanContract> getFinanContractInfoPagination (ModelFinanContract entity, 
			PagingBean pagingBean, Boolean isOnApproval) throws ServiceException;
	
	/**
	 * 查询未审批过的合同
	 * @author pyc
	 * */
	PaginationSupport<ModelFinanContract> finanContract (ModelFinanContract entity, 
			String query, PagingBean pagingBean) throws ServiceException;
	
	/**
	 * 
	 * 查询已审批过的合同
	 * @author pyc
	 * */
	PaginationSupport<ModelFinanContract> finanContractRec (ModelFinanContract entity, 
			PagingBean pagingBean) throws ServiceException;
}

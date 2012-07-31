package org.shengrui.oa.service.system;

import org.shengrui.oa.model.system.ModelSchoolDistrict;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.ServiceGeneric;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

/**
 * The service of school district
 * 
 * @author Jeccy.Zhao
 *
 */
public interface ServiceSchoolDistrict
extends ServiceGeneric<ModelSchoolDistrict>
{
	
	/**
	 * 
	 * @param districtNo
	 * @return
	 * @throws ServiceException
	 */
	ModelSchoolDistrict getDistrictByNo(String districtNo) 
			throws ServiceException;
	
	/**
	 * 根据实体及分页条件查询校区分页数据
	 * 
	 * @param entity
	 * @param pagingBean
	 * @return
	 * @throws ServiceException
	 */
	PaginationSupport<ModelSchoolDistrict> getSchoolDistrictPagination(ModelSchoolDistrict entity,
			PagingBean pagingBean) throws ServiceException;
	
	/**
	 * 根据校区名称查询校区编号
	 * @author pyc
	 * 
	 * */
	ModelSchoolDistrict getDistrictByName(String districtName) throws ServiceException;
	
	
}

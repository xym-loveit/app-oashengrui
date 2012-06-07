package org.shengrui.oa.service.system;

import org.shengrui.oa.model.system.ModelAppUser;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.ServiceGeneric;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

/**
 * The application user service.
 * 
 * @author Jeccy.Zhao
 *
 */
public interface ServiceAppUser
extends ServiceGeneric<ModelAppUser>
{
	/**
	 * Obtains user with the specified user name.
	 * 
	 * @param userName
	 *            the user name
	 * @return user entity if existed with the specified user name; null returned otherwise.
	 * @throws ServiceException
	 */
	ModelAppUser findByUserName (String userName) throws ServiceException;
	
	
	/**
	 * 获取分页用户数据
	 * 
	 * @param entity
	 * @param pagingBean
	 * @return
	 * @throws ServiceException
	 */
	PaginationSupport<ModelAppUser> getUserPagination (ModelAppUser entity, 
			PagingBean pagingBean) throws ServiceException;
	
}

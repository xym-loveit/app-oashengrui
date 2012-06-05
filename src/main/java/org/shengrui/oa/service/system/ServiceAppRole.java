package org.shengrui.oa.service.system;

import java.util.List;
import java.util.Map;
import java.util.Set;

import org.shengrui.oa.model.system.ModelAppRole;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.ServiceGeneric;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

/**
 * The service of application role
 * 
 * @author Jeccy.Zhao
 *
 */
public interface ServiceAppRole
extends ServiceGeneric<ModelAppRole>
{
	
	/**
	 * 根据角色名获取角色
	 * 
	 * @param roleName
	 *                 角色名称
	 * @return
	 * @throws ServiceException
	 */
	ModelAppRole getRoleByName(String roleName) throws ServiceException;
	
	/**
	 * 获取角色及对应的角色功能表, 主要用于安全控制
	 * 
	 * @return
	 * @throws ServiceException
	 */
	Map<String, Set<String>> getSecurityDataSource() throws ServiceException;
	
	/**
	 * 根据标识Key获取角色
	 * 
	 * @param roleKey
	 *            角色标识Key
	 * @return
	 * @throws ServiceException
	 */
	ModelAppRole getRoleByKey (String roleKey) throws ServiceException;
	
	/**
	 * 根据角色类型获取角色列表
	 * 
	 * @param roleType
	 *            角色类型
	 * @return
	 * @throws ServiceException
	 */
	List<ModelAppRole> getRolesByType (Integer roleType) throws ServiceException;
	
	/**
	 * 获取分页数据
	 * 
	 * @param entity
	 * @param pagingBean
	 * @return
	 * @throws ServiceException
	 */
	PaginationSupport<ModelAppRole> getRolePagination (ModelAppRole entity, 
			PagingBean pagingBean) throws ServiceException;
	
}

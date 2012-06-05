package org.shengrui.oa.dao.system;

import java.util.List;

import org.shengrui.oa.model.system.ModelAppRole;

import cn.trymore.core.dao.DAOGeneric;
import cn.trymore.core.exception.DAOException;

/**
 * The implementation of application role repository.
 * 
 * @author Jeccy.Zhao
 *
 */
public interface DAOAppRole
extends DAOGeneric<ModelAppRole>
{
	
	/**
	 * 根据角色名获取角色
	 * 
	 * @param roleName
	 *                 角色名称
	 * @return 角色实体
	 * @throws DAOException
	 */
	ModelAppRole getRoleByName (String roleName) throws DAOException;
	
	/**
	 * 根据标识Key获取角色
	 * 
	 * @param roleKey
	 *                 角色标识Key
	 * @return 角色实体
	 * @throws DAOException
	 */
	ModelAppRole getRoleByKey (String roleKey) throws DAOException;
	
	/**
	 * 根据角色类型获取角色列表
	 * 
	 * @param roleType
	 *                 角色类型
	 * @return
	 * @throws DAOException
	 */
	List<ModelAppRole> getRolesByType (Integer roleType) throws DAOException;
}

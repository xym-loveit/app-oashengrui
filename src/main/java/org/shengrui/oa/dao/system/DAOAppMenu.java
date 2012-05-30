package org.shengrui.oa.dao.system;

import java.util.List;

import org.shengrui.oa.model.system.ModelAppMenu;

import cn.trymore.core.dao.DAOGeneric;
import cn.trymore.core.exception.DAOException;

/**
 * The application menu repository.
 * 
 * @author Jeccy.Zhao
 *
 */
public interface DAOAppMenu
extends DAOGeneric<ModelAppMenu>
{
	/**
	 * 获取所有父节点菜单.
	 * 
	 * @return 父节点菜单列表
	 * @throws DAOException
	 */
	List<ModelAppMenu> getAllRootMenus () throws DAOException;
	
	/**
	 * 根据父节点id获取菜单列表
	 * 
	 * @param parentId
	 *           父节点菜单id
	 * @return 菜单列表
	 * @throws DAOException
	 */
	List<ModelAppMenu> getMenusByParentId (String parentId) throws DAOException;
}

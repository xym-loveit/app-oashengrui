package org.shengrui.oa.service.system;

import java.util.List;

import org.shengrui.oa.model.system.ModelAppMenu;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.ServiceGeneric;

/**
 * The service of application menu
 * 
 * @author Jeccy.Zhao
 *
 */
public interface ServiceAppMenu
extends ServiceGeneric<ModelAppMenu>
{
	/**
	 * 根据菜单Key查询菜单项
	 * 
	 * @param menuKey
	 *                 菜单Key
	 * @return
	 * @throws ServiceException
	 */
	ModelAppMenu getMenuByKey (String menuKey) throws ServiceException;
	
	/**
	 * 获取所有父节点菜单.
	 * 
	 * @return 父节点菜单列表
	 * @throws ServiceException
	 */
	List<ModelAppMenu> getAllRootMenus () throws ServiceException;
}

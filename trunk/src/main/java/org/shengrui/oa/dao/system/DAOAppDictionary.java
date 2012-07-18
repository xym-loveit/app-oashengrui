package org.shengrui.oa.dao.system;

import java.util.List;

import org.shengrui.oa.model.system.ModelAppDictionary;

import cn.trymore.core.dao.DAOGeneric;
import cn.trymore.core.exception.DAOException;

/**
 * The application dictionary repository.
 * 
 * @author Tang
 *
 */
public interface DAOAppDictionary
extends DAOGeneric<ModelAppDictionary>
{
	/**
	 * 
	 * @param name
	 * @return
	 * @throws DAOException
	 */
	List<ModelAppDictionary> getByName (String name) throws DAOException;
	
	/**
	 * 根据数据字典中的类型获取新闻类型名称
	 * @author pyc
	 * */
	List<ModelAppDictionary> getByType(String type) throws DAOException;
}

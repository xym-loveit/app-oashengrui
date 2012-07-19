package org.shengrui.oa.dao.system;

import java.util.List;

import org.shengrui.oa.model.system.ModelWorkTemplate;

import cn.trymore.core.dao.DAOGeneric;
import cn.trymore.core.exception.DAOException;

/**
 * The department repository.
 * 
 * @author Jeccy.Zhao
 *
 */
public interface DAOWorkTemplate
extends DAOGeneric<ModelWorkTemplate>
{
	
	/**
	 * 根据模板ID和日期获取工作安排列表
	 * 
	 * @param orgType
	 * @return
	 * @throws DAOException
	 */
	List<ModelWorkTemplate> getWorkArrangesByCriteria (ModelWorkTemplate entity) throws DAOException;
	
}

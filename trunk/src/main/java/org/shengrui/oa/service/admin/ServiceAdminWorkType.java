package org.shengrui.oa.service.admin;

import java.util.List;
import org.shengrui.oa.model.admin.ModelAdminWorkType;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.ServiceGeneric;

/**
 * The service for admin work type
 * 
 * @author Tang
 *
 */
public interface ServiceAdminWorkType
extends ServiceGeneric<ModelAdminWorkType>
{
	
	/**
	 * 查询所有的工作类型提供给combo使用
	 * @author Tang
	 */
	List<ModelAdminWorkType> getAllWorkTypes()throws ServiceException;
	
}

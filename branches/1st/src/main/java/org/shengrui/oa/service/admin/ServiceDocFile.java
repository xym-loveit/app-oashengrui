package org.shengrui.oa.service.admin;

import org.shengrui.oa.model.admin.ModelDocFile;

import cn.trymore.core.exception.DAOException;
import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.ServiceGeneric;

/**
 * The service for doc File 
 * 
 * @author Tang
 *
 */
public interface ServiceDocFile
extends ServiceGeneric<ModelDocFile>
{
	/**
	 * 文件信息上传保存
	 * @author Tang
	 * @throws DAOException 
	 */
	public void saveDocFile(Integer doc_id,Integer file_id)throws ServiceException, DAOException;
	
}

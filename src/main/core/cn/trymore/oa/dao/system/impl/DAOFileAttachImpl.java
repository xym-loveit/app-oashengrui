package cn.trymore.oa.dao.system.impl;

import cn.trymore.oa.dao.system.DAOFileAttach;
import cn.trymore.oa.model.system.ModelFileAttach;

import cn.trymore.core.dao.impl.DAOGenericImpl;
import cn.trymore.core.exception.DAOException;
import cn.trymore.core.util.UtilString;

/**
 * The file attachment repository.
 * 
 * @author Jeccy.Zhao
 *
 */
public class DAOFileAttachImpl
extends DAOGenericImpl<ModelFileAttach> implements DAOFileAttach
{
	/*
	 * (non-Javadoc)
	 * @see cn.trymore.oa.dao.system.DAOFileAttach#getByPath(java.lang.String)
	 */
	@Override
	public ModelFileAttach getByPath(String filePath) throws DAOException
	{
		if (UtilString.isNotEmpty(filePath))
		{
			String str = "from ModelFileAttach f where f.filePath=?";
			return (ModelFileAttach) findUnique(str, new Object[] { filePath });
		}
		
		return null;
	}

}

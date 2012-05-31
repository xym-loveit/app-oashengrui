package org.shengrui.oa.dao.system.impl;

import org.shengrui.oa.dao.system.DAOAppFunctionUrl;
import org.shengrui.oa.model.system.ModelAppFunctionUrl;

import cn.trymore.core.dao.impl.DAOGenericImpl;
import cn.trymore.core.exception.DAOException;

/**
 * The application function URL repository.
 * 
 * @author Jeccy.Zhao
 *
 */
public class DAOAppFunctionUrlImpl
extends DAOGenericImpl<ModelAppFunctionUrl> implements DAOAppFunctionUrl
{
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.dao.system.DAOAppFunctionUrl#getByPathAndFuncId(java.lang.String, java.lang.String)
	 */
	public ModelAppFunctionUrl getByPathAndFuncId(String urlPath, 
			String funcId) throws DAOException
	{
		String hsql = "from ModelAppFunctionUrl fu where fu.urlPath=? and fu.appFunction.id=?";
		
		return (ModelAppFunctionUrl) this.findUnique(hsql, new Object[] {urlPath, funcId} );
	}
	
}

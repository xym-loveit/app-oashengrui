package org.shengrui.oa.service.admin.impl;

import org.shengrui.oa.dao.admin.DAODocVisiableRange;
import org.shengrui.oa.model.admin.ModelDocVisiableRange;
import org.shengrui.oa.service.admin.ServiceDocVisiableRange;

import cn.trymore.core.service.impl.ServiceGenericImpl;

/**
 * The implementation for doc visiableRange information.
 * 
 * @author Jeccy.Zhao
 *
 */
public class ServiceDocVisiableRangeImpl
extends ServiceGenericImpl<ModelDocVisiableRange> implements ServiceDocVisiableRange
{
	private DAODocVisiableRange daoDocVisiableRange;
	public ServiceDocVisiableRangeImpl(DAODocVisiableRange dao) {
		super(dao);
		this.daoDocVisiableRange=dao;
	}
	public DAODocVisiableRange getDaoDocVisiableRange() {
		return daoDocVisiableRange;
	}
	public void setDaoDocVisiableRange(DAODocVisiableRange daoDocVisiableRange) {
		this.daoDocVisiableRange = daoDocVisiableRange;
	}

	
	
}

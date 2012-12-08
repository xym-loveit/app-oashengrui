package org.shengrui.oa.service.admin.impl;

import java.util.List;

import org.hibernate.Hibernate;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.hibernate.type.Type;
import org.shengrui.oa.dao.admin.DAODocManage;
import org.shengrui.oa.model.admin.ModelDoc;
import org.shengrui.oa.model.admin.ModelDocLevel;
import org.shengrui.oa.model.system.ModelAppDictionary;
import org.shengrui.oa.service.admin.ServiceDocManage;
import org.shengrui.oa.util.ContextUtil;

import cn.trymore.core.exception.DAOException;
import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.impl.ServiceGenericImpl;
import cn.trymore.core.util.UtilString;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

/**
 * The implementation for doc manage
 * 
 * @author Tang
 *
 */
public class ServiceDocManageImpl
extends ServiceGenericImpl<ModelDoc> implements ServiceDocManage
{
	private DAODocManage daoDocManage;
	
	public ServiceDocManageImpl(DAODocManage dao)
	{
		super(dao);
		this.daoDocManage=dao;
	}
	
	public ModelDoc getNewDoc()throws ServiceException, DAOException
	{
		String sql ="select * from app_admin_doc doc where doc_id=(select max(doc_id) from app_admin_doc)";
		ModelDoc doc=(ModelDoc) daoDocManage.findListByNativeSQL(sql,ModelDoc.class).get(0);
		if(doc!=null){
			return doc;
		}
		return null;
	}
	
	public void saveDoc(ModelDoc doc,String fileIds)throws ServiceException, DAOException
	{
		daoDocManage.saveOrUpdate(doc);
	}
	
	public List<ModelDoc> getDocsByLevel(ModelDocLevel level,ModelAppDictionary type)throws ServiceException, DAOException
	{
		DetachedCriteria criteria = DetachedCriteria.forClass(ModelDoc.class);
		if(level!=null)
		{
			criteria.createCriteria("docLevel").add(Restrictions.eq("id", level.getId()));
			// criteria.add(Restrictions.eq("docLevel", level));
			
		}
		if(type!=null)
		{
			criteria.createCriteria("type").add(Restrictions.eq("id", type.getId()));
			// criteria.add(Restrictions.eq("type", type));
		}
		
		// 文档范围过滤...
		criteria.add(
				Restrictions.sqlRestriction(
						"(doc_VisiableRange_id = " + ModelDoc.EDocVisibleRange.ALL.getValue() +
						" or (doc_VisiableRange_id = " + ModelDoc.EDocVisibleRange.PERSONALS.getValue() + 
						" and FIND_IN_SET(?, `doc_userIds`) > 0) or FIND_IN_SET( ?, `doc_VisiableRange_id`) > 0)", 
						new Object[] {
								ContextUtil.getCurrentUser().getEmployeeId(), 
								ContextUtil.getCurrentUser().getDistrictId()}, 
						new Type[] {
								Hibernate.STRING, 
								Hibernate.STRING}));
		
		criteria.addOrder(Order.desc("createTime"));
		
		return daoDocManage.getListByCriteria(criteria, 0, 5);
	}
	
	@Override
	public List<ModelDoc> getAllDocInfo() throws ServiceException {
		return super.getAll();
	}
	
	
	@Override
	public PaginationSupport<ModelDoc> getPaginationByEntity(
			ModelDoc entity, PagingBean pagingBean)
			throws ServiceException 
	{
		return this.getPaginationByEntity(entity, false, pagingBean);
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.shengrui.oa.service.admin.ServiceDocManage#getPaginationByEntity(org.shengrui.oa.model.admin.ModelDoc, boolean, cn.trymore.core.web.paging.PagingBean)
	 */
	@Override
	public PaginationSupport<ModelDoc> getPaginationByEntity (ModelDoc entity, 
			boolean visibility, PagingBean pagingBean) throws ServiceException
	{
		return this.getAll(this.getCriterias(entity, visibility), pagingBean);
	}
	
	/**
	 * Returns the criteria with the specified entity. 
	 * 
	 * @param entity
	 * @return
	 */
	//封装检索条件
	private DetachedCriteria getCriterias(ModelDoc entity, boolean visibility)
	{
		DetachedCriteria criteria = DetachedCriteria.forClass(ModelDoc.class);
		
		if (entity != null)
		{
			if(entity.getType()!=null && UtilString.isNotEmpty(entity.getType().getId()))
			{
				criteria.add(Restrictions.eq("type", entity.getType()));
			}
			
            if(entity.getDocName()!=null && UtilString.isNotEmpty(entity.getDocName()))
            {
            	criteria.add(Restrictions.like("docName", entity.getDocName(), MatchMode.ANYWHERE));
			}
            if(entity.getDocLevel()!=null&& UtilString.isNotEmpty(entity.getDocLevel().getId()))
            {
            	criteria.add(Restrictions.eq("docLevel", entity.getDocLevel()));
            }
		}
		
		// 文档范围过滤...
		if (visibility)
		{
			criteria.add(
					Restrictions.sqlRestriction(
							"(doc_VisiableRange_id = " + ModelDoc.EDocVisibleRange.ALL.getValue() +
							" or (doc_VisiableRange_id = " + ModelDoc.EDocVisibleRange.PERSONALS.getValue() + 
							" and ? in (`doc_userIds`)) or FIND_IN_SET( ?, `doc_VisiableRange_id`) > 0)", 
							new Object[] {
									ContextUtil.getCurrentUser().getId(), 
									ContextUtil.getCurrentUser().getDistrictId()}, 
							new Type[] {
									Hibernate.STRING, 
									Hibernate.STRING}));
		}
		
		criteria.addOrder(Order.desc("createTime"));
		
		return criteria;
	}
	

	public DAODocManage getDaoDocManage() {
		return daoDocManage;
	}

	public void setDaoDocManage(DAODocManage daoDocManage) {
		this.daoDocManage = daoDocManage;
	}
	
}
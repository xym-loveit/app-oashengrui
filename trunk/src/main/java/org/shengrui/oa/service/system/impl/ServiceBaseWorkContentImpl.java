package org.shengrui.oa.service.system.impl;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.shengrui.oa.dao.system.DAOBaseWorkContent;
import org.shengrui.oa.model.system.ModelBaseWorkContent;
import org.shengrui.oa.service.system.ServiceBaseWorkContent;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.impl.ServiceGenericImpl;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

/**
 * @author Tank.L
 *
 */
public class ServiceBaseWorkContentImpl extends ServiceGenericImpl<ModelBaseWorkContent> implements ServiceBaseWorkContent {
   private DAOBaseWorkContent daoBaseWorkContent;
   /**
    * @return the daoBaseWorkContent
    */
   public DAOBaseWorkContent getDaoBaseWorkContent() {
      return daoBaseWorkContent;
   }

   /**
    * @param daoBaseWorkContent the daoBaseWorkContent to set
    */
   public void setDaoBaseWorkContent(DAOBaseWorkContent daoBaseWorkContent) {
      this.daoBaseWorkContent = daoBaseWorkContent;
   }

   public ServiceBaseWorkContentImpl(DAOBaseWorkContent dao) {
      super(dao);
      this.daoBaseWorkContent = dao;
      // TODO Auto-generated constructor stub
   }

   @Override
   public ModelBaseWorkContent getById(String id) throws ServiceException {
      // TODO Auto-generated method stub
      return this.get(id);
   }

   @Override
   public PaginationSupport<ModelBaseWorkContent> getPaginationByEntity(
         ModelBaseWorkContent entity, PagingBean pagingBean)
         throws ServiceException {
      // TODO Auto-generated method stub
      DetachedCriteria criteria = DetachedCriteria.forClass(ModelBaseWorkContent.class);
      if (entity != null)
      {
         if (entity.getBaseWorkDistrict() != null && entity.getBaseWorkDistrict().getId()!=null && !"".equals(entity.getBaseWorkDistrict().getId()))
         {
            criteria.createCriteria("baseWorkDistrict").add(Restrictions.eq("id", entity.getBaseWorkDistrict().getId()));
         }
      }
      
      criteria.addOrder(Order.desc("updateTime"));
      
      return this.getAll(criteria, pagingBean);
   }
}

package org.shengrui.oa.service.admin;

import java.util.List;

import org.shengrui.oa.model.admin.ModelDoc;
import org.shengrui.oa.model.admin.ModelDocLevel;
import org.shengrui.oa.model.system.ModelAppDictionary;

import cn.trymore.core.exception.DAOException;
import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.ServiceGeneric;
import cn.trymore.core.web.paging.PaginationSupport;
import cn.trymore.core.web.paging.PagingBean;

/**
 * The service for admin doc manage
 * 
 * @author Tang
 *
 */
public interface ServiceDocManage
extends ServiceGeneric<ModelDoc>
{
	
	/**
	 * 得到最新的文档
	 * @author Tang
	 * @throws DAOException 
	 */
	public ModelDoc getNewDoc()throws ServiceException, DAOException;

	/**
	 * 文档上传保存
	 * @author Tang
	 * @throws DAOException 
	 */
	public void saveDoc(ModelDoc doc,String fileIds)throws ServiceException, DAOException;
	
	
	/**
	 * 得到类型查询文档
	 * @author Tang
	 * @throws DAOException 
	 */
	public List<ModelDoc> getDocsByLevel(ModelDocLevel level,ModelAppDictionary type)throws ServiceException, DAOException;
	
	/**
	 * 得到所有的文档信息
	 * @author Tang
	 */
	public List<ModelDoc> getAllDocInfo()throws ServiceException;
	
	/**
	 * 根据信息查分页数据
	 * 
	 * @param entity
	 * @param pagingBean
	 * @return
	 * @throws ServiceException
	 */
	PaginationSupport<ModelDoc> getPaginationByEntity (ModelDoc entity, 
			PagingBean pagingBean) throws ServiceException;
	
	/**
	 * 根据信息查分页数据
	 * 
	 * @param entity
	 * @param pagingBean
	 * @return
	 * @throws ServiceException
	 */
	PaginationSupport<ModelDoc> getPaginationByEntity (ModelDoc entity, 
			boolean visibility, PagingBean pagingBean) throws ServiceException;
}

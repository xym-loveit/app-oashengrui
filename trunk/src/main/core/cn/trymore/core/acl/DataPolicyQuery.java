package cn.trymore.core.acl;

import java.lang.reflect.Field;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.log4j.Logger;
import org.shengrui.oa.model.system.ModelAppRole;
import org.shengrui.oa.model.system.ModelAppUser;
import org.shengrui.oa.service.system.ServiceSchoolDepartment;
import org.shengrui.oa.util.AppUtil;
import org.shengrui.oa.util.ContextUtil;

import cn.trymore.core.util.UtilString;

public class DataPolicyQuery
{	
	/**
	 * The LOGGER
	 */
	private static final Logger LOGGER = Logger.getLogger(DataPolicyEngine.class);
	
	/**
	 * The service of school department.
	 */
	private ServiceSchoolDepartment serviceSchoolDepartment;
	
	/**
	 * Builds the policy query filter with the specified entity.
	 * 
	 * @param entity
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public String buildPolicyQuery (Class entity)
	{
		return buildPolicyQuery(entity, DataPolicyEngine.get().toString(), 
				ContextUtil.getCurrentUser(), null);
	}
	
	/**
	 * Builds the policy query filter with the specified entity.
	 * 
	 * @param entity
	 * @param URI·
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public String buildPolicyQuery (Class entity, String URI)
	{
		return buildPolicyQuery(entity, URI, ContextUtil.getCurrentUser(), null);
	}
	
	/**
	 * Builds the policy query filter with the specified entity.
	 * 
	 * @param entity
	 * @param URI
	 * @param user
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public String buildPolicyQuery (Class entity, final String URI, 
			final ModelAppUser user)
	{
		return this.buildPolicyQuery(entity, URI, user, null);
	}
	
	/**
	 * Builds the policy query filter with the specified entity.
	 * 
	 * @param entity
	 * @param URI
	 * @param user
	 * @param tableAlias
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public String buildPolicyQuery (Class entity, final String URI, 
			final ModelAppUser user, final String tableAlias)
	{
		Field[] fields = entity.getDeclaredFields();
		if (fields != null)
		{
			for (Field field : fields)
			{
				if (field.isAnnotationPresent(AclFilterAnnotation.class))
				{
					AclFilterAnnotation aclFilter = field.getAnnotation(AclFilterAnnotation.class);
					if (validateAnnotation(aclFilter))
					{
						return buildQueryFilter(URI, aclFilter, user, tableAlias);
					}
					else
					{
						LOGGER.warn("Invalid properties configured on ACL filter annotation..");
					}
				}
			}
		}
		
		return null;
	}
	
	/**
	 * Returns true if the specified URI granted data policy access.
	 * 
	 * @param URI
	 * @return
	 */
	public boolean isGrantedDataPolicy (Object URI)
	{
		return this.isGrantedDataPolicy(URI, ContextUtil.getCurrentUser());
	}
	
	/**
	 * Returns true if the specified URI granted data policy access.
	 * 
	 * @param URI
	 * @param user
	 * @return
	 */
	public boolean isGrantedDataPolicy (Object URI, ModelAppUser user)
	{
		if (ContextUtil.getCurrentUser() != null && URI != null)
		{
			Map<String, Integer> dataPerms = user.getDataPermissions();
			if (dataPerms != null && getStrategyByURI(URI, dataPerms) != null)
			{
				return dataPerms.get(URI) != null;
			}
		}
		return false;
	}
	
	/**
	 * Obtains strategy with the specified URI matched from the URI pool.
	 * 
	 * @param URI
	 * @param uriPool
	 * @return
	 */
	private Integer getStrategyByURI (final Object URI, final Map<String, Integer> uriPool)
	{
		Integer strategy = null;
		
		final String strURI = URI.toString().toLowerCase();
		final Set<String> keySet = uriPool.keySet();
		
		// matches directly with the full URI
		if (uriPool != null && uriPool.size() > 0)
		{
			if (keySet.contains(strURI))
			{
				strategy = uriPool.get(strURI);
			}
		}
		
		if (strategy == null)
		{
			// try to match without the parameters if provided.
			for (final String res : keySet)
			{
				if (strURI.indexOf(res.toLowerCase()) > -1)
				{
					strategy = uriPool.get(res);
					break;
				}
			}
		}
		
		return strategy;
	}
	
	/**
	 * Validates the provided annotation and returns true if valid.
	 * 
	 * @param annotation
	 *          the ACL filter annotation
	 * @return true if annotation properties valid; otherwise false returned.
	 */
	private boolean validateAnnotation(AclFilterAnnotation annotation)
	{
		if (annotation != null)
		{
			return annotation.fieldNames() != null && annotation.fieldTypes() != null && 
					annotation.fieldNames().length == annotation.fieldTypes().length;
		}
		
		return false;
	}
	
	/**
	 * Builds the query filter with the specified ACL filter annotation.
	 * 
	 * @param URI
	 * @param aclFilter
	 *          the annotation of ACL filter
	 * @param user
	 * @param tableAlias
	 * @return query native SQL
	 */
	private String buildQueryFilter (final String URI, 
			final AclFilterAnnotation aclFilter, final ModelAppUser user, final String tableAlias)
	{
		if (aclFilter != null)
		{
			String[] fieldNames = aclFilter.fieldNames();
			String[] fieldTypes = aclFilter.fieldTypes();
			
			if (fieldNames.length == fieldTypes.length)
			{
				StringBuilder builder = new StringBuilder();
				boolean multiCloud = false;
				
				for (int i = 0, size = fieldNames.length; i < size; i++)
				{
					String fieldType = fieldTypes[i];
					if (UtilString.isNotEmpty(fieldType))
					{
						String strategy = obtainDataStrategy(URI, fieldType, user);
						if (strategy != null)
						{
							if (ModelAppRole.SUPER_RIGHTS.equals(strategy))
							{
								// 全校数据
								return null;
							}
							
							if (multiCloud)
							{
								builder.append(" OR ");
							}
							
							if (UtilString.isNotEmpty(tableAlias))
							{
								builder.append(tableAlias + ".");
							}
							builder.append(fieldNames[i]);
							builder.append(" IN (");
							builder.append(strategy);
							builder.append(")");
							multiCloud = true;
						}
					}
				}
				return builder.toString();
			}
		}
		
		return null;
	}
	
	/**
	 * Obtains the data strategy with the specified request URI and field type.
	 * 
	 * @param URI
	 * @param fieldType
	 * @param user
	 * @return
	 */
	private String obtainDataStrategy (String URI, String fieldType, final ModelAppUser user)
	{
		ModelAppUser logonUser = user; //ContextUtil.getCurrentUser();
		
		Integer dataPolicy = getStrategyByURI(URI, user.getDataPermissions());
		
		if (AppUtil.EDataPermissions.DP_DIS_WHOLE.getValue().equals(dataPolicy)
				&& AppUtil.EDataPermissions.DP_DIS_WHOLE.getType().equals(fieldType))
		{
			// 全校数据, 可以访问所有数据
			return ModelAppRole.SUPER_RIGHTS;
		}
		else if (AppUtil.EDataPermissions.DP_DIS_CURRENT.getValue().equals(dataPolicy)
				&& AppUtil.EDataPermissions.DP_DIS_CURRENT.getType().equals(fieldType))
		{
			// 校区数据
			return logonUser.getEmployee() != null ? 
						logonUser.getEmployee().getEmployeeDistrict().getId() : logonUser.getDistrict().getId();
		}
		else if (AppUtil.EDataPermissions.DP_DEP_WHOLE.getValue().equals(dataPolicy)
				&& AppUtil.EDataPermissions.DP_DEP_WHOLE.getType().equals(fieldType))
		{
			// 大部门数据
			String depName = logonUser.getEmployee() != null ? 
					logonUser.getEmployee().getEmployeeDepartment().getDepName() : 
						(logonUser.getDepartment() != null ? logonUser.getDepartment().getId() : null);
			try
			{
				List<Object> depIds = this.serviceSchoolDepartment.getDepartmentIdsByName(depName);
				if (depIds != null)
				{
					StringBuilder builder = new StringBuilder();
					int index = 0;
					for (Object depId : depIds)
					{
						builder.append(depId);
						if (index < depIds.size() - 1)
						{
							builder.append(",");
						}
						index++;
					}
					return builder.toString();
				}
			}
			catch (Exception e)
			{
				LOGGER.error("Exception raised when fetch department ids with name:" + depName, e);
				return null;
			}
		}
		else if (AppUtil.EDataPermissions.DP_DEP_CURRENT.getValue().equals(dataPolicy)
				&& AppUtil.EDataPermissions.DP_DEP_CURRENT.getType().equals(fieldType))
		{
			// 部门数据
			return logonUser.getEmployee() != null ? 
					logonUser.getEmployee().getEmployeeDepartment().getId() : logonUser.getDepartment().getId();
		}
		else if (AppUtil.EDataPermissions.DP_MINE.getValue().equals(dataPolicy)
				&& AppUtil.EDataPermissions.DP_MINE.getType().equals(fieldType))
		{
			// 默认拥有个人数据的数据权限
			return logonUser.getEmployee() != null ?
						logonUser.getEmployee().getId() : logonUser.getId();
		}
		
		return null;
	}
	
	public ServiceSchoolDepartment getServiceSchoolDepartment()
	{
		return serviceSchoolDepartment;
	}

	public void setServiceSchoolDepartment(
			ServiceSchoolDepartment serviceSchoolDepartment)
	{
		this.serviceSchoolDepartment = serviceSchoolDepartment;
	}
}

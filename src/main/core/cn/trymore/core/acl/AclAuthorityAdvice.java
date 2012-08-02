package cn.trymore.core.acl;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.Map;

import org.apache.log4j.Logger;
import org.shengrui.oa.model.system.ModelSchoolDepartmentPosition;
import org.shengrui.oa.util.ContextUtil;
import org.springframework.aop.MethodBeforeAdvice;

import cn.trymore.core.dao.impl.DAOGenericImpl;
import cn.trymore.core.util.UtilString;

public class AclAuthorityAdvice 
implements MethodBeforeAdvice 
{
	
	/**
	 * The LOGGER
	 */
	private static final Logger LOGGER = Logger.getLogger(AclAuthorityAdvice.class);
			
	/*
	 * (non-Javadoc)
	 * @see org.springframework.aop.MethodBeforeAdvice#before(java.lang.reflect.Method, java.lang.Object[], java.lang.Object)
	 */
	@SuppressWarnings("rawtypes")
	@Override
	public void before(Method method, Object[] args, Object target)
			throws Throwable
	{
		System.out.println("The object fetched from data policy threadLocal:" + DataPolicyEngine.get());
		
		LOGGER.debug("The object fetched from data policy threadLocal:" + DataPolicyEngine.get());
		
		if (this.isGrantedDataPolicy(DataPolicyEngine.get()))
		{
			String targetClassName = target.getClass().getName();
			if (targetClassName.endsWith("Impl") && targetClassName.indexOf("DAO") > -1)
			{
				DAOGenericImpl repo = (DAOGenericImpl) target;
				LOGGER.debug("It interceptored entity('" + repo.getEntityClass().getName() + "') against ACL filter");
				Class entityObj = repo.getEntityClass();
				Field[] fields = entityObj.getDeclaredFields();
				if (fields != null)
				{
					for (Field field : fields)
					{
						if (field.isAnnotationPresent(AclFilterAnnotation.class))
						{
							LOGGER.debug("ACL filter detected on field:" + field.getName());
							AclFilterAnnotation aclFilter = field.getAnnotation(AclFilterAnnotation.class);
							if (this.validateAnnotation(aclFilter))
							{
								repo.setQueryFilter(this.buildQueryFilter(DataPolicyEngine.get().toString(), aclFilter));
							}
							else
							{
								LOGGER.warn("Invalid properties configured on ACL filter annotation..");
							}
						}
					}
				}
			}
		}
	}
	
	/**
	 * Returns true if the specified URI granted data policy access.
	 * 
	 * @param URI
	 * @return
	 */
	private boolean isGrantedDataPolicy (Object URI)
	{
		if (ContextUtil.getCurrentUser() != null && URI != null)
		{
			Map<String, String> dataPerms = ContextUtil.getCurrentUser().getDataPermissions();
			if (dataPerms != null && dataPerms.containsKey(URI))
			{
				return UtilString.isNotEmpty(dataPerms.get(URI));
			}
		}
		return false;
	}
	
	/**
	 * Builds the query filter with the specified ACL filter annotation.
	 * 
	 * @param aclFilter
	 *          the annotation of ACL filter
	 * @return query native SQL
	 */
	private String buildQueryFilter (String URI, AclFilterAnnotation aclFilter)
	{
		if (aclFilter != null)
		{
			String[] fields = aclFilter.fields();
			String[] snKeys = aclFilter.snKeys();
			
			if (fields.length == snKeys.length)
			{
				StringBuilder builder = new StringBuilder();
				for (int i = 0, size = fields.length; i < size; i++)
				{
					String snKey = snKeys[i];
					if (UtilString.isNotEmpty(snKey))
					{
						builder.append(fields[i]);
						builder.append(" IN (");
						// only for test.
						builder.append(this.getFilterFieldValue(URI, snKey));
						builder.append(")");	
					}
				}
				return builder.toString();
			}
		}
		
		return null;
	}
	
	private String getFilterFieldValue (String URI, String snKey)
	{
		String dataPolicy = ContextUtil.getCurrentUser().getDataPermissions().get(URI.toString());
		
		if (String.valueOf(ModelSchoolDepartmentPosition.EPositionDataPermissions.PMS_DIS_CURRENT.getValue()).equals(dataPolicy))
		{
			return "1, 4";
		}
		
		return null;
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
			return annotation.fields() != null && annotation.snKeys() != null && 
					annotation.fields().length == annotation.snKeys().length;
		}
		
		return false;
	}
	
}

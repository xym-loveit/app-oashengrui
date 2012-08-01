package cn.trymore.core.acl;

import java.lang.reflect.Field;
import java.lang.reflect.Method;

import org.apache.log4j.Logger;
import org.springframework.aop.MethodBeforeAdvice;

import cn.trymore.core.dao.impl.DAOGenericImpl;

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
							this.buildQueryFilter(aclFilter);
							repo.setQueryFilter("");
						}
						else
						{
							LOGGER.warn("");
						}
					}
				}
			}
			
		}
		System.out.println(target);
	}
	
	/**
	 * Builds the query filter with the specified ACL filter annotation.
	 * 
	 * @param aclFilter
	 *          the annotation of ACL filter
	 * @return query native SQL
	 */
	private String buildQueryFilter (AclFilterAnnotation aclFilter)
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
					builder.append(fields[i]);
					builder.append(" IN (");
					builder.append(")");
				}
				return builder.toString();
			}
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

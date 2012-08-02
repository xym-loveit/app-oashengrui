package cn.trymore.core.acl;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Inherited;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * 
 * Annotation to present ACL table filter fields.
 * 
 * @author Jeccy.Zhao
 * 
 */
@Target({ElementType.FIELD})
@Retention(RetentionPolicy.RUNTIME)
@Documented
@Inherited
public @interface AclFilterAnnotation
{
	/**
	 * Filtered fields
	 */
	String[] fieldNames() default {};
	
	/**
	 * Session keys for specified field
	 */
	String[] fieldTypes() default {};
}

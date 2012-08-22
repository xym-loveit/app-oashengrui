package cn.trymore.core.util;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.List;

/**
 * Helper class for annotation scanning.
 * 
 * @author Jeccy.Zhao
 *
 */
public class UtilAnnotation
{
	/**
	 * Obtains list of annotation objects from entity 
	 * 
	 * @param entity
	 * @param annotation
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public static List<Object> getAnnotationFromEntityFields (Class entity, Class annotation)
	{
		List<Object> objs = null;
		
		Field[] fields = entity.getDeclaredFields();
		if (fields != null)
		{
			for (Field field : fields)
			{
				if (field.isAnnotationPresent(annotation))
				{
					if (objs == null)
					{
						objs = new ArrayList<Object>();
					}
					
					objs.add(field.getAnnotation(annotation));
				}
			}
		}
		
		return objs;
	}
}

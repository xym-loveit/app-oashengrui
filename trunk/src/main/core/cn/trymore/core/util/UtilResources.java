package cn.trymore.core.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;
import java.util.Map.Entry;

import cn.trymore.core.common.Constants;

/**
 * The utility of resources
 * 
 * @author Jeccy.Zhao
 *
 */
public class UtilResources 
{
	
	/**
	 * Returns the web class path
	 * 
	 * @return web class path
	 */
	public static String getWebClassPath()
	{
		String classPath = UtilResources.class.getResource("/").toString();
		if(classPath.indexOf(Constants.RESOURCE_FILE_PREFIX) > -1)
		{
			classPath = classPath.substring(Constants.RESOURCE_FILE_PREFIX.length());
		}
		return classPath;
	}
	
	/**
	 * Returns the web root path
	 * 
	 * @return web root path
	 */
	public static String getWebRootPath()
	{
		String classPath = UtilResources.getWebClassPath();
		String rootPath = "";
		
		if(classPath.indexOf(Constants.RESOURCE_WEB_INF) > -1)
		{
			rootPath = classPath.substring(0,classPath.indexOf(Constants.RESOURCE_WEB_INF));
			if (rootPath.contains("%20"))
			{
				rootPath = rootPath.replaceAll("%20", " ");
			}
		}
		return rootPath;
	}
	
	/**
	 * Returns the properties from the property file
	 * 
	 * @param propFilePath  
	 *          the property file path, format can be classpath:xxxx, etc.
	 * @return the properties laid in a hash-map
	 */
	public static Map<String, String> getProperties(String propFile)
	{
		Properties props = new Properties();
		InputStream stream = null;
		try 
		{
			if(propFile.indexOf(Constants.RESOURCE_CLASSPATH_PREFIX) > -1)
			{
				propFile = propFile.replaceFirst(
						Constants.RESOURCE_CLASSPATH_PREFIX, UtilResources.getWebClassPath()); 
			}
			stream = new FileInputStream(new File(propFile));
			props.load(stream);
			Map<String, String> propMaps = new HashMap<String, String>();
			for(Entry<Object, Object> entry : props.entrySet())
			{
				if(entry.getKey() != null)
				{
					propMaps.put(entry.getKey().toString(), entry.getValue().toString());
				}
			}
			return propMaps;
		} 
		catch (FileNotFoundException e) 
		{
			e.printStackTrace();
		} 
		catch (IOException e) 
		{
			e.printStackTrace();
		} 
		finally 
		{
			if(stream != null)
			{
				try 
				{
					stream.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		return null;
	}
	
	/**
	 * 
	 * @return
	 * @author Zhao.Xiang
	 */
	public static String getPhyResourcePath() 
	{
		String tmp = UtilResources.class.getResource("/").getFile();
		return tmp.substring(1, tmp.length() - 1);
	}
	
	/**
	 * 
	 * @return
	 * @author Zhao.Xiang
	 */
	public static String getPhyBasePath() 
	{
		String path = getPhyResourcePath();
		return path.substring(0, path.lastIndexOf("/"));
	}
	
	public static void main(String[] args)
	{
		System.out.println(UtilResources.getWebClassPath());
		System.out.println(UtilResources.getWebRootPath());
	}
	
}

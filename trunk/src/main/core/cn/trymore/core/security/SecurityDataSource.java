package cn.trymore.core.security;

import java.util.Map;
import java.util.Set;

import org.apache.log4j.Logger;
import org.shengrui.oa.model.system.ModelAppRole;
import org.shengrui.oa.service.system.ServiceAppRole;

/**
 * The security data source component
 * 
 * @author Jeccy.Zhao
 *
 */
public class SecurityDataSource
{
	/**
	 * The LOGGER
	 */
	private static final Logger LOGGER = Logger.getLogger(SecurityDataSource.class);
	
	/**
	 * The application role service
	 */
	private ServiceAppRole serviceAppRole;
	
	/**
	 * The anonymous URLs
	 */
	private Set<String> anonymousUrls = null;
	
	/**
	 * The public URLs
	 */
	private Set<String> publicUrls = null;
	
	/**
	 * Returns the security data source
	 * 
	 * @return
	 */
	public Map<String, Set<String>> getDataSource()
	{
		try
		{
			Map<String, Set<String>> localHashMap = this.serviceAppRole.getSecurityDataSource();
			localHashMap.put(ModelAppRole.ROLE_ANONYMOUS, this.anonymousUrls);
			localHashMap.put(ModelAppRole.ROLE_PUBLIC, this.publicUrls);
			return localHashMap;
		}
		catch (Exception e)
		{
			LOGGER.error("Exception raised when fetching the security data source.", e);
		}
		
		return null;
	}
	
	public ServiceAppRole getServiceAppRole()
	{
		return serviceAppRole;
	}

	public void setServiceAppRole(ServiceAppRole serviceAppRole)
	{
		this.serviceAppRole = serviceAppRole;
	}

	public Set<String> getAnonymousUrls()
	{
		return anonymousUrls;
	}

	public void setAnonymousUrls(Set<String> anonymousUrls)
	{
		this.anonymousUrls = anonymousUrls;
	}

	public Set<String> getPublicUrls()
	{
		return publicUrls;
	}

	public void setPublicUrls(Set<String> publicUrls)
	{
		this.publicUrls = publicUrls;
	}
	
}
